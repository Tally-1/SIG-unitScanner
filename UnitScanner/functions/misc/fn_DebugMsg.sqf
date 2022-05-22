private _text = "";
params ["_entry"];

if(typeName _entry == "STRING")
then{_text = _entry}
else{
		if(typeName _entry == "ARRAY")
		then{
				_text = format _entry;
			};
	};
systemChat _text;

_text = (["***Sigmoids debug*** ", _text] joinString "");
diag_log _text;