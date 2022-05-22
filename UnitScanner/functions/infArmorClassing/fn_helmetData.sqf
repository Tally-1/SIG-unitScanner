params ["_helmet"];
/*
Author: Tally
For comments see Tally_Fnc_VestData.
*/
/*
The following numbers represent the _finalArmour extracted from vanilla helmets.
4 	Level 1 helmets.
12 	Level 2 helmets.
16 	Level 3 helmets.
20 	Level 4 helmets.
24 	Level 5 helmets.
*/
private _data = SIG_HelmetData get _helmet;
if(!isNil "_data")exitWith{_data};

private _helmetData			= createHashMap;
private _armor				= (getNumber (configFile >> "CfgWeapons" >> _helmet >> "itemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "Armor"));
private _faceArmor			= (getNumber (configFile >> "CfgWeapons" >> _helmet >> "itemInfo" >> "HitpointsProtectionInfo" >> "Face" >> "Armor"));
private _penetration			= (getNumber (configFile >> "CfgWeapons" >> _helmet >> "itemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "passThrough"));
private _finalArmour 		= _armor;
private _armorLevel			= 0;
private _facialProtection 		= (_faceArmor > 0);

if(_armor > 0
&&{_penetration > 0})
then{_finalArmour = (_armor / _penetration)};

if(_finalArmour > 3)		then{_armorLevel = 1};
if(_finalArmour > 11)	then{_armorLevel = 2};
if(_finalArmour > 15)	then{_armorLevel = 3};
if(_finalArmour > 19)	then{_armorLevel = 4};
if(_finalArmour > 23)	then{_armorLevel = 5};
if(_finalArmour > 28)	then{_armorLevel = 6};



private _customdescription = ["Level ", _armorLevel, " helmet"] JoinString "";

if(_facialProtection)
then{
		_customdescription = [_customdescription, " with facial protection"] joinString "";
	};

if(_armorLevel == 0)	then{_customdescription = "Non-protective headGear"};
if(_helmet == "")	then{_customdescription = "No helmet"};

_helmetData set ["description", 			_customdescription];
_helmetData set ["Armor level", 			_armorLevel];
_helmetData set ["Facial protection", 	_facialProtection];
_helmetData set ["Armor value", 			_finalArmour];

SIG_HelmetData set [_helmet, _helmetData];

_helmetData