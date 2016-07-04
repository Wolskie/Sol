#!/bin/bash -
#===============================================================================
#
#          FILE: build.sh
#
#         USAGE: ./build.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 4/07/2016 13:38
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

rm *.c *.h *.o *.dll *.so *.vapi

valac -o libshared.dll --pkg=gmodule-2.0 --library=libshared -H libshared.h -X -fPIC -X --shared library.vala
valac -o libping.dll --pkg gmodule-2.0 -X --shared libshared.vapi ping.vala --library libping -X libshared.dll -X -I.
valac application.vala libshared.vapi --pkg gmodule-2.0 -X libshared.dll -X -I.



