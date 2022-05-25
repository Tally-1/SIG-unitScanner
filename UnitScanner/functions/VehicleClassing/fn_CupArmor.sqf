params ["_vehicleData"];
private _armorLvl		= 0;
private _macro	 		= _vehicleData 		get "macro";
private _armorData	 	= _vehicleData 		get "armorData";
private _HP 		 	= _armorData 		get "HP";
private _structArmor	= _armorData 		get "armor";
private _crewExposed 	= _armorData 		get "openVehicle" > 0;

private _carMacro		= _macro == "Car_F";
private _tankMacro		= _macro == "Tank_F";

if(_carMacro
&&{_HP == 80
&&{_structArmor == 1
&&{_crewExposed}}}
or 
_carMacro
&&{_HP >= 20
&&{_HP <= 22
&&{_structArmor == 4
&&{_crewExposed}}}}
or
_carMacro
&&{_HP == 75
&&{_structArmor == 4
&&{_crewExposed}}}
)
then{_armorLvl = 1};

if(_carMacro
&&{_HP == 195
&&{_structArmor == 9
&&{!_crewExposed}}})
then{_armorLvl = 2};

if(_tankMacro
&&{_HP >= 500
&&{_structArmor >= 19}})
then{_armorLvl = 4};

_armorLvl