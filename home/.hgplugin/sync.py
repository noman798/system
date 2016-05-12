'''pull, update, merge and push in one command'''
import urllib2

from mercurial.i18n import _
from mercurial.node import nullid, short
from mercurial import commands, cmdutil, hg, util, exchange
from mercurial.lock import release

testedwith = 'internal'


def sync(ui, repo, source='default', **opts):
    """pull changes from a remote repository, merge new changes if needed, and push.

    This finds all changes from the repository at the specified path
    or URL and adds them to the local repository.

    If the pulled changes add a new branch head, the head is
    automatically merged, and the result of the merge is committed.
    Otherwise, the working directory is updated to include the new
    changes.

	Finally a push is performed so that the local and remote are in sync.
	
	
    When a merge is needed, the working directory is first updated to
    the newly pulled changes. Local changes are then merged into the
    pulled changes. To switch the merge order, use --switch-parent.
	
    See :hg:`help dates` for a list of formats valid for -d/--date.

    Returns 0 on success.
    """
    date = opts.get('date')
    if date:
        opts['date'] = util.parsedate(date)
    synchronizer = Synchronizer(ui, repo, source, opts)
    synchronizer.dosync()

class Synchronizer:
    def __init__(self, ui, repo, source, opts):
        self.ui = ui
        self.repo = repo
        self.source = source
        self.opts = opts
        self.remoterepository = hg.peer(repo, opts, ui.expandpath(source))

    def dosync(self):
        """pull changes from a remote repository, merge new changes if needed.

        This finds all changes from the repository at the specified path
        or URL and adds them to the local repository.

        If the pulled changes add a new branch head, the head is
        automatically merged, and the result of the merge is committed.
        Otherwise, the working directory is updated to include the new
        changes.

        When a merge is needed, the working directory is first updated to
        the newly pulled changes. Local changes are then merged into the
        pulled changes. To switch the merge order, use --switch-parent.

        See :hg:`help dates` for a list of formats valid for -d/--date.

        Returns 0 on success.
        """

        initialrevision, p2 = self.repo.dirstate.parents()

        if p2 != nullid:
            raise util.Abort(_('outstanding uncommitted merge'))

        wlock = lock = None
        try:
            wlock = self.repo.wlock()
            lock = self.repo.lock()

            self.dopull()

            self.raiseifuncleanstatus()

            self.updateormerge(initialrevision)

            self.push()

            self.ui.status('sync complete\n')


        finally:
            release(lock, wlock)

    def dopull(self):
        self.ui.status(_('pulling from %s\n') % util.hidepassword(self.ui.expandpath(self.source)))
        exchange.pull(self.repo, self.remoterepository)
        self.ui.write('pull complete\n')

    def raiseifuncleanstatus(self):
        mod, add, rem, del_ = self.repo.status()[:4]
        if mod or add or rem or del_:
            raise util.Abort('outstanding uncommitted changes, push skipped, not in sync\n')

    def updateormerge(self, initialrevision):
        branch = self.repo.dirstate.branch()
        heads = self.repo.branchheads(branch)

        self.raiseiftoomanyheads(heads)

        # Is this a simple fast-forward along the current branch?
        newchildren = self.repo.changelog.nodesbetween([initialrevision], heads)[2]
        if len(heads) == 1 and len(newchildren) and  newchildren[0] != initialrevision:
            self.update(newchildren[0])
        elif len(heads) > 1:
            # Otherwise, let's merge.
            newhead = heads[0] if heads[0] != initialrevision else heads[1]
            firstparent, secondparent = self.getmergerevisions(initialrevision, newhead)
            self.merge(initialrevision, firstparent, secondparent)
            self.commitmerge()


    def raiseiftoomanyheads(self, heads):
        bheads = [head for head in heads if len(self.repo[head].children()) == 0]
        if len(bheads) > 2:
            self.ui.status(_('not merging with %d remote repository new branch heads '
                             '(use "hg heads ." and "hg merge" to merge them)\n') %
                           (len(bheads) - 1))
            raise util.Abort('push skipped, not in sync\n')

    def update(self, newrevision):
        self.ui.status('updating local repository')
        updatefailed =  hg.update(self.repo, newrevision) #Returns true if unresolved conflicts exist
        if updatefailed:
            self.ui.status('merge conflicts occurred, update skipped\n')
            raise util.Abort('push skipped, not in sync\n')

    def merge(self, initialrevision, working, other):
        self.ui.status(_('merging with %d:%s\n') %
                  (self.repo.changelog.rev(other), short(other)))

        if working != initialrevision: self.updateClean(working)

        if hg.merge(self.repo, other, remind=False):
            if not self.ui.promptchoice(_('Merge failed, do you want to revert [Y/n]: '), ['&Yes', '&No']):
                self.updateClean(initialrevision)
                raise util.Abort('merge failed and reverted, please merge remaining heads manually and sync again')
            else:
                raise util.Abort('merge failed, please resolve remaining merge conflicts manually, commit and sync again')

    def commitmerge(self):
        message = (cmdutil.logmessage(self.ui, self.opts) or
                   ('Automated merge with %s' %
                    urllib2.unquote(util.removeauth(self.remoterepository.url()))))
        editor = cmdutil.commiteditor
        if self.opts.get('edit'):
            editor = cmdutil.commitforceeditor
        n = self.repo.commit(message, self.opts['user'], self.opts['date'], editor=editor)
        self.ui.status(_('new changeset %d:%s merges remote changes '
                    'with local\n') % (self.repo.changelog.rev(n),
                                       short(n)))

    def push(self):
        self.ui.status(_('pushing to %s\n') % util.hidepassword(self.ui.expandpath(self.source)))
        #If it's zero, it failed with an http error. If it's None, or basically any other number, we're not sure what happened, but trust it to have raised an exception if necessary.
        if exchange.push(self.repo, self.remoterepository).cgresult == 0:
            raise util.Abort('push failed, please check your synchronization settings')
        self.ui.status('push complete\n')

    def updateClean(self, revision):
        self.ui.status(_('updating to %d:%s\n') %
                       (self.repo.changelog.rev(revision),
                        short(revision)))
        hg.clean(self.repo, revision)

    def getmergerevisions(self, initialrevision, newhead):
        # By default, we consider the repository we're pulling
        # *from* as authoritative, so we merge our changes into
        # theirs.
        if self.opts['switch_parent']:
            return initialrevision, newhead
        else:
            return newhead, initialrevision


cmdtable = {
    'sync':
        (sync,
         [
             ('e', 'edit', None, _('edit commit message')),
             ('', 'switch-parent', None, _('switch parents when merging')),
         ] + commands.commitopts + commands.commitopts2 + commands.remoteopts,
         _('hg sync [SOURCE]')),
    }
