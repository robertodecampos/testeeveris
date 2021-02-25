global class AccountSchedule implements Schedulable {
    global void execute(SchedulableContext objSchedulableContext)
    {
        AccountBatch objAccountBatch = new AccountBatch();
        Database.executebatch(objAccountBatch, 200);
    }
}
