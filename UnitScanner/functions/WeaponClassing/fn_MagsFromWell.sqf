params ["_weapon"];
private _magazines 	= [];
private _wells		= (getArray (configfile >> "CfgWeapons" >> _weapon >> "magazineWell"));



{
	private _wellMags 	= [];
	private _Configs = configProperties [(configfile >> "CfgMagazineWells" >> _X), "true", true];
	private _ConfigCount	= (count _Configs) -1;
	
	for "_I" from 0 to _ConfigCount
	do 	{
			private _mags = (getArray (_Configs select _I));
			_wellMags = [_mags, _wellMags] call ObjScan_fnc_fillArrFromArr;
		};
	
	private _magCount	= (count _wellMags) -1;
	
	for "_I" from 0 to _magCount
	do 	{_magazines pushBackUnique (_wellMags select _I)};
	
}forEach _wells;

_magazines