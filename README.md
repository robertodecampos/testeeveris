Código utilizado para agendar a execução do batch:
```
AccountSchedule objAccountSchedule = new AccountSchedule();
String jobID = system.schedule('Inativação de conta', '0 0 0,6,12,18 ? * 2-6 *', objAccountSchedule);
```

Caminho da org de desenvolvimento: [Clique aqui](https://everymind77-dev-ed.my.salesforce.com)
