params ["_weaponModes"];
private _fireModes 	= createHashMap;
private _single 	= false;
private _burst 		= false;
private _auto 		= false;
private _artillery	= false;

{
	private _modeMap 		= _y;
	private _burstValue		= _modeMap get "burst";
	private _autoValue		= _modeMap get "autoFire";
	
	private _artyCharge		= _modeMap get "artyCharge";
	private _artyDispersion	= _modeMap get "artyDispersion";
	
	if(_burstValue < 2
	&&{_autoValue < 1})
	then{_single = true};
	
	if(_burstValue > 1)
	then{burst = true};
	
	if(_burstValue < 2
	&&{_autoValue > 0})
	then{_auto = true};
	
	if(_artyCharge < 1
	&&{_artyDispersion > 1
	or  _artyDispersion < 1})
	then{_artillery = true};
	
}forEach _weaponModes;

_fireModes set ["single", _single];
_fireModes set ["burst", _burst];
_fireModes set ["auto", _auto];
_fireModes set ["artillery", _artillery];

_fireModes