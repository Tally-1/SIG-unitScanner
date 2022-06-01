params ["_man"];
private _gearData		= createHashMap;
private _armorData 		= [_man] 					call ObjScan_fnc_infArmorData;
private _weaponData		= [_man] 					call ObjScan_fnc_infWeaponData;
private _gearRanking	= [_armorData, _weaponData]	call ObjScan_fnc_rankUnitGear;
private _capacities		= [_weaponData] 			call ObjScan_fnc_manCapacity;
private _armorLevel		= (_gearRanking get "armor");
private _description	= [_armorLevel, _weaponData]call ObjScan_fnc_DescribeMan;

_gearData set ["gearRanking", 	_gearRanking];
_gearData set ["description", 	_description];
_gearData set ["capacities", 	_capacities];
_gearData set ["armorData", 	_armorData];
_gearData set ["weaponData", 	_weaponData];

_gearData