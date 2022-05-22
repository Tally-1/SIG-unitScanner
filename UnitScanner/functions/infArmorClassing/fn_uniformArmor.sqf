params ["_Uniform"];

private _data = SIG_uniformData get _Uniform;
if(!isNil "_data")exitWith{_data};

private _uniformData			= createHashMap;
private _uniformBody 		= (getText (configFile >> "CfgWeapons" 		>> _Uniform 	>> "itemInfo" >> "uniformClass"));
/*private _structuralArmor	= (getNumber (configFile >> "CfgVehicles" 	>> _uniformBody >> "armorStructural"));*/
private _ChestArmor			= (getNumber (configFile >> "CfgVehicles" 	>> _uniformBody >> "Hitpoints" >> "HitChest" >> "Armor"));
private _chestPenetration		= (getNumber (configFile >> "CfgVehicles" 	>> _uniformBody >> "Hitpoints" >> "HitChest" >> "passThrough"));
private _finalArmour 		= _ChestArmor;
private _Armored			= false;
private _customdescription 	= "Non-protective uniform";

if(_ChestArmor > 0
&&{_chestPenetration > 0})
then{_finalArmour = (_ChestArmor / _chestPenetration)};

if(_finalArmour > 5)
then{
		_Armored 			= true;
		_customdescription 	= "Armored uniform";
	};

if(_Uniform == "")then{_customdescription = "No uniform"};

_uniformData set ["description",	_customdescription];
_uniformData set ["Armored", 	_Armored];
_uniformData set ["Armor value",	_finalArmour];

SIG_uniformData set [_Uniform, _uniformData];
_uniformData