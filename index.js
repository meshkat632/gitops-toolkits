const core = require('@actions/core');
const github = require('@actions/github');
//var Git = require("nodegit");
const { exec } = require('node:child_process');
const simpleGit = require('simple-git');

try {
    // `who-to-greet` input defined in action metadata file
    const nameToGreet = core.getInput('who-to-greet');
    const targetRepo = core.getInput('targetRepo');
    const tagName = core.getInput('tagName');
    const sourceRepo = core.getInput('sourceRepo');
    console.log(`Hello ${nameToGreet}!`);
    console.log(`targetRepo: ${targetRepo}!`);
    console.log(`tagName: ${tagName}!`);
    console.log(`sourceRepo: ${sourceRepo}!`);
    const time = (new Date()).toTimeString();
    core.setOutput("time", time);
    // Get the JSON webhook payload for the event that triggered the workflow
    const payload = JSON.stringify(github.context.payload, undefined, 2)
    console.log(`The event payload: ${payload}`);

    exec('ls -ltr', (err, output) => {
        // once the command has completed, the callback function is called
        if (err) {
            // log and return if we encounter an error
            console.error("could not execute command: ", err)
            return
        }
        // log the output received from the command
        console.log("Output: \n", output)
    })

    const simpleGit = require('simple-git');

    /*
    Git.Clone("https://github.com/ververica/vvc-portal", "nodegit").then(function(repository) {

    });
    */


} catch (error) {
    core.setFailed(error.message);
}
