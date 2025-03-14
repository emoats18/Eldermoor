#define COMMUNICATION_COOLDOWN 300
#define COMMUNICATION_COOLDOWN_AI 300

SUBSYSTEM_DEF(communications)
	name = "Communications"
	flags = SS_NO_INIT | SS_NO_FIRE

	var/silicon_message_cooldown
	var/nonsilicon_message_cooldown

/datum/controller/subsystem/communications/proc/can_announce(mob/living/user, is_silicon)
	if(is_silicon && silicon_message_cooldown > world.time)
		. = FALSE
	else if(!is_silicon && nonsilicon_message_cooldown > world.time)
		. = FALSE
	else
		. = TRUE

/datum/controller/subsystem/communications/proc/make_announcement(mob/living/user, is_silicon, input)
	if(is_silicon)
		if(user.job)
			var/datum/job/J = SSjob.GetJob(user.job)
			var/used_title = J.title
			if(user.gender == FEMALE && J.f_title)
				used_title = J.f_title
			if(user.gender == MALE && J.m_title)
				used_title = J.m_title
			priority_announce(html_decode(user.treat_message(input)), "The [used_title] Decrees", 'sound/misc/alert.ogg', "Captain")
			silicon_message_cooldown = world.time + 5 SECONDS
	else
		if(user.job)
			var/datum/job/J = SSjob.GetJob(user.job)
			var/used_title = J.title
			if(user.gender == FEMALE && J.f_title)
				used_title = J.f_title
			priority_announce(html_decode(user.treat_message(input)), "The [used_title] Speaks", 'sound/misc/bell.ogg', "Captain")
			nonsilicon_message_cooldown = world.time + 5 SECONDS
		else
			priority_announce(html_decode(user.treat_message(input)), "Someone Speaks", 'sound/misc/bell.ogg', "Captain")
			nonsilicon_message_cooldown = world.time + 5 SECONDS
	user.log_talk(input, LOG_SAY, tag="priority announcement")
	message_admins("[ADMIN_LOOKUPFLW(user)] has made a priority announcement.")

#undef COMMUNICATION_COOLDOWN
#undef COMMUNICATION_COOLDOWN_AI
