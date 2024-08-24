

NV="$NAME-$VER"
NV2=

DST="dest.$NV"
ARC="v$VER.tar.gz"
EXTDIR="/mnt/`cat /etc/sysconfig/backup_device`/optional"
TCZ="$NAME.tcz"
TCZNV="$NV.tcz"
DEP="$TCZ.dep"
BUILD_DEPS=
RUN_DEPS=
SQUASHFS_OPTS=
TAR_OPTS=

TOPBLD="/tmp"

GH="https://github.com"

std_build() {
  tce-load -wil squashfs-tools git wget compiletc $BUILD_DEPS
}

prep_gh_arc() {
  [ -n "$TAR_OPTS" ] && _tar_opts="$TAR_OPTS" || _tar_opts="xvzf"
  [ -n "$NV2" ] && _nv="$NV2" || _nv="$NV"
  [ -n "$1" ] && { _arc="$1"; shift; } || _arc="$GH/$GH_USER/$NAME/archive/refs/tags/$ARC"
  cd $TOPBLD
  wget "$_arc"
  tar $_tar_opts "$ARC"
  cd "$_nv"
}

prep_gh_git() {
  [ -n "$1" ] && { _git="$1"; shift; } || _git="$GH/$GH_USER/$NAME"
  cd $TOPBLD
  git clone "$_git"
  cd "$NAME"
}


top_n_clean() {
  cd $TOPBLD
  rm -rf "$DST" "$NV" "$NV2" "$NAME" || :
  rm -f "$ARC" "$TCZ" "$TCZNV" "$DEP" || :
}

mk_tcz() {
  cd "$TOPBLD"
  mksquashfs "$DST" "$TCZNV" $SQUASHFS_OPTS
  ln -sf "$TCZNV" "$TCZ"
  [ -n "$RUN_DEPS" ] && {
    for f in $RUN_DEPS; do
      echo "$f.tcz"
    done >> "$DEP"
  }
  test -d "$EXTDIR" && {
    mv "$TCZ" "$TCZNV" "$EXTDIR"/
    [ -f "$DEP" ] && mv "$DEP" "$EXTDIR"/ || :
    top_n_clean || :
  } || ls -l "$TCZ" "$TCZNV"
}

