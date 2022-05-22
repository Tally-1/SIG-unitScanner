params ["_armorLevel", "_weaponData"];
private _rifleClass 		= (_weaponData get "primary")get "class ID";
private _launcherClass	= (_weaponData get "secondary")get "class ID";
private _scopeRange		= (_weaponData get "scope range");

private _armor = "Unarmored ";
private _launcher = "";
private _weapon = "man";
private _AR 		= ((_rifleClass > 1.1 &&{_rifleClass < 1.9})or(_rifleClass == 2));
private _marksMan	= (_AR && {_scopeRange > 300});
private _sniper		= (_rifleClass == 1.9 && {_scopeRange > 300});
private _noScopeSn	= (_rifleClass == 1.9 && {_scopeRange <= 300});



if(_armorLevel >= 2
&&{_armorLevel <= 4})
then{_armor = "Lightly armored "}; 

if(_armorLevel >= 5
&&{_armorLevel <= 7})
then{_armor = "Armored "};

if(_armorLevel >= 8
&&{_armorLevel < 10})
then{_armor = "Heavily armored "};

if(_armorLevel >= 10)then{_armor = "Completely armored "};

if(_launcherClass == 4)then{_launcher = "RPG "};
if(_launcherClass == 4.2)then{_launcher = "AA "};
if(_launcherClass == 4.1
or _launcherClass == 4.3
or _launcherClass == 4.4)then{_launcher = "AT-misile "};

if(_rifleClass == 1.1)then{_weapon = "shotGunner"};
if(_rifleClass == 1.1)then{_weapon = "UZI-Man"};
if(_AR)				then{_weapon = "rifleMan"};
if(_marksMan)		then{_weapon = "marksMan"};
if(_sniper)			then{_weapon = "sniper"};
if(_noScopeSn)		then{_weapon = "High caliber rifleMan"};

if(_rifleClass	 > 2
&&{_rifleClass < 2.5})then{_weapon = "grenadier"};

if(_rifleClass	 >= 3
&&{_rifleClass <= 3.3})then{_weapon = "machineGunner"};



[_armor, _launcher, _weapon] joinstring "";