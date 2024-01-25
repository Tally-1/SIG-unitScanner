params [
	["_scope", nil, [""]]
];

if(_scope == "")exitWith{0};
private _maxRange = 50;
private _ranges = [];
private _opticConfigs   = ("true" configClasses (configfile >> "CfgWeapons" >> _scope >> "ItemInfo" >> "OpticsModes"));

{
	private _zoomMax   = getNumber(_x >> "distanceZoomMax");
	private _zoomMin   = getNumber(_x >> "distanceZoomMin");
	private _distances = getArray (_x >> "discreteDistance");
	_ranges pushBackUnique _zoomMax;
	_ranges pushBackUnique _zoomMin;
	_ranges insert [0, _distances, true];

}forEach _opticConfigs;
_maxRange = (selectMax _ranges);

_maxRange;