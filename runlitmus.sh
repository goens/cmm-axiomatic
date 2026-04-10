#!/bin/bash

ALLOY_JAR=~/code/org.alloytools.alloy/org.alloytools.alloy.dist/target/org.alloytools.alloy.dist.jar
OUTPUT=results.csv
DIR=$1
echo "test,expected,result" >$OUTPUT
for TEST in $(ls $DIR/*.als); do
  if [[ "${TEST##*/}" == "ptx.als" || "${TEST##*/}" == "util.als" ]]; then
    continue
  fi
  echo ${TEST##*/}
  echo -n ${TEST##*/}, >>$OUTPUT
  echo -n "," >>$OUTPUT
  java -jar --enable-native-access=ALL-UNNAMED $ALLOY_JAR exec -f -o alloyout $TEST 2>&1 | tee runlitmus.log | grep -o -e "[^N]SAT" -e "UNSAT" >>$OUTPUT
  cat runlitmus.log
done
