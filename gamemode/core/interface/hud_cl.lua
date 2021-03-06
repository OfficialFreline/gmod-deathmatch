local color_white = Color( 255, 255, 255 )
local color_black = Color( 0, 0, 0 )
local scrw, scrh = ScrW(), ScrH()
local draw_RoundedBox = draw.RoundedBox

hook.Add( 'RenderScene', 'Hud', function( pos )
	EyePos = pos
end )

hook.Add( 'PostPlayerDraw', 'Hud', function( ply )
	surface.SetFont( 'Hud.2' )

	local Distantion = ply:GetPos():Distance( EyePos )

	if ( Distantion > 550 or not ply:Alive() ) then
		return
	end

	local Bone = ply:LookupAttachment( 'anim_attachment_head' )

	if ( Bone == 0 ) then
		return
	end
			
	local Attach = ply:GetAttachment( Bone )
	local ColorAlpha = 255 * ( 1 - math.Clamp( ( Distantion - 450 ) * 0.01, 0, 1 ) )
	local TextNick = ply:Nick()

	cam.Start3D2D( Attach.Pos + Vector( 0, 0, 15 ), Angle( 0, ( Attach.Pos - EyePos ):Angle().y - 90, 90 ), 0.05 )
		draw.SimpleTextOutlined( TextNick, 'Hud.2', 0, 0, Color( 255, 255, 255, ColorAlpha ), 1, 1, 2, Color( 0, 0, 0, ColorAlpha ) )	
	cam.End3D2D()
end )

function GM:HUDPaint()
	-- Effect at low HP
	local health = LocalPlayer():Health()

	if ( health <= 40 ) then
		if( health <= 30 ) then
			local blurmul = 0
			local cutoff = 50

			if ( health <= 20 ) then
				cutoff = 120
			end

			if( health <= 10 ) then
				cutoff = 200
			end	

			blurmul = 1 - math.Clamp( health / cutoff, 0, 1 )

			DrawMotionBlur( 0.15 * blurmul, 0.955 * blurmul, 0.07 * blurmul )
		end

		surface.SetDrawColor( 135, 0, 0, 160 * ( 1 - math.Clamp( health * 0.02, 0, 1 ) ) )
		surface.DrawRect( 0, 0, scrw, scrh )
	end

	-- Death
	if ( not LocalPlayer():Alive() ) then
		return
	end
	
	surface.SetFont( 'Hud.1' )

	-- Health
	local siz = scrw * 0.15
	local s = 24
	local tall = 16

	draw.RectBlur( 25 + s, scrh - tall - 25, siz, tall )

	draw.OutlinedBox( 25 + s, scrh - tall - 25, siz, tall, Color( 59, 59, 59, 150 ), color_black )
	draw.OutlinedBox( 25 + s, scrh - tall - 25, math.Clamp( health, 0, 100 ) * siz / 100, tall, Color( 62, 230, 132 ), color_black )
	draw.OutlinedBox( 25, scrh - tall - 25, 25, tall, Color( 63, 63, 63 ), color_black ) // Square bar

	-- Ammo
	local Weapon = LocalPlayer():GetActiveWeapon()

	if ( IsValid( Weapon ) ) then
        local CountOne = Weapon:Clip1()
        local CountTwo = LocalPlayer():GetAmmoCount( Weapon:GetPrimaryAmmoType() )
        local CountOneMax = Weapon:GetMaxClip1()

        if ( CountOneMax > -1 ) then
			local text = CountOne .. '/' .. CountTwo
			local b = 96

	        if ( CountOne == 0 and CountTwo == 0 ) then
				text = 'Empty'

				b = 100
			end

			draw.SimpleText( text, 'Hud.1', 25, scrh - tall - 62, color_white )
        end 
	end

	-- Crosshair
	-- draw_RoundedBox( 0, scrw * 0.5 - 2, scrh * 0.5 - 2, 4, 4, Color( 255, 255, 255, 200 ) )
end

local DeleteHudElementsList = {
	[ 'CHudHealth' ] = true,
	[ 'CHudBattery' ] = true,
	[ 'CHudCrosshair' ] = false,
	[ 'CHudAmmo' ] = true,
	[ 'CHudSecondaryAmmo' ] = true,
}

hook.Add( 'HUDShouldDraw', 'Hud', function( name )
	if ( DeleteHudElementsList[ name ] ) then
		return false
	end
end )

hook.Add( 'HUDDrawTargetID', 'Hud', function( name )
	return false
end )
