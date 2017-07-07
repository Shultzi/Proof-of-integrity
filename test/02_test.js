var expect 	= require("chai").expect;
var Data = artifacts.require("DataTwo");

contract('test 02', function(accounts) {

	describe("The first stage is Deploying DataTwo", function (){

		it("Deploys the Data contract", function(){
			return Data.deployed().then(function(ins){
				Data = ins;
			});
		});

		it("Register account 0 user", function(){
			return Data.newUser().catch(function(err){
				expect(err).to.be.undefined;
			});
		});
	});

	describe("Adds three datas to account 0 user tree", function(){

		it("get account 0 user root - should be undefined", function(){
			return Data.getUserRoot(accounts[0]).then(function(res){
				expect(res.value).to.be.undefined;
			});
		});

		it("Adds the first data 1", function(){
			return Data.addData(1, accounts[0]).catch(function(err){
				expect(err).to.be.undefined;
			});
		});

		it("Adds the second data 2", function(){
			data = web3.sha3("would");
			data = web3.toDecimal(data);
			return Data.addData(2, accounts[0]).catch(function(err){
				expect(err).to.be.undefined;
			});
		});

		it("Adds the third data 5", function(){
			return Data.addData(5, accounts[0]).catch(function(err){
				expect(err).to.be.undefined;
			});
		});

	});

	describe("Check data integrity", function(){

		it("Pass the complete array [1, 2, 5] - expect true", function(){
			array = [1, 2, 5];
			return Data.checkDataIntegrity(array, accounts[0]).then(function(res){
				expect(res).to.be.true;
			});
		});

		it("Pass the  array [1, 2] - expect false", function(){
			array = [1, 2];
			return Data.checkDataIntegrity(array, accounts[0]).then(function(res){
				expect(res).to.be.false;
			});
		});

		it("Pass the  array [1, 5, 2] - expect false", function(){
			array = [1, 5, 2];
			return Data.checkDataIntegrity(array, accounts[0]).then(function(res){
				expect(res).to.be.false;
			});
		});
	});
});