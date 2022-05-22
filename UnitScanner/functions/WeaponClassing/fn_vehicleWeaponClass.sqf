params ["_weaponData", "_CFGname"];

private _class 			= 0; 
private _muzzles			= _weaponData 	get "muzzles";
private _mortarAim		= (_weaponData 	get "cursor") 		== "mortar";
private _cannonAim		= (_weaponData 	get "cursor-aim")	== "cannon";
private _ammoNames 	= _weaponData 	get "ammoNames";
private _ammoClasses 	= _weaponData 	get "ammoClasses";
private _subAmmoClasses	= _muzzles		get "ammoClasses";
private _subMinCap		= _muzzles		get "min-Ammo-Cap";
if(isNil "_subMinCap")	then{_subMinCap = 	0};
private _subMaxCap		= _muzzles		get "max-Ammo-Cap";
private _maxAmmoCap 	= _weaponData 	get "max-Ammo-Cap";
private _minProj_Speed	= _weaponData 	get "max-Ammo-speed";
private _minAmmoCap	= _weaponData 	get "min-Ammo-Cap";
private _weaponModes 	= _weaponData 	get "weapon-modes";
private _subWeaponMod	= _muzzles 		get "weapon-modes";
private _fireModes		= _weaponData 	get "fire-Modes";
private _artyMode		= (_fireModes 	get "artillery");
private _rps				= _weaponData	get "RPS";
private _minRPS			= (_rps < 1 && {_rps > 0});
private _mgRPS			= (_rps == 10);
private _highRps			= _rps > 20;
private _extremeHighRps	= _rps > 60;
private _autoFireOnly	= (_fireModes get "auto"
						&&{!(_fireModes get "burst")
						&&{!(_fireModes get "single")
						&&{!(_artyMode)}}});

private _singleFireOnly	= (_fireModes get "single"
						&&{!(_fireModes get "burst")
						&&{!(_fireModes get "auto")}});

private _confirmedArty = (_artyMode
					  &&{_mortarAim});
						
if(_ammoClasses isEqualTo []
&&{!isNil "_subAmmoClasses"})
then{
		{
			_ammoClasses pushBackUnique _x;
		} forEach _subAmmoClasses;
	};

private _rifleAmmo		= [_ammoClasses, 2, 2.2] 						call Tally_Fnc_approxClass;
private _smallAmmo		= [_ammoClasses, 2, 2.5, [0.8]] 				call Tally_Fnc_approxClass;
private _largeAmmo		= [_ammoClasses, 4, 4.3, [3, 8, 5.1, 0.9]] 	call Tally_Fnc_approxClass;
private _tankAmmo		= [_ammoClasses, 5, 5.3, [7.1]] 				call Tally_Fnc_approxClass;
private _artyAmmo		= [_ammoClasses, 8, 8.1, [9.2, 9.3, 9.4]] 		call Tally_Fnc_approxClass;
private _mortarAmmo	= [_ammoClasses, 8, 8, [9.1, 9.2, 9.3, 9.4]] 	call Tally_Fnc_approxClass;
private _AGM			= [_ammoClasses, 7, 7.2] 						call Tally_Fnc_approxClass;
private _AAM			= [_ammoClasses, 7.3, 7.3, [0.9]] 				call Tally_Fnc_approxClass;
private _rockets			= [_ammoClasses, 6, 6.2] 						call Tally_Fnc_approxClass;
private _combinedMisiles	= [_ammoClasses, 7, 7.3] 						call Tally_Fnc_approxClass;

private _artyAmmoMax	= false;
private _artyRounds		= false;
private _tankRounds		= false;

if(count _AmmoClasses > 0)
then{
		_artyAmmoMax 	= (selectMax _ammoClasses) == 8.1;
		_artyRounds		= (8 in _ammoClasses 
						or 8.1 in _ammoClasses);
						
		_tankRounds		= (5 in _ammoClasses 
						or 5.1 in _ammoClasses
						or 5.2 in _ammoClasses
						or 5.3 in _ammoClasses);
	};

private _rhsBigRockets	= (_artyRounds
						&& {[_ammoNames, "rocket"] call Tally_Fnc_multiStringSearch});

private _cupLMG		= (_rifleAmmo 
						&&{_mgRPS
						&&{_maxAmmoCap >= 1000
						&&{_minAmmoCap >= 100}}});

private _minigun		= 	(_maxAmmoCap >= 1000 
						&& 	{_highRps}
						or	(_extremeHighRps
						&&	{_maxAmmoCap >= 400}));

private _arty 			= ((_artyAmmo or _artyAmmoMax)
						&&{_artyMode
						&&{_maxAmmoCap > 10}});

private _artillery			= (_artyMode
						&&{_mortarAim
						&&{_artyAmmoMax
						or _artyRounds}});

private _Mortar			= (_mortarAmmo
						&&{_artyMode
						&&{_maxAmmoCap <= 10}});

private _rocketBattery	= (_maxAmmoCap >= 4
						&&{_rps >= 3
						&&{_rockets}});

private _rocketArtillery	= (_rps >= 5
						&&{_artyMode
						&&{_artyAmmo}});

private _rhsMlrs			= (_rhsBigRockets
						&&{_artyMode});

	
private _magRocketLnchr	= (_maxAmmoCap >= 3
						&&{_rps < 1
						&&{_rockets}});


private _ATM_Battery		= (_maxAmmoCap >= 4
						&&{_AGM
						&&{_rps > 1}});

private _rhsM242		=(_rockets
						&&{_rps >= 3
						&&{_subMinCap >= 70
						&&{_subMaxCap <= 230
						&&{_cannonAim
						&&{_autoFireOnly}}}}});

private _rhsAutoCannon	= (4.1 in _AmmoClasses or 4.2 in _AmmoClasses
						&&{_minProj_Speed > 900
						&&{_minAmmoCap >= 100
						&& _rps > 3}});



/*
The following line uses both vanilla values and a alternative method for identifying a 120mm tankCannon.
The alternative method is needed to deal ith modded weapons that might have ammoTYpes that do not fall into 
the standard vanilla parameters.
*/
private _tankCannon		= ((_tankAmmo
						&&{_singleFireOnly
						&&{!(_AGM)
						&&{!(_confirmedArty)}}})
						or 
						   ((_tankRounds or _artyRounds)
						&&{_singleFireOnly
						&&{!(_confirmedArty)
						&&{_minRPS
						}}}));

if(_minigun && {_smallAmmo})	exitWith{5};
if(_minigun && {_largeAmmo})	exitWith{5.1};
if(_minigun && {_tankAmmo})	exitWith{5.1};

if((_fireModes get "auto" or _rps > 10) &&{_largeAmmo})	exitWith{5.2};
if(_rhsM242)											exitWith{5.2};
if(_rhsAutoCannon)										exitWith{5.2};

if(_smallAmmo 
&&{!(_singleFireOnly)
&&{_rps > 10}})
exitWith{3};

if(_tankCannon)
exitWith{5.3};


if(_Mortar)					exitWith{6};
if(_arty or _artillery)			exitWith{6.1};
if(_rocketArtillery or _rhsMlrs)exitWith{6.2};
if(_rocketBattery)			exitWith{7};
if(_magRocketLnchr)			exitWith{4.01};

if(_AGM
&&{_maxAmmoCap == 2})
exitWith{7.1};


if(_AGM
&&{_maxAmmoCap > 2})
exitWith{7.2};


if(_AAM
&&{_maxAmmoCap == 2})
exitWith{7.3};

if(_AAM
&&{_maxAmmoCap > 2})
exitWith{7.4};

if(_combinedMisiles
&&{_maxAmmoCap > 1})
exitWith{7.5};



if(_ammoClasses isEqualTo [9.5, 2.5])
exitWith{1.11};

if(_cupLMG)exitWith{3.1};

_class