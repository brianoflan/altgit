# altgit
For times when you have more than one Git/GitHub/GitLab/BitBucket account and need to keep them distinct.

## Usage:
Run `run.sh` to create the underlying Docker image and update your PATH.
Then run `altgituser some_alternate_name` to create the image and container in which to run with a different Git identity (change the content of .gitconfig, .ssh, .aws, and more!).


## Details:
`run.sh` concludes with a summary of some of these details: When you run `altgituser some_alternate_name`, it spawns a shell within a container where the primary user (the user you become within the interactive shell session) has your new Git identity.

### _**altname**_
The string `some_alternate_name` is just a placeholder in these documents to inspire the user to come up with interesting nicknames for their alternative Git configurations. This is referred to with more brevity as `$altname` in the underlying scripts.

If that 'altname' is found as a subfolder under `~/.ssh/altgit/` then its contents will overlap the container's `~/.ssh`, `~/.aws`, `~/bin`, `~/pre-bin`, and `~/.gitconfig` settings.

* The **altname** can be anything you like, possibly something short and easy to remember.
* The **altname** should probably not actually be `some_alternate_name`.
* You can use any **altname** you want; even one that has no representation within `~/.ssh/altgit/` .
* The **altname** doesn't have anything to do with the username you'll have within the container shell. Your username will match your current username (per `id -un`) unless a non-empty `~/.ssh/altgit/$altname/username` file exists: Then your username will match the first line of that content.

NOTE: Neither the **altname** nor the username have anything to do with the Author or Committer listed by `git log` unless your .gitconfig file (from either the host's `~/.gitconfig` or `~/.ssh/altgit/$altname/.gitconfig`) lacks a `[user]` clause with `email` and `name` - and you have no other source for those Git config values (like `/etc/gitconfig` or `./.git/config` or environment variables like `GIT_AUTHOR_NAME`, `GIT_COMMITTER_EMAIL`, and similar).
