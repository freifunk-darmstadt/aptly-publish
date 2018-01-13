#!/bin/sh

set -ex

# upload files
echo "Uploading files"
for file in $ARTIFACT_DIR/*.deb; do 
	#curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST -F file=@${file} ${APTLY_API_BASE}/files/${CI_COMMIT_SHA}
	http -f POST -a $APTLY_USER:$APTLY_PASSWORD ${APTLY_API_BASE}/files/${CI_COMMIT_SHA} file=@${file}
done

# add files to repository
echo "Adding files to repository"
#curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST ${APTLY_API_BASE}/repos/${PREFIX}/file/${CI_COMMIT_SHA}
http POST -a ${APTLY_USER}:${APTLY_PASSWORD} ${APTLY_API_BASE}/repos/${PREFIX}/file/${CI_COMMIT_SHA}


# create snapshot
echo "Creating snapshot"
#curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X POST -H "Content-Type: application/json" --data "{\"Name\":\"${CI_COMMIT_SHA}\"}" ${APTLY_API_BASE}/repos/${PREFIX}/snapshots
http POST -a ${APTLY_USER}:${APTLY_PASSWORD} ${APTLY_API_BASE}/repos/${PREFIX}/snapshots Name=${CI_COMMIT_SHA}  

# update published snapshot
echo "Updating published snapshot"
#curl ${CURL_OPTS} -u$APTLY_USER:$APTLY_PASSWORD -X PUT -H "Content-Type: application/json" --data "{\"Snapshots\": [{\"Component\":\"main\", \"Name\": \"$CI_COMMIT_SHA\"}]}" ${APTLY_API_BASE}/publish/${PREFIX}/${DISTRIBUTION}
http PUT -a ${APTLY_USER}:${APTLY_PASSWORD} ${APTLY_API_BASE}/publish/${PREFIX}/${DISTRIBUTION} Snapshots:='[{"Component": "main", "Name": "${CI_COMMIT_SHA}"}]'
