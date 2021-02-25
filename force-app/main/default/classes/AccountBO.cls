public class AccountBO {
    public static void validate(List<Account> lstNewAccount){
        for (Account objAccount : lstNewAccount){
            if (((objAccount.Type == 'CPF') && !Utils.validaCpf(objAccount.AccountNumber)) || ((objAccount.Type == 'CNPJ') && !Utils.validaCnpj(objAccount.AccountNumber))){
                objAccount.addError('Número do cliente é inválido');
            }
        }
    }

    public static void afterCreate(List<Account> lstAccount){
        Id idRecordTypeParceiro = Utils.getRecordTypeId('Account', 'Parceiro');
        Id idRecordTypeClienteFinal = Utils.getRecordTypeId('Account', 'ConsumidorFinal');

        List<SObject> lstNewObject = new List<SObject>();

        for (Account objAccount : lstAccount){
            if (objAccount.RecordTypeId == idRecordTypeParceiro){
                lstNewObject.add(
                    new Opportunity(
                        AccountId = objAccount.Id,
                        Name = objAccount.Name + ' - opp Parceiro',
                        CloseDate = System.now().addDays(30).date(),
                        StageName = 'Qualification'
                    )
                );
            } else if (objAccount.RecordTypeId == idRecordTypeClienteFinal){
                lstNewObject.add(
                    new Task(
                        Subject = 'Consumidor Final',
                        WhatId = objAccount.Id,
                        Status = 'Não Iniciada',
                        Priority = 'Normal'
                    )
                );
            }
        }

        if (!lstNewObject.isEmpty()){
            insert lstNewObject;
        }
    }
}
