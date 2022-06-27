/datum/job/army
	department_flag = ARMY
	faction = "National Guard"
	selection_color = "#aaaaf7"
	forbids = "National Guard crimes: Assisting enemy forces."
	enforces = "National Guard rules: Stay in uniform if on duty. Act mature and respectful. Obey orders. Support and defend the Constitution of the United States against all enemies, foreign and domestic."
	access = list(ACCESS_ENCLAVE)
	minimal_access = list(ACCESS_ENCLAVE)
	exp_type = EXP_TYPE_ENCLAVE
	exp_requirements = 0

/datum/outfit/job/army
	id =	/obj/item/card/id/dogtag/enclave
	ears =	/obj/item/radio/headset/headset_enclave
	box =	/obj/item/storage/survivalkit_aid
	backpack =	/obj/item/storage/backpack
	satchel =	/obj/item/storage/backpack/satchel
	shoes =	/obj/item/clothing/shoes/f13/military
	gloves =	/obj/item/clothing/gloves/f13/military
	r_pocket =	/obj/item/flashlight/seclite
	l_pocket =	/obj/item/melee/onehanded/knife/bayonet