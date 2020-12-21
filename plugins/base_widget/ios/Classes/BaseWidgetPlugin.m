#import "BaseWidgetPlugin.h"
#if __has_include(<base_widget/base_widget-Swift.h>)
#import <base_widget/base_widget-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "base_widget-Swift.h"
#endif

@implementation BaseWidgetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBaseWidgetPlugin registerWithRegistrar:registrar];
}
@end
