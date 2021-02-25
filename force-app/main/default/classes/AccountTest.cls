@isTest
private class AccountTest {
    @isTest
    static void createAccountSuccess(){
        List<Account> lstAccount = new List<Account>{
            new Account(
                Name = 'New Account',
                RecordTypeId = Utils.getRecordTypeId('Account', 'Parceiro')
            ),
            new Account(
                Name = 'New Account',
                RecordTypeId = Utils.getRecordTypeId('Account', 'ConsumidorFinal')
            )
        };

        Test.startTest();
        insert lstAccount;
        Test.stopTest();

        List<Opportunity> lstOpportunity = [
            SELECT
                Id
            FROM
                Opportunity
            WHERE
                AccountId = :lstAccount[0].Id
        ];

        System.assertEquals(1, lstOpportunity.size());

        List<Task> lstTask = [
            SELECT
                Id
            FROM
                Task
            WHERE
                WhatId = :lstAccount[1].Id
        ];

        System.assertEquals(1, lstTask.size());
    }

    @isTest
    static void createAccountErrorCpf(){
        Account objAccount = new Account(
            Name = 'New Account',
            Type = 'CPF',
            AccountNumber = '12345678901'
        );

        Test.startTest();
        Database.SaveResult objSaveResult = Database.insert(objAccount, false);
        Test.stopTest();

        System.assertEquals(false, objSaveResult.success);
        System.assertEquals(1, objSaveResult.errors.size());
        System.assertEquals('Número do cliente é inválido', objSaveResult.errors[0].message);
    }

    @isTest
    static void createAccountErrorCnpj(){
        Account objAccount = new Account(
            Name = 'New Account',
            Type = 'CNPJ',
            AccountNumber = '12345678901234'
        );

        Test.startTest();
        Database.SaveResult objSaveResult = Database.insert(objAccount, false);
        Test.stopTest();

        System.assertEquals(false, objSaveResult.success);
        System.assertEquals(1, objSaveResult.errors.size());
        System.assertEquals('Número do cliente é inválido', objSaveResult.errors[0].message);
    }

    @isTest
    static void updateAccountErrorCpf(){
        Account objAccount = new Account(
            Name = 'New Account',
            AccountNumber = '12345678901'
        );

        insert objAccount;

        objAccount.Type = 'CPF';

        Test.startTest();
        Database.SaveResult objSaveResult = Database.update(objAccount, false);
        Test.stopTest();

        System.assertEquals(false, objSaveResult.success);
        System.assertEquals(1, objSaveResult.errors.size());
        System.assertEquals('Número do cliente é inválido', objSaveResult.errors[0].message);
    }

    @isTest
    static void updateAccountErrorCnpj(){
        Account objAccount = new Account(
            Name = 'New Account',
            AccountNumber = '12345678901234'
        );

        insert objAccount;

        objAccount.Type = 'CNPJ';

        Test.startTest();
        Database.SaveResult objSaveResult = Database.update(objAccount, false);
        Test.stopTest();

        System.assertEquals(false, objSaveResult.success);
        System.assertEquals(1, objSaveResult.errors.size());
        System.assertEquals('Número do cliente é inválido', objSaveResult.errors[0].message);
    }
}
