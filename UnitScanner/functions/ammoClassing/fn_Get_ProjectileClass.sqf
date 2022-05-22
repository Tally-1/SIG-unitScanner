params ["_projectile_Data"];
private _damage 		= (_projectile_Data get "dammage");
private _penetration 	= (_projectile_Data get "penetration");
private _speed 			= (_projectile_Data get "projectile Speed");
private _subMun 		= (_projectile_Data get "submunition");
private _Special 		= (_projectile_Data get "Special");
private _warHead 		= (_projectile_Data get "warHead");
private _splashRange		= (_projectile_Data get "splashRange");
private _splashDamage	= (_projectile_Data get "splashDamage");
private _noSplash		= (_splashRange < 3 &&{_splashDamage < 3});
private _maxPotential	= (_damage * _penetration);
private _class			= 0;

if!(_Special == ""
or _Special == "penetrator")
exitWith{
			_class = [_Special] call Tally_Fnc_ClassifySpecialAmmo;
			_class
		};



if(_subMun == ""
or _Special == "penetrator")
then{
		/*non-lethal*/
		if(_maxPotential <= 2)exitWith{_class = 0.9};
		/*pistol*/
		if(_maxPotential <= 8.6)
		exitWith{
					_class = 1;
					if(_maxPotential < 6)then{_class = 1};
					if(_damage >= 8)	then{_class = 2};
					//if(_penetration < 1) then{_class = 1};
				};
		/*rifle -*/
		if(_maxPotential < 14
		&&{_noSplash})				exitWith{_class = 2.1};
		
		/*rifle +-*/
		if(_maxPotential < 22
		&&{_noSplash})				exitWith{_class = 2.2};
		
		/*rifle +*/
		if(_maxPotential	< 40
		&&{_noSplash})				exitWith{_class = 2.3};
		
		/*rifle ++*/
		if(_maxPotential	< 100
		&&{_noSplash})				exitWith{_class = 2.4};
		
		/*rifle +++*/							
		if(_penetration	> 2.8
		&&{_damage < 61
		&&{_noSplash}})				exitWith{_class = 2.5};
		
		/*cannon -*/							
		if(_penetration 		< 10
		&&{_splashDamage 	< 30
		&&{_splashRange		<  5
		&&{_SplashRange 	> 0}}})	exitWith{_class = [4, _warHead] call Tally_Fnc_WarheadClass};
		
		if(_penetration 		< 6
		&&{_splashDamage 	== 0
		&&{_splashRange		== 0
		&&{_warHead 	== "AP"
		&&{_maxPotential > 350
		&&{_maxPotential < 530
		&&{_damage >= 90
		&&{_damage <= 95}}}}}}})exitWith{_class = [4, _warHead] call Tally_Fnc_WarheadClass};
		
		/*cannon ++*/
		if(_penetration 		<= 40
		&&{_splashDamage 	< 90
		&&{_splashRange		<  7
		&&{_SplashRange 	> 0}}})	exitWith{_class = [5, _warHead] call Tally_Fnc_WarheadClass};
		
		
		/*arty*/
		if(_penetration 		< 40
		&&{_splashDamage 	< 150
		&&{_splashRange		< 40
		&&{_SplashRange 	>= 7}}})exitWith{
												_class = 8;
											};
		
		if(_penetration		< 40
			&&{_splashDamage 	<= 850
			&&{_splashRange		< 40
			&&{_SplashRange 	>= 7
			&&{_speed >= 800}}}})
			exitWith{
						_class = 8.1;
					};
		
		
		/*Cup cannons*/
		if(_maxPotential > 16000
		&&{_splashRange < 3
		&&{_speed > 700}})			exitWith{_class = [5, _warHead] call Tally_Fnc_WarheadClass};
		
		if(_maxPotential >= 2500
		&&{_splashRange <= 3
		&&{_speed > 1100}})			exitWith{_class = [5, _warHead] call Tally_Fnc_WarheadClass};
		
		if(_maxPotential >= 1600
		&&{_splashRange <= 6
		&&{_speed >= 400}})			exitWith{_class = [5, _warHead] call Tally_Fnc_WarheadClass};
	
	_class = 0.1;	
	}
else{
		if(_maxPotential < 1)exitWith{_class = 0.9};
		
		private _subHash			= (_projectile_Data get "submun data") get "data";
		private _subSplashRange 		= _subHash get "splashRange";
		private _subSplashDamage 	= _subHash get "splashDamage";
		private _subDamage 		= _subHash get "dammage";
		
		
		if(_maxPotential <= 8
		&&{_noSplash})
		exitWith{
					_class = 1;
					if(_maxPotential < 6)then{_class = 1};
					if(_damage >= 8)then{_class = 2};
				};
		
		
		if(_subSplashDamage	< 40
		or _splashDamage	< 40
		&&{_splashRange		< 30
		&&{_SplashRange 	> 7
		or _subSplashRange	> 7
		&&{!(_noSplash)}}})	
		exitWith{
					if(_damage < 170)
					then{_class = 8}
					else{_class = 8.1};
					_class
				};
	
		if(_penetration		< 40
		&&{_splashDamage 	< 150
		&&{_splashRange		< 40
		&&{_SplashRange 	>= 7}}})
		exitWith{
					_class = 8;
				};
		
		if(_penetration		< 40
		&&{_splashDamage 	<= 850
		&&{_splashRange		< 40
		&&{_SplashRange 	>= 7
		&&{_speed >= 690}}}})
		exitWith{
					_class = 8.1;
				};
	
	_class = 0.2;
	};

_class