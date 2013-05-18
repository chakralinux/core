#!/bin/bash

if [ -e version.tag ]; then
  /bin/echo -n `cat version.tag`
fi
