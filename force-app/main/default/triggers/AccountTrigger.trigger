trigger AccountTrigger on Account (before insert, before update, after insert) {
    if (Trigger.isBefore && Trigger.isInsert){
        AccountBO.validate(Trigger.new);
    }
    
    if (Trigger.isBefore && Trigger.isUpdate){
        AccountBO.validate(Trigger.new);
    }
    
    if (Trigger.isAfter && Trigger.isInsert){
        AccountBO.afterCreate(Trigger.new);
    }
}