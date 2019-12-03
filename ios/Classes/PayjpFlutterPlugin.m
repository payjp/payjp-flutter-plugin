#import "PayjpFlutterPlugin.h"
#import <payjp_flutter/payjp_flutter-Swift.h>

@implementation PayjpFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPayjpFlutterPlugin registerWithRegistrar:registrar];
}
@end
