params ["_weapon"];
private _weaponData = SIG_weaponData get _weapon;
if(!isNil "_weaponData")exitWith{_weaponData};

_weaponData = createHashMap;

private _name 			= (getText (configfile >> "CfgWeapons" >> _weapon >> "displayName"));
private _magazines 		= (getArray (configfile >> "CfgWeapons" >> _weapon >> "magazines"));
private _muzzles	 	= (getArray (configfile >> "CfgWeapons" >> _weapon >> "muzzles"));
private _autoReload		= (getNumber (configfile >> "CfgWeapons" >> _weapon >> "autoReload"));
private _cursor			= (getText 	(configfile >> "CfgWeapons" >> _weapon >> "cursor"));
private _cursorAim		= (getText 	(configfile >> "CfgWeapons" >> _weapon >> "cursoraim"));
private _magCapacity	= [];
private _projectileSpeeds	= [];
private _AmmoTypes		= [];
private _AmmoClasses	= [];

if(_magazines isEqualTo [])
then{
		_magazines = [_weapon] call ObjScan_fnc_MagsFromWell;
	};


{
	private _magData = [_x] call ObjScan_fnc_magazineData;
	
	_magCapacity pushBackUnique (_magData get "AmmoCount");
	_AmmoTypes pushBackUnique (_magData get "AmmoType");
	_projectileSpeeds pushBackUnique (_magData get "AmmoSpeed");
} forEach _magazines;



private _maxAmmoCap 	= 0;
private _minAmmoCap 	= 0;
private _maxSpeed 		= 0;
private _minSpeed 		= 0;

if(count _magCapacity > 0)
then{
		_maxAmmoCap 	= selectMax _magCapacity;
		_minAmmoCap 	= selectMin _magCapacity;
		_maxSpeed 		= selectMax _projectileSpeeds;
		_minSpeed 		= selectMin _projectileSpeeds;
	};

{
	private _AmmoData = 	[_x, false , _minSpeed] call ObjScan_fnc_getAmmoData;
	_AmmoClasses pushBackUnique (_AmmoData get "class ID");
}forEach _AmmoTypes;

private _weaponModes 	= [_weapon] call ObjScan_fnc_weaponModes;
private _muzzleData		= createHashMap;
if(count _muzzles > 1)then{_muzzleData = [_weapon] call ObjScan_fnc_weaponMuzzles}; 

_weaponData set ["name", 			_name];
_weaponData set ["max-Ammo-Cap", 	_maxAmmoCap];
_weaponData set ["min-Ammo-Cap", 	_minAmmoCap];
_weaponData set ["max-Ammo-speed", 	_maxSpeed];
_weaponData set ["min-Ammo-speed", 	_minSpeed];
_weaponData set ["magazines", 		_magazines];
_weaponData set ["ammoClasses", 	_ammoClasses];
_weaponData set ["ammoNames", 		_AmmoTypes];
_weaponData set ["weapon-modes", 	_weaponModes];
_weaponData set ["fire-Modes", 		[_weaponModes] call ObjScan_fnc_fireModes];
_weaponData set ["muzzles", 		_muzzleData];
_weaponData set ["cursor", 			_cursor];
_weaponData set ["cursor-aim", 		_cursorAim];

private _rps 		= [_weaponData] call ObjScan_fnc_maxRps;
_weaponData 		set ["RPS", _rps];

private _classID 		= [_weaponData, _weapon] call ObjScan_fnc_classifyWeapon;
private _description	= [_classID] call ObjScan_fnc_describeWeaponByClass;

_weaponData set ["class ID", 	_classID];
_weaponData set ["description",	_description];

SIG_weaponData set [_weapon, _weaponData];
_weaponData