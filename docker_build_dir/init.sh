
[[ -e ~/.ssh ]] || rsync -a --ignore-errors /resources/.ssh.gold/ ~/.ssh 2>/dev/null
[[ -e ~/.aws ]] || rsync -a --ignore-errors /resources/.aws.gold/ ~/.aws
[[ -e ~/.gitconfig ]] || cat /resources/.gitconfig.gold > ~/.gitconfig
if [[ $ALTNAME ]] ; then
    for x in .ssh .aws .gitconfig bin pre-bin ; do
        original=~/$x
        override=~/.ssh/altgit/$ALTNAME/$x
        if [[ -e "$override" ]] ; then
            backup=~/$x.bak$(date -u +'%Y%m%dT%H%M%S')
            if [[ -d "$override" ]] ; then
                mkdir "$backup"
                rsync -a --exclude altgit --exclude .git "$original"/ "$backup"
                rsync -a "$override"/ "$original"
            else
                cp -rp "$original" "$backup"
                rsync -a "$override" "$original"
            fi ;
        fi ;
    done
fi ;
chmod -R go-rwx ~/.ssh ~/.aws
export INIT_DONE=true
