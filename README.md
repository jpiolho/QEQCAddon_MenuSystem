# QEQC Library - MenuSystem
This is a small library that you can add to any QE codebase that will provide you with a menu system based around prompts.

## How to add
1. Clone or add this repo as a submodule inside your code libs folder (prefered: `<root>/libs/menusystem`)
2. Import in progs.src '../libs/menusystem/menusystem.qc'
3. Add the following code to the beginning of `ImpulseCommands` inside `weapons.qc` (or equivalent where you handle player impulses):
   ```quakec
     if(MenuSystem::HandleImpulses())
        return;
   ```

## Usage
### MOTD
```quakec
MenuSystem::Create("Welcome to my server","OK");
MenuSystem::Send(self);
```

### Choose a team
```
// Function that handles what option the player choose for the menu
void(float menu) Menu_Team = {
  if(menu == 0)
    self.team = 1;
  else if(menu == 1)
    self.team = 2;
};

// Place this somewhere to show the player a menu
MenuSystem::Create("Pick a team!",
  "Red",
  "Blue"
);
MenuSystem::Send(self,Menu_Team);
```

### Lots of options
```quakec

void(float menu) Menu_LotsOfOptions = {
  // TODO: Do something about the options here
}

MenuSystem::Create("Lots of options on this one");
MenuSystem::AddChoice("Option 1");
MenuSystem::AddChoice("Option 2");
MenuSystem::AddChoice("Option 3");
MenuSystem::AddChoice("Option 4");
MenuSystem::AddChoice("Option 5");
MenuSystem::AddChoice("Option 6");
MenuSystem::AddChoice("Option 7");
MenuSystem::AddChoice("Option 8");
MenuSystem::AddChoice("Option 9");
MenuSystem::AddChoice("Option 10");
MenuSystem::Send(self,Menu_LotsOfOptions);
```

## Functions
### Create
`void(string text,string opt1="",string opt2="",string opt3="",string opt4="")`

Creates a new menu. You can immediatelly add up to 4 choices.

### AddChoice
`void(string text)`

Adds a choice to the menu being created. By default there's a limit of 32 choices.

### Send
`void(entity client,void(float menu) callback = __NULL__)`

Sends the created menu to `client`, and assigns the `callback` function that will be called when the player makes a choice.

### OverrideCallback
`void(entity client,void(float menu) callback)`

**ADVANCED**

Sets the `callback` function to the client. Intended to be used if you're creating the menu yourself without using the library but still want to use the callback system.

### HandleImpulses
`float()`

Interfaces with the mod so it can handle player choices. You must call this function in your impulse handling method. Returns `TRUE` if a choice has been handled.

## Advanced uses

The addon takes over a stretch of impulses so it can handle player choices. You can override these values by setting up #define's before importing `defs.qc`

`#define MENUSYSTEM_IMPULSE_BASE 200` - Defines the first impulse number

`#define MENUSYSTEM_MAX_CHOICES 32` - How many choices are available
