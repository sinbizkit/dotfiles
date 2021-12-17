set ncpu 4

switch  (uname)
case Linux
	set ncpu (nproc)
case Darwin
	set ncpu (sysctl -n hw.ncpu)
end

set -x CMAKE_BUILD_PARALLEL_LEVEL $ncpu
set -x CTEST_PARALLEL_LEVEL       $ncpu

