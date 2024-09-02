source /usr/local/etc/bashrc

EXT_BIN_LIST="/etc/sysconfig/tcedir/not_found.aux.$(uname -m)"

function command_not_found_handle() {
  rc=127
  bin="$1"; shift
  test -f "$EXT_BIN_LIST" && {
    exts="$(sed -n "s,^\(.*\)[ ]\+.*/$bin/.*,\1,p" <"$EXT_BIN_LIST")"
    test -n "$exts" && {
      echo "$bin found in: ${exts//$'\n'/ }"
      return $rc
    }
  }
  echo "$bin: not found"
  return $rc
}

