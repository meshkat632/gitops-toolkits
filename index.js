const core = require('@actions/core');
const github = require('@actions/github');
//const { exec } = require('node:child_process');
//const spawn = require('child_process').spawn;
const path = require("path");


const exec = (cmd, args=[]) => new Promise((resolve, reject) => {
    console.log(`Started: ${cmd} ${args.join(" ")}`)
    const app = spawn(cmd, args, { stdio: 'inherit' });
    app.on('close', code => {
        if(code !== 0){
            err = new Error(`Invalid status code: ${code}`);
            err.code = code;
            return reject(err);
        };
        return resolve(code);
    });
    app.on('error', reject);
});

const main = async () => {
    await exec('bash', [path.join(__dirname, "./deploy.sh"), "--bucketname","olabucket"]);
};


try {
    // `who-to-greet` input defined in action metadata file
    const nameToGreet = core.getInput('who-to-greet');
    const targetRepo = core.getInput('targetRepo');
    const tagName = core.getInput('tagName');
    const sourceRepo = core.getInput('sourceRepo');
    console.log(`Hello ${nameToGreet}!`);
    console.log(`targetRepo: ${targetRepo}!`);
    console.log(`gitrepoName: ${gitrepoName}!`);
    console.log(`targetBranch: ${targetBranch}!`);
    console.log(`targetBranch: ${targetBranch}!`);
    const time = (new Date()).toTimeString();
    core.setOutput("time", time);
    // Get the JSON webhook payload for the event that triggered the workflow
    const payload = JSON.stringify(github.context.payload, undefined, 2)
    //console.log(`The event payload: ${payload}`);
    /*
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

    exec('git status', (err, output) => {
        // once the command has completed, the callback function is called
        if (err) {
            // log and return if we encounter an error
            console.error("could not execute command: ", err)
            return
        }
        // log the output received from the command
        console.log("Output: \n", output)
    })
    */
    exec(`cd .. && ls -ltr`, (err, output) => {
        // once the command has completed, the callback function is called
        if (err) {
            // log and return if we encounter an error
            console.error("could not execute command: ", err)
            return
        }
        // log the output received from the command
        console.log("Output: \n", output)
    })
    main().catch(err => {
        console.error(err);
        console.error(err.stack);
        process.exit(err.code || -1);
    })
} catch (error) {
    core.setFailed(error.message);
}
