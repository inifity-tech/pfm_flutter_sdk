class EqualSDKConfig {
  final String token;
  final String env;

  EqualSDKConfig({
    required this.token, 
    String? env,
  }) : env = env ?? "pre-prod";
}
