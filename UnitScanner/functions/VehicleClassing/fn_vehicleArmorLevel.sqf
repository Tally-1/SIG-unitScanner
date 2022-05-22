params ["_armorData"];
private _armor		= _armorData get "Calculated HP";

if(_armor <= 6)		exitwith{0};
if(_armor <= 25)	exitwith{1};
if(_armor <= 50)	exitwith{2};
if(_armor <= 100)	exitwith{3};
if(_armor >  100)	exitwith{4};

/*
if(_armor <= 200)	exitwith{4};
if(_armor >  200)	exitwith{5};
*/

-1