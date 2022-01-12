const express = require('express');
const app = express();
const port = 9001;

var git = require('git-last-commit');

let apiResponse = {
  "version": "1.0.0",
  "build_sha": "abcd1234#",
  "description" : "pre-interview technical test"
}

app.get('/version', function (req, res) {
   console.log("Got a GET request for the homepage");
   git.getLastCommit(function(err, commit) {
	  // read commit object properties
	   var commitHash = commit.shortHash;
	   apiResponse.build_sha = commitHash;
	   console.log(commit.shortHash);
	   
	   return res.send(apiResponse);
 });
   
})

app.listen(port, () =>
  console.log("Example app listening on port: "+port));
