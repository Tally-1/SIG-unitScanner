params ["_weaponData"];
private _rpsArr	= [];
private _allModes = [];
private _muzzles			= _weaponData 	get "muzzles";
private _weaponModes 	= _weaponData 	get "weapon-modes";
private _subWeaponMod	= _muzzles 		get "weapon-modes";
private _rps = 0;

if(count _weaponModes > 0)	then{{_allModes pushBackUnique _y}forEach _weaponModes};
if(!isNil "_subWeaponMod")	then{{_allModes pushBackUnique _y}forEach _subWeaponMod};
if(count _allModes < 1)exitWith{-1};

{_rpsArr pushBackUnique (_x get "reloadTime")}forEach _allModes;

if(count _rpsArr > 0
&&{(selectMin _rpsArr) > 0})
then{
		_rps = (1 / (selectMin _rpsArr));
		if(_rps > 1)then{_rps = round _rps};
	};


_rps