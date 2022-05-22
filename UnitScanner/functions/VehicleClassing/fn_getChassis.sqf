params ["_vehicleData", "_typeData", "_chassisData"];
private _Chassis		 	= 0;
private _armorData	 	= _vehicleData 		get "armorData";
private _macro	 		= _vehicleData 		get "macro";
private _passengers	 	= _vehicleData 		get "passengers";
private _weapons	 	= _vehicleData 		get "weaponTypes";
private _name	 		= _vehicleData 		get "name";
private _wheels 		 	= _chassisData		get "wheels";
private _mass 		 	= _chassisData		get "mass";
private _size 		 	= _chassisData		get "size";
private _shape 		 	= _chassisData		get "shape";
private _LengthXwidth 	= _shape			get "Y to X";
private _Length 			= _shape			get "length";
private _height 			= _shape			get "height";
private _HP 		 	= _armorData 		get "HP";
private _structArmor	 	= _armorData 		get "armor";
private _armor 		 	= _armorData 		get "Calculated HP";
private _combinedHP 	= _armorData 		get "combined HP";
private _armorLvl	 	= _armorData 		get "Standard Armor-Level";
private _rhsArmor	 	= _armorData 		get "Alt Armor-Level";
private _crewExposed 	= _armorData 		get "openVehicle" > 0;
private _cupArmor		= _armorData		get "CUP-armor";
private _static 			= _typeData 			get "kindOfStatic";
private _Air 			= _typeData 			get "kindOfAir";
private _VTOL 			= _typeData 			get "VTOL";
private _plane 			= _typeData 			get "plane";
private _helicopter		= _typeData 			get "helicopter";
private _drone			= _typeData 			get "drone";
private _speed 			= _typeData 			get "maxSpeed";
private _wheeled 	 	= _typeData 			get "kindOfcar";
private _tracked 	 	= _typeData 			get "kindOftank";





private _truckMacros		= [	"Truck_F", 
							"O_Truck_02_covered_F", 
							"Truck_01_base_F", 
							"O_Truck_03_fuel_F", 
							"O_T_Truck_03_fuel_ghex_F",
							"O_T_Truck_02_transport_F",
							"O_Truck_03_covered_F",
							"I_E_Truck_02_Medical_F"];

private _apcMacros		= [	"Wheeled_APC_F", 
							"APC_Tracked_02_base_F",
							"APC_Tracked_03_base_F"];

private _MRAP_Macros	= [	"MRAP_01_base_F", 
							"MRAP_02_base_F",
							"CUP_Ridgback_Base",
							"CUP_Wolfhound_Base",
							"CUP_Mastiff_Base"];

private _carMacros		= ["Car_F"];

private _truckMacro		= _macro in _truckMacros;
private _apcMacro		= _macro in _apcMacros;
private _MRAP_Macro		= _macro in _MRAP_Macros;
private _MBT_Macros		= _macro == "MBT_01_base_F";
private _tankType_Macro	= _macro == "Tank_F";
private _carMacro		= _macro == "Car_F";
private _towTractor 	= _name  == "Towing Tractor";



private _carSize	 	 	= (_size > 6 		&& {_size <= 16});
private _carMass	 	 	= (_mass >= 590		&& {_mass <= 6500});
private _carArmor 	 	= ((_armorLvl == 1 	&& {_crewExposed})
						or (_cupArmor == 1));

private _truckSize	 	= (_size >= 15 	  	&&	{_size <= 30});
private _truckMass	 	= (_mass > 8100		&&	{_mass <= 17000});
private _truckArmor 	 	= (_armorLvl <= 2 	&&	{_crewExposed});
private _truckShape		= (_LengthXwidth >= 2
						&&{_Length > 4.5});


private _MRAP_Mass	 	= (_mass >= 6500		&&	{_mass <= 10000});
private _MRAP_Armor 	= (_armorLvl <= 2 	&&	{true /*_crewExposed*/});


private _LghtArmSize 	= (_size >= 13		&&	{_size <= 18});
private _LghtArmMass 	= (_mass > 10000	&&	{_mass <= 65500}); /*37000 is the actual highest, but there are some exceptions*/
private _APC_Armor 		= (_armorLvl == 3);

private _rhsLight_Armor	= (_rhsArmor 	>= 2
						&&({_combinedHP>= 600
						&&{_combinedHP < 900}})
						or (_armorLvl 	== 2 or _rhsArmor == 2)
						&&{_structArmor	>= 6
						&&{_HP > 250
						&&{_HP < 350}}}); 

private _rhsLghtSize 		= (_size >= 11		&&	{_size <= 18});
private _rhsLghtMass 	= (_mass > 10000	&&	{_mass <= 31000});
private _cupLghtMass 	= (_mass > 7500	&&	{_mass <= 30720});




private _heavyArmSize 		= (_size >= 16		&&{_size <= 24});
private _heavyArmMass 		= (_mass > 41000);
private _TankShape 			= (0);
private _TankArmor 			= (_armorLvl > 3);

private _rhsHeavyArmor		= ((_structArmor >= 	200
							&&{_structArmor <=	400
							&&{_HP >= 450
							&&{!(_crewExposed)}}})
							or _rhsArmor == 3);
private _CupHeavyArmor		= (_cupArmor == 4);

private _smallChopperSiz		= (_size >= 10 		&&{_size <= 15});
private _smallChopperMass 	= (_mass > 1000		&&{_mass <= 2000});

private _mediumChopperSiz	= (_size > 15 		&&{_size <= 27});
private _mediumChopperMass	= (_mass > 2000		&&{_mass <= 11000});

private _largeChopperSiz		= (_size > 27);
private _largeChopperMass	= (_mass >= 10000	&&{_mass <= 20000});

private _heavyChopperMass	= (_mass > 20000);


private _microVehicle 	= (!(_static)
						&&{_mass < 900
						&& _size <= 6});
						
private _UAV			= (_Air
						&&{_drone});
						
private _UGV			= (!(_Air)
						&&{_drone});
						
private _car 			= (_wheeled
						&&{_carSize
						&&{_carMass
						&&{_carArmor
						&&{!(_Air)
						&&{!(_truckMacro)}}}}});

private _truck 			= (_wheeled
						&&{_truckShape
						&&{_truckMass
						&&{_truckArmor
						&&{!(_Air)}}}});

private _MRAP			= (_wheeled
						&&{_carSize
						&&{!(_truckMacro)
						&&{_MRAP_Mass
						&&{_MRAP_Armor
						&&{!(_Air)}}}}});

private _CUP_MRAP		= (_wheeled
						&&{_carSize
						&&{(_carMacro or (_wheels == 4))
						&&{_carMass
						&&{_MRAP_Armor
						&&{_armorLvl == 2
						&&{!(_cupArmor == 1)}}}}}});

private _CUP_MRAP2		= _carMacro
						&&{0.8 in _weapons
						&&{_wheels == 4
						&&{_mass > 10000
						&&{_mass < 13000
						&&{_cupArmor == 2}}}}};
						
private _CUP_MRAP3		= _apcMacro
						&&{0.8 in _weapons
						&&{_wheels == 4
						&&{_MRAP_Mass
						&&{_carSize
						&&{_LengthXwidth <= 1.8
						&&{_Length <= 4.2}}}}}};

private _smallArmor		= (_tracked
						&&{_carSize
						&&{_carMass or _MRAP_Mass
						&&{_MRAP_Armor
						&&{!(_Air)}}}});

private _lightArmor		= (_LghtArmSize
						&&{_LghtArmMass
						&&{_APC_Armor or _rhsLight_Armor
						&&{!(_Air)}}});

private _cupLightArmored = ((_MRAP 
						&&{_apcMacro})
						or 
						_tankType_Macro
						&&{_cupLghtMass
						&&{_rhsLghtSize}});


private _upArmAPC		= (_LghtArmSize
						&&{_LghtArmMass
						&&{_armorLvl > 3
						&&{_passengers > 5
						&&{!(_Air)}}}});
						
private _rhsBTR			= (_combinedHP > 100
						&&{_combinedHP < 120
						&&{_armorLvl == 1
						&&{_LengthXwidth >= 2
						&&{_mass > 10000
						&&{_mass < 12000
						&&{_height < 3
						&&{!(_crewExposed)}}}}}}});

private _heavyArmor		= (_heavyArmSize
						&&{_heavyArmMass
						&&{(_TankArmor or _rhsHeavyArmor or _CupHeavyArmor)
						&&{!(_Air)}}});
						
private _planeRotor		= (_plane
						&&{!(_VTOL)
						&&{_speed < 600}});
						
private _jet				= (_plane
						&&{!(_VTOL)
						&&{_speed >= 600}});

private _smallChopper   =(_smallChopperSiz
						&&{_smallChopperMass
						&&{_helicopter}});
						
private _mediumChopper =(_mediumChopperSiz
						&&{_mediumChopperMass
						&&{_helicopter}});
						
private _largeChopper   =(_largeChopperSiz
						&&{_largeChopperMass
						&&{_helicopter}});




/*Standard chassis*/
/*land*/
if(_static)			exitwith{0.8};
if(_UAV)			exitwith{5};
if(_UGV)			exitwith{5.1};
if(_microVehicle)	exitwith{0.9};

if(_car
or _towTractor)		exitwith{1};
if(_truck)			exitwith{1.1};
if(_MRAP
&&{!_apcMacro}) 	exitwith{1.2};
if _CUP_MRAP		exitwith{1.2};
if _CUP_MRAP2		exitwith{1.2};
if _CUP_MRAP3		exitwith{1.2};	

if(_rhsBTR)			exitwith{2.3};
if(_lightArmor
or _cupLightArmored)exitwith{2.4};
if(_heavyArmor)		exitwith{2.6};

/*Air*/
if(_planeRotor)		exitwith{3};
if(_jet)				exitwith{3.1};
if(_VTOL)			exitwith{3.2};

if(_smallChopper)	exitwith{4};
if(_mediumChopper)	exitwith{4.1};
if(_largeChopper)	exitwith{4.3};

/*Special chassis / exceptions to general rules*/
if(_smallArmor)		exitwith{1.3};
if(_upArmAPC)		exitwith{2.5};

if(_heavyArmSize
&&{_heavyArmMass
&&{_armor >= 94}})	exitwith{2.6};

if(_helicopter 
&&{_mediumChopperSiz
or _largeChopperSiz
&&{_heavyChopperMass}})exitwith{4.2};




/*backup function using macro type defined at top of config*/
if(_truckMacro 	&&{_crewExposed})	exitwith{1.1};
if(_apcMacro 	&&{_rhsLghtMass})	exitwith{2.4};
if(_MRAP_Macro &&{_rhsLghtMass})	exitwith{1.2};
if(_MRAP_Macro &&{_mass < 6100})	exitwith{1};
if(_tankType_Macro
&&{(_TankArmor or _rhsHeavyArmor)
&&{5.3 in _weapons}}) exitwith{2.6};

if(_tankType_Macro 
&&{_rhsLight_Armor 
&&{!(_rhsHeavyArmor)
&&{!(5.3 in _weapons)}}})			exitwith{2.4};

_Chassis