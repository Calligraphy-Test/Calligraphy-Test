/client/verb/discord()
	set name = "discord"
	set desc = "Visit the discord."
	set hidden = TRUE
	var/discordurl = CONFIG_GET(string/discordurl)
	if(discordurl)
		if(tgui_alert(src, "This will open the discord in your browser. Are you sure?",, list("Yes","No"))!="Yes")
			return
		src << link(discordurl)
	else
		to_chat(src, span_danger("The discord URL is not set in the server configuration."))
	return

/datum/config_entry/string/discordurl
	default = "https://discord.gg/Mn2fs7mWSU"
