#!/bin/bash
set -o pipefail # exit status 0 only if all cmds 0
set -e # exit immediately upon failure
# set -x # log all cmds before executing


CFILE="todo.cfile"
GREPFILE=$(mktemp /tmp/grepfile-XXX)
DELETED=$(mktemp /tmp/deleted-XXX)
CFILEBAK=$(mktemp /tmp/cfile-XXX)

grep --recursive --ignore-case --line-number \
     --include=\*.md --exclude=todo.md todo > $GREPFILE

# New items found in GREPFILE are appended to CFILE
comm -13 <(sort $CFILE) <(sort $GREPFILE) >> $CFILE

# lines in CFILE not in GREPFILE need to be DELETED from CFILE
comm -23 <(sort $CFILE) <(sort $GREPFILE) > $DELETED

# grep can't write to output file
cp $CFILE $CFILEBAK

# match the whole line in file, 
# interpreted as a fixed string, not a regex,
# invert to get lines that should be kepted, not deleted
grep --line-regexp --fixed-strings --invert-match --file=$DELETED $CFILEBAK > $CFILE

# clean up temp files
# rm $GREPFILE $DELETED $CFILEBAK


# using gawk instead of grep:
# maintain order in CFILE by
# BEGIN: add DELETED lines to dictionary
# if CFILE line $0 in dictionary, do not print
# gawk -i inplace '
# BEGIN {
#   while( (getline deleted_line < "/tmp/del") > 0 ) {
#     x[deleted_line]++
#   }
# }
# !x[$0]++
# ' $CFILE
