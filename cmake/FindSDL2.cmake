find_package(PkgConfig QUIET)
pkg_check_modules(PC_SDL2 sdl2)

set_extra_dirs(SDL2 sdl)

# Looking for 'SDL.h' directly might accidently find a SDL instead of SDL 2
# installation. Look for a header file only present in SDL 2 instead.
find_path(SDL2_INCLUDEDIR SDL_assert.h
  PATH_SUFFIXES SDL2
  HINTS ${HINTS_SDL2_INCLUDEDIR} ${PC_SDL2_INCLUDEDIR} ${PC_SDL2_INCLUDE_DIRS}
  PATHS ${PATHS_SDL2_INCLUDEDIR}
)
find_library(SDL2_LIBRARY
  NAMES SDL2
  HINTS ${HINTS_SDL2_LIBDIR} ${PC_SDL2_LIBDIR} ${PC_SDL2_LIBRARY_DIRS}
  PATHS ${PATHS_SDL2_LIBDIR}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2 DEFAULT_MSG SDL2_LIBRARY SDL2_INCLUDEDIR)

mark_as_advanced(SDL2_LIBRARY SDL2_INCLUDEDIR)

set(SDL2_LIBRARIES ${SDL2_LIBRARY})
set(SDL2_INCLUDE_DIRS ${SDL2_INCLUDEDIR})

string(FIND "${SDL2_LIBRARY}" "${PROJECT_SOURCE_DIR}" LOCAL_PATH_POS)
if(LOCAL_PATH_POS EQUAL 0 AND TARGET_OS STREQUAL "windows")
  set(SDL2_COPY_FILES "${EXTRA_SDL2_LIBDIR}/SDL2.dll")
else()
  set(SDL2_COPY_FILES)
endif()
