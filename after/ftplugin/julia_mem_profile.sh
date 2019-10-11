julia --track-allocation=user --startup-file=no   memory_profile.jl  $@

# filename.jl.PID.mem:line:     1234 source_code
grep -P -n "^\s*\d+\s" *.jl.*.mem
