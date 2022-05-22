params ["_man"];
private _gearData		= createHashMap;
private _armorData 		= [_man] 					call Tally_Fnc_infArmorData;
private _weaponData		= [_man] 					call Tally_Fnc_infWeaponData;
private _gearRanking	= [_armorData, _weaponData]	call Tally_Fnc_rankUnitGear;
private _capacities		= [_weaponData] 			call Tally_Fnc_manCapacity;
private _armorLevel		= (_gearRanking get "armor");
private _description	= [_armorLevel, _weaponData]call Tally_Fnc_DescribeMan;

_gearData set ["gearRanking", 	_gearRanking];
_gearData set ["description", 	_description];
_gearData set ["capacities", 	_capacities];
_gearData set ["armorData", 	_armorData];
_gearData set ["weaponData", 	_weaponData];

_gearData