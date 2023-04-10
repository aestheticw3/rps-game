const { expect } = require("chai");

describe("Rps contract", () => {
  let rps;
  before(async () => {
    const [owner] = await ethers.getSigners();
    console.log("Deploying contract with this account: ", owner);
    console.log("Deployer balance: ", (await owner.getBalance()).toString());
    const Rps = await ethers.getContractFactory("RockPaperScissors", owner);
    rps = await Rps.deploy();
    await rps.deployed();
    console.log("Deployed to:", rps.address);
    console.log(Rps, rps, owner);
  });
  it("should do something", () => {
    expect("asdf").to.be.a("string");
  });
});
