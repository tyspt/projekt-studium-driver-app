const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {
  'baseUrl': 'http://192.168.2.115:8080',
  'requestTimeout': 5,
  'locationUpdateCron': '* * * * *'
};

const productionConfig = {
  'baseUrl': 'https://jiaweitang.com/api',
  'requestTimeout': 5,
  'locationUpdateCron': '*/5 * * * *'
};

final environment = isProduction ? productionConfig : testConfig;
