class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  static const String LOCAL = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.PRODUCTION;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.LOCAL,
      'url': 'http://192.168.0.2:5000/api/',
      'token-git': '',
    },
    {
      'env': Environments.DEV,
      'url': '',
      'token-git': '',
    },
    {
      'env': Environments.QAS,
      'url': '',
      'token-git': '',
    },
    {
      'env': Environments.PRODUCTION,
      'url': '',
      'token-git': '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',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
    );
  }
}
