params ["_weaponData", "_CFGname"];
private _class			= 0;
private _exit			= false;
private _safeMuzz		= false;

private _muzzles		= _weaponData 	get "muzzles";
private _ammoClasses 	= _weaponData 	get "ammoClasses";
private _subAmmoClasses	= _muzzles		get "ammoClasses";
private _subMinCap		= _muzzles		get "min-Ammo-Cap";
private _subMaxCap		= _muzzles		get "max-Ammo-Cap";
private _maxAmmoCap 	= _weaponData 	get "max-Ammo-Cap";
private _minAmmoCap		= _weaponData 	get "min-Ammo-Cap";
private _weaponModes 	= _weaponData 	get "weapon-modes";
private _fireModes		= _weaponData 	get "fire-Modes";
private _cursorType		= _weaponData 	get "cursor";
private _aimType		= _weaponData 	get "cursor-aim";
private _name			= _weaponData 	get "name";
private _rps			= _weaponData	get "RPS";

/*rhs weapons have a "safe-mode" registered as a muzzle*/
if(count _muzzles == 1
&&{((_muzzles select 0) get "name") == "SAFE"})
then{_safeMuzz = true};

private _noUnderBarrel	= (count _muzzles < 1 or _safeMuzz);
private _sniperCursor		= (_cursorType == "srifle");
private _AR_Cursor		= (_cursorType == "arifle");
private _SMG_Cursor		= (_cursorType == "smg");
private _pistol_Cursor	= (_cursorType == "hgun");


private _pistolAmmo		= [_ammoClasses, 1, 1, 		[0.8]]	call ObjScan_fnc_approxClass;
private _smallRifleAmmo	= [_ammoClasses, 2, 2, 		[0.8]]	call ObjScan_fnc_approxClass;
private _standRifleAmmo	= [_ammoClasses, 2.1, 2.1, [0.8]] 	call ObjScan_fnc_approxClass;
private _heavyRifleAmmo	= [_ammoClasses, 2.2, 2.2, [0.8]] 	call ObjScan_fnc_approxClass;
private _standLowRifleA	= [_ammoClasses, 2, 2.1, 	[0.8]] 	call ObjScan_fnc_approxClass;
private _standHighRifleA= [_ammoClasses, 2.2, 2.3, [0.8]] 	call ObjScan_fnc_approxClass;
private _bigRifleAmmo	= [_ammoClasses, 2.3, 2.3, [0.8]] 	call ObjScan_fnc_approxClass;
private _APRifleAmmo	= [_ammoClasses, 2.4, 2.5, [0.8]] 	call ObjScan_fnc_approxClass;
private _sniperAmmo		= [_ammoClasses, 2.2, 2.5, [0.8]] 	call ObjScan_fnc_approxClass;
private _rhsSniperAmmo	= [_ammoClasses, 2.2, 2.5, [0.8, 4]] 	call ObjScan_fnc_approxClass;
private _lmgAmmo		= [_ammoClasses, 2, 2.3, 	[0.8]] 	call ObjScan_fnc_approxClass;
private _GMG_Ammo		= [_ammoClasses, 3, 3, 		[9.1, 9.2, 9.5, 0.9]] call ObjScan_fnc_approxClass;

private _smallAmmoMax	= false;
private _standAmmoMax	= false;
private _heavyAmmoMax	= false;
private _apAmmoMax	= false;

if(count _AmmoClasses > 0)
then{
		_smallAmmoMax	= (selectMax _ammoClasses) == 2;
		_standAmmoMax	= (selectMax _ammoClasses) == 2.1;
		_heavyAmmoMax	= (selectMax _ammoClasses) == 2.2;
		_apAmmoMax 	= (selectMax _ammoClasses) == 4;
	};


private _ShotgunMuzzle	= (!(_noUnderBarrel)
						&&{[_subAmmoClasses, 2.3, 2.4, [9.5]] call ObjScan_fnc_approxClass});
						
private _GL_Muzzle	= (!(_noUnderBarrel)
						&&{3 in _subAmmoClasses});

private _VSSmagSize		= (_maxAmmoCap <= 30
						&&{_minAmmoCap >= 10});

private _ARmagSize		= (_maxAmmoCap <= 40
						&&{_minAmmoCap >= 20});
						
private _bigARmagSize	= (_maxAmmoCap <= 150
						&&{_maxAmmoCap >  40
						&&{_minAmmoCap < 150
						or _smallRifleAmmo}});
						
private _lmgMagsize		= (_minAmmoCap 	> 100
						&&{_maxAmmoCap 	<= 500});
						
private _hmgMagsize		= (_minAmmoCap >= 75
						&&{_maxAmmoCap <= 500});

private _singleFireOnly	= (_fireModes get "single"
						&&{!(_fireModes get "burst")
						&&{!(_fireModes get "auto")}});

private _autoFireOnly	= (_fireModes get "auto"
						&&{!(_fireModes get "burst")
						&&{!(_fireModes get "single")}});


private _standardAR		= (_noUnderBarrel
						&&{(_ARmagSize or (_VSSmagSize && {_AR_Cursor}))
						&&{(_fireModes 	get "auto"
						or _fireModes 	get "burst")
						&&{_fireModes 	get "single"}}});

private _rhs45smg		= (_noUnderBarrel
						&&{_ARmagSize
						&&{_autoFireOnly
						&&{_standRifleAmmo
						&&{_SMG_Cursor}}}});

private _rhsPistol		= (_pistol_Cursor
						&&{_maxAmmoCap < 20
						&&{_singleFireOnly
						&&{_ammoClasses isEqualTo [1,2]
						}}});

private _singleAR		= (_noUnderBarrel
						&&{_ARmagSize
						&&{_singleFireOnly
						&&{(_AR_Cursor or _sniperCursor)
						&&{_lmgAmmo
						or _smallAmmoMax}}}});


private _bigMagAR		= (_noUnderBarrel
						&&{_bigARmagSize
						&&{_fireModes get "auto"
						&&{_fireModes get "single"}}});
						
private _shotgunAR		= (_ShotgunMuzzle
						&&{_ARmagSize
						&&{_fireModes get "auto"
						&&{_fireModes get "single"}}});
						
private _rhsShotGun		= (9.5 in _ammoClasses 
						&&{_maxAmmoCap <= 8
						&&{_AR_Cursor
						&&{_singleFireOnly}}});

private _GL_AR			= (_GL_Muzzle
						&&{_ARmagSize
						&&{_fireModes get "auto"
						&&{_fireModes get "single"}}});

private _GL_semiAR		= (_GL_Muzzle
						&&{_ARmagSize
						&&{_singleFireOnly}});

private _sniperRifle		= ((_singleFireOnly
						&&{_sniperAmmo
						&&{_maxAmmoCap <= 20}})
						or (_standHighRifleA or _heavyAmmoMax)
						&&{_maxAmmoCap <= 12});

private _rhsSniper		= (_rhsSniperAmmo
						&&{_singleFireOnly
						&&{_sniperCursor
						&&{_maxAmmoCap <= 12}}});

private _marksManRlf	= (_noUnderBarrel
						&&{_maxAmmoCap < 12
						&&{_singleFireOnly
						&&{_smallAmmoMax
						or  _standAmmoMax}}});
						
private _standardLMG	= (_fireModes get "auto"
						&&{_lmgMagsize
						&&{_noUnderBarrel}});

private _HMG 			= (_hmgMagsize
						&&{_APRifleAmmo
						&&{_autoFireOnly}});

private _rhsHMG		= (_minAmmoCap >= 50
						&&{_maxAmmoCap <= 250
						&&{_APRifleAmmo
						&&{_autoFireOnly
						&&{_aimType  == "mg"
						or _cursorType == "mg"}}}});

private _GMG			= (_fireModes get "auto"
						&&{_GMG_Ammo
						&&{_noUnderBarrel
						&&{_minAmmoCap > 3}}});
						
private _cup_GMG		= (_ammoClasses isEqualTo [3]
						&&{_rps > 5
						&&{_noUnderBarrel
						&&{_minAmmoCap > 30}}});

private _handHeldGMG	= (_GMG_Ammo
						&&{_noUnderBarrel
						&&{_minAmmoCap > 3
						&&{_rps > 10
						&&{_AR_Cursor}}}});
					
private _infRLauncher	= (_minAmmoCap == 1
						&&{_maxAmmoCap == 1
						&& [_ammoClasses, 6, 6.2] call ObjScan_fnc_approxClass});
						
private _infAGLauncher	= (_minAmmoCap == 1
						&&{_maxAmmoCap == 1
						&& [_ammoClasses, 7, 7.2] call ObjScan_fnc_approxClass});

private _infAALauncher	= (_minAmmoCap == 1
						&&{_maxAmmoCap == 1
						&& [_ammoClasses, 7.3, 7.3] call ObjScan_fnc_approxClass});
						
private _infCoMLauncher	= (_minAmmoCap == 1
						&&{_maxAmmoCap == 1
						&& [_ammoClasses, 7, 7.3] call ObjScan_fnc_approxClass});
						
private _all_InfLaunchers	= (_minAmmoCap == 1
						&&{_maxAmmoCap == 1
						&& [_ammoClasses, 6, 7.3] call ObjScan_fnc_approxClass});



if(_ammoClasses isEqualTo [0.9])					exitWith{0.9};
if(_ammoClasses isEqualTo [9])					exitWith{8	};
if(_ammoClasses isEqualTo [9.1])					exitWith{0.7};
if(_ammoClasses isEqualTo [9.2])					exitWith{0.6};
if([_name, "smoke"] call ObjScan_fnc_FindSubString)	exitWith{0.6};

if 	((_pistolAmmo				
&& 	{_maxAmmoCap < 31
&& 	{_singleFireOnly}})
or	(_rhsPistol))				exitWith{1};	/*Pistol*/

if(_pistolAmmo)					exitWith{1.1};	/*subMachineGun*/
if(_rhsShotGun)					exitWith{1.11};
if(_standardAR
&&{_smallRifleAmmo
or _standLowRifleA})			exitWith{1.3};	/*~5.56 no GL*/

if(_standardAR
&&{_standRifleAmmo
or _standAmmoMax})				exitWith{1.4};	/*~6.5 - 7.62x39 no GL*/

if(_standardAR
&&{_heavyRifleAmmo})			exitWith{1.5};	/*~7.62x51 no GL*/

if(_standardAR
&&{_bigRifleAmmo})				exitWith{1.6};	/*9.3-12.7*/

if(_singleAR or _marksManRlf)	exitWith{1.12};

if(_bigMagAR
&&{_smallRifleAmmo})			exitWith{1.7};	/*556 40-150mag AR*/
if(_bigMagAR
&&{_standRifleAmmo
or  _heavyRifleAmmo})			exitWith{1.8};	/*6.5-7.62 40-150mag AR*/

if(_sniperRifle or _rhsSniper)	exitWith{1.9};	/*sniper-rifles*/
if(_shotgunAR)					exitWith{2};	/*AR with shotgun underBarrel*/

if(_GL_AR 
&&{_subMaxCap >= 3})			exitWith{2.4}; /*GL AR with at least 3 grenades in the mag*/

if(_GL_AR or _GL_semiAR
&&{(_smallRifleAmmo
or   _smallAmmoMax)})			exitWith{2.1};	/*5.56 GL rifle*/


if(_GL_AR or _GL_semiAR
&&{_standRifleAmmo
or (_standAmmoMax)})			exitWith{2.2};	/*6.5-7.62x39 GL rifle*/

if(_GL_AR or _GL_semiAR
&&{_heavyRifleAmmo
or	_bigRifleAmmo
or	_APRifleAmmo
or  _heavyAmmoMax})				exitWith{2.3}; /*7.62x39++ GL rifle*/

if(_handHeldGMG)				exitWith{2.5};




if(_standardAR or _rhs45smg)exitWith{1.2}; /*catch All remaining assaultRifles*/

if(_standardLMG
&&{_standLowRifleA})		exitWith{3.1};	/*LMG 5.56 - 6.5*/

if(_standardLMG
&&{_standHighRifleA})		exitWith{3.2};	/*LMG 7.62 - 9.3*/

if(_standardLMG
&&{_lmgAmmo})				exitWith{3};	/*catch All remaining Light machineGuns*/
If(_HMG or _rhsHMG)			exitWith{3.3}; /*HMG 12.7*/
if(_GMG or _cup_GMG)		exitWith{3.4}; /*GMG*/

if(_infRLauncher)			exitWith{4};	/*rocket launchers 	1-shot*/
if(_infAGLauncher)			exitWith{4.1};	/*AGM launchers 	1-shot*/
if(_infAALauncher)			exitWith{4.2};	/*AA launchers 		1-shot*/

if(_infCoMLauncher)			exitWith{4.3};	/*AGM-AA launchers	1-shot*/
if(_all_InfLaunchers)		exitWith{4.4};	/*ALL launchers		1-shot*/

_class = [_weaponData, _CFGname] call ObjScan_fnc_vehicleWeaponClass;


if(_name == "")		exitWith{-1};
if(_name == "Horn")	exitWith{0.8};

_class