public class AccountBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext objBatchableContext){
        return Database.getQueryLocator(
            [
                SELECT
                    Id,
                    (
                        SELECT
                            Id
                        FROM
                            Tasks
                        WHERE
                            CreatedDate = LAST_N_DAYS:90
                    ),
                    (
                        SELECT
                            Id
                        FROM
                            Opportunities
                        WHERE
                            (
                                CloseDate = LAST_N_DAYS:120 AND
                                StageName = 'Closed Won'
                            ) OR
                            StageName = 'Negotiation/Review'
                    )
                FROM
                    Account
            ]
        );
    }
   
    public void execute(Database.BatchableContext objBatchableContext, List<Account> lstAccount){
        
        List<Account> lstNewAccount = new List<Account>();

        for(Account objAccount : lstAccount){
            if (objAccount.Tasks.size() == 0 || objAccount.Opportunities.size() == 0){
                lstNewAccount.add(
                    new Account(
                        Id = objAccount.Id,
                        Inativa__c = true
                    )
                );
            }
        }

        if (!lstNewAccount.isEmpty()){
            update lstNewAccount;
        }
    }
   
    public void finish(Database.BatchableContext BC){
    }
}
