
params ["_string", "_subString"];
private _subStringPresent = false;

if(isNil "_string")						exitWith{false};
if(isNil "_subString")					exitWith{false};
if(_string == "" or _subString == "")	exitWith{false};

(_subString in _string)