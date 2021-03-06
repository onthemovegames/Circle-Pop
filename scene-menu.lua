local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- These values are set for easier access later on.
local acw = display.actualContentWidth
local ach = display.actualContentHeight
local cx = display.contentCenterX
local cy = display.contentCenterY
local bottom = display.viewableContentHeight - display.screenOriginY

-- -----------------------------------------------------------------------------------
-- Scene event functions

-- This function will send the player to the game scene
local function onPlayTouch( event )
  if ( "ended" == event.phase ) then
    composer.gotoScene("scene-game")
  end
end
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen
  local background = display.newRect(sceneGroup, 0, 0, acw, ach)
  	background.x = cx
  	background.y = cy

  -- Create the title
  local title = display.newText(sceneGroup, "Circle Pop", 0, 0, native.systemFont, 72)
  	title.x = cx
  	title.y = 100
  	title:setFillColor(0)
	
	-- Create a start playing button. When touched, trigger the onPlayTouch function
	local btn_play = widget.newButton({
      left = 100,
      top = 200,
      label = "Start Playing",
      fontSize = 48,
      onEvent = onPlayTouch
    }
	)
	btn_play.x = cx
	btn_play.y = cy
	sceneGroup:insert(btn_play)

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
      -- Code here runs when the scene is entirely on screen

      -- This will remove the game scene when available. This is important to allow the game scene to reset itself.
      local prevScene = composer.getSceneName( "previous" )
      if(prevScene) then 
      	composer.removeScene( prevScene )
      end
    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
      -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene