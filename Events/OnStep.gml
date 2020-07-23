#define OnStep
if(!instance_exists(objPlayer)) {
    exit;
}

var item = undefined;
var item_heal_value = 0;

if(keyboard_check_pressed(ord("H"))) {
    // Iterate through the Item enum. The last entry in the enum is Count
    for(var i = 0; i <= Item.Count; i++) {
        if(IsHealingItem(i) && IsItemInInventory(i)) {
            // If there are multiple healing items in the inventory, choose 
            // the one with the highest healing value
            if(GetItemHealValue(i) > item_heal_value) {
                item = i;
                item_heal_value = GetItemHealValue(i);
            }
        }
    }
}

if(item != undefined) {
    // UseItem(item) crashes, this is a work around that. Unsure if there
    // are any negative side effects from this. 
    if(UseConsume(item)) {
        RemoveItem(item);
    }
}

#define GetItemHealValue(item)
return ItemGet(item, ItemData.Healing);

#define IsHealingItem(item)
return GetItemHealValue(item) > 0;

#define IsItemInInventory(item)
// Does not count items inside the Vaults
return ItemCount(item, false) > 0;