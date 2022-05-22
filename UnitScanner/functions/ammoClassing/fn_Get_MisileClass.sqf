params ["_misileData"];


private _guided			= _misileData get "guided";
private _splashRange		= (_misileData get "splashRange");
private _splashDamage	= (_misileData get "splashDamage");
private _warHead		= (_misileData get "warHead");
private _special			= (_misileData get "Special");
private _HEAT			= (_splashRange > 1 && {_splashRange < 6});
private _HE				= (_splashRange >= 6);
private _class 			= 0;





if(_guided)
/*Guided misiles*/
then{
		_class 	= 7;
		if(_HEAT)	then{_class = 7.1};
		if(_HE)		then{_class = 7.2};
		
		if(_warHead == "HE"
		&&{_special == "penetrator"})
		then{_class = 7.1};
	}
/*Rockets*/
else{
		_class 	= 6;
		if(_HEAT)	then{_class = 6.1};
		if(_HE)		then{_class = 6.2};
		
		if(_warHead == "HE"
		&&{_special == "penetrator"})
		then{_class = 6.1};
	};


if(_misileData get "anti air")then{_class = 7.3};
if(_splashDamage > 900
&&{_HE})then{_class = 9};


_class