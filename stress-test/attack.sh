#!/bin/bash

vegeta attack -targets targets.txt  -rate=10 -duration=60s -workers=10 | tee results.bin
cat results.bin | vegeta report
cat results.bin | vegeta plot > /reports/plot.html
