params ["_Vehicle"];
private _vehicleCFG = (typeOf _vehicle);
private _vehicleData = SIG_VehicleData get _vehicleCFG;
if(!isNil "_vehicleData")exitwith{_vehicleData};

private _vehicleData = createHashMap;
private _armorData 	 = createHashMap;
private _chassis     = createHashMap;

private _simulationType	= (getText 		(configfile >> "CfgVehicles" >> _vehicleCFG >> "simulation"));
private _class			= (getText 		(configfile >> "CfgVehicles" >> _vehicleCFG >> "vehicleClass"));
private _textName		= (getText 		(configfile >> "CfgVehicles" >> _vehicleCFG >> "textSingular"));
private _name			= (getText 		(configfile >> "CfgVehicles" >> _vehicleCFG >> "displayName"));
private _macro			= (getText 		(configfile >> "CfgVehicles" >> _vehicleCFG >> "_generalMacro"));
private _flaps			= (getNumber	(configfile >> "CfgVehicles" >> _vehicleCFG >> "flaps"));

private _enginePower	= (getNumber	(configfile >> "CfgVehicles" >> _vehicleCFG >> "enginePower"));
private _maxSpeed		= (getNumber	(configfile >> "CfgVehicles" >> _vehicleCFG >> "maxSpeed"));


private _VTOL			= (getNumber	(configfile >> "CfgVehicles" >> _vehicleCFG >> "vtol") > 0);
private _typeData		= createHashMap;


if([_name, "Volga"] call ObjScan_fnc_FindSubString) then {_name = "GAZ-24"};


MACROS pushBackUnique _macro;
_typeData set ["kindOfcar", 		(_vehicleCFG isKindOf "car")]; 
_typeData set ["kindOftank", 	 	(_vehicleCFG isKindOf "tank")]; 
_typeData set ["kindOfStatic", 	 	(_Vehicle isKindOf "StaticWeapon")]; 
_typeData set ["drone", 			isAutonomous _Vehicle];
_typeData set ["kindOfAir", 	 	(_Vehicle isKindOf "Air")]; 
_typeData set ["helicopter", 		(_Vehicle isKindOf "Helicopter")]; 
_typeData set ["plane", 			(_Vehicle isKindOf "plane")]; 
_typeData set ["VTOL", 	 	 		_VTOL]; 
_typeData set ["className", 			_class];
_typeData set ["flaps", 		 		_flaps];
_typeData set ["enginePower", 		_enginePower];
_typeData set ["maxSpeed", 		 	_maxSpeed];
_typeData set ["textDescription",	_textName];
_typeData set ["name", 			 	_name];


private _mass			  = getMass _Vehicle;
private _size			  = sizeOf _vehicleCFG;
private _HP				  = (getNumber (configfile >> "CfgVehicles" >> _vehicleCFG >> "armor"));
private _Armor			  = (getNumber (configfile >> "CfgVehicles" >> _vehicleCFG >> "armorStructural"));
private _damageResistance = (getNumber (configfile >> "CfgVehicles" >> _vehicleCFG >> "damageResistance"));
private _hitCrew		  = (getNumber (configfile >> "CfgVehicles" >> _vehicleCFG >> "crewVulnerable"));
private _passengers		  = (getNumber (configfile >> "CfgVehicles" >> _vehicleCFG >> "transportSoldier"));
private _driver			  = (getNumber (configfile >> "CfgVehicles" >> _vehicleCFG >> "hasDriver"));
private _wheels			  = count ("true" configClasses (configfile >> "CfgVehicles" >> _vehicleCFG >> "Wheels"));
/*private _author				= (getNumber (configfile >> "CfgVehicles" >> _vehicleCFG >> "author"));*/

private _turretConfigs = "true" configClasses (configfile >> "CfgVehicles" >> _vehicleCFG >> "Turrets");
private _allWeapons    = createHashMap;
private _WeaponTypes   = [];
private _crew          = _driver;
private _weapons       = [_Vehicle] call ObjScan_fnc_GetVehicleWeapons;

{_crew	= (_crew + getNumber (_x >> "hasGunner"))} forEach _turretConfigs;

{
	private _subData	= createHashMap;
	private _weapon 	= _x;
	private _weaponData	= [_weapon] call ObjScan_fnc_weaponData;
				
	_subData 	set ["class ID", 	(_weaponData get "class ID")];
	_subData 	set ["name", 		(_weaponData get "name")];
	_subData 	set ["description",(_weaponData get "description")];
	//_subData 	set ["aimType",	(_weaponData get "cursor-aim")];
	_subData 	set ["ammoClasses",(_weaponData get "ammoClasses")];
	_allWeapons set [_weapon, _subData];
	_WeaponTypes pushBackUnique (_weaponData get "class ID");
} forEach _weapons;


_armorData set 	["HP", 					_HP];
_armorData set 	["armor", 				_Armor];
_armorData set 	["Calculated HP",		round(_HP / _Armor)];
_armorData set 	["combined HP",			round(_HP + _Armor)];
_armorData set 	["Standard Armor-Level",[_armorData] call ObjScan_fnc_vehicleArmorLevel];
_armorData set 	["Alt Armor-Level",		round(_Armor / _HP)];
_armorData set 	["damageResistance",	_damageResistance];
_armorData set 	["openVehicle",			_hitCrew];
_vehicleData set ["weapons", 			_allWeapons];
_vehicleData set ["crew", 				_crew];
_vehicleData set ["armorData", 			_armorData];
_vehicleData set ["weaponTypes",			_WeaponTypes];
_vehicleData set ["passengers",			_passengers];
_vehicleData set ["driver",				_driver];
_vehicleData set ["name", 			 	_name];
_vehicleData set ["macro", 			 	_macro];
_vehicleData	set ["maxSpeed", 		 	_maxSpeed];

_armorData 	set ["CUP-armor", 			([_vehicleData] call ObjScan_fnc_CupArmor)];

_chassis 		set ["wheels", 				_wheels];
_chassis 		set ["mass", 				round _mass];
_chassis 		set ["size", 				round _size];
_chassis 		set ["shape", 				[_Vehicle] call ObjScan_fnc_objectShape];

private _chassisID 			= [_vehicleData, _typeData, _chassis] call ObjScan_fnc_getChassis;
private _chassisDescription	= [_chassisID] call ObjScan_fnc_chassisDespcription;

_chassis 		set ["chassisID", 			_chassisID];
_chassis 		set ["chassisDescription",	_chassisDescription];
_vehicleData set ["chassis",				_chassis];




SIG_VehicleData set [_vehicleCFG, _vehicleData];

_vehicleData