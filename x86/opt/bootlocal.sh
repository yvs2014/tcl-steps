#!/bin/sh
# put other system startup commands here

USER=tc
LOADER="tce-load -i"
SRC=/mnt/sda1/tce
PKG=optional
POSTLIST="$SRC/afterboot.lst"
PRELIST="$SRC/afterboot-pre.lst"
ACPID=/usr/local/etc/init.d/acpid

modprobe -r squashfs
cp "$SRC/squashfs.ko.gz" "/lib/modules/$(uname -r)/kernel/fs/squashfs"
modprobe squashfs

[ -r "$PRELIST" ] && while read NAME; do
  if [ -n "$NAME" ]; then
    su "$USER" -c "/usr/bin/$LOADER $SRC/$PKG/$NAME"
  fi
done < "$PRELIST"

[ -x "$ACPID" ] && "$ACPID" start

[ -r "$POSTLIST" ] && while read NAME; do
  if [ -n "$NAME" ]; then
    su "$USER" -c "/usr/bin/$LOADER $SRC/$PKG/$NAME"
  fi
done < "$POSTLIST"

