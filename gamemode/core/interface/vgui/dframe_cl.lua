local PANEL = {}

function PANEL:Paint( w, h )
	draw.Blur( self )
	draw.OutlinedBox( 0, 0, w, h, Color( 75, 75, 75, 245 ), Color( 0, 0, 0, 230 ) ) -- Background
	draw.OutlinedBox( 0, 0, w, 24, Color( 63, 63, 63 ), Color( 0, 0, 0 ) ) -- Bar
end

vgui.Register( 'dm_frame', PANEL, 'DFrame' )
