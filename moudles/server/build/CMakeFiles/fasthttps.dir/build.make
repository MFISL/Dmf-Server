# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pzc/Dmfserver/dmfserver/core/server

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pzc/Dmfserver/dmfserver/core/server/build

# Include any dependencies generated for this target.
include CMakeFiles/fasthttps.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/fasthttps.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/fasthttps.dir/flags.make

CMakeFiles/fasthttps.dir/dm_events.c.o: CMakeFiles/fasthttps.dir/flags.make
CMakeFiles/fasthttps.dir/dm_events.c.o: ../dm_events.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/fasthttps.dir/dm_events.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fasthttps.dir/dm_events.c.o   -c /home/pzc/Dmfserver/dmfserver/core/server/dm_events.c

CMakeFiles/fasthttps.dir/dm_events.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fasthttps.dir/dm_events.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pzc/Dmfserver/dmfserver/core/server/dm_events.c > CMakeFiles/fasthttps.dir/dm_events.c.i

CMakeFiles/fasthttps.dir/dm_events.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fasthttps.dir/dm_events.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pzc/Dmfserver/dmfserver/core/server/dm_events.c -o CMakeFiles/fasthttps.dir/dm_events.c.s

CMakeFiles/fasthttps.dir/dm_master.c.o: CMakeFiles/fasthttps.dir/flags.make
CMakeFiles/fasthttps.dir/dm_master.c.o: ../dm_master.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/fasthttps.dir/dm_master.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fasthttps.dir/dm_master.c.o   -c /home/pzc/Dmfserver/dmfserver/core/server/dm_master.c

CMakeFiles/fasthttps.dir/dm_master.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fasthttps.dir/dm_master.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pzc/Dmfserver/dmfserver/core/server/dm_master.c > CMakeFiles/fasthttps.dir/dm_master.c.i

CMakeFiles/fasthttps.dir/dm_master.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fasthttps.dir/dm_master.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pzc/Dmfserver/dmfserver/core/server/dm_master.c -o CMakeFiles/fasthttps.dir/dm_master.c.s

CMakeFiles/fasthttps.dir/dm_server.c.o: CMakeFiles/fasthttps.dir/flags.make
CMakeFiles/fasthttps.dir/dm_server.c.o: ../dm_server.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/fasthttps.dir/dm_server.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fasthttps.dir/dm_server.c.o   -c /home/pzc/Dmfserver/dmfserver/core/server/dm_server.c

CMakeFiles/fasthttps.dir/dm_server.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fasthttps.dir/dm_server.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pzc/Dmfserver/dmfserver/core/server/dm_server.c > CMakeFiles/fasthttps.dir/dm_server.c.i

CMakeFiles/fasthttps.dir/dm_server.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fasthttps.dir/dm_server.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pzc/Dmfserver/dmfserver/core/server/dm_server.c -o CMakeFiles/fasthttps.dir/dm_server.c.s

CMakeFiles/fasthttps.dir/dm_socket.c.o: CMakeFiles/fasthttps.dir/flags.make
CMakeFiles/fasthttps.dir/dm_socket.c.o: ../dm_socket.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/fasthttps.dir/dm_socket.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fasthttps.dir/dm_socket.c.o   -c /home/pzc/Dmfserver/dmfserver/core/server/dm_socket.c

CMakeFiles/fasthttps.dir/dm_socket.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fasthttps.dir/dm_socket.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pzc/Dmfserver/dmfserver/core/server/dm_socket.c > CMakeFiles/fasthttps.dir/dm_socket.c.i

CMakeFiles/fasthttps.dir/dm_socket.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fasthttps.dir/dm_socket.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pzc/Dmfserver/dmfserver/core/server/dm_socket.c -o CMakeFiles/fasthttps.dir/dm_socket.c.s

CMakeFiles/fasthttps.dir/dm_threading_pool.c.o: CMakeFiles/fasthttps.dir/flags.make
CMakeFiles/fasthttps.dir/dm_threading_pool.c.o: ../dm_threading_pool.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/fasthttps.dir/dm_threading_pool.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fasthttps.dir/dm_threading_pool.c.o   -c /home/pzc/Dmfserver/dmfserver/core/server/dm_threading_pool.c

CMakeFiles/fasthttps.dir/dm_threading_pool.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fasthttps.dir/dm_threading_pool.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pzc/Dmfserver/dmfserver/core/server/dm_threading_pool.c > CMakeFiles/fasthttps.dir/dm_threading_pool.c.i

CMakeFiles/fasthttps.dir/dm_threading_pool.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fasthttps.dir/dm_threading_pool.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pzc/Dmfserver/dmfserver/core/server/dm_threading_pool.c -o CMakeFiles/fasthttps.dir/dm_threading_pool.c.s

CMakeFiles/fasthttps.dir/dm_timer.c.o: CMakeFiles/fasthttps.dir/flags.make
CMakeFiles/fasthttps.dir/dm_timer.c.o: ../dm_timer.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/fasthttps.dir/dm_timer.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fasthttps.dir/dm_timer.c.o   -c /home/pzc/Dmfserver/dmfserver/core/server/dm_timer.c

CMakeFiles/fasthttps.dir/dm_timer.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fasthttps.dir/dm_timer.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pzc/Dmfserver/dmfserver/core/server/dm_timer.c > CMakeFiles/fasthttps.dir/dm_timer.c.i

CMakeFiles/fasthttps.dir/dm_timer.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fasthttps.dir/dm_timer.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pzc/Dmfserver/dmfserver/core/server/dm_timer.c -o CMakeFiles/fasthttps.dir/dm_timer.c.s

CMakeFiles/fasthttps.dir/main.c.o: CMakeFiles/fasthttps.dir/flags.make
CMakeFiles/fasthttps.dir/main.c.o: ../main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object CMakeFiles/fasthttps.dir/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fasthttps.dir/main.c.o   -c /home/pzc/Dmfserver/dmfserver/core/server/main.c

CMakeFiles/fasthttps.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fasthttps.dir/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pzc/Dmfserver/dmfserver/core/server/main.c > CMakeFiles/fasthttps.dir/main.c.i

CMakeFiles/fasthttps.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fasthttps.dir/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pzc/Dmfserver/dmfserver/core/server/main.c -o CMakeFiles/fasthttps.dir/main.c.s

# Object files for target fasthttps
fasthttps_OBJECTS = \
"CMakeFiles/fasthttps.dir/dm_events.c.o" \
"CMakeFiles/fasthttps.dir/dm_master.c.o" \
"CMakeFiles/fasthttps.dir/dm_server.c.o" \
"CMakeFiles/fasthttps.dir/dm_socket.c.o" \
"CMakeFiles/fasthttps.dir/dm_threading_pool.c.o" \
"CMakeFiles/fasthttps.dir/dm_timer.c.o" \
"CMakeFiles/fasthttps.dir/main.c.o"

# External object files for target fasthttps
fasthttps_EXTERNAL_OBJECTS =

fasthttps: CMakeFiles/fasthttps.dir/dm_events.c.o
fasthttps: CMakeFiles/fasthttps.dir/dm_master.c.o
fasthttps: CMakeFiles/fasthttps.dir/dm_server.c.o
fasthttps: CMakeFiles/fasthttps.dir/dm_socket.c.o
fasthttps: CMakeFiles/fasthttps.dir/dm_threading_pool.c.o
fasthttps: CMakeFiles/fasthttps.dir/dm_timer.c.o
fasthttps: CMakeFiles/fasthttps.dir/main.c.o
fasthttps: CMakeFiles/fasthttps.dir/build.make
fasthttps: CMakeFiles/fasthttps.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Linking C executable fasthttps"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fasthttps.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/fasthttps.dir/build: fasthttps

.PHONY : CMakeFiles/fasthttps.dir/build

CMakeFiles/fasthttps.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/fasthttps.dir/cmake_clean.cmake
.PHONY : CMakeFiles/fasthttps.dir/clean

CMakeFiles/fasthttps.dir/depend:
	cd /home/pzc/Dmfserver/dmfserver/core/server/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pzc/Dmfserver/dmfserver/core/server /home/pzc/Dmfserver/dmfserver/core/server /home/pzc/Dmfserver/dmfserver/core/server/build /home/pzc/Dmfserver/dmfserver/core/server/build /home/pzc/Dmfserver/dmfserver/core/server/build/CMakeFiles/fasthttps.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/fasthttps.dir/depend

