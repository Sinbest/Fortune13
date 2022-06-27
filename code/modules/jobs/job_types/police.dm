/*
Police Design notes:
Standard issue stuff to keep the theme visually and gameplay and avoid watering down.
Gloves		Officers - Leather glovesl, fingerless leather gloves for sergeants. Bayonet standard issue knife. Sidearms mostly for officers, 9mm is the standard. MP gets nonstandard pot helm, the exception to prove the rule.
			NCOs -		Fingerless gloves
			Rest -		No gloves
Knives		Army -		Bayonet
			Ranger -	Bowie knife
Money		Commanding Officer (LT and CAP) - "small" money bag
			Officers and Rangers - /obj/item/storage/bag/money/small/ncrofficers
			Rest - /obj/item/storage/bag/money/small/ncrenlisted
Sidearm		Officers & a few specialists - 9mm pistol
Weapons		Service Rifle, Grease Gun, 9mm pistol, all good.
			Don't use Greaseguns, Lever shotguns, Police shotguns, Berettas, Hunting knives
*/

/datum/job/police
	department_flag = POLICE
	faction = "Police Department"
	selection_color = "#aaaaf7"
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

/*--------------------- Police Chief -------------------------*/
// The big cheese of the department, in charge of maintaining
// law and order.

/datum/job/police/chief
	title = "Chief of Police"
	flag = POLICECHIEF
	total_positions = 1
	spawn_positions = 1
	description = "You are the Chief of Police, you are the highest ranking member of the Police Department, as the chief you you are charged with leading the Department, and acting on their behalf in the local government."
	supervisors = "The Mayor and the City Council."
	selection_color = "#323232"
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
	accessory =	/obj/item/clothing/accessory/ncr/CPT
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/clothing/suit/armor/vest = 1,
		/obj/item/clothing/head/helmet = 1,
		)

/*--------------------- Police Lieutenant -------------------------*/
// The second in command of the department.

/datum/job/police/lieutenant
	title = "Police Lieutenant"
	flag = POLICELIEUTENTANT
	total_positions = 1
	spawn_positions = 1
	description = "You are the Lieutenant, you are the second highest rank in the Police Department, as the Lieutenant you are charged with leading the department as the Chief's right hand when they are present and acting as the Chief when they are not."
	supervisors = "The Chief of Police."
	selection_color = "#323232"
	exp_requirements = 1500
	access = list(ACCESS_ENCLAVE, ACCESS_ENCLAVE_RD)
	minimal_access = list(ACCESS_ENCLAVE, ACCESS_ENCLAVE_RD)

	outfit = /datum/outfit/job/police/lieutenant

/datum/outfit/job/police/lieutenant
	name =	"Police Lieutenant"
	jobtype =	/datum/job/police/lieutenant
	head =	/obj/item/clothing/head/f13/police/lieutenant
	neck =	/obj/item/storage/belt/holster/legholster/policepistol
	uniform =	/obj/item/clothing/under/f13/police/lieutenant
	accessory =	/obj/item/clothing/accessory/ncr/LT1
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/clothing/glasses/sunglasses = 1,
		)

/datum/job/police/desksergeant
	title = "Police Desk Sergeant"
	flag = POLICEDESKSERGEANT
	total_positions = 1
	spawn_positions = 1
	description = "You are the Desk Sergeant, you are the third highest rank in the Police Department, as the Desk Sergeant you are charged with managing the actual Police Department building, in this role you act as a dispatcher, armory officer, and warden, because of this role you are the only member of the PD permitted to carry a rifle or shotgun during a low alert level."
	supervisors = "The Lieutenant, and the Chief of Police."
	selection_color = "#323232"
	exp_requirements = 1500
	access = list(ACCESS_ENCLAVE, ACCESS_ENCLAVE_RD)
	minimal_access = list(ACCESS_ENCLAVE, ACCESS_ENCLAVE_RD)

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
	accessory =	/obj/item/clothing/accessory/ncr/SSGT
	belt =	/obj/item/storage/belt/security/police
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/clothing/glasses/sunglasses = 1,
		)

/datum/outfit/loadout/desksergeantrifle
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault = 4,
		/obj/item/gun/ballistic/automatic/service/police = 1,
		 = 1,
		 )

/datum/outfit/loadout/desksergeantshotgun
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/bean = 2,
		/obj/item/ammo_box/shotgun/bean = 2,
		/obj/item/gun/ballistic/shotgun/police = 1,
		 = 1,
		 )
