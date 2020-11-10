const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {'baseUrl': 'http://10.0.2.2:8080'};

const productionConfig = {'baseUrl': 'https://...'};

final environment = isProduction ? productionConfig : testConfig;
