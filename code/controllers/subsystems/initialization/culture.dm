SUBSYSTEM_DEF(culture)
	name = "Culture"
	init_order = SS_INIT_CULTURE
	flags = SS_NO_FIRE

	var/list/cultural_info_by_name =      list()
	var/list/cultural_info_by_path =      list()
	var/list/tagged_info =                list()
	var/list/education_tiers_to_strings = list()

/datum/controller/subsystem/culture/proc/get_all_entries_tagged_with(var/token)
	return tagged_info[token]

/datum/controller/subsystem/culture/Initialize()

	education_tiers_to_strings = list(
		"[EDUCATION_TIER_NONE]"      = "no education",
		"[EDUCATION_TIER_BASIC]"     = "some schooling",
		"[EDUCATION_TIER_TRADE]"     = "a high school diploma",
		"[EDUCATION_TIER_BACHELOR]"  = "a bachelor's degree",
		"[EDUCATION_TIER_MASTERS]"   = "a master's degree",
		"[EDUCATION_TIER_DOCTORATE]" = "a doctorate",
		"[EDUCATION_TIER_MEDSCHOOL]" = "a medical degree"
	)

	for(var/ftype in subtypesof(/decl/cultural_info))
		var/decl/cultural_info/culture = ftype
		if(!initial(culture.name))
			continue
		culture = new culture
		if(cultural_info_by_name[culture.name])
			crash_with("Duplicate cultural datum ID - [culture.name] - [ftype]")
		cultural_info_by_name[culture.name] = culture
		cultural_info_by_path[ftype] = culture
		if(culture.category && !culture.hidden)
			if(!tagged_info[culture.category])
				tagged_info[culture.category] = list()
			var/list/tag_list = tagged_info[culture.category]
			tag_list[culture.name] = culture
	. = ..()

/datum/controller/subsystem/culture/proc/get_culture(var/culture_ident)
	return cultural_info_by_name[culture_ident] ? cultural_info_by_name[culture_ident] : cultural_info_by_path[culture_ident]
