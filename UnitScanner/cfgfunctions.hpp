class CfgFunctions
{
	class ObjScan
	{
		class WeaponClassing
		{
			class MagsFromWell	 		{file = "\UnitScanner\functions\WeaponClassing\fn_MagsFromWell.sqf"};
			class fillArrFromArr		{file = "\UnitScanner\functions\WeaponClassing\fn_fillArrFromArr.sqf"};
			class weaponData			{file = "\UnitScanner\functions\WeaponClassing\fn_weaponData.sqf"};
			class classifyWeapon		{file = "\UnitScanner\functions\WeaponClassing\fn_classifyWeapon.sqf"};
			class vehicleWeaponClass	{file = "\UnitScanner\functions\WeaponClassing\fn_vehicleWeaponClass.sqf"};
			class maxRps				{file = "\UnitScanner\functions\WeaponClassing\fn_maxRps.sqf"};
			class approxClass			{file = "\UnitScanner\functions\WeaponClassing\fn_approxClass.sqf"};
			class fireModes				{file = "\UnitScanner\functions\WeaponClassing\fn_fireModes.sqf"};
			class weaponModes			{file = "\UnitScanner\functions\WeaponClassing\fn_weaponModes.sqf"};
			class weaponMuzzles			{file = "\UnitScanner\functions\WeaponClassing\fn_weaponMuzzles.sqf"};
			class magazineData			{file = "\UnitScanner\functions\WeaponClassing\fn_magazineData.sqf"};
			class describeWeaponByClass	{file = "\UnitScanner\functions\WeaponClassing\fn_describeWeaponByClass.sqf"};
		};
		class VehicleClassing
		{
			class VehicleType			{file = "\UnitScanner\functions\VehicleClassing\fn_VehicleType.sqf"};
			class vehicleDescription	{file = "\UnitScanner\functions\VehicleClassing\fn_vehicleDescription.sqf"};
			class VehicleData			{file = "\UnitScanner\functions\VehicleClassing\fn_VehicleData.sqf"};
			class objectShape			{file = "\UnitScanner\functions\VehicleClassing\fn_objectShape.sqf"};
			class CupArmor				{file = "\UnitScanner\functions\VehicleClassing\fn_CupArmor.sqf"};
			class getChassis			{file = "\UnitScanner\functions\VehicleClassing\fn_getChassis.sqf"};
			class vehicleArmorLevel		{file = "\UnitScanner\functions\VehicleClassing\fn_vehicleArmorLevel.sqf"};
			class chassisDespcription	{file = "\UnitScanner\functions\VehicleClassing\fn_chassisDespcription.sqf"};
		};
		class ammoClassing
		{
			class getAmmoData			{file = "\UnitScanner\functions\ammoClassing\fn_getAmmoData.sqf"};
			class special_Munition		{file = "\UnitScanner\functions\ammoClassing\fn_special_Munition.sqf"};
			class ClassifyAmmo			{file = "\UnitScanner\functions\ammoClassing\fn_ClassifyAmmo.sqf"};
			class Get_MisileClass		{file = "\UnitScanner\functions\ammoClassing\fn_Get_MisileClass.sqf"};
			class Get_ProjectileClass	{file = "\UnitScanner\functions\ammoClassing\fn_Get_ProjectileClass.sqf"};
			class ClassifySpecialAmmo	{file = "\UnitScanner\functions\ammoClassing\fn_ClassifySpecialAmmo.sqf"};
			class WarheadClass			{file = "\UnitScanner\functions\ammoClassing\fn_WarheadClass.sqf"};
			class describeAmmoByClass	{file = "\UnitScanner\functions\ammoClassing\fn_describeAmmoByClass.sqf"};
		};
		class infArmorClassing
		{
			class infArmorData			{file = "\UnitScanner\functions\infArmorClassing\fn_infArmorData.sqf"};
			class helmetData			{file = "\UnitScanner\functions\infArmorClassing\fn_helmetData.sqf"};
			class VestData				{file = "\UnitScanner\functions\infArmorClassing\fn_VestData.sqf"};
			class uniformArmor			{file = "\UnitScanner\functions\infArmorClassing\fn_uniformArmor.sqf"};
		}
		class infClassing
		{
			class infGearData			{file = "\UnitScanner\functions\infClassing\fn_infGearData.sqf"};
			class rankUnitGear			{file = "\UnitScanner\functions\infClassing\fn_rankUnitGear.sqf"};
			class DescribeMan			{file = "\UnitScanner\functions\infClassing\fn_DescribeMan.sqf"};
			class manCapacity			{file = "\UnitScanner\functions\infClassing\fn_manCapacity.sqf"};
			class decimals				{file = "\UnitScanner\functions\infClassing\fn_decimals.sqf"};
			class infWeaponRank			{file = "\UnitScanner\functions\infClassing\fn_infWeaponRank.sqf"};
			class infWeaponData			{file = "\UnitScanner\functions\infClassing\fn_infWeaponData.sqf"};
			class scopeRange			{file = "\UnitScanner\functions\infClassing\fn_scopeRange.sqf"};
			class rankUnitArmor			{file = "\UnitScanner\functions\infClassing\fn_rankUnitArmor.sqf"};
		};
		class misc
		{
			class multiStringSearch 	{file = "\UnitScanner\functions\misc\fn_multiStringSearch.sqf"};
			class GetVehicleWeapons 	{file = "\UnitScanner\functions\misc\fn_GetVehicleWeapons.sqf"};
			class FindSubString			{file = "\UnitScanner\functions\misc\fn_FindSubString.sqf"};
			class average				{file = "\UnitScanner\functions\misc\fn_average.sqf"};
			class CFGfromConfig			{file = "\UnitScanner\functions\misc\fn_CFGfromConfig.sqf"};
			class ScanAll				{file = "\UnitScanner\functions\misc\fn_ScanAll.sqf"};
			class init					{file = "\UnitScanner\functions\misc\fn_init.sqf"; postInit = 1};
			class DebugMsg				{file = "\UnitScanner\functions\misc\fn_DebugMsg.sqf"};
			class SpawnAllObjects		{file = "\UnitScanner\functions\misc\fn_SpawnAllObjects.sqf"};
		};
	};
};