params["_armorData"];
private _vest			= (_armorData get "vest");
private _Helmet			= (_armorData get "helmet");
private _Uniform		= (_armorData get "uniform");
private _helmetArmor	= (_Helmet get "Armor level"); 
if(_helmetArmor > 0)
then{_helmetArmor		= ceil(_helmetArmor / 2)};
private _armor 			= (0 + 
						  (_vest get "Armor level")+
						  _helmetArmor);

if(_Uniform	get "Armored")			then{_armor = (_armor + 2)};
if(_Helmet	get "Facial protection")then{_armor = (_armor + 1)};
_armor