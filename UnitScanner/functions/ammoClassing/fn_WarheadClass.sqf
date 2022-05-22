params ["_baseClass", "_warHead"];

	
switch _warHead do
{
	case "HE": 		{_baseClass = _baseClass + 0.1};
	case "AP": 		{_baseClass = _baseClass + 0.2};
	case "AT": 		{_baseClass = _baseClass + 0.2};
	case "HEAT": 	{_baseClass = _baseClass + 0.3};
};



_baseClass