#!/usr/bin/env bash
set -e # exit immediately upon failure
set -x # log all cmds before executing
export FLASK_ENV=development
export FLASK_APP=$(dirname "$0")/NewNoteApp.py
flask run -p 4999
