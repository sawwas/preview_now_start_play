const String SENTRY_DSN =
    'https://67064227b9e2ec8421f3223ffa94928b@o4508120700289024.ingest.us.sentry.io/4508840679768064';

// Set `sampleRate` to 1.0 to capture 100%
// of events for error monitoring.
const double SENTRY_SAMPLE_RATE = 1.0;

// Set `ignoreErrors` to ignore some errors.
const List<String> SENTRY_IGNORE_ERRORS = [
  'Network Error',
  'timeout of 20000ms exceeded',
  'timeout exceeded',
];

// Set tracesSampleRate to 0.5 to capture 50%
// of transactions for performance monitoring.
const double SENTRY_TRACES_SAMPLE_RATE = 1.0;
// const double SENTRY_TRACES_SAMPLE_RATE = 0.2;

/// Severity levels.
/// this is a copy of the enum from @sentry/types
enum ErrorLevel { fatal, error, warning, log, info, debug }

/// this is a list of success api business code
const List<int> SENTRY_HTTP_SUCCESS_BIZ_CODE = [0, 20000, 10000, 8000];

/// this is a list of http ignore error STATUS
const List<int> SENTRY_OAUTH_HTTP_IGNORE_ERROR_STATUS = [401];
