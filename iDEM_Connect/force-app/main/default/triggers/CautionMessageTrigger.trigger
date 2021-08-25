
/**This trigger block's users when they want to activate an order with out items
 * and displayed an error message
 */

trigger CautionMessageTrigger on Order (before update) {

        for(Integer i=0;i<Trigger.new.size();i++){
            if(Trigger.old[i].status == 'Draft' && Trigger.new[i].status =='Activated'){
                if(VerifingOrdersItems.countOrderItemsLines(Trigger.new[i].id) == 0){
                    Trigger.new[i].addError('message d\'erreur, pas de produit dans la commande');
                }
            }
        }
}