import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {deployments, getNamedAccounts} = hre;
  const {deploy, get, save} = deployments;

  const oldToken = "0x5EcC0446e8AA72B9BD74B8935687e1E4cA3478d3";

  const newToken = "0xF19547f9ED24aA66b03c3a552D181Ae334FBb8DB";

  const {deployer, admin} = await getNamedAccounts();

  const lode = await deploy('TokenFix', {
    from: deployer,
    contract: 'TokenFix',
    args: [
      oldToken,
      newToken,
      admin
    ],
    log: true
  });

};
export default func;
func.tags = ['TokenFix'];