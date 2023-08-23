local composer = require ("composer")

display.setStatusBar (display.HiddenStatusBar)

math.randomseed(os.time())

audio.reserveChannels (1)
audio.setVolume (0.1, {channel=1})

composer.gotoScene("principal")