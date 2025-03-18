#!/bin/bash

set -e

if [[ "${EXPORTED_GPG_ZIP}" == "undefined" ]]; then
    echo "EXPORTED_GPG_ZIP is not set"
    exit 1
fi

if [[ ! -f "${EXPORTED_GPG_ZIP}" ]]; then
    echo "File ${EXPORTED_GPG_ZIP} does not exist"
    exit 1
fi

TMP_DIR=$(mktemp -d)
pushd "${TMP_DIR}"

unzip "${EXPORTED_GPG_ZIP}"
cd sharran-gpg
gpg --import sharran-secret-gpg.key
gpg --import-ownertrust sharran-ownertrust-gpg.txt

popd

rm -rf "${TMP_DIR}"
