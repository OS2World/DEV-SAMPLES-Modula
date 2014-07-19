===============================================================================
readme.txt             Modula-3 Version 3.6d for OS/2               06-Apr-1997
===============================================================================
                   Copyright (c) 1997 by Klaus Preschern

1. Introduction
  1.1. About the versions
  1.2. Available packages
  1.3. Description of the zip files
  1.4. Dependencies between packages
  1.5. The base system
  1.6. Required Software
2. Installation
  2.1. Unpacking the files
  2.2. Config.sys settings
  2.3. Template settings
3. Compiling Modula-3 programs
  3.1. Building programs
  3.2. Building libraries
4. Further info
  4.1. Books, WWW, newsgroup
  4.2. My e-mail address
  4.3. Known problems and bug reports
  4.4. Acknowledgements

1. Introduction
===============

Modula-3 is a member of the Pascal family of languages. Modula-3 supports
interfaces, objects, generics, threads, isolation of unsafe code, garbage
collection, exceptions and subtyping. For more information about Modula-3
visit the Modula-3 home page

http://www.research.digital.com/SRC/modula-3/html/home.html

This document describes the contents of Modula-3 for OS/2. This
implementation is a port of SRC Modula-3 distributed by the DEC Systems
Research Center. The sources of SRC Modula-3 are available under a
liberal license from ftp://gatekeeper.dec.com/pub/DEC/Modula-3.


1.1. About the versions
-----------------------

This port to OS/2 is based on Modula-3 version 3.6. To distinguish
different versions for OS/2 I append a letter to the version number.

Features of 3.6a (released in Dec. 96):
- does work on Warp 3.0 and Warp 4.0 (Merlin)
- Modula-3 thread scheduling based on a virtual timer signal
- fork() used for process creation
- only static libraries (".a") are supported
- template is "OS2unix"

Features of 3.6b (released in Jan. 97):
- does work on Warp 4.0 (Merlin) - does NOT work on Warp 3.0
- OS/2 native threads used for Modula-3 threads
- DosExecPgm() used for process creation (compiler is faster)
- link386.exe used for building DLLs and executeables
- static libraries (".a") still supported (DLLs are built by default)
- X applications are more stable (no focus lose problem)
- more packages are available (m3browser, network objects, stable, opengl)
- OpenGL implementation based on PM
- does use the GNU backend for code generation
- template is "OS2i386"

Features of 3.6c (released in Mar. 97):
- 3.6c has nearly the same features as 3.6b (3.6c does replace 3.6b)
- compiler with integrated Modula-3 x86 backend (compiles much faster)
- the OpenGL interface is now based on MesaGL and does work with X (not PM)
- it is not possible to mix DLLs of 3.6b and 3.6c
- template is "OS2i386"

Features of 3.6d (released in Apr. 97):
- 3.6d does replace 3.6a (Dec. 96) and is especially for Warp 3.0.
  People with Warp 4.0 should take version 3.6c.
- does work on Warp 3.0 and Warp 4.0 (Merlin)
- Modula-3 thread scheduling based on a virtual timer signal
- DosExecPgm() used for process creation
- static (".a") and dynamic (".DLL") libraries are supported (DLLs default)
- does use the GNU backend for code generation (the M3 backend does not work)
- template is "OS2unix"


1.2. Available packages
-----------------------

Modula-3 for OS/2 3.6d includes:

- the Modula-3 compiler and tools for building DLLs and executeables

- the m3core library. m3core is the minimal base library.

- the libm3 library. libm3 is the library that most others need.

- the m3bundle utility. A program that captures binary data from files as
  Modula-3 source.

- the set library. A simple, generic Set interface.

- the digraph library. A directed graph type, generic over the types
  labeling nodes and edges.

- the table-list library. An association-list-based, generic implementation
  of "Table.T"

- the realgeometry library. A version of the geometry package (Point, Rect,
  Path, ...) with REAL-valued coordinates.

- the parseparams library. A library that helps parse command line arguments.

- the slisp library. A library containing a small Lisp interpreter.

- the tempfiles library. A library to build tempfiles.

- the tcp library. tcp implements a Modula-3 interface to TCP sockets.

- the web library. A library for retrieving documents from the World Wide Web
  using an http proxy server.

- the netobj library. The network objects runtime library, needed by most
  distributed applications.

- the netobjd utility. The network objects daemon, needed by all programs
  using network objects.

- the m3tk library. A (large) Modula-3 abstract syntax tree (AST) toolkit.

- the stubgen utility. The network objects stub generator.

- the stable library. A library providing log-based persistent objects.

- the stablegen utility. A stub generator to make the use of the "stable"
  library much easier

- the X11R4 library. X11R4 implements a Modula-3 interface to the X library.

- the ui library. ui implements the Trestle window-system toolkit. It is used
  by most graphical applications.

- the bicycle library. bicycle is a library of playing card images.

- the solitaire game. A Modula-3 version of SeaHaven towers.

- the m3tools library. A simple Modula-3 scanner.

- the m3browser utility. An HTTP server that provides WWW browsing of the
  installed Modula-3 system (example URL: http://localhost:3829/, no
  proxies, command line: "m3browser -root /m3/lib/m3/pkg", I have used
  m3browser with Netscape Navigator). Not tested with 3.6d.

- the vbtkit library. A large collection of useful window widgets.

- the images library. Support for displaying bitmap images.

- the jvideo library. A low-level interface to the J-video hardware.

- the videovbt library. A window widget that displays live video images.

- the formsvbtpixmaps library. Misc. bitmaps, cursors.

- the formsvbt library. A high-level language based on S-expressions that
  makes it easy to assemble VBTs (windows) using the TeX metaphors of boxes
  and glue.

- the fisheye demo. A demo of "fisheye" views for graph browsing.

- the cube demo. A rotating cube.


1.3. Description of the zip files
---------------------------------

This distribution (3.6d) contains the following files:

  readme.txt               this file
  bicycle.zip              library for playing card images
  cube.zip                 rotating cube demo
  digraph.zip              a directed graph type
  fisheye.zip              a demo of "fisheye" views for graph browsing
  formsvbt.zip             the formsvbt library
  formsvbtpixmaps.zip      library with misc. bitmaps, cursors, ...
  images.zip               support for displaying bitmap images
  jvideo.zip               J-video library
  libm3.zip                general library
  m3.zip                   M3 compiler, GNU backend and make tools
  m3back.zip               M3 compiler x86 backend
  m3browser.zip            a HTTP server for WWW browsing the M3 packages
  m3build.zip              templates required for the M3 make program
  m3bundle.zip             tool for building packages
  m3core.zip               core library
  m3front.zip              M3 compiler front end
  m3linker.zip             M3 linker library
  m3middle.zip             M3 compiler library
  m3objfile.zip            M3 compiler object file writer
  m3tk.zip                 M3 abstract syntax tree (AST) toolkit
  m3tools.zip              a simple M3 scanner
  mtex.zip                 quake function for producing documentation
  netobj.zip               network objects runtime library
  netobjd.zip              network objects daemon
  parseparams.zip          library for parameter parsing
  realgeometry.zip         geometry package with REAL-valued coordinates
  set.zip                  simple, generic set library
  slisp.zip                a library containing a small lisp interpreter
  solitaire.zip            solitaire game
  stable.zip               a library for log-based persistent objects
  stablegen.zip            the stub generator for "stable" objects
  stubgen.zip              the network objects stub generator
  table-list.zip           association-list-based implementation of "Table.T"
  tcp.zip                  tcp interface
  tempfiles.zip            a library to build tempfiles
  test.zip                 very simple example programs
  ui.zip                   Trestle window system toolkit
  vbtkit.zip               window widgets
  videovbt.zip             window widget for video images
  web.zip                  web library
  x11r4.zip                X interface library


1.4. Dependencies between packages
----------------------------------

A package is a library (DLL) or a program with exported Modula-3
interfaces.

The following list shows the dependencies between packages. The first
line shows the package name. The last line shows the DLL of the package
or the executeable name. The lines between the first and last line show
the required DLLs (packages) for building and using it. Programs
using the X11R4 and OpenGL packages require the XFree86 and OpenGL
libraries.

Example: The DLL of the DIGRAPH package is DIGRAPH.DLL and requires
M3CORE, EMXLIBCM and EMX. To use DIGRAPH you have to download and
install the M3CORE package. EMXLIBCM and EMX are part of EMX.
Note: The DLL names and the package names are not always equal.


-------------------- DIGRAPH --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\DIGRAPH.DLL' could be loaded.
-------------------- REALGEOMETRY --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\GEOMETRY.DLL' could be loaded.
-------------------- IMAGES --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\IMAGES.DLL' could be loaded.
-------------------- JVIDEO --------------------
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\JVIDEO.DLL' could be loaded.
-------------------- LIBM3 --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'DOSCALLS' --> loaded.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3.DLL' could be loaded.
-------------------- M3BACK --------------------
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3MIDDLE' --> H:\M3\LIB\M3MIDDLE.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3BACK.DLL' could be loaded.
-------------------- BICYCLE --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3BICYCL.DLL' could be loaded.
-------------------- M3CORE --------------------
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3CORE.DLL' could be loaded.
-------------------- FORMSVBT --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3VBTKIT' --> H:\M3\LIB\M3VBTKIT.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'WEB' --> H:\M3\LIB\WEB.DLL.
Loading DLL 'VIDEOVBT' --> H:\M3\LIB\VIDEOVBT.DLL.
Loading DLL 'M3FORMSV' --> H:\M3\LIB\M3FORMSV.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3FORMS1.DLL' could be loaded.
-------------------- FORMSVBTPIXMAPS --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3FORMSV.DLL' could be loaded.
-------------------- M3FRONT --------------------
Loading DLL 'M3MIDDLE' --> H:\M3\LIB\M3MIDDLE.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3FRONT.DLL' could be loaded.
-------------------- M3LINK --------------------
Loading DLL 'M3MIDDLE' --> H:\M3\LIB\M3MIDDLE.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3LINK.DLL' could be loaded.
-------------------- M3MIDDLE --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3MIDDLE.DLL' could be loaded.
-------------------- NETOBJ --------------------
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3NETOBJ.DLL' could be loaded.
-------------------- M3OBJFILE --------------------
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3MIDDLE' --> H:\M3\LIB\M3MIDDLE.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3OBJFIL.DLL' could be loaded.
-------------------- PARSEPARAMS --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3PARSEP.DLL' could be loaded.
-------------------- SLISP --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3SLISP.DLL' could be loaded.
-------------------- TCP --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3TCP.DLL' could be loaded.
-------------------- M3TK --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3TK.DLL' could be loaded.
-------------------- M3TOOLS --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3TOOLS.DLL' could be loaded.
-------------------- UI --------------------
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3X11R4' --> H:\M3\LIB\M3X11R4.DLL.
Loading DLL 'X11' --> H:\XFREE86\LIB\X11.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3UI.DLL' could be loaded.
-------------------- VBTKIT --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3VBTKIT.DLL' could be loaded.
-------------------- X11R4 --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\M3X11R4.DLL' could be loaded.
-------------------- SET --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\SET.DLL' could be loaded.
-------------------- STABLE --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\STABLE.DLL' could be loaded.
-------------------- TABLE-LIST --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\TABLE-LI.DLL' could be loaded.
-------------------- TEMPFILE --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\TEMPFILE.DLL' could be loaded.
-------------------- VIDEOVBT --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'JVIDEO' --> H:\M3\LIB\JVIDEO.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\VIDEOVBT.DLL' could be loaded.
-------------------- WEB --------------------
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\lib\WEB.DLL' could be loaded.
-------------------- CUBE --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3X11R4' --> H:\M3\LIB\M3X11R4.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3VBTKIT' --> H:\M3\LIB\M3VBTKIT.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'WEB' --> H:\M3\LIB\WEB.DLL.
Loading DLL 'VIDEOVBT' --> H:\M3\LIB\VIDEOVBT.DLL.
Loading DLL 'JVIDEO' --> H:\M3\LIB\JVIDEO.DLL.
Loading DLL 'M3FORMS1' --> H:\M3\LIB\M3FORMS1.DLL.
Loading DLL 'M3FORMSV' --> H:\M3\LIB\M3FORMSV.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\CUBE.EXE' could be loaded.
-------------------- FISHEYE --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3X11R4' --> H:\M3\LIB\M3X11R4.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3VBTKIT' --> H:\M3\LIB\M3VBTKIT.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'WEB' --> H:\M3\LIB\WEB.DLL.
Loading DLL 'VIDEOVBT' --> H:\M3\LIB\VIDEOVBT.DLL.
Loading DLL 'JVIDEO' --> H:\M3\LIB\JVIDEO.DLL.
Loading DLL 'M3FORMS1' --> H:\M3\LIB\M3FORMS1.DLL.
Loading DLL 'M3FORMSV' --> H:\M3\LIB\M3FORMSV.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\FISHEYE.EXE' could be loaded.
-------------------- M3BROWSER --------------------
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3TOOLS' --> H:\M3\LIB\M3TOOLS.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\M3BROWSER.EXE' could be loaded.
-------------------- M3BUNDLE --------------------
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\M3BUNDLE.EXE' could be loaded.
-------------------- NETOBJD --------------------
Loading DLL 'M3NETOBJ' --> H:\M3\LIB\M3NETOBJ.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\NETOBJD.EXE' could be loaded.
-------------------- SOLITAIRE --------------------
Loading DLL 'M3X11R4' --> H:\M3\LIB\M3X11R4.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3UI' --> H:\M3\LIB\M3UI.DLL.
Loading DLL 'M3TCP' --> H:\M3\LIB\M3TCP.DLL.
Loading DLL 'M3BICYCL' --> H:\M3\LIB\M3BICYCL.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\SOLITAIRE.EXE' could be loaded.
-------------------- STABLEGEN --------------------
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3TK' --> H:\M3\LIB\M3TK.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\STABLEGEN.EXE' could be loaded.
-------------------- STUBGEN --------------------
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3TK' --> H:\M3\LIB\M3TK.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by 'h:\m3\bin\STUBGEN.EXE' could be loaded.
-------------------- M3-COMPILER --------------------
Loading DLL 'M3LINK' --> H:\M3\LIB\M3LINK.DLL.
Loading DLL 'M3MIDDLE' --> H:\M3\LIB\M3MIDDLE.DLL.
Loading DLL 'M3CORE' --> H:\M3\LIB\M3CORE.DLL.
Loading DLL 'M3' --> H:\M3\LIB\M3.DLL.
Loading DLL 'M3FRONT' --> H:\M3\LIB\M3FRONT.DLL.
Loading DLL 'EMXLIBCS' --> H:\EMX\DLL\EMXLIBCS.DLL.
Loading DLL 'EMX' --> H:\EMX\DLL\EMX.DLL.
All DLL's used by '\m3\lib\m3\OS2unix\m3.exe' could be loaded.


1.5. The base system
--------------------

If you want use the Modula-3 compiler only, you need:

  m3.zip                    M3 compiler main, GNU backend and make tools
  m3front.zip               M3 compiler frontend
  m3middle.zip              M3 compiler library
  m3core.zip                M3 core library
  libm3.zip                 M3 general library
  m3objfile.zip             M3 compiler object file writer
  m3linker.zip              M3 linker library
  m3build.zip               M3 make tool templates
  EMX with gcc              Unix library/runtime system and GNU C compiler


1.6. Required Software
----------------------

Modula-3 3.6a and 3.6d for OS/2 should work on OS/2 Warp 3.0 and OS/2
Warp 4.0 (Merlin). Versions 3.6b and 3.6c work only on Merlin.

For XFree86 you need Warp 3.0 with at least fixpack 17 or Merlin.

You need at least emx-0.9c fix02. You need the complete development
system (GNU C compiler and friends) and not just the emx runtime.

emx is available for anonymous ftp on

  ftp.uni-stuttgart.de: /pub/systems/os2/emx-0.9c
  ftp-os2.cdrom.com:    /pub/os2/lang/emx09c
  ftp-os2.nmsu.edu:     /os2/unix/emx09c
  ftp.leo.org:          /pub/comp/os/os2/devtools/emx+gcc
  src.doc.ic.ac.uk:     /packages/os2/unix/emx09c

You need XFree86 for OS/2 version 3.2 if you want use the Modula-3 window
system toolkit (Trestle). There is no PM interface available for Trestle.
XFree86 is NOT required if you want use the Modula-3 compiler only.

XFree86/OS2 3.2 is available by anonymous ftp from:

  ftp://ftp.XFree86.org:/pub/XFree86/binaries/OS2
  ftp://borneo.gmd.de:/
  Check first http://borneo.gmd.de:/~veit/os2/xf86os2.html

OpenGL libraries for 3.6b (I have used the version for Merlin) are available
by anonymous ftp from:
  ftp://ftp.austin.ibm.com/pub/developer/os2/OpenGL

Version 3.6c does use MesaGL 2.1 for XFree86/OS2. MesaGL is available at
  http://fly.HiWAAY.net/~abbott/xfree86-os2/xfree86.html
MesaGL is a freeware OpenGL clone. Please send any e-mail relating MesaGL to
abbott@hiwaay.net.

GNU file utilities: If you want use "m3ship" to ship libraries, then you
should have "cp.exe" for copying the files. You need at least a program
which does copy files and does accept "/" as path separator (therefore the
OS/2 copy command does not work). You can find the GNU file utilities
in example on ftp.leo.org.


2. Installation
===============

The current distribution occupies unpacked approx. 20 MB of disk space.
You need a HPFS drive (long filenames) for the installation.


2.1. Unpacking the files
------------------------

Unpack all files in the root directory of the drive you selected for
Modula-3 (in the following I assume you have selected drive "X:").
Unzip will create a "\m3" directory with subdirectories. All
files will be unpacked in this directory and its subdirectories.
If you want remove Modula-3 then you can simply delete this directory.

To unpack a file (example: m3core.zip) do:

  X:
  cd \
  unzip m3core.zip


2.2. Config.sys settings
------------------------

For Modula-3 you need the following environment settings:

SET M3_ROOT=X:/m3                             /* all versions               */
SET PATH=...;X:\m3\bin;...                    /* all versions               */
SET M3_TARGET=OS2unix                         /* for 3.6a/3.6d              */
SET M3_TARGET=OS2i386                         /* for 3.6b/3.6c              */
SET LIBPATH=..;X:\m3\lib;...                  /* for 3.6b/3.6c/3.6d         */

Please replace the "X:" in M3_ROOT and PATH with the drive letter of
the drive where you have installed Modula-3.

M3_TARGET describes the target for which you want generate code. There
are two targets available for OS/2. One is "OS2unix" (distributed with
version 3.6a and 3.6d) and the other is "OS2i386" (distributed with
version 3.6b and 3.6c).

It should be possible (but is not recommended) to use both targets on one
system (install 3.6b/3.6c over 3.6a/3.6d). Note: All targets with DLLs
use X:\m3\lib and the same DLL names! Switching between targets is possible
by changing the M3_TARGET environment variable and renaming the DLL directory.

There are numerous settings required for emx and XFree86. Please
follow carefully the installation descriptions provided with this
software.

Note: The shell used by emx for commands must be able to handle a
large number of command line arguments (cmd.exe does not work!).
bash.exe does work and is therefore recommended.

REM ------------------------ Sample EMX Settings ----------------------------

SET C_INCLUDE_PATH=X:/emx/include
SET LIBRARY_PATH=X:/emx/lib;X:/XFree86/lib
SET CPLUS_INCLUDE_PATH=X:/emx/include/cpp;X:/emx/include
SET PROTODIR=X:/emx/include/cpp/gen
SET OBJC_INCLUDE_PATH=X:/emx/include
SET GCCLOAD=5
SET GCCOPT=-pipe
SET TERM=ansi-color-3
SET TERMCAP=X:/emx/etc/termcap.dat

SET SHELL=X:/emx/bin/bash.exe
SET EMXSHELL=X:/emx/bin/bash.exe
SET TMP=X:/tmp
SET TMPDIR=X:/tmp
SET PROTODIR=X:/emx/include/cpp/gen

REM -------------------- Sample XFree-OS/2 Settings --------------------------

DEVICE=X:\XFree86\lib\xf86sup.sys
SET X11ROOT=X:
SET DISPLAY=your_hostname:0.0
SET XSERVER=X:/XFree86/bin/XF86_S3.exe
SET X11SHELL=c:\os2\cmd.exe

Note: X11SHELL should be cmd.exe. Do not forget to reboot your computer to
activate the config.sys settings.


2.3. Template settings
----------------------

The Modula-3 make program does use a template file to find the interfaces
for compiling and the libraries for linking. You have to set the drive
letters in this template. The templates are in m3build.zip.

The template for 3.6a/3.6d is the file
    "X:\m3\lib\m3\pkg\m3build\templates\OS2unix".

The template for 3.6b/3.6c is the file
    "X:\m3\lib\m3\pkg\m3build\templates\OS2i386".

First make a copy of this file. Then edit this file and set INSTALL_ROOT =
"X:/m3/" ("X:" is the drive letter of the drive where you have installed
Modula-3).

INSTALL_ROOT         = "X:/m3/"

Furthermore change the following constants to match your configuration:

readonly EMX_BIN     = "Y:/emx/bin"
readonly EMX_LIB     = "Y:/emx/lib"
readonly XFREE86_LIB = "Y:/XFree86/lib"
readonly OPENGL_LIB  = "Y:/XFree86/lib"


3. Compiling Modula-3 programs
==============================

The file test.zip contains a few simple example programs. These files are
upacked in \m3\test. There is a "Hello world", a "Hello Trestle", two
examples for network objects and a example for a persistent object.


3.1. Building programs
----------------------

To compile the simple Modula-3 "Hello world" program, do the follwing:

  X:
  cd \m3\test\hello
  m3build

m3build will call the compiler and build the program. The executeable
program is created in "\m3\test\hello\<target>". <target> is "OS2unix"
or "OS2i386". The source code does reside in "\m3\test\hello\src" together
with the Modula-3 make file "m3makefile".

If you want write programs on your own then you should use the same
directory structure. Create a directory "my_project" with a subdirectory
"my_project\src". "my_project\src" should contain your sources and a
m3makefile (samples for simple m3makefiles are in the subdirs of "\m3\test").
If you want compile your sources then cd to "my_project" and call "m3build".
If there are no errors then you can find the executeable in
"my_project\<target>".


3.2. Building libraries
-----------------------

If you want build Modula-3 libraries then I would recommend to start
with one of the available Modula-3 packages. Get the sources of a small
package (in example: "web") and unpack them (say in \m3\m3src\web). Now cd
to \m3\m3src\web and call "m3build". This will create the "web" library in
\m3\m3src\web\<target>. Now you have to call "m3ship" in \m3\m3src\web to
make the library available for linking. m3ship does copy the library and
the interfaces to \m3\lib\m3\pkg\web.


4. Further info
===============

If you want know more about Modula-3, need help or have found a bug
then this section hopefully contains a pointer for you to follow.


4.1. Books, WWW, newsgroup
--------------------------

If you want learn Modula-3 then this book may be useful:

  Samual P. Harbison
  Modula-3
  Prentice Hall, 1992
  ISBN 0-13-596396-6
  (I do not know whether there is already a 2nd edition.)

More advanced users usually prefer "SPwM3":

  Edited by Greg Nelson
  Systems Programming with Modula-3
  Prentice Hall Series in Innovative Technology, 1991
  ISBN 0-13-590464-1

Starting points for the WWW are:

http://www.research.digital.com/SRC/modula-3/html/home.html
http://www.vlsi.polymtl.ca/m3
http://cassis.vlsi.polymtl.ca/m3

The Modula-3 newsgroup is "comp.lang.modula3". If you post something
concerning Modula-3 for OS/2 then it is a good idea to put "M3forOS2:"
in your subject line. Please note: This is the Modula-3 group, therefore
do not discuss something which has nothing to do with Modula-3.

If you send e-mail to "m3@pa.dec.com" then this mail is forwarded
to "comp.lang.modula3".

There are mailing lists for emx and XFree86-OS/2.


4.2. My e-mail address
----------------------

I am Klaus Preschern. My e-mail address is: "klausp@ping.at"
Feel free to use my first name in e-mails you send to me.

I am sorry, but my time for Modula-3 for OS/2 is limited. I will
try to respond to your postings but I do not read my e-mails and
the newsgroup every day.


4.3. Bugs and bug reports
-------------------------

Well, you get what you have paid for. There is absolutely no warranty
for this software. If you cannot accept this, then simply do not use
this software.

There is a problem known with "OS2unix" and graphical applications. Some
applications dump core if the window does lose the focus. You can avoid
this problem by setting the focus with the X window manager to the application
window. I guess this is, because "OS2unix" does use signals for thread
preemtion - the problem disappeared with "OS2i386" (native OS/2 threads).

If you build a program with more than 1024 modules then LINK386 complains
that not more than 1024 external symbols are allowed in the startup module.
You can solve this problem by using ld.exe for linking the main program.
Change the value of the "LINK" variable in the OS2i386 template and use
"gcc" instead of "m3os2lnk".

If you find bugs which have obviously nothing to do with OS/2 please try
to contact the authors of the package or post a bug report to
comp.lang.modula3.


4.4. Acknowledgements
---------------------

I have just ported this great software. But other people have
designed Modula-3, provided the compiler and have written the
libraries and programs. There are many authors and I
cannot mention all of them (see the Modula-3 who is who page on
http://www.vlsi.polymtl.ca/m3).

Therefore thanks much to all people who have contributed to the
Modula-3 project!

Modula-3 for OS/2 would not exist without emx and XFree86 for OS/2.
Many thanks to Sebastien Marineau, Holger Veit (both XFree86) and
Eberhard Mattes (emx).

Thanks to Michel Dagenais for providing disk space on his ftp server
for this distribution.
=========================== end of readme.txt ==============================

