from flask import Flask, request
import subprocess
import datetime
import logging

app = Flask(__name__)

@app.route('/NewNote',methods=["POST"])
def NewNote():
  date = datetime.datetime.now().isoformat(timespec='seconds')
  title = request.args.get('title')
  url = request.args.get('url')
  cmd = f"+NewNoteBookmark {date}\t{title}\t{url}"
  logging.info(f'date = {date}')
  logging.info(f'title = {title}')
  logging.info(f'url = {url}')
  subprocess.run(args=['gnome-terminal','-x','nvim',cmd,'+ToggleAutoPaste'])
  return ''
