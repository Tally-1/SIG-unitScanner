params ["_man"];

private _armorData	= createHashMap;
private _helmetData = [(headGear _man)]	call Tally_Fnc_helmetData;
private _vestData 	= [(vest	_man)]	call Tally_Fnc_VestData;
private _uniformData= [(uniform	_man)]	call Tally_Fnc_uniformArmor;

private _helmetdescription 	= (_helmetData	get "description");
private _vestdescription 	= (_vestData		get "description");
private _uniformdescription = (_uniformData	get "description");

_armorData set ["helmet", 	_helmetData];
_armorData set ["vest", 	_vestData];
_armorData set ["uniform", 	_uniformData];

_armorData