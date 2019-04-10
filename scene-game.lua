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

-- The next lines are forward declares
local createCircles, timerForCircles
local enemyCircle = {} -- a table to store the enemy circles
local enemyCounter = 1 -- a counter to store the number of enemies

local playerScore -- stores the text object that displays player score
local playerScoreCounter = 0 -- a counter to store the players score

-- -----------------------------------------------------------------------------------
-- Scene event functions

-- This is called when the menu button is touched. This will send the player back to the menu.
local function onPlayTouch( event )
  if ( "ended" == event.phase ) then
    timer.cancel(timerForCircles)
    composer.gotoScene("scene-menu")
  end
end

-- This function will remove the circle on touch, increment the player score by 1, and return true. The return true means the function was called successfully. 
local function onCircleTouch(event)
    if ( "ended" == event.phase ) then    
        display.remove(event.target)

        playerScoreCounter = playerScoreCounter + 1
        playerScore.text = "Score: "..playerScoreCounter

        return true
    end
end
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Create the background
    local background = display.newRect(sceneGroup, 0, 0, acw, ach)
        background.x = cx
        background.y = cy

    -- Create the black bar at the bottom of the screen
    local bottombar = display.newRect(sceneGroup, 0, 0, acw, 54)
        bottombar:setFillColor(0)
        bottombar.anchorY = 1
        bottombar.x = cx
        bottombar.y = bottom

    -- Create a text object to keep track of the player score
    playerScore = display.newText(sceneGroup, "Score: "..playerScoreCounter, 0, 0, native.systemFont, 20)
        playerScore:setFillColor(0)
        playerScore.x = cx
        playerScore.y = bottombar.y - 70

    -- Create a button to allow the player to return to the menu
    local btn_menu = widget.newButton({
      left = 100,
      top = 200,
      label = "Menu",
      fontSize = 40,
      onEvent = onPlayTouch
    })
    btn_menu.anchorY = 1 -- anchorY changes the anchor point of the object. By setting it to 1, the anchor point is at the bottom of the object.
    btn_menu.x = cx
    btn_menu.y = bottom - 5
    sceneGroup:insert(btn_menu)

    -- This function will create an enemy circle, assign a random color, assign a random position, and attach the touch event listener. At the end, the enemy counter variable is increased by 1. 
    createCircles = function()
        enemyCircle[enemyCounter] = display.newCircle(sceneGroup, 0, 0, 25)
            enemyCircle[enemyCounter]:setFillColor(math.random(1,255)/255, math.random(1,255)/255, math.random(1,255)/255)
            enemyCircle[enemyCounter].x = math.random(20, acw-20)
            enemyCircle[enemyCounter].y = math.random(20, ach-130)
            enemyCircle[enemyCounter]:addEventListener("touch", onCircleTouch)

        enemyCounter = enemyCounter + 1
    end
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        timerForCircles = timer.performWithDelay(1000, createCircles, 0)
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