if [ -z $1 ]
then
  echo "Project's name expected"
  exit 1
fi

mkdir $1
mkdir $1/build
mkdir $1/sim
mkdir $1/src
cp .Simulation.sh $1/Simulation.sh
cp .Compilation.sh $1/Compilation.sh
cp .build.tcl $1/build/build.tcl
cp .constraints.ucf $1/src/constraints.ucf
echo -e "$1\n$1\n../src/constraints.ucf" > $1/build/project
