'use strict';

require('dotenv').config();

const args = process.argv.slice(2);

if (!args[0]) {
    console.error("You should pass the branch name as parameter");
    return;
}

const dockerHubAPI = require('docker-hub-api');
const username = process.env.DOCKER_HUB_DEV_USERNAME;
const password = process.env.DOCKER_HUB_DEV_PASSWORD;
const dockerHubRepo = process.env.DOCKER_HUB_DEV_REPO || "unity3d";
const doDelete = process.env.DOCKER_HUB_DEV_DO_DELETE === "true";
const tagMatchingStrategy = process.env.DOCKER_HUB_DEV_TAG_MATCHING_STRATEGY || "endsWith";
const branchName = args[0];

if (!doDelete) {
    console.log(`Dry run mode, set DOCKER_HUB_DEV_DO_DELETE to true to actually delete tags`);
}

// Enables the cache, because we need to issue the tag request twice, due to the fact
// there is not an API dedicated to check the number of tag pages
dockerHubAPI.setCacheOptions({enabled: true});

dockerHubAPI.login(username, password).then(function (info) {
    console.log(`Logged in to Docker Hub with user: ${username}`);
    const loginToken = info.token;
    dockerHubAPI.setLoginToken(loginToken);

    function tagMatchesBranch(tags, tag) {
        if (tagMatchingStrategy === 'startsWith') {
            return tags[tag].name.startsWith(branchName);
        } else if (tagMatchingStrategy === 'endsWith') {
            return tags[tag].name.endsWith(branchName);
        } else if (tagMatchingStrategy === 'contains') {
            return tags[tag].name.contains(branchName);
        } else {
            console.error("Unsupported tag matching strategy");
        }
    }

    // Collects all the tags matching the branch we want to delete, and delete them
    dockerHubAPI.loggedInUser().then(function () {

        // Docker hub defaults
        const options = {page: 1, perPage: 100};

        // Iterate the pages and delete the tags
        const getPage = function () {

            // Get the tags
            dockerHubAPI.tags(username, dockerHubRepo, options).then(function (tags) {

                // Deletes all the image tags containing the branchName
                for (let tag = 0; tag < tags.length; tag++) {
                    if (tagMatchesBranch(tags, tag)) {
                        if (doDelete) {
                            dockerHubAPI.deleteTag(username, dockerHubRepo, tags[tag].name);
                            console.log(`Tag deleted: ${tags[tag].name}`);
                        } else {
                            console.log(`Would have deleted: ${tags[tag].name}`)
                        }
                    }
                }

                options.page = options.page + 1;

                getPage();

                /*
                 * The Docker Hub API has not way to check the number of pages, but it returns
                 * an error when you query for a page that does not exist. Here I'm using this
                 * behavior, to determine when to stop to iterate over the pages.
                */
            }).catch(function (reason) {
                console.log("Done deleting the tags");
            });
        };

        getPage();

    });
});