#!/bin/bash -xe
#
# jenkins restore scripts

readonly MASTER_KEY="$1"
readonly SRC_FILE="$2"
readonly DEST_FILE="$3"
readonly ARC_NAME="jenkins"
readonly TMP_DIR=$(mktemp -d -t jenkins-XXXXXXXXXX)
readonly ARC_DIR="${TMP_DIR}/${ARC_NAME}"
readonly TMP_TAR_NAME="${TMP_DIR}/jenkins.tar.gz"

function usage() {
  echo "usage: $(basename $0) master.key src-archive.tar.gz dest.tar.gz"
}

function main() {
  if [[ "$#" -lt 3 ]]; then
    usage >&2
    exit 1
  fi
  if [ ! -f "${MASTER_KEY}" ] ; then
    echo "master key file ${MASTER_KEY} doesn't exist"
    exit 1
  fi

  cd "${TMP_DIR}"
  # extract archive and add files
  tar zxfpv $(realpath ${SRC_FILE})
  mkdir -p $ARC_NAME/agent && chmod 777 $ARC_NAME/agent
  cp $(realpath ${MASTER_KEY}) $ARC_NAME/secrets/master.key
  chmod a+r $ARC_NAME/secrets/master.key
  # compress again
  tar zcfpv "${TMP_TAR_NAME}" "${ARC_NAME}/"*
  cd -
  mv -f "${TMP_TAR_NAME}" "${DEST_FILE}"
  # clean
  rm -rf "${TMP_DIR}"
  exit 0
}

main $@
