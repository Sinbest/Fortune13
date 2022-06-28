/datum/job/police
	department_flag = POLICE
	faction = "Police Department"
	selection_color = "#3D4553"
	forbids = "Department crimes: Assising criminals and criminal organizations. Violating the fundamental rights of all Americans."
	enforces = "Department rules: Stay in uniform. Act mature and respectful. Obey the orders of your superiors unless they are unlawful."
	objectivesList = list("Placeholder text!!")
	access = list(ACCESS_POLICE)
	minimal_access = list(ACCESS_POLICE)
	exp_type = EXP_TYPE_POLICE
	exp_requirements = 0

/datum/outfit/job/police
	id =	/obj/item/card/id/dogtag/enclave
	ears =	/obj/item/radio/headset/headset_enclave
	box =	/obj/item/storage/survivalkit_aid
	backpack =	/obj/item/storage/backpack/satchel
	satchel =	/obj/item/storage/backpack/satchel
	shoes =	/obj/item/clothing/shoes/laceup

//Police Chief

/datum/job/police/chief
	title = "Chief of Police"
	flag = POLICECHIEF
	total_positions = 1
	spawn_positions = 1
	description = "You are the Chief of Police, you are the highest ranking member of the Police Department, as the chief you you are charged with leading the Department, and acting on their behalf in the local government."
	supervisors = "The Mayor and the City Council."
	selection_color = "#2D333E"
	exp_requirements = 2000
	access = list(ACCESS_ENCLAVE, ACCESS_ENCLAVE_RD)
	minimal_access = list(ACCESS_ENCLAVE, ACCESS_ENCLAVE_RD)

	outfit = /datum/outfit/job/police/chief

/datum/outfit/job/police/chief
	name =	"Police Chief"
	jobtype =	/datum/job/police/chief
	head =	/obj/item/clothing/head/f13/police/chief
	neck =	/obj/item/storage/belt/holster/legholster/policepistol
	uniform =	/obj/item/clothing/under/f13/police/chief
	armor = /obj/item/clothing/suit/armor/vest/alt
	accessory =	/obj/item/clothing/accessory/ncr/CPT
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/clothing/suit/armor/vest = 1,
		/obj/item/clothing/head/helmet = 1,
		)

//Police Lieutenant

/datum/job/police/lieutenant
	title = "Police Lieutenant"
	flag = POLICELIEUTENTANT
	total_positions = 1
	spawn_positions = 1
	description = "You are the Lieutenant, you are the second highest rank in the Police Department, as the Lieutenant you are charged with leading the department as the Chief's right hand when they are present and acting as the Chief when they are not."
	supervisors = "The Chief of Police."
	selection_color = "#2D333E"
	exp_requirements = 1500
	access = list(ACCESS_POLICE)
	minimal_access = list(ACCESS_POLICE)

	outfit = /datum/outfit/job/police/lieutenant

/datum/outfit/job/police/lieutenant
	name =	"Police Lieutenant"
	jobtype =	/datum/job/police/lieutenant
	head =	/obj/item/clothing/head/f13/police/lieutenant
	neck =	/obj/item/storage/belt/holster/legholster/policepistol
	uniform =	/obj/item/clothing/under/f13/police/lieutenant
	armor = /obj/item/clothing/suit/armor/vest/alt
	accessory =	/obj/item/clothing/accessory/ncr/LT1
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/clothing/glasses/sunglasses = 1,
		)

//Desk Sergeant

/datum/job/police/desksergeant
	title = "Police Desk Sergeant"
	flag = POLICEDESKSERGEANT
	total_positions = 1
	spawn_positions = 1
	description = "You are the Desk Sergeant, you are the third highest rank in the Police Department, as the Desk Sergeant you are charged with managing the actual Police Department building, in this role you act as a dispatcher, armory officer, and warden, because of this role you are the only member of the PD permitted to carry a rifle or shotgun during a low alert level."
	supervisors = "The Lieutenant, and the Chief of Police."
	exp_requirements = 800
	access = list(ACCESS_POLICE)
	minimal_access = list(ACCESS_POLICE)

	outfit = /datum/outfit/job/police/desksergeant

	loadout_options = list(
		/datum/outfit/loadout/desksergeantrifle, //Police Rifle
		/datum/outfit/loadout/desksergeantshotgun, //Police Shotgun
		)

/datum/outfit/job/police/desksergeant
	name =	"Police Desk Sergeant"
	jobtype =	/datum/job/police/desksergeant
	head =	/obj/item/clothing/head/f13/police/sergeant
	neck =	/obj/item/storage/belt/holster/legholster/policepistol
	uniform =	/obj/item/clothing/under/f13/police/officer
	armor = /obj/item/clothing/suit/armor/vest/alt
	accessory =	/obj/item/clothing/accessory/police/SSGT
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/clothing/glasses/sunglasses = 1,
		)

/datum/outfit/loadout/desksergeantrifle
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault = 4,
		/obj/item/gun/ballistic/automatic/service/police = 1
		 )

/datum/outfit/loadout/desksergeantshotgun
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/bean = 2,
		/obj/item/ammo_box/shotgun/bean = 2,
		/obj/item/gun/ballistic/shotgun/police = 1
		 )

//Detectives

/datum/job/police/detective
	title = "Police Detective"
	flag = POLICEDETECTIVE
	total_positions = 2
	spawn_positions = 2
	description = "You are an Detective, you are charged with investigating crimes, their duties in this role include, searching, interviewing, interrogating, and collecting and preserving evidence. You hold a rank equal to Sergeant but are not intended to order around officers unless the situation absolutely it."
	supervisors = "The Chief of Police, the Lieutenant, and the Desk Sergeant
	exp_requirements = 600
	access = list(ACCESS_POLICE)
	minimal_access = list(ACCESS_POLICE)

	outfit = /datum/outfit/job/police/detective

	loadout_options = list(
		/datum/outfit/loadout/detectivebrownsuit //Brown suit
		/datum/outfit/loadout/detectivegreysuit //Grey suit
		)

/datum/outfit/job/police/detective
	name =	"Police Detective"
	jobtype =	/datum/job/police/detective
	neck =	/obj/item/storage/belt/holster/full
	eyes = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/f13/detectivealt
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/storage/box/evidence = 1,
		/obj/item/detective_scanner = 1,
		/obj/item/clothing/suit/armor/vest/det_suit = 1,
		/obj/item/clothing/suit/det_suit/forensicsblue = 1
		)

/datum/outfit/loadout/detectivebrownsuit
	backpack_contents = list(
		/obj/item/clothing/under/rank/security/detective = 1,
		/obj/item/clothing/suit/det_suit = 1,
		/obj/item/clothing/head/fedora/det_hat = 1
		 )

/datum/outfit/loadout/detectivegreysuit
	backpack_contents = list(
		/obj/item/clothing/under/rank/security/detective/grey = 1,
		/obj/item/clothing/suit/det_suit/grey = 1,
		/obj/item/clothing/head/fedora = 1
		 )

//Sergeant

/datum/job/police/sergeant
	title = "Police Sergeant"
	flag = POLICESERGEANT
	total_positions = 2
	spawn_positions = 2
	description = "You are a Sergeant, you are the fourth highest rank in the Police Department, you are charged with many the same duties as Officers but with a higher rank."
	supervisors = "The Chief of Police, the Lieutenant, and the Desk Sergeant."
	exp_requirements = 600
	access = list(ACCESS_POLICE)
	minimal_access = list(ACCESS_POLICE)

	outfit = /datum/outfit/job/police/sergeant

/datum/outfit/job/police/sergeant
	name =	"Police Sergeant"
	jobtype =	/datum/job/police/sergeant
	head =	/obj/item/clothing/head/f13/police/police
	neck =	/obj/item/storage/belt/holster/legholster/policepistol
	eyes = /obj/item/clothing/glasses/sunglasses
	uniform =	/obj/item/clothing/under/f13/police/officer
	armor = /obj/item/clothing/suit/armor/vest/alt
	accessory =	/obj/item/clothing/accessory/police/SGT
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		)

//Officer

/datum/job/police/officer
	title = "Police Officer"
	flag = POLICEOFFICER
	total_positions = 8
	spawn_positions = 8
	description = "You are an Officer, you are the lowest rank in the PD, they are charged with patrolling the town 'on the beat;, responding to emergency situations, acting out arrest and search warrants, and occasionally acting as bodyguards to Local Government officials."
	supervisors = "The Chief of Police, the Lieutenant, the Desk Sergeant, and the Sergeants"
	exp_requirements = 30
	access = list(ACCESS_POLICE)
	minimal_access = list(ACCESS_POLICE)

	outfit = /datum/outfit/job/police/officer

/datum/outfit/job/police/sergeant
	name =	"Police Officer"
	jobtype =	/datum/job/police/officer
	head =	/obj/item/clothing/head/f13/police/police
	neck =	/obj/item/storage/belt/holster/legholster/policepistol
	eyes = /obj/item/clothing/glasses/sunglasses
	uniform =	/obj/item/clothing/under/f13/police/officer
	armor = /obj/item/clothing/suit/armor/vest/alt
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		)