params ["_AmmoData"];
private _Propelled 	= _AmmoData get "propelled";
private _special		= (_AmmoData get "Special");
private _speed		= (_AmmoData get "projectile Speed");
private _warHead	= (_AmmoData get "warHead");
private _ammoClass 	= 0;

if(_special == "laser")exitWith{0.9};


if(_Propelled)
/* rockets && misiles */
then{
		_ammoClass = [_AmmoData] call Tally_Fnc_Get_MisileClass;
	}
/*bullets && shells*/
else{
		if(_AmmoData get "grenade"
		&&{_speed < 700})exitWith{_ammoClass = 3};
		
		if(_AmmoData get "grenade"
		&&{_speed >= 700})exitWith{_ammoClass = [4, _warHead] call Tally_Fnc_WarheadClass};
		
		_ammoClass = [_AmmoData] call Tally_Fnc_Get_ProjectileClass;
	};

_ammoClass