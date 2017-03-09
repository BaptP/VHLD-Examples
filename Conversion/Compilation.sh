for f in $(find -L -type f \( -path *.xco -o -path  *.vhd \)
); do echo "."$f; done > build/files
source /am/embassy/vol/x6/XILINX/Xilinx/14.3/ISE_DS/settings64.sh > /dev/null
export LM_LICENSE_FILE=2100@embassy.ecs.vuw.ac.nz
cd build && { xtclsh build.tcl
if [ $? = 0 ]
then
  cd .. && a=${PWD##*/} && echo $a > ../.lastProject
fi
} 2>&1 | ../../.color.sh