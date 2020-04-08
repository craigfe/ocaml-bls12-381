#!/bin/bash

set -e

BUILD_DIR=$(mktemp -dt rustc.bls12.381.XXXXXXXX)

function build_rustc_bls12_381 () {
  #directory where this script lives
  local dir_script=$(cd $(dirname $0) && pwd)

  # Tag 0.3.0
  local commit="a29d26c4605d7d8a2aa5808a54def399d5499c10"
  local repository_name="rustc-bls12-381"
  local repository="https://gitlab.com/dannywillems/rustc-bls12-381"
  local install_dir="${OPAM_SWITCH_PREFIX}/lib/librustc-bls12-381"
  local full_url_zip="${repository}/-/archive/${commit}/${repository_name}-${commit}.zip"

  if ! [ -d ${install_dir} ] ; then
      echo "Installing rustc-bls12-381 in ${install_dir}"
      command -v cargo > /dev/null 2>&1 || { echo >&2 "Install cargo. Aborting."; exit 1; }
      mkdir -p ${BUILD_DIR}
      cd ${BUILD_DIR}
      echo "Downloading rustc-bls12-381 from ${full_url_zip}"
      curl -L ${full_url_zip} --output ${commit}.zip
      unzip ${commit}.zip >> /dev/null # do not print the resulting file
      cd ${repository_name}-${commit}
      export RUST_BACKTRACE=1
      cargo build --release
      rm -rf ${install_dir}
      mkdir ${install_dir}
      cp ${BUILD_DIR}/${repository_name}-${commit}/target/release/librustc_bls12_381.a ${install_dir}
      cd ${dir_script}
      rm -rf ${BUILD_DIR}
  fi
}


function cleanup () {
    echo "Cleaning up build directory ${BUILD_DIR}"
    rm -rf ${BUILD_DIR}
}

trap cleanup EXIT INT

build_rustc_bls12_381
