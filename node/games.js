const fs = require("fs");
const path = require("path");
const { promisify } = require("util");
const mkdirp = promisify(require("mkdirp"));
const fetch = require("node-fetch");
const execa = require("execa");

const logpath = path.join("/", "cache", "log.txt");
// const VISUALIZER = path.join('/', 'cache', 'log.txt');

const writeFile = promisify(fs.writeFile);

await mkdirp(path.join("/", "cache"));
while (true) {
  const res = await fetch("https://tv.mechmania.io");
  const log = await res.text();
  await writeFile(logpath, log);
  console.log(res.headers);
  process.exit(0);
//   await execa(VISUALIZER, [logpath, team1, team2]);
}
