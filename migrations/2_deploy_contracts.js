var IdolFactory = artifacts.require("./IdolFactory.sol");
var IdolHelper = artifacts.require("./IdolHelper.sol");
var IdolWork = artifacts.require("./IdolWork.sol");
var Ownable = artifacts.require("./Ownable.sol");
var OwnerHelper = artifacts.require("./OwnerHelper.sol");

module.exports = function(deployer) {
  deployer.deploy(IdolFactory);
  deployer.deploy(IdolHelper);
  deployer.deploy(IdolWork);
  deployer.deploy(Ownable);
  deployer.deploy(OwnerHelper);
};
