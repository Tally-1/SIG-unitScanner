params ["_class"];
private _unDefTxt = "undefined chassis";

if(_class == 0)	exitwith{_unDefTxt};

if(_class == 0.8)	exitwith{"static"};
if(_class == 0.9)	exitwith{"microVehicle"};

if(_class == 1)		exitwith{"car"};
if(_class == 1.1)	exitwith{"truck"};
if(_class == 1.2)	exitwith{"MRAP"};
if(_class == 1.3)	exitwith{"small armor"};

if(_class == 2.3)	exitwith{"BTR"};
if(_class == 2.4)	exitwith{"light armor"};
if(_class == 2.5)	exitwith{"up-armored APC"};
if(_class == 2.6)	exitwith{"heavy armor"};

if(_class == 3)		exitwith{"plane"};
if(_class == 3.1)	exitwith{"jet"};
if(_class == 3.2)	exitwith{"VTOL"};

if(_class == 4)		exitwith{"small chopper"};
if(_class == 4.1)	exitwith{"chopper"};
if(_class == 4.2)	exitwith{"heavy chopper"};
if(_class == 4.3)	exitwith{"large chopper"};

if(_class == 5)		exitwith{"UAV"};
if(_class == 5.1)	exitwith{"UGV"};


_unDefTxt