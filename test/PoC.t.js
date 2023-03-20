const { ethers } = require("hardhat");

describe("PoC", () => {
  let owner, tokenFix;

  beforeEach(async () => {
    const MockERC20 = await ethers.getContractFactory("MockERC20");
    const TokenFix = await ethers.getContractFactory("TokenFix");

    owner = (await ethers.getSigners())[1];
    const erc20 = await MockERC20.deploy();
    tokenFix = await TokenFix.deploy(erc20.address, erc20.address, owner.address);

    await erc20.mint(tokenFix.address, 1);
  });

  it("_adminTransferAll", async () => {
    await tokenFix.connect(owner)._adminTransferAll();
  });

  it("_adminTransfer", async () => {
    await tokenFix.connect(owner)._adminTransfer(1);
  });
});
