#!/bin/bash

d0=$(dirname "$0")
source "$d0/vars.sh"
source "$d0/_source.sh"

main() {
  export ALTGIT_SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
  docker_build_dir="$ALTGIT_SCRIPT_DIR/docker_build_dir"
  [[ -d "$docker_build_dir" ]] || mkdir -p "$docker_build_dir"
  cd "$docker_build_dir" || die "ERROR: $?: Failed to 'cd $docker_build_dir'."
  already=$(docker images -f=reference="$BASE_TAG" --format '{{.ID}}')
  [[ $already ]] || docker build -t $BASE_TAG -f Dockerfile.base . || die "ERROR: $?: From docker build."
  docker tag $BASE_TAG $BASE_IMG:latest
  export PATH="$ALTGIT_SCRIPT_DIR:$PATH"
  usage
  cd "$PWD0" || die "ERROR: $?: Failed to return to $PWD0 (cd $PWD0)."
  bash
}
realpath --version >/dev/null || realpath() { local pwd=$(pwd); echo "$1" | perl -ne "s{^([.]/|([^\/]))}{$pwd/\$2};print \$_"; }
usage() {
  echo
  echo "Now run 'altgituser some_alternate_name' to spawn a Docker container shell based on that alternative identity."
  echo "If that 'altname' is found as a subfolder under ~/.ssh/altgit/ then its contents will overlap the container's ~/.ssh, ~/.aws, and ~/.gitconfig settings."
  echo "If a ~/.ssh/altgit/\$altname/username file exists then the container shell will run with that file's contents as the user's name."
  echo "Otherwise the username will be the same as the current one ($(id -un))."
  echo
}

main "$@"
