params ["_Vehicle"];
private _data 		 = [_vehicle] call ObjScan_fnc_VehicleData;
private _description = [_data] call ObjScan_fnc_vehicleDescription;


_description;