const expect  = require('chai').expect;
var request = require('request');
const app = require('../application')

  describe("GET /version API Tests", () => {
	
	    it('/version API response status - should be 200', function(done) {
			request('http://localhost:8081/version' , function(error, response, body) {
				expect(response.statusCode).to.equal(200);
				done();
			});
		});

		it('/version API version check', function(done) {
			request('http://localhost:8081/version' , function(error, response, body) {
				var jsonObj = JSON.parse(body);
				expect(jsonObj.version).to.equal('1.0.0');							
				done();
			});
		});
		
		it('/version API description check', function(done) {
			request('http://localhost:8081/version' , function(error, response, body) {				
				var jsonObj = JSON.parse(body);
				expect(jsonObj.description).to.equal('pre-interview technical test');
				done();
			});
		});
 })