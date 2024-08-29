source /usr/local/etc/bashrc

EXT_BIN_LIST="/etc/sysconfig/tcedir/not_found.aux"

function command_not_found_handle() {
  test -f "$EXT_BIN_LIST" && {
    bin="$1"; shift
    exts="$(sed -n "s,^\(.*\)[ ]\+.*/$bin/.*,\1,p" <"$EXT_BIN_LIST")"
    test -n "$exts" && echo "$bin found in '$exts'" || echo "$bin: not found"
  }
  return 127
}

