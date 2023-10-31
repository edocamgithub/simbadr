#!/bin/bash
simbadr_setup=$(simbadr-read-conf.sh -s)
SIMBADR_ALL_GROUPS=$(grep -w group_enable $simbadr_setup"simbadr" | cut -d= -f2)
env $SIMBADR_ALL_GROUPS
