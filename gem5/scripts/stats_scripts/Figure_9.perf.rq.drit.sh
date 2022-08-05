cd ..
mkdir -p stats_scripts/data 

## Normalized Performance based on Weighted-Speedup Metric ###
## Inverted for Slowdown ##

# 18 SPEC workloads
perl getdata.pl -n 0  -w spec17_single -ipc 4 -ws -printmask 0-1-1-1  -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
    -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
    ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.AQUA.SRAM_TABLES.1K.4C \
    ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RQ.MEMORY_MAPPED_TABLES.1K.4C \
    | sed 's/[_A-Z0-9]*[\/]*AE.AQUA.SRAM_TABLES.1K.4C/AQUA-SRAM/' | sed 's/[_A-Z0-9]*[\/]*_16KB_CACHE_V2.1K.4C/AQUA-DRAM/'  \
    | sed 's/[_A-Z]*\///' | column -t > stats_scripts/data/perf_rq_drit.stat ;

# # MIX-16 workloads
perl getdata.pl -n 0 -nh  -w spec17_mix -ipc 4 -ws -printmask 0-1-1-1  -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
    -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
    ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.AQUA.SRAM_TABLES.1K.4C \
    ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RQ.MEMORY_MAPPED_TABLES.1K.4C \
    | sed 's/[_A-Z]*\///' | column -t  >> stats_scripts/data/perf_rq_drit.stat ;

echo ".  0  0" | column -t >> stats_scripts/data/perf_rq_drit.stat ;

# Avg - ALL-34
perl getdata.pl -gmean -n 0 -nh -ns -gmean -w spec17_all  -ipc 4 -ws -printmask 0-1-1-1  -b ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C1/AE.BASELINE.1C \
    -d ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.BASELINE.4C \
    ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.AQUA.SRAM_TABLES.1K.4C \
    ../stats/multiprogram_16GBmem_250Mn.SPEC2017.C4/AE.RQ.MEMORY_MAPPED_TABLES.1K.4C \
    | sed 's/Gmean/Gmean-34/' | column -t >> stats_scripts/data/perf_rq_drit.stat;

# Format
cat stats_scripts/data/perf_rq_drit.stat
