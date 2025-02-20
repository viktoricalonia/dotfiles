#!/bin/bash
MINWAIT=10
MAXWAIT=30
while [ 1 ];
do
  sleep $((MINWAIT+RANDOM % (MAXWAIT-MINWAIT)))
  cliclick m:${RANDOM:0:3},${RANDOM:0:3};      
done
