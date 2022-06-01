params ["_man"];
private _weaponData 	= createHashMap;
private _rifle			= (primaryWeapon _man);
private _scope			= ((primaryWeaponItems _man)Select 2);
private _launcher		= (secondaryWeapon _man);
private _sideArm		= (handgunWeapon _man);


private _rifleData 		= [_rifle] 		call ObjScan_fnc_weaponData;
private _scopeRange		= [_scope] 		call ObjScan_fnc_scopeRange;
private _launcherData	= [_launcher] 	call ObjScan_fnc_weaponData;
private _sideArmData	= [_sideArm] 	call ObjScan_fnc_weaponData;

_weaponData set ["primary", 	_rifleData];
_weaponData set ["scope range", _scopeRange];
_weaponData set ["secondary", 	_launcherData];
_weaponData set ["sideArm", 	_sideArmData];

_weaponData