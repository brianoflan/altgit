
die() {
  echo "${1:-ERROR}"
  final
  exit ${2:-2}
}
final() {
  true
}

get_gid() {
  [[ $GID ]] && echo "$GID" || id -g
}
get_group() {
  [[ $GROUP ]] && echo "$GROUP" || get_user
}
get_uid() {
  [[ $UID ]] && echo "$UID" || id -u
}
get_user() {
  local maybe=''
  # local result=''
  if [[ $altname ]] && [[ -e ~/.ssh/altgit/$altname/username ]] ; then
    maybe=$(cat ~/.ssh/altgit/$altname/username | head -1)
  fi ;
  # # [[ $maybe ]] && echo "$maybe" || [[ $USER ]] && echo "$USER" || id -un
  # [[ $maybe ]] && result=$maybe || [[ $USER ]] && result=$USER || result=$(id -un)
  # echo "get_user()='$result'" 1>&2
  # echo "$result"
  [[ $maybe ]] && echo "$maybe" || { [[ $USER ]] && echo "$USER" || id -un ; }
}
get_host_share() {
  pwd
}
get_container_share() {
  echo -n "/home/$CONTAINED_USER/"
  basename "$(pwd)"
}
