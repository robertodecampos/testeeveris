public class Utils {
    public static Boolean validaCpf(String cpf) {
        Integer tamanho;
        String numeros;
        String digitos;
        Integer pos;
        Integer soma;
        Integer resultado;
        Integer digito;

        cpf = cpf.replace('.', '').replace('/', '').replace('-', '');

        if(Pattern.matches('\\D', cpf)) {
            return false;
        }

        if(cpf.length() != 11) {
            return false;
        }

        if(cpf == '00000000000' ||
            cpf == '11111111111' ||
            cpf == '22222222222' ||
            cpf == '33333333333' ||
            cpf == '44444444444' ||
            cpf == '55555555555' ||
            cpf == '66666666666' ||
            cpf == '77777777777' ||
            cpf == '88888888888' ||
            cpf == '99999999999') {
            return false;
        }

        tamanho = cpf.length() - 2;
        numeros = cpf.substring(0, tamanho);
        digitos = cpf.substring(tamanho);
        soma = 0;
        pos = tamanho + 1;

        for(Integer i = 0; i < tamanho; i++) {
            soma += Integer.valueOf(numeros.substring(i, i+1)) * pos--;
        }

        resultado = 11 - Math.mod(soma, 11);
        resultado = resultado >= 10 ? 0 : resultado;

        if(resultado != Integer.valueOf(digitos.substring(0, 1))) {
            return false;
        }

        tamanho = cpf.length() - 1;
        numeros = cpf.substring(0, tamanho);
        soma = 0;
        pos = tamanho + 1;

        for(Integer i = 0; i < tamanho; i++) {
            soma += Integer.valueOf(numeros.substring(i, i+1)) * pos--;
        }

        resultado = 11 - Math.mod(soma, 11);
        resultado = resultado >= 10 ? 0 : resultado;

        if(resultado != Integer.valueOf(digitos.substring(1, 2))) {
            return false;
        }

        return true;
    }

    public static Boolean validaCnpj(String cnpj) {
        Integer tamanho;
        String numeros;
        String digitos;
        Integer pos;
        Integer soma;
        Integer resultado;
        Integer digito;
        
        cnpj = cnpj.replace('.', '').replace('/', '').replace('-', '');

        if(cnpj.length() != 14) {
            return false;
        }

        if(cnpj == '00000000000000' ||
            cnpj == '11111111111111' ||
            cnpj == '22222222222222' ||
            cnpj == '33333333333333' ||
            cnpj == '44444444444444' ||
            cnpj == '55555555555555' ||
            cnpj == '66666666666666' ||
            cnpj == '77777777777777' ||
            cnpj == '88888888888888' ||
            cnpj == '99999999999999') {
            return false;
        }

        tamanho = cnpj.length() - 2;
        numeros = cnpj.substring(0, tamanho);
        digitos = cnpj.substring(tamanho);
        soma = 0;
        pos = 2;
        for(Integer i = tamanho; i >= 1; i--) {
            soma += Integer.valueOf(numeros.substring(i-1, i)) * pos++;

            if(pos == 10) {
                pos = 2;
            }
        }
        resultado = Math.mod(soma, 11);
        resultado = resultado < 2 ? 0 : 11 - resultado;

        if(resultado != Integer.valueOf(digitos.substring(0, 1))) {
            return false;
        }

        tamanho = cnpj.length() - 1;
        numeros = cnpj.substring(0, tamanho);
        soma = 0;
        pos = 2;
        for(Integer i = tamanho; i >= 1; i--) {
            soma += Integer.valueOf(numeros.substring(i-1, i)) * pos++;

            if(pos == 10) {
                pos = 2;
            }
        }
        resultado = Math.mod(soma, 11);
        resultado = resultado < 2 ? 0 : 11 - resultado;

        if(resultado != Integer.valueOf(digitos.substring(1, 2))) {
            return false;
        }

        return true;
    }

    public static RecordTypeInfo getRecordType(String strSObject, String strRecordTypeName) {
        Map<String, RecordTypeInfo> mapRecordTypeInfo = ((SObject)Type.forName(strSObject).newInstance()).getSObjectType().getDescribe().getRecordTypeInfosByName();
        
        for (String strKey : mapRecordTypeInfo.keySet()) {
            RecordTypeInfo objRecordTypeInfo = mapRecordTypeInfo.get(strKey);

            if (objRecordTypeInfo.getDeveloperName() == strRecordTypeName){
                return objRecordTypeInfo;
            }
        }

        return null;
    }

    public static Id getRecordTypeId(String strSObject, String strRecordTypeName){
        RecordTypeInfo objRecordTypeInfo = getRecordType(strSObject, strRecordTypeName);
        
        if (objRecordTypeInfo != null){
            return objRecordTypeInfo.getRecordTypeId();
        } else {
            return null;
        }
    }
}
