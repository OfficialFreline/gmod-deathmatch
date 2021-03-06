local PANEL = {}

function PANEL:Init()
    self.VBar:SetWide( 12 )
    self.VBar:SetHideButtons( true )
    self.VBar.Paint = nil
    self.VBar.btnGrip.Paint = function( self, w, h )
        if ( self:IsHovered() ) then
            self:SetCursor( 'sizens' )

            draw.RoundedBox( 0, 4, 4, w - 8, h - 8, Color( 90, 138, 222 ) )
        else
            draw.RoundedBox( 0, 4, 4, w - 8, h - 8, Color( 120, 120, 120 ) )
        end
    end
end

vgui.Register( 'dm_scrollpanel', PANEL, 'DScrollPanel' )
