params ["_string"];
private _length = (count _string)-1;
private _counter = 0;

for "_I" from 0 to _length
do 	{
		private _Letter = _string select [_I, 1];
		_counter = _counter +1;
		if(_Letter == "/")then{_counter = 0};
	}; 
private _cfgName = _string select [((_length + 1) - _counter), _counter];
_cfgName