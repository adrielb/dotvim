command! -buffer SystemctlUserEnable !systemctl --user enable %:p
command! -buffer SystemctlUserDaemonReload !systemctl --user daemon-reload
command! -buffer SystemdAnalyzeVerify !systemd-analyze verify %:p
command! -buffer SystemctlUserStart !systemctl --user start %:t
command! -buffer SystemctlUserStatus !systemctl --user status %:t:r
command! -buffer JournalctlUserFollow terminal journalctl --user --follow --unit  %:t:r
command! -buffer SystemctlUserListTimers !systemctl --user list-timers
command! -buffer SystemctlUserListUnitFiles !systemctl --user list-unit-files
command! -buffer SystemctlUserListUnitFilesEnabled !systemctl --user list-unit-files --state=enabled
