private _exceptions = [];
params ["_AmmoClasses", "_min", "_max", "_exceptions"];
private _withinRange = true;

{
	private _outOfRange = (_X > _max or _X < _min);
	private _exception	= (_x in _exceptions);
	if(_outOfRange
	&&{!(_exception)})
	exitWith{_withinRange = false};
	
}forEach _AmmoClasses;

if(_AmmoClasses isEqualTo [])then{_withinRange = false};

_withinRange