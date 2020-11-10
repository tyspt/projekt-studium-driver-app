const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {'baseUrl': 'http://192.168.2.115:8080'};

const productionConfig = {'baseUrl': 'https://...'};

final environment = isProduction ? productionConfig : testConfig;
