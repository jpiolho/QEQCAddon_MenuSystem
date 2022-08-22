#ifndef MENUSYSTEM_IMPULSE_BASE
#define MENUSYSTEM_IMPULSE_BASE 200
#endif

#ifndef MENUSYSTEM_MAX_OPTIONS
#define MENUSYSTEM_MAX_OPTIONS 32
#endif

.void(float menu) menucallback;

class MenuSystem {
	static void(string text,string opt1="",string opt2="",string opt3="",string opt4="") Create;
	static void(string text) AddChoice;
	static void(entity client,void(float menu) callback) Send;
	static void(entity client,void(float menu) callback) OverrideCallback;
	static float() HandleImpulses;
};

