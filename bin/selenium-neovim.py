#!/usr/bin/env python3
import sys
import pynvim
from selenium import webdriver
driver = webdriver.Firefox()

if len(sys.argv) == 2:
    driver.get(sys.argv[1])

# with pynvim.attach('stdio') as nvim:
with pynvim.attach('socket', path='/tmp/nvim.sock') as nvim:
    nvim.subscribe("SeleniumRefresh")
    while True:
        print("Waiting")
        msg = nvim.next_message()
        print("Refresh")
        driver.refresh()


# TODO: reconnect to a running Selenium session
# TODO: youtube key presses for pause and rewind
