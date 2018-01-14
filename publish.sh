#!/bin/sh

set -e

# upload files
echo "Uploading files"
for file in $ARTIFACT_DIR/*.deb; do 
	curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST -F file=@${file} ${APTLY_API_BASE}/files/${CI_COMMIT_SHA}
done

# add files to repository
echo "Adding files to repository"
curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST ${APTLY_API_BASE}/repos/${REPOSITORY}/file/${CI_COMMIT_SHA}

# create snapshot
echo "Creating snapshot"
curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST -H "Content-Type: application/json" --data "{\"Name\":\"${REPOSITORY}/${CI_COMMIT_SHA}\"}" ${APTLY_API_BASE}/repos/${REPOSITORY}/snapshots

# update published snapshot
echo "Updating published snapshot"
curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X PUT -H "Content-Type: application/json" --data "{\"Snapshots\": [{\"Component\":\"main\", \"Name\": \"${REPOSITORY}/${CI_COMMIT_SHA}\"}]}" ${APTLY_API_BASE}/publish/${REPOSITORY}/${DISTRIBUTION}
