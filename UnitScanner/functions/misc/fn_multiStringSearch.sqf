params ["_strings", "_substring"];
private _stringFound = false;

{
	if([_x, _substring] call ObjScan_fnc_FindSubString)exitWith{_stringFound = true};
}forEach _strings;

_stringFound