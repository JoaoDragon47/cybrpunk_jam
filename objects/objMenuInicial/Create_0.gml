enum MenuElementType {
	ScriptRunner,
	PageTransfer,
	Shift,
	Toggle,
	Slider,
	Input,
	Warning
}

enum MenuPage {
	Main,
	Options,
	Credits
}
/*
ScriptRunner ->		["NOME", MenuElementType.ScriptRunner, script_to_run],
PageTransfer ->		["NOME", MenuElementType.PageTransfer, PausePage.PageToTransfer],
Shift ->			["NOME", MenuElementType.Shift, script_to_run, InitialValue, [ValueOne, ValueTwo...]],
Toggle ->			["NOME", MenuElementType.Toggle, script_to_run, InitialValue, [ValueOne, ValueTwo...]],
Slider ->			["NOME", MenuElementType.Slider, script_to_run, InitialValue, [ValueOne, ValueTwo...]],
Input ->			["NOME", MenuElementType.Input, "global_value", InitialValue],
*/

dsMenuMain = createMenuPage(
	["Start",MenuElementType.ScriptRunner,startGame],
	["Options",MenuElementType.PageTransfer,MenuPage.Options],
	["Credits",MenuElementType.PageTransfer,MenuPage.Credits],
	["Exit",MenuElementType.Warning, exitGame, 1, ["Yes", "No"]]
)

dsMenuOptions = createMenuPage(
	["Volume",MenuElementType.Slider,changeGameVolume,audio_get_master_gain(audiogroup_default),[0,1]],
	["Back",MenuElementType.PageTransfer,MenuPage.Main]
)

dsMenuCredits = createMenuPage(
	["Daniel 'Guarah'",MenuElementType.Shift,function(){return},0,["Game Designer"]],
	["'Babs'",MenuElementType.Shift,function(){return},0,["Artist"]],
	["João 'Luska'",MenuElementType.Shift,function(){return},0,["Programmer"]],
	["Back",MenuElementType.PageTransfer,MenuPage.Main]
)

page = MenuPage.Main;
menuPages = [
	dsMenuMain,
	dsMenuOptions,
	dsMenuCredits
];

var i = 0, arr_leng = array_length(menuPages);
repeat (arr_leng) {
	menuOption[i] = 0;
	i++;
}

inputting = false;
firstColorOptions = make_color_rgb(94,63,102);
inputColorOptions = make_color_rgb(245,208,255);
startTransitionMenu=false;