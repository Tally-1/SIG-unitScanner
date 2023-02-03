params ["_object"];
private _shape		= createHashMap;
private _XYZ 		= (boundingBox _object) select 1;
private _X_Y_Ratio	= (_XYZ select 1) / (_XYZ select 0);
private _center		= boundingCenter _object;


_shape set ["width",	[(_XYZ select 0), 1] call ObjScan_fnc_decimals];
_shape set ["length", 	[(_XYZ select 1), 1] call ObjScan_fnc_decimals];
_shape set ["height", 	[(_XYZ select 2), 1] call ObjScan_fnc_decimals];
_shape set ["center", 	_center];
_shape set ["Y to X", 	[_X_Y_Ratio, 1] 	 call ObjScan_fnc_decimals];

_shape