-- ## Information #############################################################
-- Filename: GPMDP.lua
-- Project: PlayMusic
-- Contact: BStevensonDev@gmail.com
-- Version: v1.0.6
-- License: BSD 3-Clause
-- Updated: Jan 4, 2017
-- #############################################################################


-- ## Description ##############################################################
-- This is the Lua script which allows the PlayMusic skin to interface with
-- Google Play Music Desktop Player, in order to collect and process the
-- displayed song data and application state from GPMDP's playback.json file.
-- #############################################################################


function Initialize()
	sJSONParser = SELF:GetOption('JSONParser')
	sFileToRead = SELF:GetOption('FileToRead')
	sSettingsFile = SELF:GetOption('SettingsFile')
	--load the external JSON library
	JSON = assert(loadfile(sJSONParser))()
    	JSON.strictTypes = true
end


function Update()
	--Create info for the previous song if it doesn't exist
	if prevSongInfo == nill then
		local prevSongInfo
	end

	local File = io.open(sFileToRead)
	-- Handle errors opening file
	if not File then
		print('ReadFile: unable to open file at ' .. sFileToRead)
		return
	end

	-- Read the file contents and close
	local FileContents = File:read("*all")
	File:close()

	-- Read settings file
	local SettingsFile = io.open(sSettingsFile)
	local Variant = tonumber(string.match(SettingsFile:read("*line"), "%d+"))
	SKIN:Bang('!SetVariable', 'VariantStatus', Variant)
	local MinString = SettingsFile:read("*line")
	local MinStatus = tonumber(string.match(MinString, "%d+"))
	SKIN:Bang('!SetVariable', 'MinimizeStatus', MinStatus)

	--Convert JSON to lua table and set meters
	nowPlaying_info = JSON:decode(FileContents)
	if nowPlaying_info ~= nill then
		SKIN:Bang('!SetVariable', 'Shuffle', nowPlaying_info.shuffle)
		if nowPlaying_info.playing or prevSongInfo == nil then
		SKIN:Bang('!SetVariable', 'SongPlaying', 1)
		SKIN:Bang('!SetVariable', 'GPMDPOpen', 1)
			if prevSongInfo == nil or prevSongInfo.title ~= nowPlaying_info.song.title then
				--Set all variables
				SKIN:Bang('!SetVariable', 'AlbumArtUrl', nowPlaying_info.song.albumArt)
				SKIN:Bang('!SetVariable', 'SongTitle', nowPlaying_info.song.title)
				SKIN:Bang('!SetVariable', 'SongArtist', nowPlaying_info.song.artist)
				SKIN:Bang('!SetVariable', 'SongAlbum', nowPlaying_info.song.album)
				SKIN:Bang('!CommandMeasure', 'MeasureImageDownload', "Update")
			end
			local seconds = nowPlaying_info.time.total/1000
			if  SKIN:GetMeter(SKIN:GetVariable("MeterTotalTime")) ~= nil then
				if math.floor(seconds/(60*60)) ~= 0  then
					SKIN:GetMeter(SKIN:GetVariable("MeterTotalTime")):SetText(string.format("%.2d:%.2d:%.2d", seconds/(60*60), seconds/60%60, seconds%60))
				else
					SKIN:GetMeter(SKIN:GetVariable("MeterTotalTime")):SetText(string.format("%.2d:%.2d", seconds/60%60, seconds%60))
				end
			end
			local currentSeconds = nowPlaying_info.time.current/1000
			if SKIN:GetMeter(SKIN:GetVariable("MeterCurrentTime")) ~= nil then
				if math.floor(currentSeconds/(60*60)) ~= 0 then
					SKIN:GetMeter(SKIN:GetVariable("MeterCurrentTime")):SetText(string.format("%.2d:%.2d:%.2d", currentSeconds/(60*60), currentSeconds/60%60, currentSeconds%60))
				else
					SKIN:GetMeter(SKIN:GetVariable("MeterCurrentTime")):SetText(string.format("%.2d:%.2d", currentSeconds/60%60, currentSeconds%60))
				end
			end
			SKIN:Bang('!SetVariable', 'Length', nowPlaying_info.time.current / nowPlaying_info.time.total)
			prevSongInfo = nowPlaying_info.song
		else
			SKIN:Bang('!SetVariable', 'SongPlaying', 0)
			if nowPlaying_info.song.artist == nil or nowPlaying_info.time.total == 0 then
				SKIN:Bang('!SetVariable', 'GPMDPOpen', 0)
			end
		end
	end
end
