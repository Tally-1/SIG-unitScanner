params ["_armorData", "_weaponData"];
private _gearRanking		= createHashMap;
private _armor			= [_armorData] call ObjScan_fnc_rankUnitArmor;
private _weaponRanking	= [_weaponData] call ObjScan_fnc_infWeaponRank;
private _strength		= [[_armor, _weaponRanking], true] call ObjScan_fnc_average;

_gearRanking set ["armor", _armor];
_gearRanking set ["weaponry", _weaponRanking];
_gearRanking set ["strength", _strength];
_gearRanking