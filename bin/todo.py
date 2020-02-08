#!/usr/bin/env python3

import re
import subprocess
from collections import OrderedDict


# line numbers can shift between edits and trigger a new/delete
# instead use the filename and todo text to uniquely identify a task as the key
RE_LINENUMBER = re.compile(r':(\d+):')
RE_TODO = r'todo(?!\w)'
TODOFILE = "todo.cfile"
GREPCMD = ["ag",
           "--vimgrep",
           "--path-to-ignore", ".todoignore",
           "--ignore", TODOFILE,
           RE_TODO]

def make_dict(lines):
    d = OrderedDict()
    for line in lines.strip().split('\n'):
        # Remove line number
        key = RE_LINENUMBER.sub('', line, 1)
        d[key] = line
    return d

def todotxt():
    with open(TODOFILE) as fp:
        txt = fp.read()
    return txt

def grep():
    stdout = subprocess.check_output(GREPCMD).decode()
    return stdout

def write(d):
    with open(TODOFILE, 'w') as fp:
        for line in d.values():
            print(line, file=fp)

def main():
    d = make_dict(todotxt())
    g = make_dict(grep())

    d_set = set(d.keys())
    g_set = set(g.keys())

    deleted_keys = d_set - g_set
    new_keys = g_set - d_set

    # remove accomplished tasks
    for k in deleted_keys:
        print("DELETE: ", d[k])
        del d[k]

    # append to end of OrderedDict new tasks
    for k in new_keys:
        print("ADD: ", g[k])
        d[k] = g[k]

    write(d)


if __name__ == "__main__":
    main()


def test_todo(tmp_path):
    import os
    os.chdir(tmp_path)
    positive_matches_text = '''todo
# todo: match this new task
[tag1,TODO,tag2]
"todo-this in new too
'''
    posfile = tmp_path / 'positive_matches.txt'
    posfile.write_text(positive_matches_text)
    negfile = tmp_path / 'negative_matches.txt'
    negfile.write_text('''
todon't
.todoignore
```@autodocs
''')
    (tmp_path / 'ignore.me').write_text('todo: ignore this file')
    todoignorefile = tmp_path / '.todoignore'
    todoignorefile.write_text('ignore.me')
    todocfile = tmp_path / TODOFILE
    todocfile.write_text(
'''positive_matches.txt:3:7:[tag1,TODO,tag2]
deletedfile.txt:3:todo: a deleted file
positive_matches.txt:1:1:todo
positive_matches.txt:3:1:delete a relabeled todo item
''')
    #
    # testing RE_TODO
    out = grep()
    print('grep output:\n', out)
    m = re.match('negative_matches', out)
    # nothinig matches in negative_matches text
    assert m is None
    m = re.findall('positive_matches', out)
    num_positive_matches = len(positive_matches_text.split('\n'))
    # all positive matches are found
    assert num_positive_matches == len(m) + 1, out
    # no ignore files are included
    assert num_positive_matches == len(out.split('\n')), out

    d = make_dict(todotxt())
    print_dict('todo dict', d)

    g = make_dict(grep())
    print_dict('grep dict', g)

    main()
    
    newtodo = open(todocfile).read()
    print('\nnewtodo:\n',newtodo)

    # test if all new items are added
    m = re.findall('new', newtodo)
    assert len(m) == 2

    # test if all deleted items are not present
    m = re.findall('delete', newtodo)
    assert len(m) == 0

    # test if order is kept with existing items
    newtodos = newtodo.split('\n')
    assert newtodos[1] == 'positive_matches.txt:1:1:todo'




def print_dict(name, d):
    print(name)
    for k,v in d.items():
        print(k," : ", v)
    print('-----------------------------------')


def test_regex_linenumber():
    line = 'somedir/somefile.md:23:99:some text with:12:colon'
    key = RE_LINENUMBER.sub('', line, 1)
    assert key == 'somedir/somefile.md99:some text with:12:colon'




# set makeprg=pytest\ -x\ bin/todo.py
