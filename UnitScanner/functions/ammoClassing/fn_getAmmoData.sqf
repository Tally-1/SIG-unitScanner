private _subMunition = false;
private _minSpeed	= 0;
params ["_Ammo", "_subMunition", "_minSpeed"];
private _data = SIG_AmmoData get _Ammo;

if(!isNil "_data")exitWith{_data};


private _subMunData	= createHashMap;
private _returnData		= createHashMap;
		_data 			= createHashMap;
private _baseDamage 	= getNumber (configfile >> "CfgAmmo" >> _Ammo >> "hit");
private _penetration	= getNumber (configfile >> "CfgAmmo" >> _Ammo >> "caliber"); 
private	_subMun			= getText 	(configfile >> "CfgAmmo" >> _Ammo >> "submunitionAmmo");
private _warHead		= getText	(configfile >> "CfgAmmo" >> _Ammo >> "warheadName");
private _weaponType		= getText	(configfile >> "CfgAmmo" >> _Ammo >> "weaponType");

/*Some projectiles have "penetrator sub-ammo"*/
if(_penetration < 2
&&{!(_subMun == "")})
then{_penetration		= getNumber (configfile >> "CfgAmmo" >> _subMun >> "caliber")};


if(!(_subMun == ""))
then{
		private _subMunDt = [_subMun, true] call Tally_Fnc_getAmmoData;
		_subMunData set ["name", _subMun];
		_subMunData set ["data", _subMunDt];
	};



private _SplashDamage	= getNumber (configfile >> "CfgAmmo" >> _Ammo >> "indirectHit");
private _SplashRange	= getNumber (configfile >> "CfgAmmo" >> _Ammo >> "indirectHitRange");
private _grenade		= (getNumber (configfile >> "CfgAmmo" >> _Ammo >> "fuseDistance") > 2 
						  &&{_SplashDamage > 3 
						  &&{_SplashRange > 3}});
						
private _Propelled		= (getNumber (configfile >> "CfgAmmo" >> _Ammo >> "maxSpeed")) > 0;
private _Guided			= (getNumber (configfile >> "CfgAmmo" >> _Ammo >> "maneuvrability")) > 1;
private _AA				= (getNumber (configfile >> "CfgAmmo" >> _Ammo >> "airLock")) == 2;

_data set ["dammage", 			_baseDamage];
_data set ["penetration", 		_penetration];
_data set ["pen dammage", 		(_baseDamage * _penetration)];
_data set ["submunition", 		_subMun];
_data set ["submun data", 		_subMunData];
_data set ["warHead", 			_warHead];
_data set ["splashDamage", 		_SplashDamage];
_data set ["splashRange", 		_SplashRange];
_data set ["projectile Speed", 	_minSpeed];
_data set ["weaponType", 		_weaponType];
_data set ["grenade", 			_grenade];
_data set ["propelled",		 	_Propelled];
_data set ["guided", 			_Guided];
_data set ["anti air",			_AA];
_data set ["Special", 			([_Ammo, _data] call Tally_Fnc_special_Munition)];

private _classID 		= [_data] call Tally_Fnc_ClassifyAmmo;
private _description	= [_classID] call Tally_Fnc_describeAmmoByClass;


_data set ["class ID", 		_classID];
_data set ["Description", 	_description];

if(_subMunition)
then{SIG_subMunitionData set [_Ammo, _data]}
else{SIG_AmmoData set [_Ammo, _data]};

_data