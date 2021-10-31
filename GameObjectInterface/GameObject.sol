
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObjectInterface.sol";
// This is class that describes you smart contract.
contract GameObject is GameObjectInterface{
    uint public hp = 10;
    uint public def = 0;
    function isObjectDead() private returns (bool){
        tvm.accept();
        if (hp > 0) {
            die();
        }
        else {
            return false;
        }
    }
    function takeDefPower(uint defense) virtual external {
        tvm.accept();
        def = defense;
    }
    function takeAttack(uint value) virtual external override {
        tvm.accept();
        address attacker = msg.sender;
        hp = hp - value + def;
        isObjectDead();
        
    }

    function die() virtual public {
        sendAllandDestroy(msg.sender);

    }
    function sendAllandDestroy(address obj_addr) public {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
        obj_addr.transfer(1, false, 160);
    }

}
