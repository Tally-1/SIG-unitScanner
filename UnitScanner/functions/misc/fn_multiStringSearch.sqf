params ["_strings", "_substring"];
private _stringFound = false;

{
	if([_x, _substring] call Tally_Fnc_FindSubString)exitWith{_stringFound = true};
}forEach _strings;

_stringFound