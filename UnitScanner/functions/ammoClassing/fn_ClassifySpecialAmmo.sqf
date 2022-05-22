params ["_stringName"];
private _class			= 0.3;

switch _stringName do
{
	case "blank": 	{ _class = 0.8 };
	case "laser": 	{ _class = 0.9 };
	case "flare": 	{ _class = 9.1 };
	case "chaff": 	{ _class = 9.1 };
	case "smoke": 	{ _class = 9.2 };
	case "mine": 	{ _class = 9.3 };
	case "cluster": { _class = 9.4 };
	case "pellets": { _class = 9.5 };
	case "buckshot":{ _class = 9.5 };
};

_class