const core = require('@actions/core');
const github = require('@actions/github');

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
} catch (error) {
    core.setFailed(error.message);
}
