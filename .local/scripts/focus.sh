#!/bin/bash

while [ 1 ];
do
  sleep 20;
  MAXCOUNT=${RANDOM:0:2}
  count=1
  while [ "$count" -le $MAXCOUNT ]      # Generate 10 ($MAXCOUNT) random integers.
  do
    cliclick m:${RANDOM:0:3},${RANDOM:0:3};
    sleep ${RANDOM:0:1};
    cliclick m:${RANDOM:0:3},${RANDOM:0:3};
    let "count += 1"  # Increment count.
  done
  
  sleep 10;
  MAXCOUNT=${RANDOM:0:2}
  count=1
  while [ "$count" -le $MAXCOUNT ]      # Generate 10 ($MAXCOUNT) random integers.
  do
    cliclick m:${RANDOM:0:3},${RANDOM:0:3};
    sleep ${RANDOM:0:1};
    cliclick m:${RANDOM:0:3},${RANDOM:0:3};
    let "count += 1"  # Increment count.
  done

  MAXCOUNT=${RANDOM:0:1}
    count=1
    while [ "$count" -le $MAXCOUNT ]     # Generate 10 ($MAXCOUNT) random integers.
    do
      cliclick m:${RANDOM:0:3},${RANDOM:0:3};
      sleep ${RANDOM:0:1};
      cliclick m:${RANDOM:0:3},${RANDOM:0:3};
      sleep ${RANDOM:0:1};
      cliclick m:${RANDOM:0:3},${RANDOM:0:3};      
      sleep ${RANDOM:0:1};
      cliclick m:${RANDOM:0:3},${RANDOM:0:3};      
      sleep ${RANDOM:0:1};
      cliclick m:${RANDOM:0:3},${RANDOM:0:3};      
      sleep ${RANDOM:0:1};
      let "count += 1"; # Increment count.
    done
done
