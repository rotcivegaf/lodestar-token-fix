import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {deployments, getNamedAccounts} = hre;
  const {deploy, get, save} = deployments;

  const oldToken = "0x44b96717AD68d11F0D3Bf4389B788E7e7EE179Eb";

  const newToken = "0x3fA6552C02bd371f2e100D5FAAD486686ce5C5c2";

  const {deployer} = await getNamedAccounts();

  const lode = await deploy('TokenFix', {
    from: deployer,
    contract: 'TokenFix',
    args: [
      oldToken,
      newToken
    ],
    log: true
  });

};
export default func;
func.tags = ['TokenFix'];