#!/bin/bash

# function to check that all dependencies are installed
function check_installs { 
  DEPENDS=$@
 
  echo "Checking that dependencies of NAND are installed"  
  for DEPEND in $DEPENDS 
  do 
    if ! type $DEPEND > /dev/null ; then
      echo "It looks like you don't have "$DEPEND" installed-- aborting build." ;
      exit 1 ;
    fi 
  done 
  echo "All dependencies are installed" 
}

# function that builds nand in current directory 
function build_nand { 
  check_installs ocaml ocamlbuild ocamlyacc ocamllex

  # actual build 

  # location of source code 
  INCLUDE_FLAGS="-I src -I parsing" 

  echo "Starting build" 
  if   ocamlbuild main.native $INCLUDE_FLAGS ; then 
    echo "Build succeeded" 
  else 
    echo "Build failed-- compilation exited with code $?" 
  fi 
}

build_nand
