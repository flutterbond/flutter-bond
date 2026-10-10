// Timeouts are in milliseconds.
const apiConfigs = {
  'API_BASE_URL': String.fromEnvironment('API_BASE_URL'),
  'CONNECT_TIMEOUT': int.fromEnvironment('CONNECT_TIMEOUT', defaultValue: 10000),
  'SEND_TIMEOUT': int.fromEnvironment('SEND_TIMEOUT', defaultValue: 30000),
  'RECEIVE_TIMEOUT': int.fromEnvironment('RECEIVE_TIMEOUT', defaultValue: 30000),
  'RECEIVE_DATA_WHEN_STATUS_ERROR':
      bool.fromEnvironment('RECEIVE_DATA_WHEN_STATUS_ERROR'),
};
