
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
  local result=''
  if [[ $altname ]] && [[ -e ~/.ssh/altgit/$altname/username ]] ; then
    result=$(cat ~/.ssh/altgit/$altname/username | head -1)
  fi ;
  [[ $result ]] && echo $result || [[ $USER ]] && echo "$USER" || id -un
}
get_host_share() {
  pwd
}
get_container_share() {
  echo -n "/home/$CONTAINED_USER/"
  basename "$(pwd)"
}
