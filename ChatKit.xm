#import "Headers.h"

%hook CKBrowserSwitcherFooterView
-(void)updateCollectionView:(id)arg1{
    NSLog(@"%@",arg1);
    %orig(arg1);
}
%end

%hook CKEffectPickerView
// -(void)_touchUpInsideSendMomentButton:(id)arg1{
//     int firstNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
//     int secondNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
//     int answerValue = firstNumber + secondNumber;

//     applicationDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
//     UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
//                                             message:[NSString stringWithFormat:@"Answer the following to send this message.\n\nWhat is %d + %d?", firstNumber, secondNumber]
//                                             preferredStyle:UIAlertControllerStyleAlert];
//     [intoxicatedAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//         textField.placeholder = @"Answer";
//         textField.textColor = [UIColor blueColor];
//         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//     }];

//     UIAlertAction *sendMessage = [UIAlertAction actionWithTitle:@"Send Message"
//                             style:UIAlertActionStyleDestructive
//                             handler:^(UIAlertAction * _Nonnull action) {
//                                 NSArray * textFields = intoxicatedAlert.textFields;
//                                 UITextField * answerField = textFields[0];
//                                 if ([answerField.text isEqualToString:[NSString stringWithFormat:@"%d", answerValue]]) {
//                                     %orig(arg1);
//                                 } else {
//                                     UIAlertController *intoxicatedAlert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
//                                     message:@"You did not answer the question correctly. Intoxicated will not allow you to send this message."
//                                     preferredStyle:UIAlertControllerStyleAlert];
                                    
//                                     UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK"
//                                         style:UIAlertActionStyleCancel
//                                         handler:^(UIAlertAction * _Nonnull action) {
//                                             return;
//                                         }];

//                                     [intoxicatedAlert2 addAction:okay];
//                                     [self.parentViewController presentViewController:intoxicatedAlert2 animated:YES completion:nil];
//                                 }
//                             }];
//     UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * _Nonnull action) {
//                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                             }];

//     UIAlertAction *cancelMessage = [UIAlertAction actionWithTitle:@"Cancel"
//                             style:UIAlertActionStyleCancel
//                             handler:^(UIAlertAction * _Nonnull action) {
//                             }];
//     [intoxicatedAlert addAction:sendMessage];
//     [intoxicatedAlert addAction:openSettings];
//     [intoxicatedAlert addAction:cancelMessage];
//     [self.parentViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
// }
-(void)_touchUpInsideSendButton:(id)arg1{
    int firstNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
    int secondNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
    int answerValue = firstNumber + secondNumber;

    NSString *applicationDisplayName = @"";

    if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] != nil){
        applicationDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    } else {
        applicationDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                            message:[NSString stringWithFormat:@"Answer the following to send this message.\n\nWhat is %d + %d?", firstNumber, secondNumber]
                                            preferredStyle:UIAlertControllerStyleAlert];
    [intoxicatedAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Answer";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];

    UIAlertAction *sendMessage = [UIAlertAction actionWithTitle:@"Send Message"
                            style:UIAlertActionStyleDestructive
                            handler:^(UIAlertAction * _Nonnull action) {
                                NSArray * textFields = intoxicatedAlert.textFields;
                                UITextField * answerField = textFields[0];
                                if ([answerField.text isEqualToString:[NSString stringWithFormat:@"%d", answerValue]]) {
                                    %orig(arg1);
                                } else {
                                    UIAlertController *intoxicatedAlert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                    message:@"You did not answer the question correctly. Intoxicated will not allow you to send this message."
                                    preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK"
                                        style:UIAlertActionStyleCancel
                                        handler:^(UIAlertAction * _Nonnull action) {
                                            return;
                                        }];

                                    [intoxicatedAlert2 addAction:okay];
                                    [self.parentViewController presentViewController:intoxicatedAlert2 animated:YES completion:nil];
                                }
                            }];
    UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * _Nonnull action) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                            }];

    UIAlertAction *cancelMessage = [UIAlertAction actionWithTitle:@"Cancel"
                            style:UIAlertActionStyleCancel
                            handler:^(UIAlertAction * _Nonnull action) {
                            }];
    [intoxicatedAlert addAction:sendMessage];
    [intoxicatedAlert addAction:openSettings];
    [intoxicatedAlert addAction:cancelMessage];
    [self.parentViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
}
%end

%hook CKEffectPickerViewController
-(void)handleTouchUp:(CGPoint)arg1{
    int firstNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
    int secondNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
    int answerValue = firstNumber + secondNumber;

    NSString *applicationDisplayName = @"";

    if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] != nil){
        applicationDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    } else {
        applicationDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                            message:[NSString stringWithFormat:@"Answer the following to send this message.\n\nWhat is %d + %d?", firstNumber, secondNumber]
                                            preferredStyle:UIAlertControllerStyleAlert];
    [intoxicatedAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Answer";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];

    UIAlertAction *sendMessage = [UIAlertAction actionWithTitle:@"Send Message"
                            style:UIAlertActionStyleDestructive
                            handler:^(UIAlertAction * _Nonnull action) {
                                NSArray * textFields = intoxicatedAlert.textFields;
                                UITextField * answerField = textFields[0];
                                if ([answerField.text isEqualToString:[NSString stringWithFormat:@"%d", answerValue]]) {
                                    %orig(arg1);
                                } else {
                                    UIAlertController *intoxicatedAlert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                    message:@"You did not answer the question correctly. Intoxicated will not allow you to send this message."
                                    preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK"
                                        style:UIAlertActionStyleCancel
                                        handler:^(UIAlertAction * _Nonnull action) {
                                            return;
                                        }];

                                    [intoxicatedAlert2 addAction:okay];
                                    [self.parentViewController presentViewController:intoxicatedAlert2 animated:YES completion:nil];
                                }
                            }];
    UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * _Nonnull action) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                            }];

    UIAlertAction *cancelMessage = [UIAlertAction actionWithTitle:@"Cancel"
                            style:UIAlertActionStyleCancel
                            handler:^(UIAlertAction * _Nonnull action) {
                            }];
    [intoxicatedAlert addAction:sendMessage];
    [intoxicatedAlert addAction:openSettings];
    [intoxicatedAlert addAction:cancelMessage];
    [self.parentViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
}
%end

%hook CKMessageEntryView
// -(BOOL)shouldShowPluginButtons{
//     return NO;
// }
-(BOOL)shouldShowAppStrip{
    return NO;
}
-(BOOL)showsKeyboardPredictionBar{
    return YES;
}
-(BOOL)isPredictionBarEnabled{
    return YES;
}
-(BOOL)entryFieldCollapsed{
    return NO;
}
-(void)updateEntryView{
    %orig;
    self.audioButton.hidden = YES;
}
-(void)touchUpInsideSendButton:(id)arg1{
        int firstNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
        int secondNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
        int answerValue = firstNumber + secondNumber;

        NSString *applicationDisplayName = @"";

        if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] != nil){
            applicationDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        } else {
            applicationDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        }
        UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                                message:[NSString stringWithFormat:@"Answer the following to send this message.\n\nWhat is %d + %d?", firstNumber, secondNumber]
                                                preferredStyle:UIAlertControllerStyleAlert];
        [intoxicatedAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Answer";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];

        UIAlertAction *sendMessage = [UIAlertAction actionWithTitle:@"Send Message"
                                style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction * _Nonnull action) {
                                    NSArray * textFields = intoxicatedAlert.textFields;
                                    UITextField * answerField = textFields[0];
                                    if ([answerField.text isEqualToString:[NSString stringWithFormat:@"%d", answerValue]]) {
                                        %orig(arg1);
                                    } else {
                                        UIAlertController *intoxicatedAlert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                        message:@"You did not answer the question correctly. Intoxicated will not allow you to send this message."
                                        preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK"
                                            style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                return;
                                            }];

                                        [intoxicatedAlert2 addAction:okay];
                                        [self.parentViewController presentViewController:intoxicatedAlert2 animated:YES completion:nil];
                                    }
                                }];
        UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * _Nonnull action) {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                }];

        UIAlertAction *cancelMessage = [UIAlertAction actionWithTitle:@"Cancel"
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction * _Nonnull action) {
                                }];
        [intoxicatedAlert addAction:sendMessage];
        [intoxicatedAlert addAction:openSettings];
        [intoxicatedAlert addAction:cancelMessage];
        [self.parentViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
}
%end