// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PeerTipping {
    mapping(address => uint256) public tipsReceived;

    event Tipped(address indexed from, address indexed to, uint256 amount);

    function tip(address recipient) external payable {
        require(msg.value > 0, "Tip amount must be greater than zero");
        tipsReceived[recipient] += msg.value;
        emit Tipped(msg.sender, recipient, msg.value);
    }

    function getTotalTips(address user) external view returns (uint256) {
        return tipsReceived[user];
    }

    function withdrawTips() external {
        uint256 amount = tipsReceived[msg.sender];
        require(amount > 0, "No tips to withdraw");
        tipsReceived[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
