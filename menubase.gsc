// ================================================
//  mod menu base with gui — iw8 engine
//  private match / iw8mod only
// ================================================

#using scripts\codescripts\struct;
#using scripts\shared\util_shared;

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon( "disconnect" );

    for(;;)
    {
        self waittill( "spawned_player" );
        self.menuOpen = false;
        self.menuIndex = 0;
        self thread menuMonitor();
    }
}

// ================================================
//  OPTIONS — add / remove options here
// ================================================

getOptions()
{
    options = [];
    options[0] = "Add Bot";
    options[1] = "Remove Bot";
    return options;
}

// ================================================
//  MONITOR — hold attack + melee to toggle menu
// ================================================

menuMonitor()
{
    self endon( "disconnect" );
    self endon( "death" );

    for(;;)
    {
        if ( self attackButtonPressed() && self meleeButtonPressed() )
        {
            if ( !self.menuOpen )
            {
                self.menuOpen = true;
                self thread openMenu();
            }
            else
            {
                self.menuOpen = false;
                self notify( "close_menu" );
            }
            wait 0.5;
        }

        wait 0.05;
    }
}

// ================================================
//  GUI
// ================================================

openMenu()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "close_menu" );

    options = getOptions();
    self.menuIndex = 0;

    // background box
    bg = self createRectangle( "center", "center", 0, 0, 200, 30 + ( options.size * 22 ), ( 0, 0, 0 ), 0.7, "white", 1 );

    // title text
    title = self createFontString( "default", 1.8 );
    title setPoint( "center", "center", 0, -( ( options.size * 11 ) + 5 ) );
    title setText( "^2MOD MENU" );
    title.foreground = true;

    // option labels
    labels = [];
    for ( i = 0; i < options.size; i++ )
    {
        labels[i] = self createFontString( "default", 1.4 );
        labels[i] setPoint( "center", "center", 0, -( options.size * 11 ) + 24 + ( i * 22 ) );
        labels[i].foreground = true;
    }

    // main loop — handles drawing + input
    for(;;)
    {
        // highlight selected option in yellow, rest in white
        for ( i = 0; i < options.size; i++ )
        {
            if ( i == self.menuIndex )
                labels[i] setText( "^3> " + options[i] );
            else
                labels[i] setText( "^7  " + options[i] );
        }

        // scroll down — ads button
        if ( self adsButtonPressed() )
        {
            self.menuIndex++;
            if ( self.menuIndex >= options.size )
                self.menuIndex = 0;
            wait 0.2;
        }

        // scroll up — jump button
        if ( self jumpButtonPressed() )
        {
            self.menuIndex--;
            if ( self.menuIndex < 0 )
                self.menuIndex = options.size - 1;
            wait 0.2;
        }

        // select — use button
        if ( self useButtonPressed() )
        {
            self thread runOption( options, self.menuIndex );
            wait 0.3;
        }

        wait 0.05;
    }

    // cleanup hud when menu closes
    bg destroy();
    title destroy();
    for ( i = 0; i < labels.size; i++ )
        labels[i] destroy();
}

// ================================================
//  RUN OPTION
// ================================================

runOption( options, index )
{
    switch ( options[index] )
    {
        case "Add Bot":
            self thread addBot();
            break;

        case "Remove Bot":
            self thread removeBot();
            break;
    }
}

// ================================================
//  BOT FUNCTIONS
// ================================================

addBot()
{
    self endon( "disconnect" );
    addtestclient();
    self iprintln( "^2bot added" );
}

removeBot()
{
    self endon( "disconnect" );

    players = getentarray( "player", "classname" );

    for ( i = 0; i < players.size; i++ )
    {
        if ( players[i] isTestClient() )
        {
            kick( players[i] getEntityNumber() );
            self iprintln( "^1bot removed" );
            return;
        }
    }

    self iprintln( "^3no bots found" );
}
