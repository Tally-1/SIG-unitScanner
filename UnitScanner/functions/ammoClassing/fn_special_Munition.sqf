params ["_ammoName", "_projectile_Data"];
private _special = "";
private _subAmmoName = (_projectile_Data get "submun data") get "name";
if(isNil "_subAmmoName")then{_subAmmoName = ""};
private _strings 			= [_ammoName, _subAmmoName];
private _SpecialNames 	= ["mine", "cluster", "smoke", "flare", "chaff", "penetrator", "laser", "pellets", "buckshot", "blank"];


{
	private _match = [_strings, _x] call ObjScan_fnc_multiStringSearch;
	if(_match)then{_special = _x};
} forEach _SpecialNames;

if(_special == "")
then{
		if((getText (configfile >> "CfgAmmo" >> _ammoName >> "simulation")) == "shotIlluminating")
		then{
				_special = "flare"
			};
		
	};

_special