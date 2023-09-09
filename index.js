const core = require('@actions/core');
const github = require('@actions/github');
//const { exec } = require('node:child_process');
const spawn = require('child_process').spawn;
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

const main = async (args) => {
    console.log(JSON.stringify(args));
    await exec('bash', [path.join(__dirname, "./sync-chart-repo.sh"),
        "--tagName",args.tagName,
        "--sourceRepo",args.sourceRepo,
        "--sourceBranch",args.sourceBranch,
        "--targetRepo",args.targetRepo,
        "--targetBranch",args.targetBranch,
        "--GITHUB_TOKEN",args.GITHUB_TOKEN,
        "--GITHUB_USER",args.GITHUB_USER,
    ]);
};


try {
    const tagName = core.getInput('tagName');
    const sourceRepo = core.getInput('sourceRepo');
    const sourceBranch = core.getInput('sourceBranch');
    const targetRepo = core.getInput('targetRepo');
    const targetBranch = core.getInput('targetBranch');
    const GITHUB_TOKEN = core.getInput('GITHUB_TOKEN');
    const GITHUB_USER = core.getInput('GITHUB_USER');

    console.log(`tagName: ${tagName}!`);
    console.log(`sourceRepo: ${sourceRepo}!`);
    console.log(`sourceBranch: ${sourceBranch}!`);
    console.log(`targetRepo: ${targetRepo}!`);
    console.log(`targetBranch: ${targetBranch}!`);
    console.log(`GITHUB_TOKEN: ${GITHUB_TOKEN}!`);
    console.log(`GITHUB_USER: ${GITHUB_USER}!`);
    const time = (new Date()).toTimeString();
    core.setOutput("time", time);
    // Get the JSON webhook payload for the event that triggered the workflow
    const payload = JSON.stringify(github.context.payload, undefined, 2)

    main({
        tagName,
        sourceRepo,
        sourceBranch,
        targetRepo,
        targetBranch,
        GITHUB_TOKEN,
        GITHUB_USER
    }).catch(err => {
        console.error(err);
        console.error(err.stack);
        process.exit(err.code || -1);
    })
} catch (error) {
    core.setFailed(error.message);
}
