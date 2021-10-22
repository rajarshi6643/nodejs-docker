const express = require('express');
const app = express();
const port = 8081;

var git = require('git-last-commit');

let apiResponse = {
  "version": "1.0.0",
  "build_sha": "abcd1234#",
  "description" : "ANZ Bank technical test"
}

// This responds with "Hello World" on the homepage
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