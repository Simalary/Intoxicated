//SpringBoard
@interface SBApplication
@end

@interface SBApplicationController
+(id)sharedInstanceIfExists;
@end

@interface SBIcon : NSObject
-(void)launchFromLocation:(long long)arg1 context:(id)arg2 activationSettings:(id)arg3 actions:(id)arg4;
-(id)applicationBundleID;
-(NSString *)displayName;
@end

@interface SBLeafIcon : SBIcon <NSCopying> {
	NSString* _applicationBundleID;
}
-(id)applicationBundleID;
@end

@interface SBUIController
+(id)sharedInstanceIfExists;
-(void)activateApplication:(id)arg1 fromIcon:(id)arg2 location:(long long)arg3 activationSettings:(id)arg4 actions:(id)arg5;
-(id)applicationWithBundleIdentifier:(id)arg1 ;
@end

@interface SBUIAppIconForceTouchControllerDataProvider : NSObject //Karimo299
@property (nonatomic,readonly) NSString * applicationBundleIdentifier;
@property (nonatomic,readonly) NSURL * applicationBundleURL;
-(NSString *)applicationBundleIdentifier;
-(NSURL *)applicationBundleURL;
@end

@interface SBUIAppIconForceTouchController : NSObject{ //Karimo299
    UIViewController* _primaryViewController;
	UIViewController* _secondaryViewController;
}
-(void)appIconForceTouchShortcutViewController:(id)arg1 activateApplicationShortcutItem:(id)arg2;
-(void)dismissAnimated:(BOOL)arg1 withCompletionHandler:(/*^block*/id)arg2;
@end

@interface SBAppLayout : NSObject {
	NSDictionary* _rolesToLayoutItemsMap;
}
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;
@end

@interface SBFluidSwitcherItemContainerHeaderView : UIView{
    UILabel* _firstIconTitle;
	UILabel* _secondIconTitle;
}
@end

@interface SBFluidSwitcherItemContainer : UIView {
    SBAppLayout* _appLayout;
    SBFluidSwitcherItemContainerHeaderView* _iconAndLabelHeader;
}
@property (nonatomic,retain) SBAppLayout * appLayout;
@end

//ChatKit
@interface CKEntryViewButton : UIButton{
    long long _entryViewButtonType;
}
-(long long)entryViewButtonType;
@end

@interface CKMessageEntryView : UIView <UIAlertViewDelegate>{
    BOOL _showAppStrip;
    BOOL _shouldShowPluginButtons;
    BOOL _entryFieldCollapsed;
    CKEntryViewButton* _sendButton;
    CKEntryViewButton* _audioButton;
}
@property (nonatomic,retain) CKEntryViewButton * sendButton;
@property (nonatomic,retain) CKEntryViewButton * audioButton;
@property (nonatomic,readonly) BOOL shouldShowAppStrip; 
@property (nonatomic,readonly) BOOL showsKeyboardPredictionBar; 
@property (assign,nonatomic) BOOL entryFieldCollapsed;
@property (assign,nonatomic) BOOL shouldShowPluginButtons;
-(void)touchUpInsideSendButton:(id)arg1;
-(BOOL)shouldShowAppStrip;
-(BOOL)showsKeyboardPredictionBar;
-(BOOL)isPredictionBarEnabled;
-(BOOL)shouldShowPluginButtons;
-(BOOL)entryFieldCollapsed;
@end

@interface CKEffectPickerView : UIView
-(void)_touchUpInsideSendButton:(id)arg1;
//-(void)_touchUpInsideSendMomentButton:(id)arg1;
@end

@interface CKEffectPickerViewController : UIViewController //<CKEffectPickerViewDelegate>
-(void)handleTouchUp:(CGPoint)arg1;
@end

//Base Headers
@interface IntoxicatedBase : NSObject
+(int)getRandomNumberBetween:(int)arg1 And:(int)arg2;
@end

@interface UIView (Intoxicated)
- (UIViewController *)parentViewController;
@end

@implementation UIView (Intoxicated)
- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
    return (UIViewController *)responder;
}
@end