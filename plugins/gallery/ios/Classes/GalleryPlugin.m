#import "GalleryPlugin.h"
#if __has_include(<gallery/gallery-Swift.h>)
#import <gallery/gallery-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "gallery-Swift.h"
#endif

@implementation GalleryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGalleryPlugin registerWithRegistrar:registrar];
}
@end
