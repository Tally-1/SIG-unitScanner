params ["_weaponData"];
private _capacities		= createHashMap;
private _rifleData 		= _weaponData 		get "primary";
private _launcherData 	= _weaponData 		get "secondary";
private _pistolData		= (_weaponData 		get "sideArm");
private _scopeRange		= (_weaponData 		get "scope range");

private _hasRifle		 	= !(_rifleData 		get "name" 	== "");
private _hasLauncher	 	= !(_launcherData 	get "name" 	== "");
private _hasSideArm	 	= !((_pistolData 		get "name")	== "");

private _weaponClass		= _rifleData 			get "class ID";
private _launcherClass 	= _launcherData 		get "class ID";
private _rifleAmmo 	 	= _rifleData 			get "ammoClasses";

private _mediumCaliber	= [_rifleAmmo,	2.1, 2.1, [2.4, 3]]	call ObjScan_fnc_approxClass;
private _highCaliber		= [_rifleAmmo,	2.2, 4.3] 				call ObjScan_fnc_approxClass;
private _GL				= [[_weaponClass],	2.1, 2.4] 			call ObjScan_fnc_approxClass;
private _MG			= [[_weaponClass],	3, 3.3] 			call ObjScan_fnc_approxClass;
private _GMG			= _weaponClass 			== 2.5;

private _scopeMultiplier	 = 1;
private _caliberMultiplier	 = 1;
private _aiValue			 = 0;
private _AtValue			 = 0;
private _launcherValue	 = 0;
private _AT_launcherValue = 0;
private _AA_launcherValue = 0;

if(_scopeRange > 200)then{_scopeMultiplier = 1.1};
if(_scopeRange > 300)then{_scopeMultiplier = 1.3};

if(_mediumCaliber)	then{_caliberMultiplier = 1.2};
if(_highCaliber)		then{_caliberMultiplier = 1.4};



if(_hasSideArm
&&{!(_hasRifle)})then{
						_aiValue = 1;
						_AtValue	= 0.2
					};

if(_hasRifle)
then{
		if(_weaponClass == 1.1)exitWith{
											_aiValue 	= 2;
											_AtValue		= 0.3;
										};
		if(_weaponClass > 1.1
		&&{_weaponClass < 1.9})exitWith{
											_aiValue 	= 3;
											_AtValue		= 0.55;
										};
		
		
		If(_weaponClass >= 1.9
		&&{_weaponClass <= 2.4})exitWith{
											_aiValue	= 4;
											_AtValue	= 1.1;
										};
										
		if(_GMG)				exitWith{
											_aiValue	= 7;
											_AtValue	= 3;
										};
	};

if(_weaponClass == 2)then	{_AtValue = 1.1};
if(_MG)			then	{_AtValue = 1.65};
if(_GL)				then	{_AtValue = 2.3};



if(_hasLauncher)
then{
		
		if(_launcherClass == 4)exitWith{
										_launcherValue = 2;
										_AT_launcherValue = 3;
									};
		_launcherValue = 3;
		_AT_launcherValue = 7;
		if(_launcherClass == 4.2)
		then{
				_AT_launcherValue = 0;
				_AA_launcherValue = 7;
			};
	};

private _Anti_Infantry	= ((_aiValue	* _scopeMultiplier) * _caliberMultiplier) + _launcherValue;
private _Anti_Vehicle		= ((_AtValue	* _scopeMultiplier) * _caliberMultiplier) + _AT_launcherValue;
private _Anti_Air			= ((_AtValue	* _scopeMultiplier) * _caliberMultiplier) + _AA_launcherValue;
if(_GMG or !(_hasRifle))then{_Anti_Air	= 0 + _AA_launcherValue};

_Anti_Infantry	= [_Anti_Infantry]	call ObjScan_fnc_decimals;
_Anti_Vehicle		= [_Anti_Vehicle, 1] 	call ObjScan_fnc_decimals;
_Anti_Air			= [_Anti_Air, 	1] 	call ObjScan_fnc_decimals;

_capacities set ["anti infantry", _Anti_Infantry];
_capacities set ["anti vehicle",	_Anti_Vehicle];
_capacities set ["anti air",		_Anti_Air];
_capacities