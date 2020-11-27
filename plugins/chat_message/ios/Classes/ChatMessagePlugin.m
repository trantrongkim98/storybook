#import "ChatMessagePlugin.h"
#if __has_include(<chat_message/chat_message-Swift.h>)
#import <chat_message/chat_message-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "chat_message-Swift.h"
#endif

@implementation ChatMessagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftChatMessagePlugin registerWithRegistrar:registrar];
}
@end
