params ["_weaponData"];
private _rifleData	 = _weaponData get "primary";
private _launcherData = _weaponData get "secondary";

private _hasRifle		 = !(_rifleData get "name" == "");
private _hasLauncher	 = !(_launcherData get "name" == "");
private _hasSideArm	 = !(((_weaponData get "sideArm") get "name") == "");

private _longRange	 =  _rifleData get "scope range" > 300;
private _muchAmmo	 =  _rifleData get "max-Ammo-Cap" >= 100;

private _rifleAmmo 	 = _rifleData get "ammoClasses";
private _muzzles 	 = (_rifleData get "muzzles");
if(count _muzzles > 0)
then{
		private _muzzleAmmo = _muzzles get "ammoClasses";
		{
			_rifleAmmo pushBackUnique _x;
		}forEach _muzzleAmmo;
	};


private _weaponRanking = 0;
if(_hasSideArm)then{_weaponRanking = 1};

if(!(_hasRifle)
&&{!(_hasLauncher)})
exitWith{_weaponRanking};

if(_hasRifle)
then{
		_weaponRanking = (_weaponRanking +3);
		private _lowCaliber 	= [_rifleAmmo, 1, 2.1, [3, 9.1, 9.2, 9.5]] call Tally_Fnc_approxClass;
		private _highCaliber	= [_rifleAmmo, 2.2, 4.3, [9.1, 9.2, 9.5]] call Tally_Fnc_approxClass;
		private _GL			= 3 in _rifleAmmo;
		private _GMG		= (_rifleData get "class ID") == 2.5;
		if(_GL)			then{_weaponRanking = (_weaponRanking +1)};
		if(_GMG)		then{_weaponRanking = (_weaponRanking +2)};
		if(_highCaliber)	then{_weaponRanking = (_weaponRanking +1)};
		if(_muchAmmo)	then{_weaponRanking = (_weaponRanking +1)};
	};

if(_hasLauncher)
then{
		_weaponRanking = (_weaponRanking +2);
		private _launcherClass = _launcherData get "class ID";
		
		if(_launcherClass > 4
		&&{_launcherClass < 4.4})
		then{_weaponRanking = (_weaponRanking +2)};
	};

_weaponRanking