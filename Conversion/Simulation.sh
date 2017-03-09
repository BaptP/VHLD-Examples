source /am/embassy/vol/x6/XILINX/Xilinx/14.3/ISE_DS/settings64.sh > /dev/null
export LM_LICENSE_FILE=2100@embassy.ecs.vuw.ac.nz
for f in $(find -L -path *.vhd); do echo "vhdl work ../"$f; done > sim/test.prj
cd sim && { /am/embassy/vol/x6/XILINX/Xilinx/14.3/ISE_DS/ISE/bin/lin64/fuse -intstyle ise -o test -prj test.prj test;
if [ $? = 0 ]
then
  ./test -gui
fi
} 2>&1 | ../../.color.sh