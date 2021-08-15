#-------------------------------------------------------------------------------
# General.
#-------------------------------------------------------------------------------
set index-cache on
set auto-load local-gdbinit on
set auto-load safe-path /

set breakpoint pending on
set print thread-events off

set python print-stack full

#-------------------------------------------------------------------------------
# Third-party modules.
#-------------------------------------------------------------------------------
# Modular visual interface for GDB in Python.
# Source: https://github.com/cyrus-and/gdb-dashboard
source ~/.config/gdb/dashboard/.gdbinit

# STL pretty-printers.
python
import sys
try:
    stl_pp_path = os.environ['HOME'] + '/.local/share/gdb/stl'
    sys.path.insert(0, stl_pp_path)
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
except Exception:
    pass
end

# Qt5 pretty-printers (Provided by KDE community).
python
import sys
try:
    qt5_pp_path = os.path.join(os.environ['HOME'], '.local/share/gdb/qt5')
    sys.path.append(qt5_pp_path)
    from printers import register_qt_printers
    register_qt_printers(None)
except Exception as e:
    print("Qt5 Printers: Exception occured - ", e)
    pass
end

#-------------------------------------------------------------------------------
# Dashboard settings.
#-------------------------------------------------------------------------------
define hookpost-up
dashboard
end

define hookpost-down
dashboard
end

dashboard source -style height 30
dashboard source -style tab-size 4
dashboard stack  -style compact 1
dashboard -style syntax_highlighting 'monokai'
dashboard -layout source stack history expressions !assembly !registers !threads !memory

python

import os
import gdb

try:
    tty_output = os.environ['GDB_TTY_OUTPUT']
    gdb.execute('dashboard -output {}'.format(tty_output))
except:
    pass

try:
    tty_source = os.environ['GDB_TTY_SOURCE']
    gdb.execute('dashboard source -output {}'.format(tty_source))
except:
    pass
try:
    tty_stack = os.environ['GDB_TTY_STACK']
    gdb.execute('dashboard stack -output {}'.format(tty_stack))
except:
    pass
end

