#!/bin/sh

set -ex

# upload files
for file in $ARTIFACT_DIR/*.deb; do 
	curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST -F file=@${file} ${APTLY_API_BASE}/files/${CI_COMMIT_SHA}
done

# add files to repository
curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST ${APTLY_API_BASE}/repos/${REPONAME}/file/${CI_COMMIT_SHA}

# create snapshot
curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST -H "Content-Type: application/json" --data "{\"Name\":\"${CI_COMMIT_SHA}\"}" ${APTLY_API_BASE}/repos/${REPONAME}/snapshots

# update published snapshot
curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X PUT -H "Content-Type: application/json" --data "{\"Snapshots\": [{\"Component\":\"main\", \"Name\": \"$CI_COMMIT_SHA\"}]}" ${APTLY_API_BASE}/publish/${REPONAME}/${CODENAME}
