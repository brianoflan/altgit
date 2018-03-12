
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
  # # Quick version:
  [[ $result ]] && echo $result || [[ $USER ]] && echo "$USER" || id -un
  # # Debug version:
  # echo -e "\nSTDERR: get_user(): result='$result'" 1>&2
  # if [[ -z $result ]] ; then
  #   if [[ -z $USER ]] ; then
  #     result=$(id -un)
  #   else
  #     result=$USER
  #   fi ;
  # fi ;
  # echo -e "\nSTDERR: get_user(): result='$result'" 1>&2
  # echo "$result"
}
get_host_share() {
  pwd
}
get_container_share() {
  echo -n "/home/$CONTAINED_USER/"
  basename "$(pwd)"
}
