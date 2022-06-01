params ["_weapon"];
private _muzzles	 		= (getArray (configfile >> "CfgWeapons" >> _weapon >> "muzzles"));
private _muzzleData 	= createHashMap;
private _allAmmoClasses	= [];
private _allAmmoCounts	= [];

private _nonMuzzle		= ["this", "SAFE", "FOLD", "ADS"];

if(count _muzzles > 1)
then{
		{
			if!(_x in _nonMuzzle)
			then{
					if(isNil "_X")exitWith{};
					
					private _data = createHashMap;
					private _AmmoCount 	= [];
					private _ammoClasses	= [];
					private _ammoNames	= [];
					private _maxAmmoCap 	= 0;
					private _minAmmoCap 	= 0;
					
					private _muzzleMagazines = getArray (configfile >> "CfgWeapons" >> _weapon >> _x >> "magazines");
					private _indicator 		 = getText (configfile >> "CfgWeapons" >> _weapon >> _x >> "cursor");
					private _indicator2 		 = getText (configfile >> "CfgWeapons" >> _weapon >> _x >> "cursoraim");
					private _magCount		 = (count _muzzleMagazines) - 1;
					private _weaponModes	 = [_X] call ObjScan_fnc_weaponModes;
					
					
					for "_I" from 0 to _magCount do
					{
						private _mag 		= _muzzleMagazines select _I;
						private _magData 	= [_mag] call ObjScan_fnc_magazineData;
						private _clipSize		= (_magData get "AmmoCount");
						private _ammo		= (_magData get "AmmoType");
						private _ammoData	= [_ammo] call ObjScan_fnc_getAmmoData;
						
						_ammoClasses 	pushBackUnique (_ammoData get "class ID");
						_allAmmoClasses 	pushBackUnique (_ammoData get "class ID");
						_AmmoCount		pushBackUnique _clipSize;
						_allAmmoCounts	pushBackUnique _clipSize;
						_ammoNames	pushBackUnique _ammo;
					};
					if(count _AmmoCount > 0)
					then{
							_maxAmmoCap 	= selectMax _AmmoCount;
							_minAmmoCap 	= selectMin _AmmoCount;
						};
					
					_data set ["aimTypes",		[_indicator, _indicator2]];
					_data set ["ammoClasses",	_ammoClasses];
					_data set ["ammoNames",		_ammoNames];
					_data set ["max-Ammo-Cap",	_maxAmmoCap];
					_data set ["min-Ammo-Cap",	_minAmmoCap];
					_data set ["weapon-modes",	_weaponModes];
					_muzzleData set [_x, _data];
				};
		}forEach _muzzles;
	};

private _maxAmmoCap 	= 0;
private _minAmmoCap 	= 0;
if(count _allAmmoCounts > 0)
then{
		_maxAmmoCap 	= selectMax _allAmmoCounts;
		_minAmmoCap 	= selectMin _allAmmoCounts;
	};

_muzzleData set ["max-Ammo-Cap",	_maxAmmoCap];
_muzzleData set ["min-Ammo-Cap",	_minAmmoCap];
_muzzleData set ["ammoClasses",		_allAmmoClasses];

if(_maxAmmoCap == 0
&& _allAmmoClasses isEqualTo [])
then{_muzzleData = createHashMap;};

_muzzleData