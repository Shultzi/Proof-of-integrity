var Data = artifacts.require("Data");
var DataTwo = artifacts.require("DataTwo");

module.exports = function(deployer) {
  deployer.deploy(Data);
  deployer.deploy(DataTwo);
};
