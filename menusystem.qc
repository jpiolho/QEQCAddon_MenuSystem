static string menu_text;
static string menu_option[MENUSYSTEM_MAX_OPTIONS];
static float menu_options;

class MenuSystem {
	static void(string text,string opt1="",string opt2="",string opt3="",string opt4="") Create = {
		menu_text = text;
		menu_options = 0;

		if(opt1 != "")
			AddChoice(opt1);
		if(opt2 != "")
			AddChoice(opt2);
		if(opt3 != "")
			AddChoice(opt3);
		if(opt4 != "")
			AddChoice(opt4);
	};

	
	static void(string text) AddChoice = {
		if(menu_options >= MENUSYSTEM_MAX_OPTIONS)
			objerror("Too many menu options");

		menu_option[menu_options++] = text;
	};
	
	static void(entity client,void(float menu) callback) Send = {
		client.menucallback = callback;

		prompt(client,menu_text,menu_options);

		for(float i=0;i<menu_options;i++) {
			promptchoice(client,menu_option[i],MENUSYSTEM_IMPULSE_BASE + i);
		}
	};

	static inline void(entity client,void(float menu) callback) OverrideCallback = {
		client.menucallback = callback;
	};

	static float() HandleImpulses = {

		// Handle menu callbacks
		if(self.menucallback != __NULL__) {
			if(self.impulse >= MENUSYSTEM_IMPULSE_BASE && self.impulse < (MENUSYSTEM_IMPULSE_BASE + MENUSYSTEM_MAX_OPTIONS)) {
				void(float menu) callback = self.menucallback; // Backup the callback
				self.menucallback = __NULL__;	
				callback(self.impulse - MENUSYSTEM_IMPULSE_BASE);

				// Callback handled
				self.impulse = 0;
				return TRUE;
			}
		}	

		return FALSE;
	};
};