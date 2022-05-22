params ["_vest"];
/*
Author: Tally
*/
/*
This function is needed to extract a globally understood value from vests, that will not be dependant on CFG_Names, 
allowing for categorization of modded vests without having to rewrite the entire code-base.
for more info go to:
https://community.bistudio.com/wiki/Arma_3:_Soldier_Protection
*/
/*
Actual values when testing on vanilla Vests: 
The _finalArmour variable is the result after taking into account the penetration allowed by the vest.
_finalArmour = (_chestArmor / _chestPenetration)
The following numbers represent the _finalArmour variable.
16 Level 1 vests.
30 Level 2 vests.
53 Level 3 vests.
100 Level 4 vests.
130 Explosive resistant vests (should be the same as lvl 3, some potential errors here).
240 Level 5 vests.
*/
private _data = SIG_VestData get _vest;
if(!isNil "_data")exitWith{_data};


private _VestData			= createHashMap;
private _chestArmor			= (getNumber (configFile >> "CfgWeapons" >> _vest >> "itemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "Armor"));
private _chestPenetration		= (getNumber (configFile >> "CfgWeapons" >> _vest >> "itemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "passThrough"));
private _description			= (getText (configFile >> "CfgWeapons" >> 	_vest >> "descriptionShort"));
private _finalArmour 		= _chestArmor;
private _armorLevel			= 0;
private _explosiveResistant 	= false;

if(_chestArmor > 0
&&{_chestPenetration > 0})
then{_finalArmour = (_chestArmor / _chestPenetration)};

if(_finalArmour > 10)	then{_armorLevel = 1};
if(_finalArmour > 25)	then{_armorLevel = 2};
if(_finalArmour > 45)	then{_armorLevel = 3};
if(_finalArmour > 90)	then{_armorLevel = 4};
if(_finalArmour > 200)	then{_armorLevel = 5};
if(_finalArmour > 400)	then{_armorLevel = 6};

private _customdescription = ["Level ", _armorLevel, " vest"] JoinString "";

if(_chestArmor > 30
&&{_chestPenetration > 0.4})
then{_customdescription = ["Explosive resistant level ", _armorLevel, " vest"] joinString ""};

if(_armorLevel == 0)then{_customdescription = "Non-protective vest"};
if(_vest == "")		then{_customdescription = "No vest"};

_VestData set ["description", _customdescription];
_VestData set ["Armor level", _armorLevel];
_VestData set ["Armor value", _finalArmour];

SIG_VestData set [_vest, _VestData];
_VestData