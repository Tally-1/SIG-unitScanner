
params ["_class"];
private _unDefTxt = "undefined weapon-Type";

if(_class == -1)	exitWith{""};
if(_class == 0)		exitWith{_unDefTxt};
if(_class == 0.1)	exitWith{"undefined vehicle weapon"};
if(_class == 0.6)	exitWith{"Smoke-launcher"};
if(_class == 0.7)	exitWith{"Chaff / flare-launcher"};
if(_class == 0.8)	exitWith{"Horn"};
if(_class == 0.9)	exitWith{"non-lethal weapon"};
/*pistols-subMachineGuns*/
if(_class == 1)		exitWith{"Pistol"};
if(_class == 1.1)	exitWith{"SubmachineGun"};

if(_class == 1.11)	exitWith{"shotGun"};
if(_class == 1.12)	exitWith{"Semi-automatic rifle"};
/*Assault rifles*/
if(_class == 1.2)	exitWith{"Assault rifle"};
if(_class == 1.3)	exitWith{"Light assault rifle"};
if(_class == 1.4)	exitWith{"Standard assault rifle"};
if(_class == 1.5)	exitWith{"Heavy assault rifle"};
if(_class == 1.6)	exitWith{"Armor Piercing assault rifle"};

/*Assault rifles++*/
if(_class == 1.7)	exitWith{"light Automatic rifle"};
if(_class == 1.8)	exitWith{"Automatic rifle"};

/*sniper-rifles*/
if(_class == 1.9)	exitWith{"Sniper rifle"};

/*Assault rifles with underBarrel*/
if(_class == 2)		exitWith{"Assault rifle / shotGun"};
if(_class == 2.1)	exitWith{"light Assault rifle GL"};
if(_class == 2.2)	exitWith{"Assault rifle GL"};
if(_class == 2.3)	exitWith{"Heavy Assault rifle GL"};
if(_class == 2.4)	exitWith{"Assault rifle 3GL"};
if(_class == 2.5)	exitWith{"Hand-held Automatic grenade Launcher"};

/*machineGuns*/
if(_class == 3)		exitWith{"MachineGun"};
if(_class == 3.1)	exitWith{"LMG"};
if(_class == 3.2)	exitWith{"GPMG"};
if(_class == 3.3)	exitWith{"HMG"};
if(_class == 3.4)	exitWith{"GMG"};

/*1-round Launchers*/
if(_class == 4)		exitWith{"Rocket launcher"};
if(_class == 4.01)	exitWith{"Rocket launcher"};/*magazine launcher*/
if(_class == 4.1)	exitWith{"AT misile launcher"};
if(_class == 4.2)	exitWith{"AA misile launcher"};
if(_class == 4.3)	exitWith{"AA-AT combo launcher"};
if(_class == 4.4)	exitWith{"launcher"};

/*miniguns*/
if(_class == 5)		exitWith{"Light miniGun"};
if(_class == 5.1)	exitWith{"Heavy miniGun"};

/*cannons*/
if(_class == 5.2)	exitWith{"Auto-cannon"};
if(_class == 5.3)	exitWith{"100-130mm Cannon"};

/*artillery / mortars*/
if(_class == 6)	exitWith{"Mortar"};
if(_class == 6.1)exitWith{"Artillery"};
if(_class == 6.2)exitWith{"Rocket Artillery"};

/*Misiles / rockets*/
if(_class == 7)		exitWith{"rocket battery"};
if(_class == 7.1)	exitWith{"2x AT misile launcher"};
if(_class == 7.2)	exitWith{"AT misile battery"};
if(_class == 7.3)	exitWith{"2x AA misile launcher"};
if(_class == 7.4)	exitWith{"AA misile battery"};
if(_class == 7.5)	exitWith{"Combined misile battery"};


if(_class == 8)exitWith{"Bomb launcher"};
_unDefTxt