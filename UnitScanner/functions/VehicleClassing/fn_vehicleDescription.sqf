params ["_vehicleData"];
private _chassis 				= (_vehicleData get "chassis") get "chassisDescription";
private _chassisID				= (_vehicleData get "chassis") get "chassisID";
private _weaponData				= _vehicleData get "weapons";
private _weapons				= _vehicleData get "weaponTypes";
private _drone					= _vehicleData get "drone";
private _passengers				= _vehicleData get "passengers";
private _transPort				= _passengers > 5;
private _description 			= _chassis;
private _lethalWeapons			= [];

if(count _weapons > 0)
then{
		private _excludedWeaponTypes	= [0.6, 0.7, 0.8, 0.9];
		private _transPortTXT			= "";
		if(_transPort)then{_transPortTXT	= " transport"};
		{if!(_x in _excludedWeaponTypes)then{_lethalWeapons pushBackUnique _X}}forEach _weapons;/*fill lethaWeapons array*/
		
		if(count _lethalWeapons > 0)
		then{
				private _mainWeaponType 		= selectMax _lethalWeapons;
				private _mainWeaponDescription 	= [_mainWeaponType] call Tally_Fnc_describeWeaponByClass;
				_description = [_chassis, _transPortTXT, " (", _mainWeaponDescription, ")"] joinString "";
			};
	};

private _Armed 		= !(count _lethalWeapons > 0);

private _LMG 		= (3 in _lethalWeapons
					or 3.1 in _lethalWeapons
					or 3.2 in _lethalWeapons);

private _HMG 		= (3.3 in _lethalWeapons);
private _GMG 		= (3.4 in _lethalWeapons);

private _ATM		= (7.1 in _lethalWeapons
					or 7.2 in _lethalWeapons
					or 4.2 in _lethalWeapons);

private _AAM		= (4.2 in _lethalWeapons
					or 7.3 in _lethalWeapons
					or 7.4 in _lethalWeapons);

private _AutoCannon	= (5.1 in _lethalWeapons
					or 5.2 in _lethalWeapons);

private _Cannon		= (5.3 in _lethalWeapons);

private _rocket		= (7 in _lethalWeapons
					or 4 in _lethalWeapons
					or 4.01 in _lethalWeapons);

private _bomber		=(8 in _lethalWeapons);



/*Air vehicles*/
if(_Armed
&&{_chassisID == 4})then{_description = "Armed small chopper"};

if(_chassisID >= 4
&&{_chassisID <= 4.3
&&{_ATM
&&{_AutoCannon}}})
then{_description = "CAS chopper"};

if(_Armed
&&{_chassisID == 3.1})
then{_description = "Armed Jet"};

if(_chassisID == 3.1
&&{_AutoCannon
&&{_ATM
or _bomber}})
then{
		_description = "CAS Jet"
	};

/*Land vehicles*/
if((_chassisID == 2.4
or _chassisID == 2.5)
&&{_transPort
&&{!(_Armed)}})
then{
		_description = "unarmed APC";
	};

if((_chassisID == 2.4
or _chassisID == 2.5)
&&{_transPort
&&{_HMG
or  _GMG}})
then{
		_description = "APC";
	};

if((_chassisID == 2.4
or _chassisID == 2.5)
&&{_transPort
&&{_AutoCannon}})
then{
		_description = "IFV";
	};

if((_chassisID == 2.4
or _chassisID == 2.5)
&&{!(_transPort)
&&{_Cannon}})
then{
		_description = "Tank destroyer";
	};

if((_chassisID == 2.4
or _chassisID == 2.5
or _chassisID == 1.3)
&&{!(_transPort)
&&{_AAM}})
then{
		_description = "Armored Anti-Air";
	};

if((_chassisID == 2.6)
&&{_Cannon})
then{_description = "Tank"};


_description