
// While most browsers display the console in a monospace font, Safari doesn't
// so it's needed to make sure the ascii art is displayed correctly
logo = "font-family: monospace; font-weight: bold;";
logo_green = logo + " text-shadow: 1px 1px 2px black, 0 0 20px green, 0 0 5px darkgreen;";
// String.raw lets us use "\" without having to escape it
console.log(String.raw`%c
  _   _                      _    _               
 | \ | |                    | |  | |              
 |  \| | __ _ _ __ ___   ___| |__| | ___ _ __ ___ 
 | .   |/ _  | '_   _ \ / _ \  __  |/ _ \ '__/ _ \
 | |\  | (_| | | | | | |  __/ |  | |  __/ | |  __/
 |_| \_|\__,_|_| |_| |_|\___|_|  |_|\___|_|  \___|%c.com%c


%cHello! We hope you like our site!

`, logo_green, logo, logo_green, "font-size: 18px;");
