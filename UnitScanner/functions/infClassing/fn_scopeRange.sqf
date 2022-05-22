params ["_scope"];

if(_scope == "")exitWith{0};
private _maxRange = 50;
private _ranges = [];
private _opticConfigs = ("true" configClasses (configfile >> "CfgWeapons" >> _scope >> "ItemInfo" >> "OpticsModes"));

{
	_ranges pushBackUnique (getNumber(_x >> "distanceZoomMax"));
}forEach _opticConfigs;
_maxRange = (selectMax _ranges);

_maxRange