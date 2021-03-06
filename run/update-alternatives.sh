#! /usr/bin/env sh
set -o errexit -o xtrace

# Set target directory to install alternatives into. Anything on the $PATH
# should work.
bin=/usr/local/bin

# Set the priority to use for the alternatives. Larger numbers are higher
# priority.
priority=0

# Get full paths to all commands.
asan_symbolize=$( command -v "asan_symbolize-$CLANG_VERSION" )
bugpoint=$( command -v "bugpoint-$CLANG_VERSION" )
clang__=$( command -v "clang++-$CLANG_VERSION" )
clang_cpp=$( command -v "clang-cpp-$CLANG_VERSION" )
clang=$( command -v "clang-$CLANG_VERSION" )
count=$( command -v "count-$CLANG_VERSION" )
dsymutil=$( command -v "dsymutil-$CLANG_VERSION" )
FileCheck=$( command -v "FileCheck-$CLANG_VERSION" )
llc=$( command -v "llc-$CLANG_VERSION" )
lli_child_target=$( command -v "lli-child-target-$CLANG_VERSION" )
lli=$( command -v "lli-$CLANG_VERSION" )
llvm_addr2line=$( command -v "llvm-addr2line-$CLANG_VERSION" )
llvm_ar=$( command -v "llvm-ar-$CLANG_VERSION" )
llvm_as=$( command -v "llvm-as-$CLANG_VERSION" )
llvm_bcanalyzer=$( command -v "llvm-bcanalyzer-$CLANG_VERSION" )
llvm_bitcode_strip=$( command -v "llvm-bitcode-strip-$CLANG_VERSION" )
llvm_c_test=$( command -v "llvm-c-test-$CLANG_VERSION" )
llvm_cat=$( command -v "llvm-cat-$CLANG_VERSION" )
llvm_cfi_verify=$( command -v "llvm-cfi-verify-$CLANG_VERSION" )
llvm_config=$( command -v "llvm-config-$CLANG_VERSION" )
llvm_cov=$( command -v "llvm-cov-$CLANG_VERSION" )
llvm_cvtres=$( command -v "llvm-cvtres-$CLANG_VERSION" )
llvm_cxxdump=$( command -v "llvm-cxxdump-$CLANG_VERSION" )
llvm_cxxfilt=$( command -v "llvm-cxxfilt-$CLANG_VERSION" )
llvm_cxxmap=$( command -v "llvm-cxxmap-$CLANG_VERSION" )
llvm_diff=$( command -v "llvm-diff-$CLANG_VERSION" )
llvm_dis=$( command -v "llvm-dis-$CLANG_VERSION" )
llvm_dlltool=$( command -v "llvm-dlltool-$CLANG_VERSION" )
llvm_dwarfdump=$( command -v "llvm-dwarfdump-$CLANG_VERSION" )
llvm_dwp=$( command -v "llvm-dwp-$CLANG_VERSION" )
llvm_elfabi=$( command -v "llvm-elfabi-$CLANG_VERSION" )
llvm_exegesis=$( command -v "llvm-exegesis-$CLANG_VERSION" )
llvm_extract=$( command -v "llvm-extract-$CLANG_VERSION" )
llvm_gsymutil=$( command -v "llvm-gsymutil-$CLANG_VERSION" )
llvm_ifs=$( command -v "llvm-ifs-$CLANG_VERSION" )
llvm_install_name_tool=$( command -v "llvm-install-name-tool-$CLANG_VERSION" )
llvm_jitlink_executor=$( command -v "llvm-jitlink-executor-$CLANG_VERSION" )
llvm_jitlink=$( command -v "llvm-jitlink-$CLANG_VERSION" )
llvm_lib=$( command -v "llvm-lib-$CLANG_VERSION" )
llvm_libtool_darwin=$( command -v "llvm-libtool-darwin-$CLANG_VERSION" )
llvm_link=$( command -v "llvm-link-$CLANG_VERSION" )
llvm_lipo=$( command -v "llvm-lipo-$CLANG_VERSION" )
llvm_lto=$( command -v "llvm-lto-$CLANG_VERSION" )
llvm_lto2=$( command -v "llvm-lto2-$CLANG_VERSION" )
llvm_mc=$( command -v "llvm-mc-$CLANG_VERSION" )
llvm_mca=$( command -v "llvm-mca-$CLANG_VERSION" )
llvm_ml=$( command -v "llvm-ml-$CLANG_VERSION" )
llvm_modextract=$( command -v "llvm-modextract-$CLANG_VERSION" )
llvm_mt=$( command -v "llvm-mt-$CLANG_VERSION" )
llvm_nm=$( command -v "llvm-nm-$CLANG_VERSION" )
llvm_objcopy=$( command -v "llvm-objcopy-$CLANG_VERSION" )
llvm_objdump=$( command -v "llvm-objdump-$CLANG_VERSION" )
llvm_opt_report=$( command -v "llvm-opt-report-$CLANG_VERSION" )
llvm_pdbutil=$( command -v "llvm-pdbutil-$CLANG_VERSION" )
llvm_PerfectShuffle=$( command -v "llvm-PerfectShuffle-$CLANG_VERSION" )
llvm_profdata=$( command -v "llvm-profdata-$CLANG_VERSION" )
llvm_profgen=$( command -v "llvm-profgen-$CLANG_VERSION" )
llvm_ranlib=$( command -v "llvm-ranlib-$CLANG_VERSION" )
llvm_rc=$( command -v "llvm-rc-$CLANG_VERSION" )
llvm_readelf=$( command -v "llvm-readelf-$CLANG_VERSION" )
llvm_readobj=$( command -v "llvm-readobj-$CLANG_VERSION" )
llvm_reduce=$( command -v "llvm-reduce-$CLANG_VERSION" )
llvm_rtdyld=$( command -v "llvm-rtdyld-$CLANG_VERSION" )
llvm_size=$( command -v "llvm-size-$CLANG_VERSION" )
llvm_split=$( command -v "llvm-split-$CLANG_VERSION" )
llvm_stress=$( command -v "llvm-stress-$CLANG_VERSION" )
llvm_strings=$( command -v "llvm-strings-$CLANG_VERSION" )
llvm_strip=$( command -v "llvm-strip-$CLANG_VERSION" )
llvm_symbolizer=$( command -v "llvm-symbolizer-$CLANG_VERSION" )
llvm_tblgen=$( command -v "llvm-tblgen-$CLANG_VERSION" )
llvm_undname=$( command -v "llvm-undname-$CLANG_VERSION" )
llvm_xray=$( command -v "llvm-xray-$CLANG_VERSION" )
not=$( command -v "not-$CLANG_VERSION" )
obj2yaml=$( command -v "obj2yaml-$CLANG_VERSION" )
opt=$( command -v "opt-$CLANG_VERSION" )
sanstats=$( command -v "sanstats-$CLANG_VERSION" )
split_file=$( command -v "split-file-$CLANG_VERSION" )
verify_uselistorder=$( command -v "verify-uselistorder-$CLANG_VERSION" )
yaml_bench=$( command -v "yaml-bench-$CLANG_VERSION" )
yaml2obj=$( command -v "yaml2obj-$CLANG_VERSION" )

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
  --slave "$bin/yaml2obj" yaml2obj "$yaml2obj"
