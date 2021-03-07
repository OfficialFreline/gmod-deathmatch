hook.Add( 'ScalePlayerDamage', 'ScaleDamage', function( ply, hitgroup, dmginfo )
	if ( hitgroup == HITGROUP_HEAD ) then
		dmginfo:ScaleDamage( 0.7 )
	elseif ( hitgroup == HITGROUP_GENERIC ) then
		dmginfo:ScaleDamage( 0.6 )
	end
end )
