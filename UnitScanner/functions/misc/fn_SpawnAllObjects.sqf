private _spawnMen = false;
private _spawnVanilla = false;
params["_spawnMen"];
private _configs 	= configProperties [(configfile >> "CfgVehicles"), "true", true];
private _strConfigs 	= [];
private _long 		= 0;
private _lat 		= 0;
private _counter 	= 0;
private _group 		= createGroup civilian;
private _object 		= "";

{if(_x getVariable "scanVeh")then{deleteVehicle _x}} forEach vehicles;
{if(_x getVariable "scanVeh")then{deleteVehicle _x}} forEach allUnits;


{
	private _cfg 		= [([_x] joinString "")] call ObjScan_fnc_CFGfromConfig;
	private _isMan 		= (_cfg isKindOf "man");
	private _spawnThis 	= ((_spawnMen
						&&{_isMan})
						or (!(_spawnMen)
						&&{!(_isMan)}));
	
	if(_cfg isKindOf "land"
	&& {_spawnThis
	&&{!(getText (_x >> "author") == "Bohemia InterActive")}})
	then{
			_strConfigs pushBackUnique ([_x] joinString "");
			
			private _pos = [_long, _lat, 0];
			_long = _long +20;
			if(_long > 500)then{_long = 0; _lat = _lat +20};
			
			_object = createVehicle [_cfg, _pos];
			_object setVariable ["scanVeh", true];
			
			if(_object isKindOf "man"
			&&{!(primaryWeapon _object == "")})
			then{VEH_MEN pushBackUnique _object};
			
			
			hint format ["%1 objects spawned", _counter];
			_counter = _counter +1;
			sleep 0.02;
		};
}forEach _configs;
hint format ["%1 objects spawned. Spawning complete!", _counter];
[["%1", (count _strConfigs)]] call ObjScan_fnc_DebugMsg;