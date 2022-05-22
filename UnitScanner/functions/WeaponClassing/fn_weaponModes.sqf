params ["_weapon"];
private _modes 	= (getArray (configfile >> "CfgWeapons" >> _weapon >> "modes"));
private _WpModes = createHashMap;

{
	private _name 			= getText	(configfile >> "CfgWeapons" >> _weapon >> 	_X >> "displayName");
	private _autoFire 		= getNumber	(configfile >> "CfgWeapons" >> _weapon >> 	_X >> "autoFire");
	private _burst 			= getNumber	(configfile >> "CfgWeapons" >> _weapon >> 	_X >> "burst");
	private _reloadTime 		= getNumber	(configfile >> "CfgWeapons" >> _weapon >>	_x >> "reloadTime"); 
	private _showToPlayer	= getNumber	(configfile >> "CfgWeapons" >> _weapon >>	_x >> "showToPlayer");
	private _artyCharge		= getNumber	(configfile >> "CfgWeapons" >> _weapon >>	_x >> "artilleryCharge");
	private _artyDispersion	= getNumber	(configfile >> "CfgWeapons" >> _weapon >>	_x >> "artilleryDispersion");
	
	if(_showToPlayer > 0)
	then{
			private _mode		= createHashMap;
			private _modeData	= createHashMap;
			
			_modeData set ["cfgName", 			_X];
			_modeData set ["autoFire", 			_autoFire];
			_modeData set ["burst", 			_burst];
			_modeData set ["reloadTime", 		_reloadTime];
			_modeData set ["artyCharge", 		_artyCharge];
			_modeData set ["artyDispersion", 	_artyDispersion];
			
			_WpModes set [_name, _modeData];
		};

}forEach _modes;

_WpModes