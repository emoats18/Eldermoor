/datum/job/roguetown/churchling
	title = "Churchling"
	flag = CHURCHLING
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_CHILD)

	tutorial = "Your family were zealots. They scolded you with a studded belt and prayed like sinners every waking hour of the day they weren't toiling in the fields. You escaped them by becoming a churchling--and a guaranteed education isn't so bad."

	outfit = /datum/outfit/job/roguetown/churchling
	display_order = JDO_CHURCHLING
	give_bank_account = TRUE
	min_pq = -10
	can_have_apprentices = FALSE
	allowed_patrons = ALL_TEMPLE_PATRONS

/datum/outfit/job/roguetown/churchling
	name = "Churchling"
	jobtype = /datum/job/roguetown/churchling
	allowed_patrons = ALL_TEMPLE_PATRONS

/datum/outfit/job/roguetown/churchling/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	if(H.gender == FEMALE)
		head = /obj/item/clothing/head/roguetown/armingcap
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/robe
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	belt = /obj/item/storage/belt/rogue/leather/rope
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	beltl = /obj/item/storage/keyring/priest
	neck = /obj/item/clothing/neck/roguetown/psycross/silver
	switch(H.patron?.type)
		if(/datum/patron/veneration/lythios)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/lythios
		if(/datum/patron/veneration/labbeus) //labbeus acolytes are now gravetenders
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/labbeus
		if(/datum/patron/veneration/nazar)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/nazar
		if(/datum/patron/veneration/eosten)
			neck = /obj/item/clothing/neck/roguetown/psycross/eosten
		if(/datum/patron/veneration/mikros)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/mikros
		if(/datum/patron/veneration/yaakov)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/yaakov
		if(/datum/patron/veneration/cana)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/cana
		if(/datum/patron/veneration/mathuin)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/mathuin
		if(/datum/patron/veneration/julias)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/julius
		if(/datum/patron/veneration/toma)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/toma
		if(/datum/patron/psydon)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver
		if(/datum/patron/veneration/patras)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver

	H.change_stat("perception", 1)
	H.change_stat("speed", 2)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.grant_spells_churchling(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	if(H.gender == MALE)
		var/acceptable = list("None")
		if(!(H.facial_hairstyle in acceptable))
			H.facial_hairstyle = pick(acceptable)
			H.update_hair()
