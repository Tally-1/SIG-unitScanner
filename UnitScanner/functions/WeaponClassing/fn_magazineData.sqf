params ["_magazine"];
private _magData = SIG_MagazineData get _magazine;
if(!isNil "_magData")exitWith{_magData};

_magData = createHashMap;
private _type = (getNumber (configfile >> "CfgMagazines" >>     _magazine >> "type"));

if(_type isEqualTo 0)then    {
    _type = (getText (configfile >> "CfgMagazines" >> _magazine >> "type"));
    if(_type isEqualTo "2* 256")
    then{_type = 512}
    else{_type = 0;};
};

_magData set ["MagType",     _type];
_magData set ["AmmoType",    (getText   (configfile >> "CfgMagazines" >> _magazine >> "ammo"))];
_magData set ["AmmoCount",   (getNumber (configfile >> "CfgMagazines" >> _magazine >> "count"))];
_magData set ["AmmoSpeed",   (getNumber (configfile >> "CfgMagazines" >>    _magazine >> "initSpeed"))];

SIG_MagazineData set [_magazine, _magData];

_magData