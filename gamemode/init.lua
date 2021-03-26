AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )

include( 'shared.lua' )

hook.Add( 'PreGamemodeLoaded', 'widgets_disabler_cpu', function()
	function widgets.PlayerTick()
        -- Clear
	end

	hook.Remove( 'PlayerTick', 'TickWidgets' )
end )
