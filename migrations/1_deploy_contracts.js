const Voting = artifacts.require("voting.sol");
const Feedback = artifacts.require("Feedback.sol")
module.exports = function(deployer) {
  deployer.deploy(Voting);
  deployer.deploy(Feedback,12,["12","23"],["12","23"],["12","23"],[1,2,3,4,5],2);

};