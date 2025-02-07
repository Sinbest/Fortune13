// In this document: Axes, Spears, Heavy clubs, Sledgehammers, Advanced twohanded weapons

/obj/item/twohanded // Two handed template. Slower melee speed than onehanders.
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee2h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee2h_righthand.dmi'
	attack_speed = CLICK_CD_MELEE * 1.1
	w_class = WEIGHT_CLASS_BULKY
	var/icon_prefix = null
	var/wielded = FALSE

/obj/item/twohanded/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/twohanded/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/obj/item/twohanded/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/twohanded/update_icon_state()
	icon_state = "[icon_prefix]"



//////////
// AXES //
//////////			-bonus damage to grill/window


// Fire Axe			Keywords: Damage 25/45, Bonus vs inanimate
/obj/item/twohanded/fireaxe
	name = "fire axe"
	desc = "Heavy fireman axe from the old world, with its distinctive red colour and excellent quality steel."
	icon_state = "fireaxe"
	icon_prefix = "fireaxe"
	slot_flags = ITEM_SLOT_BACK
	force = 25
	throwforce = 15
	wound_bonus = 10
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	resistance_flags = FIRE_PROOF
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	attack_verb = list("axed", "chopped", "cleaved", "torn", "hacked")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/twohanded/fireaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , hitsound) //axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=45, icon_wielded="[icon_prefix]2")

/obj/item/twohanded/fireaxe/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] axes [user.p_them()]self from head to toe! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/twohanded/fireaxe/afterattack(atom/A, mob/living/user, proximity)
	. = ..()
	if(!proximity || !wielded || IS_STAMCRIT(user))
		return
	if(istype(A, /obj/structure/window)) //destroys windows and grilles in one hit (or more if it has a ton of health like plasmaglass)
		var/obj/structure/window/W = A
		W.take_damage(200, BRUTE, "melee", 0)
	else if(istype(A, /obj/structure/grille))
		var/obj/structure/grille/G = A
		G.take_damage(40, BRUTE, "melee", 0)


// Bone Axe			Keywords: Damage 25/40, Bonus vs inanimate
/obj/item/twohanded/fireaxe/boneaxe
	name = "bone axe"
	desc = "A large, vicious axe crafted out of several sharpened bone plates and crudely tied together. Made of monsters, by killing monsters, for killing monsters."
	icon_state = "boneaxe"
	icon_prefix = "boneaxe"
	resistance_flags = null

/obj/item/twohanded/fireaxe/boneaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=40, icon_wielded="[icon_prefix]2")


// Bumper Sword		Keywords: Damage 25/45, Bonus vs inanimate
/obj/item/twohanded/fireaxe/bmprsword
	name = "bumper sword"
	desc = "It was too big to be called a sword. Massive, thick, heavy, and far too rough. Indeed, it was more like a heap of raw iron."
	icon_prefix = "bumper"
	icon_state = "bumper"
	wound_bonus = null
	sharpness = SHARP_NONE
	resistance_flags = null



////////////
// SPEARS //
////////////		- Reach

// Metal Spear		Keywords: Damage 10/30, Reach
/obj/item/twohanded/spear
	name = "spear"
	desc = "A simple spear with a metal head and wooden shaft."
	icon_state = "spear-metal"
	icon_prefix = "spear-metal"
	force = 10
	slot_flags = ITEM_SLOT_BACK
	throwforce = 30
	throw_speed = 4
	embedding = list("embed_chance" = 0)
	max_reach = 2
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "impaled", "jabbed", "torn", "gored")
	sharpness = SHARP_POINTY
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	wound_bonus = -15
	bare_wound_bonus = 15
	var/obj/item/grenade/explosive = null
	var/war_cry = "AAAAARGH!!!"

/obj/item/twohanded/spear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70) //decent in a pinch, but pretty bad.
	AddElement(/datum/element/sword_point)
	AddComponent(/datum/component/two_handed, force_unwielded=10, force_wielded=30, icon_wielded="[icon_prefix]2")

/obj/item/twohanded/spear/rightclick_attack_self(mob/user)
	if(explosive)
		explosive.attack_self(user)
		return
	. = ..()

/obj/item/twohanded/spear/update_overlays()
	. = ..()
	if(explosive)
		. += "spearbomb_overlay"

/obj/item/twohanded/spear/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to sword-swallow \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	if(explosive) //Citadel Edit removes qdel and explosive.forcemove(AM)
		user.say("[war_cry]", forced="spear warcry")
		explosive.prime()
		user.gib()
		return BRUTELOSS
	return BRUTELOSS

/obj/item/twohanded/spear/examine(mob/user)
	. = ..()
	if(explosive)
		. += "<span class='notice'>Alt-click to set your war cry.</span>"
		. += "<span class='notice'>Right-click in combat mode to activate the attached explosive.</span>"

/obj/item/twohanded/spear/afterattack(atom/movable/AM, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(isopenturf(AM)) //So you can actually melee with it
		return
	if(explosive && wielded) //Citadel edit removes qdel and explosive.forcemove(AM)
		user.say("[war_cry]", forced="spear warcry")
		explosive.prime()

/obj/item/twohanded/spear/grenade_prime_react(obj/item/grenade/nade) //Citadel edit, removes throw_impact because memes
	nade.forceMove(get_turf(src))
	qdel(src)

/obj/item/twohanded/spear/AltClick(mob/user)
	. = ..()
	if(user.canUseTopic(src, BE_CLOSE))
		..()
		if(!explosive)
			return
		if(istype(user) && loc == user)
			var/input = stripped_input(user,"What do you want your war cry to be? You will shout it when you hit someone in melee.", ,"", 50)
			if(input)
				src.war_cry = input
		return TRUE

/obj/item/twohanded/spear/CheckParts(list/parts_list)
	var/obj/item/twohanded/spear/S = locate() in parts_list
	if(S)
		if(S.explosive)
			S.explosive.forceMove(get_turf(src))
			S.explosive = null
		parts_list -= S
		qdel(S)
	..()
	var/obj/item/grenade/G = locate() in contents
	if(G)
		explosive = G
		name = "explosive lance"
		embedding = list(embed_chance = 0, pain_mult = 1)//elances should not be embeddable
		updateEmbedding()
		desc = "A makeshift spear with \a [G] attached to it."
	update_icon()


// Lance		Keywords: LEGION, Damage 25/40, Reach
/obj/item/twohanded/spear/lance
	name = "legion lance"
	desc = "A long spear made in the Legions war foundries. Useful for fighting tribals and hunting when ammunition is scarce."
	icon_state = "spear-lance"
	icon_prefix = "spear-lance"

/obj/item/twohanded/spear/lance/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=40, icon_wielded="[icon_prefix]2")


// Scrap spear		Keywords: Damage 17/28, Reach
/obj/item/twohanded/spear/scrapspear
	name = "scrap spear"
	desc = "Made from two rods, a glass shard and some duct tape. For the modern tribal or the truly desperate."
	icon_state = "spear-scrap"
	icon_prefix = "spear-scrap"

/obj/item/twohanded/spear/scrapspear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=17, force_wielded=28, icon_wielded="[icon_prefix]2")


// Bone Spear		Keywords: TRIBAL, Damage 18/30, Armor-piercing +0.2, Reach
/obj/item/twohanded/spear/bonespear
	name = "bone spear"
	desc = "A haphazardly-constructed yet still deadly weapon. The pinnacle of modern technology."
	icon_state = "spear-bone"
	icon_prefix = "spear-bone"
	slot_flags = ITEM_SLOT_BACK
	force = 15
	throwforce = 25
	throw_speed = 4
	armour_penetration = 0.2
	max_reach = 2
	embedding = list("embedded_impact_pain_multiplier" = 3)
	custom_materials = null
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/twohanded/spear/bonespear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=18, force_wielded=30, icon_wielded="[icon_prefix]2")


// Deathclaw Spear		Keywords: TRIBAL, Damage 20/45, Armor-piercing +0.3, Reach
/obj/item/twohanded/spear/bonespear/deathclaw
	name = "deathclaw spear"
	desc = "A finely crafted spear with a shaft wrapped in deathclaw leather. It is tipped with a claw from a beast that must have been terrifying in size."
	icon_state = "spear-claw"
	icon_prefix = "spear-claw"
	force = 20
	armour_penetration = 0.3
	sharpness = SHARP_EDGED

/obj/item/twohanded/spear/bonespear/deathclaw/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 20, force_wielded = 45, icon_wielded="[icon_prefix]2")



/////////////////
// HEAVY CLUBS //
/////////////////		- Bonus damage to stamina

// Baseball Bat			Keywords: Damage 12/30, Damage bonus Stamina
/obj/item/twohanded/baseball
	name = "baseball bat"
	desc = "A long wooden stick used to play the great american sport of baseball."
	icon_state = "baseball"
	icon_prefix = "baseball"
	force = 12
	throwforce = 12
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("beat", "smacked", "clubbed", "clobbered")
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_NONE
	icon_prefix = "baseball"

/obj/item/twohanded/baseball/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 12, force_wielded = 30, icon_wielded="[icon_prefix]2")

/obj/item/twohanded/baseball/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(15, STAMINA, null, 0)

// Spiked Baseball Bat		Keywords: Damage 15/33, Damage bonus Stamina, Sharp
/obj/item/twohanded/baseball/spiked
	name = "spiked baseball bat"
	desc = "A long wooden stick used to play the great american sport of baseball, although probably not anymore because somebody has hammered large nails through the top of it."
	icon_state = "baseballspike"
	icon_prefix = "baseballspike"
	force = 15
	throwforce = 15
	wound_bonus = 5
	sharpness = SHARP_POINTY

/obj/item/twohanded/baseball/spiked/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 15, force_wielded = 33, icon_wielded="[icon_prefix]2")


// Golf Club		Keywords: Damage 15/32, Damage bonus Stamina
/obj/item/twohanded/baseball/golfclub
	name = "golf club"
	desc = "A long metal stick used to play the most boring sport in the world, golf."
	icon_state = "golfclub"
	icon_prefix = "golfclub"
	attack_verb = list("smashed", "bashed", "fored", "hit", "bludgeoned", "whacked")

/obj/item/twohanded/baseball/golfclub/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 15, force_wielded = 32, icon_wielded="[icon_prefix]2")

/obj/item/twohanded/baseball/golfclub/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(19, STAMINA, null, 0)


// Louisville Slugger		Keywords: Damage 15/33, Damage bonus Stamina
/obj/item/twohanded/baseball/golfclub/louisville
	name = "Louisville slugger"
	desc = "A baseball bat made by the Hillerich & Bradsby company."
	icon_state = "louisville"
	attack_verb = list("thwacked", "bashed", "slugged", "hit", "bludgeoned", "whacked", "bonked")

/obj/item/twohanded/baseball/golfclub/louisville/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 15, force_wielded = 33, icon_wielded="[icon_prefix]2")

/obj/item/twohanded/baseball/golfclub/louisville/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(22, STAMINA, null, 0)



///////////////////
// SLEDGEHAMMERS //
///////////////////			-Bonus damage to structures

// Sledgehammer			Keywords: Damage 25/45
/obj/item/twohanded/sledgehammer
	name = "sledgehammer"
	desc = "A heavy sledgehammer, often used in demolition work."
	icon_state = "hammer-sledge"
	icon_prefix = "hammer-sledge"
	attack_speed = CLICK_CD_MELEE * 1.2
	force = 25
	throwforce = 30
	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_NONE
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "thrashed")

/obj/item/twohanded/sledgehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 45, icon_wielded="[icon_prefix]2")

/*
/obj/item/twohanded/sledgehammer/afterattack(atom/A, mob/living/user, proximity) //Bonus damage to structures, demolition time
	. = ..()
	if(!proximity || !wielded || IS_STAMCRIT(user))
		return
	if(istype(A, /obj/structure))
		var/obj/structure/ = A
		A.take_damage(30, BRUTE, "melee", 0)
*/
/obj/item/twohanded/sledgehammer/afterattack(atom/A, mob/living/user, proximity)
	. = ..()
	if(!proximity || !wielded || IS_STAMCRIT(user))
		return
	if(istype(A, /obj/structure)) //destroys windows and grilles in one hit (or more if it has a ton of health like plasmaglass)
		var/obj/structure/W = A
		W.take_damage(30, BRUTE, "melee", 0)
		return

// Heavy Wrench			Keywords: Damage 25/45
/obj/item/twohanded/sledgehammer/tankwrench
	name = "tank wrench"
	desc = "A huge wrench made for changing tracks on tanks and similar heavy duty work."
	icon_state = "tankwrench"
	icon_prefix = "tankwrench"
	tool_behaviour = TOOL_WRENCH
	toolspeed = 0.7

/////////////////////////////////
// ADVANCED TWO HANDED WEAPONS //
/////////////////////////////////

// Thermic Lance		Keywords: Damage 5/60, Special Damage Type - Burn
/obj/item/twohanded/thermic_lance
	name = "thermic lance"
	desc = "A versatile power-welding tool. Useful for cutting apart metal and limbs."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	icon_state = "thermiclance_off"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = null
	force = 5
	throwforce = 20
	throw_speed = 2
	throw_range = 4
	attack_verb = list("burned", "welded", "cauterized", "melted", "charred")
	actions_types = list(/datum/action/item_action/toggle_lance)
	hitsound = "swing_hit"
	var/on = FALSE
	var/force_on = 60

/obj/item/twohanded/thermic_lance/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/twohanded/thermic_lance/attack_self(mob/user)
	on = !on
	to_chat(user, "As you turn the lever from [src], [on ? "it begins to heat." : "the flame goes off."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : initial(force)
	update_icon()

	if(on)
		hitsound = 'sound/items/welder2.ogg'
		damtype = "fire"
	else
		hitsound = "swing_hit"
		damtype = "brute"

	if(src == user.get_active_held_item()) //update inhands
		user.update_inv_hands()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/twohanded/thermic_lance/update_icon_state()
	icon_state = "thermiclance_[on ? "on" : "off"]"


// Proton axe			Keywords: Damage 20/32, AP 0.7
/obj/item/melee/transforming/energy/axe/protonaxe
	name = "proton axe"
	desc = "The experimental proton axe resembles a futuristic war-axe with a glowing blue blade of electrical energy at its head."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee2h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee2h_righthand.dmi'
	icon_state = "protonaxe"
	icon_state_on = "protonaxe_on"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	force = 20
	force_on = 32
	armour_penetration = 0.7
	throwforce = 15
	throwforce_on = 30

/obj/item/melee/transforming/energy/axe/protonaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddElement(/datum/element/update_icon_updates_onmob)


// Super Sledge			Keywords: Damage 25/60
/obj/item/twohanded/sledgehammer/supersledge
	name = "Super Sledge"
	desc = "The original incarnation of the Super Sledgehammer, produced formerly by the US Military. The head of the hammer contains the kinetic storage device and a pair of faces that transfer the stored energy to the target. It is mounted on a shock damper held in place by springs, designed to reduce the recoil produced by the impact to manageable, non-lethal levels. Additional padding helps make it more comfortable to use, while a fixture at the terminal end of the shaft ensures it won't slip out of the user's hands."
	icon_state = "hammer-super"
	icon_prefix = "hammer-super"
	force = 25

obj/item/twohanded/sledgehammer/supersledge/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 60, icon_wielded="[icon_prefix]2")


// Rocket-assisted Sledgehammer			Keywords: Damage 20/52, Mining  Issues left: mining only when dual wielded, sound to play always on hit
/obj/item/twohanded/sledgehammer/rockethammer
	name = "rocket-assisted sledgehammer"
	desc = "This pre-War model was originally used by construction crews for demolition. Fitted with a rocket booster at the head, \
	the sledgehammer would behave like a normal tool until it reached a certain acceleration point, when the booster would activate  \
	and deliver a tremendously powerful impact, easily crushing concrete."
	icon_state = "hammer-rocket"
	icon_prefix = "hammer-rocket"
	force = 20
	tool_behaviour = TOOL_MINING
	toolspeed = 0.4
	hitsound = "sound/f13effects/explosion_distant_2.ogg"
	usesound = "sound/f13effects/explosion_distant_2.ogg"
	var/digrange = 1
	var/attacksound = "sound/f13effects/explosion_distant_2.ogg"
	var/sound = "sound/f13effects/explosion_distant_2.ogg"

/obj/item/twohanded/sledgehammer/rockethammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 20, force_wielded = 56, icon_wielded="[icon_prefix]2")

// The Court Martial	Keywords: UNIQUE, Damage 20/52, Inferior mining
/obj/item/twohanded/sledgehammer/rockethammer/courtmartial
	name = "the court martial"
	desc = "The Captain found use for this during a discussion with a would-be deserter. He grew so fond of it he had the engineers refit the hammer head \
	to focus its energy on impact, at the cost of utility as a mining tool. <br>The men call it the Court Martial, and if you think it's a joke you better think again \
	before your skull assumes a consistency reminiscent of a smashed egg."
	icon_state = "hammer-courtmartial"
	icon_prefix = "hammer-courtmartial"
	toolspeed = 0.8


// Atom's Judgement			Keywords: UNIQUE, Damage 25/60, Damage bonus Rad
/obj/item/twohanded/sledgehammer/atomsjudgement
	name = "atom's judgement"
	desc = "A heavy hammer with a head that consists of leaking fusion cores. Might be unhealthy."
	icon_state = "hammer-atom"
	icon_prefix = "hammer-atom"
	force = 25

/obj/item/twohanded/sledgehammer/atomsjudgement/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 60, icon_wielded="[icon_prefix]2")

/obj/item/twohanded/sledgehammer/atomsjudgement/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_effect(300, EFFECT_IRRADIATE, 0)


// War Mace			Keywords: TRIBAL, Damage 25/45, AP 0.2
/obj/item/twohanded/sledgehammer/warmace
	name = "war mace"
	desc = "A heavy wooden club with a turquoise head."
	icon_state = "hammer-war"
	icon_prefix = "hammer-war"
	force = 25
	throwforce = 20
	armour_penetration = 0.2
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "thrashed")

/obj/item/twohanded/sledgehammer/atomsjudgement/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 45, icon_wielded="[icon_prefix]2")


// Shaman staff				Keywords: TRIBAL, Damage 15/30
/obj/item/twohanded/sledgehammer/shamanstaff
	name = "shaman staff"
	desc = "An intricate staff, carried for centuries by the shaman class of the Wayfayer Tribe."
	icon_state = "staff-shaman"
	icon_prefix = "staff-shaman"
	force = 15
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "thrashed")

/obj/item/twohanded/sledgehammer/shamanstaff/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 15, force_wielded = 30, icon_wielded="[icon_prefix]2")


// Staff of Mars			Keywords: Damage 10/10, Damage bonus Burn + Stamina
/obj/item/twohanded/sledgehammer/marsstaff
	name = "Staff of Mars"
	desc = "A staff crafted by the guidance of Mars."
	icon_state = "staff-mars"
	icon_prefix = "staff-mars"
	hitsound = "swing_hit"
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "enlightened")

/obj/item/twohanded/sledgehammer/marsstaff/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 5, force_wielded = 10, icon_wielded="[icon_prefix]2")

/obj/item/twohanded/sledgehammer/marsstaff/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(2, BURN, 0)
	M.apply_damage(25, STAMINA, null, 0)

/obj/item/twohanded/sledgehammer/marsstaff/pickup(mob/living/user, slot)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/U = user
		if(U.job in list("Priestess of Mars"))
		else
			to_chat(user, "<span class='userdanger'>You invoke the wrath of Mars!</span>")
			user.emote("scream")
			user.apply_damage(30, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
			user.dropItemToGround(src, TRUE)
			user.Knockdown(50)
		return

// Chainsaw				Keywords: Damage 13/55, Wound bonus, Tool saw-off
/obj/item/twohanded/chainsaw
	name = "chainsaw"
	desc = "A versatile power tool. Useful for limbing trees and delimbing humans."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee2h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee2h_righthand.dmi'
	icon_state = "chainsaw"
	item_state = "chainsaw"
	icon_prefix = "chainsaw"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
	force = 7
	wound_bonus = 25
	throw_speed = 2
	throw_range = 2
	throwforce = 10
	toolspeed = 0.5
	tool_behaviour = TOOL_SAW
	sharpness = SHARP_EDGED
	resistance_flags = FIRE_PROOF
	hitsound = 'sound/weapons/chainsawhit.ogg'
	var/on_icon_state = "chainsaw_on"
	var/off_icon_state = "chainsaw"
	var/on_item_state = "chainsaw_on"
	var/off_item_state = "chainsaw"
	var/weight_class_on = WEIGHT_CLASS_HUGE
	var/on = FALSE
	var/force_on = 55
	var/force_off = 7
	var/description_on = "<span class ='warning'>You pull the cord, starting up the chainsaw with a roar and letting the blades spin up.</span>"
	var/description_off = "<span class ='notice'>You press the off button, stopping the noise and the carnage.</span>"
	var/on_sound = 'sound/weapons/chainsawhit.ogg'

/obj/item/twohanded/chainsaw/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/chainsawhit.ogg', TRUE)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	update_icon()

/obj/item/twohanded/chainsaw/attack_self(mob/user)
	on = !on
	if(on)
		to_chat(user, description_on)
		icon_state = on_icon_state
		item_state = on_item_state
		w_class = weight_class_on
		force = force_on
		attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
		playsound(loc, on_sound, 50, TRUE)
	else
		to_chat(user, description_off)
		icon_state = off_icon_state
		item_state = off_item_state
		w_class = WEIGHT_CLASS_BULKY
		force = force_off
		attack_verb = list("poked", "scraped")
	add_fingerprint(user)

/obj/item/twohanded/chainsaw/suicide_act(mob/living/carbon/user)
	if(on)
		user.visible_message("<span class='suicide'>[user] begins to tear [user.p_their()] head off with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
		playsound(src, 'sound/weapons/chainsawhit.ogg', 100, 1)
		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
		if(myhead)
			myhead.dismember()
	else
		user.visible_message("<span class='suicide'>[user] smashes [src] into [user.p_their()] neck, destroying [user.p_their()] esophagus! It looks like [user.p_theyre()] trying to commit suicide!</span>")
		playsound(src, 'sound/weapons/genhit1.ogg', 100, 1)
	return(BRUTELOSS)

/*
CODE ARCHIVE

CODE FOR POISON EFFECT
/obj/item/twohanded/spear/ultra/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, TOX, null, 0)

//GREY TIDE
/obj/item/twohanded/spear/grey_tide
	icon_state = "spearglass0"
	name = "\improper Grey Tide"
	desc = "Recovered from the aftermath of a revolt aboard Defense Outpost Theta Aegis, in which a seemingly endless tide of Assistants caused heavy casualities among Nanotrasen military forces."
	throwforce = 20
	throw_speed = 4
	attack_verb = list("gored")
	var/clonechance = 50
	var/clonedamage = 12
	var/clonespeed = 0
	var/clone_replication_chance = 30
	var/clone_lifespan = 100


/obj/item/twohanded/spear/grey_tide/afterattack(atom/movable/AM, mob/living/user, proximity)
	. = ..()
	if(!proximity)
		return
	user.faction |= "greytide([REF(user)])"
	if(isliving(AM))
		var/mob/living/L = AM
		if(istype (L, /mob/living/simple_animal/hostile/illusion))
			return
		if(!L.stat && prob(50))
			var/mob/living/simple_animal/hostile/illusion/M = new(user.loc)
			M.faction = user.faction.Copy()
			M.Copy_Parent(user, 100, user.health/2.5, 12, 30)
			M.GiveTarget(L)


/obj/item/twohanded/bonespear/venom //added for Viper raiders -Thes
	container_type = INJECTABLE
	name = "Viper spear"
	desc = "A bone spear which has been modified to envenomate targets without drawing as much blood. Wielding it with both hands allows for stronger blows, but renders the venom ineffective.<br>It has been designed to allow for easily refitting the tip with a typical spear blade after the venom is dry."
	force_unwielded = 11 //unwielded force decreased to reflect special spear point design and prevent excessive damage during envenomation


/obj/item/twohanded/bonespear/venom/attack(mob/living/L, mob/user)
	..()
	if(!istype(L))
		return

	if(!wielded) //sends empty message when venom is dry and defaults back to normal attack, and allows for injection attack if possible//
		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>[src]'s venom has been used up!</span>")
		else
			if(L.can_inject(user, 1))
				to_chat(user, "<span class='warning'>Your light strike successfully injects venom into [L]'s veins.</span>")
				. = 1

				add_logs(user, L, "stabbed", src) //left this here, but it may or may not work properly

				var/amount_per_transfer_from_this = 8
				var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)

				if(reagents.total_volume)
					if(L.reagents)
						reagents.reaction(L, INJECT, fraction)
						reagents.trans_to(L, amount_per_transfer_from_this)
			else
				..()

/obj/item/twohanded/bonespear/venom/Initialize()
	. = ..()
	create_reagents(72) //mix that causes quick incap without significant risk of death, at least with one attacker. 4-5 attacks on a single target typically causes histamine symptoms, fatigue, sleep, as well as minor suffocation, toxins, and possible liver damage
	reagents.add_reagent(/datum/reagent/venom,12)
	reagents.add_reagent(/datum/reagent/sodium_thiopental, 50)
	reagents.add_reagent(/datum/reagent/pancuronium, 10)
//end of Viper spear. Venom mix is interesting but a simpler poisoned weapon solution might be more generally useful, with injectable or open container weapons that have lower volume but can be easily refilled with small doses of venom or something
*/
