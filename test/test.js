const Ethergram = artifacts.require("../src/contracts/Ethergram.sol");
require("chai").use(require("chai-as-promised")).should();

contract("Ethergram", ([deployer, author, tipper]) => {
  let ethergram;

  before(async () => {
    ethergram = await Ethergram.deployed();
  });

  describe("deployment", async () => {
    it("deploys successfully", async () => {
      const address = await ethergram.address;
      assert.notEqual(address, 0x0);
      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
    });

    it("has a name", async () => {
      const name = await ethergram.name();
      assert.equal(name, "Ethergram");
    });
  });

  describe("images", async () => {
    let result;
    const hash = "abc123";

    before(async () => {
      result = await ethergram.uploadImage(hash, "Description", {
        from: author,
      });
      imageCount = await ethergram.imageCount();
    });

    it("creates images", async () => {
      assert.equal(imageCount, 1);
      console.log(result);
    });
  });
});
