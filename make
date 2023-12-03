#!/bin/sh
wla-65816 -v -s -o main.o asm/main.asm > log &&
echo \[objects]\ > linkfile &&
echo main.o >> linkfile &&
wlalink -D -A -v -S linkfile rom/dls_br.sfc &&
rm linkfile &&
rm *.o &&
perl ./tools/abcde/abcde.pl -cm abcde::Atlas rom/dls_br.sfc txt/jgd_br.txt
