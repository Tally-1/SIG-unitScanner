params ["_man"];

private _armorData	= createHashMap;
private _helmetData = [(headGear _man)]	call ObjScan_fnc_helmetData;
private _vestData 	= [(vest	_man)]	call ObjScan_fnc_VestData;
private _uniformData= [(uniform	_man)]	call ObjScan_fnc_uniformArmor;

private _helmetdescription 	= (_helmetData	get "description");
private _vestdescription 	= (_vestData		get "description");
private _uniformdescription = (_uniformData	get "description");

_armorData set ["helmet", 	_helmetData];
_armorData set ["vest", 	_vestData];
_armorData set ["uniform", 	_uniformData];

_armorData