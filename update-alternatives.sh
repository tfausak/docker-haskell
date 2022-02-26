#! /usr/bin/env sh

# Exit if any command fails.
set -o errexit

# Set target directory to install alternatives into. Anything on the $PATH
# should work.
bin=/usr/local/bin

# Set the priority to use for the alternatives. Larger numbers are higher
# priority.
priority=0

# Ensure there is exactly one argument.
if test "$#" -ne 1
then
  echo "Usage: $0 CLANG_VERSION"
  exit 1
fi

# Log commands as they're executed.
set -o xtrace

# Get full paths to all commands.
asan_symbolize=$( command -v "asan_symbolize-$1" )
bugpoint=$( command -v "bugpoint-$1" )
clang__=$( command -v "clang++-$1" )
clang_cpp=$( command -v "clang-cpp-$1" )
clang=$( command -v "clang-$1" )
count=$( command -v "count-$1" )
dsymutil=$( command -v "dsymutil-$1" )
FileCheck=$( command -v "FileCheck-$1" )
llc=$( command -v "llc-$1" )
lli_child_target=$( command -v "lli-child-target-$1" )
lli=$( command -v "lli-$1" )
llvm_addr2line=$( command -v "llvm-addr2line-$1" )
llvm_ar=$( command -v "llvm-ar-$1" )
llvm_as=$( command -v "llvm-as-$1" )
llvm_bcanalyzer=$( command -v "llvm-bcanalyzer-$1" )
llvm_bitcode_strip=$( command -v "llvm-bitcode-strip-$1" )
llvm_c_test=$( command -v "llvm-c-test-$1" )
llvm_cat=$( command -v "llvm-cat-$1" )
llvm_cfi_verify=$( command -v "llvm-cfi-verify-$1" )
llvm_config=$( command -v "llvm-config-$1" )
llvm_cov=$( command -v "llvm-cov-$1" )
llvm_cvtres=$( command -v "llvm-cvtres-$1" )
llvm_cxxdump=$( command -v "llvm-cxxdump-$1" )
llvm_cxxfilt=$( command -v "llvm-cxxfilt-$1" )
llvm_cxxmap=$( command -v "llvm-cxxmap-$1" )
llvm_diff=$( command -v "llvm-diff-$1" )
llvm_dis=$( command -v "llvm-dis-$1" )
llvm_dlltool=$( command -v "llvm-dlltool-$1" )
llvm_dwarfdump=$( command -v "llvm-dwarfdump-$1" )
llvm_dwp=$( command -v "llvm-dwp-$1" )
llvm_elfabi=$( command -v "llvm-elfabi-$1" )
llvm_exegesis=$( command -v "llvm-exegesis-$1" )
llvm_extract=$( command -v "llvm-extract-$1" )
llvm_gsymutil=$( command -v "llvm-gsymutil-$1" )
llvm_ifs=$( command -v "llvm-ifs-$1" )
llvm_install_name_tool=$( command -v "llvm-install-name-tool-$1" )
llvm_jitlink_executor=$( command -v "llvm-jitlink-executor-$1" )
llvm_jitlink=$( command -v "llvm-jitlink-$1" )
llvm_lib=$( command -v "llvm-lib-$1" )
llvm_libtool_darwin=$( command -v "llvm-libtool-darwin-$1" )
llvm_link=$( command -v "llvm-link-$1" )
llvm_lipo=$( command -v "llvm-lipo-$1" )
llvm_lto=$( command -v "llvm-lto-$1" )
llvm_lto2=$( command -v "llvm-lto2-$1" )
llvm_mc=$( command -v "llvm-mc-$1" )
llvm_mca=$( command -v "llvm-mca-$1" )
llvm_ml=$( command -v "llvm-ml-$1" )
llvm_modextract=$( command -v "llvm-modextract-$1" )
llvm_mt=$( command -v "llvm-mt-$1" )
llvm_nm=$( command -v "llvm-nm-$1" )
llvm_objcopy=$( command -v "llvm-objcopy-$1" )
llvm_objdump=$( command -v "llvm-objdump-$1" )
llvm_opt_report=$( command -v "llvm-opt-report-$1" )
llvm_pdbutil=$( command -v "llvm-pdbutil-$1" )
llvm_PerfectShuffle=$( command -v "llvm-PerfectShuffle-$1" )
llvm_profdata=$( command -v "llvm-profdata-$1" )
llvm_profgen=$( command -v "llvm-profgen-$1" )
llvm_ranlib=$( command -v "llvm-ranlib-$1" )
llvm_rc=$( command -v "llvm-rc-$1" )
llvm_readelf=$( command -v "llvm-readelf-$1" )
llvm_readobj=$( command -v "llvm-readobj-$1" )
llvm_reduce=$( command -v "llvm-reduce-$1" )
llvm_rtdyld=$( command -v "llvm-rtdyld-$1" )
llvm_size=$( command -v "llvm-size-$1" )
llvm_split=$( command -v "llvm-split-$1" )
llvm_stress=$( command -v "llvm-stress-$1" )
llvm_strings=$( command -v "llvm-strings-$1" )
llvm_strip=$( command -v "llvm-strip-$1" )
llvm_symbolizer=$( command -v "llvm-symbolizer-$1" )
llvm_tblgen=$( command -v "llvm-tblgen-$1" )
llvm_undname=$( command -v "llvm-undname-$1" )
llvm_xray=$( command -v "llvm-xray-$1" )
not=$( command -v "not-$1" )
obj2yaml=$( command -v "obj2yaml-$1" )
opt=$( command -v "opt-$1" )
sanstats=$( command -v "sanstats-$1" )
split_file=$( command -v "split-file-$1" )
verify_uselistorder=$( command -v "verify-uselistorder-$1" )
yaml_bench=$( command -v "yaml-bench-$1" )
yaml2obj=$( command -v "yaml2obj-$1" )

# Install alternatives.
update-alternatives --install "$bin/clang" clang "$clang" "$priority" \
  --slave "$bin/asan_symbolize" asan_symbolize "$asan_symbolize" \
  --slave "$bin/bugpoint" bugpoint "$bugpoint" \
  --slave "$bin/clang-cpp" clang-cpp "$clang_cpp" \
  --slave "$bin/clang++" clang++ "$clang__" \
  --slave "$bin/count" count "$count" \
  --slave "$bin/dsymutil" dsymutil "$dsymutil" \
  --slave "$bin/FileCheck" FileCheck "$FileCheck" \
  --slave "$bin/llc" llc "$llc" \
  --slave "$bin/lli-child-target" lli-child-target "$lli_child_target" \
  --slave "$bin/lli" lli "$lli" \
  --slave "$bin/llvm-addr2line" llvm-addr2line "$llvm_addr2line" \
  --slave "$bin/llvm-ar" llvm-ar "$llvm_ar" \
  --slave "$bin/llvm-as" llvm-as "$llvm_as" \
  --slave "$bin/llvm-bcanalyzer" llvm-bcanalyzer "$llvm_bcanalyzer" \
  --slave "$bin/llvm-bitcode-strip" llvm-bitcode-strip "$llvm_bitcode_strip" \
  --slave "$bin/llvm-c-test" llvm-c-test "$llvm_c_test" \
  --slave "$bin/llvm-cat" llvm-cat "$llvm_cat" \
  --slave "$bin/llvm-cfi-verify" llvm-cfi-verify "$llvm_cfi_verify" \
  --slave "$bin/llvm-config" llvm-config "$llvm_config" \
  --slave "$bin/llvm-cov" llvm-cov "$llvm_cov" \
  --slave "$bin/llvm-cvtres" llvm-cvtres "$llvm_cvtres" \
  --slave "$bin/llvm-cxxdump" llvm-cxxdump "$llvm_cxxdump" \
  --slave "$bin/llvm-cxxfilt" llvm-cxxfilt "$llvm_cxxfilt" \
  --slave "$bin/llvm-cxxmap" llvm-cxxmap "$llvm_cxxmap" \
  --slave "$bin/llvm-diff" llvm-diff "$llvm_diff" \
  --slave "$bin/llvm-dis" llvm-dis "$llvm_dis" \
  --slave "$bin/llvm-dlltool" llvm-dlltool "$llvm_dlltool" \
  --slave "$bin/llvm-dwarfdump" llvm-dwarfdump "$llvm_dwarfdump" \
  --slave "$bin/llvm-dwp" llvm-dwp "$llvm_dwp" \
  --slave "$bin/llvm-elfabi" llvm-elfabi "$llvm_elfabi" \
  --slave "$bin/llvm-exegesis" llvm-exegesis "$llvm_exegesis" \
  --slave "$bin/llvm-extract" llvm-extract "$llvm_extract" \
  --slave "$bin/llvm-gsymutil" llvm-gsymutil "$llvm_gsymutil" \
  --slave "$bin/llvm-ifs" llvm-ifs "$llvm_ifs" \
  --slave "$bin/llvm-install-name-tool" llvm-install-name-tool "$llvm_install_name_tool" \
  --slave "$bin/llvm-jitlink-executor" llvm-jitlink-executor "$llvm_jitlink_executor" \
  --slave "$bin/llvm-jitlink" llvm-jitlink "$llvm_jitlink" \
  --slave "$bin/llvm-lib" llvm-lib "$llvm_lib" \
  --slave "$bin/llvm-libtool-darwin" llvm-libtool-darwin "$llvm_libtool_darwin" \
  --slave "$bin/llvm-link" llvm-link "$llvm_link" \
  --slave "$bin/llvm-lipo" llvm-lipo "$llvm_lipo" \
  --slave "$bin/llvm-lto" llvm-lto "$llvm_lto" \
  --slave "$bin/llvm-lto2" llvm-lto2 "$llvm_lto2" \
  --slave "$bin/llvm-mc" llvm-mc "$llvm_mc" \
  --slave "$bin/llvm-mca" llvm-mca "$llvm_mca" \
  --slave "$bin/llvm-ml" llvm-ml "$llvm_ml" \
  --slave "$bin/llvm-modextract" llvm-modextract "$llvm_modextract" \
  --slave "$bin/llvm-mt" llvm-mt "$llvm_mt" \
  --slave "$bin/llvm-nm" llvm-nm "$llvm_nm" \
  --slave "$bin/llvm-objcopy" llvm-objcopy "$llvm_objcopy" \
  --slave "$bin/llvm-objdump" llvm-objdump "$llvm_objdump" \
  --slave "$bin/llvm-opt-report" llvm-opt-report "$llvm_opt_report" \
  --slave "$bin/llvm-pdbutil" llvm-pdbutil "$llvm_pdbutil" \
  --slave "$bin/llvm-PerfectShuffle" llvm-PerfectShuffle "$llvm_PerfectShuffle" \
  --slave "$bin/llvm-profdata" llvm-profdata "$llvm_profdata" \
  --slave "$bin/llvm-profgen" llvm-profgen "$llvm_profgen" \
  --slave "$bin/llvm-ranlib" llvm-ranlib "$llvm_ranlib" \
  --slave "$bin/llvm-rc" llvm-rc "$llvm_rc" \
  --slave "$bin/llvm-readelf" llvm-readelf "$llvm_readelf" \
  --slave "$bin/llvm-readobj" llvm-readobj "$llvm_readobj" \
  --slave "$bin/llvm-reduce" llvm-reduce "$llvm_reduce" \
  --slave "$bin/llvm-rtdyld" llvm-rtdyld "$llvm_rtdyld" \
  --slave "$bin/llvm-size" llvm-size "$llvm_size" \
  --slave "$bin/llvm-split" llvm-split "$llvm_split" \
  --slave "$bin/llvm-stress" llvm-stress "$llvm_stress" \
  --slave "$bin/llvm-strings" llvm-strings "$llvm_strings" \
  --slave "$bin/llvm-strip" llvm-strip "$llvm_strip" \
  --slave "$bin/llvm-symbolizer" llvm-symbolizer "$llvm_symbolizer" \
  --slave "$bin/llvm-tblgen" llvm-tblgen "$llvm_tblgen" \
  --slave "$bin/llvm-undname" llvm-undname "$llvm_undname" \
  --slave "$bin/llvm-xray" llvm-xray "$llvm_xray" \
  --slave "$bin/not" not "$not" \
  --slave "$bin/obj2yaml" obj2yaml "$obj2yaml" \
  --slave "$bin/opt" opt "$opt" \
  --slave "$bin/sanstats" sanstats "$sanstats" \
  --slave "$bin/split-file" split-file "$split_file" \
  --slave "$bin/verify-uselistorder" verify-uselistorder "$verify_uselistorder" \
  --slave "$bin/yaml-bench" yaml-bench "$yaml_bench" \
  --slave "$bin/yaml2obj" yaml2obj "$yaml2obj" \
