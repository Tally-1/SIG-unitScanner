private _HashToCopy = SIG_AmmoData;
params ["_HashToCopy"];
private _timer 			= time;
private _iterationTimer	= time + 2;
private _longScan		= false;
private _counter 		= 0;
private _vehicleWeapons 	= [];
private _name			= "";
private _objectCount		= (count vehicles) + (count allUnits) + (count VEH_MEN);

systemChat format["Scanning %1 objects...", _objectCount];

{
	if((_x isKindOf "land"
	or _x isKindOf "air")
	&&{!(_x isKindOf "man")})
	then{[_x] call Tally_Fnc_VehicleData};
	
	if(_x isKindOf "man")
	then{
			[_x] call Tally_Fnc_infWeaponData;
			[_x] call Tally_Fnc_infArmorData;
		};
	
	private _Weapons = [_x] call Tally_Fnc_GetVehicleWeapons;
	for "_I" from 0 to ((count _weapons)-1)do{_vehicleWeapons pushBackUnique (_weapons select _I)};
	_counter = (_counter + 1);
	
	if(time > _iterationTimer)
	then{
			_iterationTimer = time + 2;
			_longScan	  = true;
			hint format["Please wait %1 of %2 objects scanned...", _counter, _objectCount];
		};
} forEach vehicles;

{VEH_MEN pushBackUnique _x}forEach allUnits;

{
	[_x] call Tally_Fnc_infWeaponData;
	[_x] call Tally_Fnc_infArmorData;
	_counter = (_counter + 1);
	if(time > _iterationTimer)
	then{
			_iterationTimer = time + 2;
			_longScan	  = true;
			hint format["Please wait %1 of %2 objects scanned...", _counter, _objectCount];
		};
}forEach VEH_MEN;


if(_longScan)then{Hint "getting vehicle weapon data"};

{[_x] call Tally_Fnc_weaponData}forEach _vehicleWeapons;


switch _HashToCopy do
{
	case SIG_HelmetData: 		{_name = "HelmetData"};
	case SIG_VestData: 			{_name = "VestData"};
	case SIG_uniformData: 		{_name = "uniformData"};
	case SIG_AmmoData: 			{_name = "AmmoData"};
	case SIG_subMunitionData: 	{_name = "subMunitionData"};
	case SIG_MagazineData: 		{_name = "MagazineData"};
	case SIG_weaponData: 		{_name = "weaponData"};
	case SIG_VehicleData: 		{_name = "VehicleData"};
	default 					{_name = "data"};
};


copyToClipboard str _HashToCopy;
systemChat format["scanned %1 objects in %2 seconds", _counter, (time - _timer)];
systemChat format["Copied %1 to clipboard", _name];
if(_longScan)then{Hint "Scan complete!"};
