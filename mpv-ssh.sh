#!/usr/bin/bash

VERSION="0.0.1"

usage() {
	echo "mpv-ssh version $VERSION copyright © 2021 cloud11665"
	echo "  https://github.com/cloud11665/mpv-ssh"
	echo ""
	echo "Dependency versions:"
	echo "  mpv version: $(mpv --version | head -n1 | awk '{print $2}')"
	echo "  OpenSSH: $(ssh -V 2>/dev/stdout)"
	echo ""
	echo "Usage:  $(basename $0) [ssh cmd] [file] [mpv opts]"
	echo ""
	echo "mpv-ssh options:"
	echo " -h, --help       show this message."
	echo ""
	echo "mpv options:"
	echo "$(mpv --help | tail -n+4)"
	echo ""
}

if [ $# -eq 0 ] || [ $1 == "--help" ] || [ $1 == "-h" ]; then
	usage
	exit 0
fi

SSH_CMD_=$1
PATH_=$2
shift
shift

IS_DIR_=$(ssh $SSH_CMD_ "if [ -d \"$PATH_\" ]; then echo \"true\"; else echo \"false\"; fi" 2>/dev/null | tail -n 1)

if $IS_DIR_; then
	readarray -t FILES_ <<<$(ssh $SSH_CMD_ "ls -1 \"$PATH_\"" 2>/dev/null )

	echo "  (0) .."
	for IDX_ in $(seq 0 $(expr ${#FILES_[@]} - 1)); do
		echo "  ($(expr $IDX_ + 1)) ./${FILES_[$(echo $IDX_)]}"
	done
	echo "Select a file to play:"
	read SEL_

	PATH_=$(echo $PATH_ | sed -s "s/^\(\(\"\(.*\)\"\)\|\('\(.*\)'\)\)\$/\\3\\5/g")

	if [ $SEL_ -eq 0 ]; then
		PFORMAT_=$PATH_/..
	else
		#echo "${FILES_[$SEL_-1]}"
		PFORMAT_="$PATH_/${FILES_[$SEL_-1]}"
	fi

	bash -c "$0 $SSH_CMD_ \"$PFORMAT_\" $@"

else
	TITLE_="$(basename "$PATH_")"
	TITLE_="${TITLE_%.*}"
	ssh $SSH_CMD_ "cat \"$PATH_\"" 2>/dev/null | mpv - \
		--force-seekable="yes"\
		--profile="gpu-hq"\
		--cache="yes"\
		--cache-dir="$HOME/.cache/mpv-ssh"\
		--cache-on-disk="yes"\
		--demuxer-mkv-subtitle-preroll="yes"\
		--stream-buffer-size="4MiB"\
		--title="mpv-ssh - $TITLE_" $@
fi

