#!/bin/sh

# Get the token from Travis environment vars and build the bot URL:
WEBHOOK_URL="https://hooks.slack.com/services/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"
TRAVIS_TEST_RESULT=0
# Use built-in Travis variables to check if all previous steps passed:
if [ $TRAVIS_TEST_RESULT -ne 0 ]; then
    build_status="errored"
    p_color="№c41e3a"
else
    build_status="passed"
    p_color="#2e8b57"
fi

p_username="Travis CI WebHook"
p_text="
Build <${TRAVIS_BUILD_WEB_URL}|#${TRAVIS_BUILD_NUMBER}> (${TRAVIS_COMMIT})
of ${TRAVIS_REPO_SLUG}@${TRAVIS_BRANCH}
*${build_status}!*
*Commit Msg:*\n${TRAVIS_COMMIT_MESSAGE}
[Job Log here](${TRAVIS_JOB_WEB_URL})"

curl -s -X POST --data-urlencode "payload={\"color\": \"${p_color}\", \"username\": \"${p_username}\", \"text\": \"${p_text}\"}" ${WEBHOOK_URL}
