#import "Headers.h"

static NSArray *prohibitedApplicationBundleIDsThatAreApps = @[@"com.apple.MobileSMS"];
static NSArray *prohibitedApplicationBundleIDsThatHaveBeenLimited = @[@"com.apple.MobileSMS"];
static NSArray *prohibitedApplicationBundleIdsThatAreRestricted = @[@"com.toyopagroup.picaboo", @"com.hammerandchisel.discord"];
static NSArray *prohibitedApplicationBundleIDsPRE = [prohibitedApplicationBundleIDsThatAreApps arrayByAddingObjectsFromArray:prohibitedApplicationBundleIdsThatAreRestricted];
static NSArray *prohibitedApplicationBundleIDs = [prohibitedApplicationBundleIDsPRE arrayByAddingObjectsFromArray:prohibitedApplicationBundleIDsThatHaveBeenLimited];

%hook SBUIAppIconForceTouchController
-(void)appIconForceTouchShortcutViewController:(id)arg1 activateApplicationShortcutItem:(id)arg2 {
    //UIViewController *primaryViewController = (UIViewController *)[self valueForKey:@"_primaryViewController"];
    NSString *applicationBundleID = MSHookIvar<SBUIAppIconForceTouchControllerDataProvider*>(self,"_dataProvider").applicationBundleIdentifier;
    NSURL *applicationBundleURL = MSHookIvar<SBUIAppIconForceTouchControllerDataProvider*>(self,"_dataProvider").applicationBundleURL;
    NSString *applicationDisplayName = @"";
    if ([[NSBundle bundleWithURL:applicationBundleURL] objectForInfoDictionaryKey:@"CFBundleDisplayName"] != nil){
        applicationDisplayName = [[NSBundle bundleWithURL:applicationBundleURL] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    } else {
        applicationDisplayName = [[NSBundle bundleWithURL:applicationBundleURL] objectForInfoDictionaryKey:@"CFBundleName"];
    }
	[self dismissAnimated:TRUE withCompletionHandler:nil];
    if ([prohibitedApplicationBundleIdsThatAreRestricted containsObject:applicationBundleID]) {
		int firstNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
		int secondNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
		int answerValue = firstNumber + secondNumber;
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                                message:[NSString stringWithFormat:@"You can turn off Intoxicated for this app in Settings. Answer the following to perform the action for this app.\n\nWhat is %d + %d?", firstNumber, secondNumber]
                                                preferredStyle:UIAlertControllerStyleAlert];
        [intoxicatedAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Answer";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];

        UIAlertAction *openApplication = [UIAlertAction actionWithTitle:@"Continue"
                                style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction * _Nonnull action) {
                                    NSArray * textFields = intoxicatedAlert.textFields;
                                    UITextField * answerField = textFields[0];
                                    if ([answerField.text isEqualToString:[NSString stringWithFormat:@"%d", answerValue]]) {
                                        %orig(arg1,arg2);
                                    } else {
                                        UIAlertController *intoxicatedAlert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                        message:@"You did not answer the question correctly. Intoxicated will not allow you to perform the action for this app."
                                        preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK"
                                            style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                return;
                                            }];

                                        [intoxicatedAlert2 addAction:okay];
                                        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert2 animated:YES completion:nil];
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
        [intoxicatedAlert addAction:openApplication];
        [intoxicatedAlert addAction:openSettings];
        [intoxicatedAlert addAction:cancelMessage];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
	} else if ([prohibitedApplicationBundleIDsThatHaveBeenLimited containsObject:applicationBundleID]) {
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
												message:@"Intoxicated has limited the functions enabled in this app. You can turn off Intoxicated for this app in Settings."
												preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *acceptAlert = [UIAlertAction actionWithTitle:@"OK"
								style:UIAlertActionStyleCancel
								handler:^(UIAlertAction * _Nonnull action) {
									return;
							}];

		UIAlertAction *openAnyway = [UIAlertAction actionWithTitle:@"Continue"
								style:UIAlertActionStyleDestructive
								handler:^(UIAlertAction * _Nonnull action) {
									%orig(arg1,arg2);
							}];

		UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction * _Nonnull action) {
									SBApplication *settingsApplication = [[%c(SBApplicationController) sharedInstanceIfExists] applicationWithBundleIdentifier:@"com.apple.Preferences"];
									[[%c(SBUIController) sharedInstanceIfExists] activateApplication:settingsApplication fromIcon:nil location:0 activationSettings:nil actions:nil];
								}];
        [intoxicatedAlert addAction:acceptAlert];
        [intoxicatedAlert addAction:openAnyway];
        [intoxicatedAlert addAction:openSettings];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
    } else if ([prohibitedApplicationBundleIDs containsObject:applicationBundleID]) {
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
												message:@"You can turn off Intoxicated for this app in Settings."
												preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *acceptAlert = [UIAlertAction actionWithTitle:@"OK"
								style:UIAlertActionStyleCancel
								handler:^(UIAlertAction * _Nonnull action) {
									return;
							}];

		UIAlertAction *openAnyway = [UIAlertAction actionWithTitle:@"Continue"
								style:UIAlertActionStyleDestructive
								handler:^(UIAlertAction * _Nonnull action) {
									%orig(arg1,arg2);
							}];

		UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction * _Nonnull action) {
									SBApplication *settingsApplication = [[%c(SBApplicationController) sharedInstanceIfExists] applicationWithBundleIdentifier:@"com.apple.Preferences"];
									[[%c(SBUIController) sharedInstanceIfExists] activateApplication:settingsApplication fromIcon:nil location:0 activationSettings:nil actions:nil];
								}];
        [intoxicatedAlert addAction:acceptAlert];
        [intoxicatedAlert addAction:openAnyway];
        [intoxicatedAlert addAction:openSettings];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
    } else {
		%orig(arg1, arg2);
	}
}
%end

%hook SBLeafIcon
-(void)launchFromLocation:(long long)arg1 context:(id)arg2 activationSettings:(id)arg3 actions:(id)arg4 {
	if ([prohibitedApplicationBundleIdsThatAreRestricted containsObject:self.applicationBundleID]) {
		int firstNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
		int secondNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
		int answerValue = firstNumber + secondNumber;
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", self.displayName]
                                                message:[NSString stringWithFormat:@"You can turn off Intoxicated for this app in Settings. Answer the following to open this app.\n\nWhat is %d + %d?", firstNumber, secondNumber]
                                                preferredStyle:UIAlertControllerStyleAlert];
        [intoxicatedAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Answer";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];

        UIAlertAction *openApplication = [UIAlertAction actionWithTitle:@"Open"
                                style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction * _Nonnull action) {
                                    NSArray * textFields = intoxicatedAlert.textFields;
                                    UITextField * answerField = textFields[0];
                                    if ([answerField.text isEqualToString:[NSString stringWithFormat:@"%d", answerValue]]) {
                                        %orig(arg1,arg2,arg3,arg4);
                                    } else {
                                        UIAlertController *intoxicatedAlert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", self.displayName]
                                        message:@"You did not answer the question correctly. Intoxicated will not allow you to open this app."
                                        preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK"
                                            style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                return;
                                            }];

                                        [intoxicatedAlert2 addAction:okay];
                                        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert2 animated:YES completion:nil];
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
        [intoxicatedAlert addAction:openApplication];
        [intoxicatedAlert addAction:openSettings];
        [intoxicatedAlert addAction:cancelMessage];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
	} else if ([prohibitedApplicationBundleIDsThatHaveBeenLimited containsObject:self.applicationBundleID]) {
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", self.displayName]
												message:@"Intoxicated has limited the functions enabled in this app. You can turn off Intoxicated for this app in Settings."
												preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *acceptAlert = [UIAlertAction actionWithTitle:@"OK"
								style:UIAlertActionStyleCancel
								handler:^(UIAlertAction * _Nonnull action) {
									return;
							}];

		UIAlertAction *openAnyway = [UIAlertAction actionWithTitle:@"Open"
								style:UIAlertActionStyleDestructive
								handler:^(UIAlertAction * _Nonnull action) {
									%orig(arg1,arg2,arg3,arg4);
							}];

		UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction * _Nonnull action) {
									SBApplication *settingsApplication = [[%c(SBApplicationController) sharedInstanceIfExists] applicationWithBundleIdentifier:@"com.apple.Preferences"];
									[[%c(SBUIController) sharedInstanceIfExists] activateApplication:settingsApplication fromIcon:nil location:0 activationSettings:nil actions:nil];
								}];
        [intoxicatedAlert addAction:acceptAlert];
        [intoxicatedAlert addAction:openAnyway];
        [intoxicatedAlert addAction:openSettings];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
    } else if ([prohibitedApplicationBundleIDs containsObject:self.applicationBundleID]) {
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", self.displayName]
												message:@"You can turn off Intoxicated for this app in Settings."
												preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *acceptAlert = [UIAlertAction actionWithTitle:@"OK"
								style:UIAlertActionStyleCancel
								handler:^(UIAlertAction * _Nonnull action) {
									return;
							}];

		UIAlertAction *openAnyway = [UIAlertAction actionWithTitle:@"Open"
								style:UIAlertActionStyleDestructive
								handler:^(UIAlertAction * _Nonnull action) {
									%orig(arg1,arg2,arg3,arg4);
							}];

		UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction * _Nonnull action) {
									SBApplication *settingsApplication = [[%c(SBApplicationController) sharedInstanceIfExists] applicationWithBundleIdentifier:@"com.apple.Preferences"];
									[[%c(SBUIController) sharedInstanceIfExists] activateApplication:settingsApplication fromIcon:nil location:0 activationSettings:nil actions:nil];
								}];
        [intoxicatedAlert addAction:acceptAlert];
        [intoxicatedAlert addAction:openAnyway];
        [intoxicatedAlert addAction:openSettings];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
    } else {
		%orig(arg1, arg2, arg3, arg4);
	}
}
%end

%hook SBFluidSwitcherItemContainer
-(void)_handlePageViewTap:(id)arg1 {
    NSLog(@"%@",(NSString *)arg1);
    SBAppLayout *lay = self.appLayout;
    NSArray *jsonArray = [lay.rolesToLayoutItemsMap allValues];
    NSDictionary *firstObjectDict = [jsonArray objectAtIndex:0];
    NSString *applicationBundleID = [firstObjectDict valueForKey:@"displayIdentifier"];
    SBFluidSwitcherItemContainerHeaderView *headerView = (SBFluidSwitcherItemContainerHeaderView *)[self valueForKey:@"_iconAndLabelHeader"];
    UILabel *applicationTitleLabel = (UILabel *)[headerView valueForKey:@"_firstIconTitle"];
    NSString *applicationDisplayName = applicationTitleLabel.text;
	if ([prohibitedApplicationBundleIdsThatAreRestricted containsObject:applicationBundleID]) {
		int firstNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
		int secondNumber = [%c(IntoxicatedBase) getRandomNumberBetween:1 And:25];
		int answerValue = firstNumber + secondNumber;
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                                message:[NSString stringWithFormat:@"You can turn off Intoxicated for this app in Settings. Answer the following to open this app.\n\nWhat is %d + %d?", firstNumber, secondNumber]
                                                preferredStyle:UIAlertControllerStyleAlert];
        [intoxicatedAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Answer";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];

        UIAlertAction *openApplication = [UIAlertAction actionWithTitle:@"Open"
                                style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction * _Nonnull action) {
                                    NSArray * textFields = intoxicatedAlert.textFields;
                                    UITextField * answerField = textFields[0];
                                    if ([answerField.text isEqualToString:[NSString stringWithFormat:@"%d", answerValue]]) {
                                        %orig(arg1);
                                    } else {
                                        UIAlertController *intoxicatedAlert2 = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
                                        message:@"You did not answer the question correctly. Intoxicated will not allow you to open this app."
                                        preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK"
                                            style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                return;
                                            }];

                                        [intoxicatedAlert2 addAction:okay];
                                        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert2 animated:YES completion:nil];
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
        [intoxicatedAlert addAction:openApplication];
        [intoxicatedAlert addAction:openSettings];
        [intoxicatedAlert addAction:cancelMessage];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
	} else if ([prohibitedApplicationBundleIDsThatHaveBeenLimited containsObject:applicationBundleID]) {
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
												message:@"Intoxicated has limited the functions enabled in this app. You can turn off Intoxicated for this app in Settings."
												preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *acceptAlert = [UIAlertAction actionWithTitle:@"OK"
								style:UIAlertActionStyleCancel
								handler:^(UIAlertAction * _Nonnull action) {
									return;
							}];

		UIAlertAction *openAnyway = [UIAlertAction actionWithTitle:@"Open"
								style:UIAlertActionStyleDestructive
								handler:^(UIAlertAction * _Nonnull action) {
									%orig(arg1);
							}];

		UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction * _Nonnull action) {
									SBApplication *settingsApplication = [[%c(SBApplicationController) sharedInstanceIfExists] applicationWithBundleIdentifier:@"com.apple.Preferences"];
									[[%c(SBUIController) sharedInstanceIfExists] activateApplication:settingsApplication fromIcon:nil location:0 activationSettings:nil actions:nil];
								}];
        [intoxicatedAlert addAction:acceptAlert];
        [intoxicatedAlert addAction:openAnyway];
        [intoxicatedAlert addAction:openSettings];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
    } else if ([prohibitedApplicationBundleIDs containsObject:applicationBundleID]) {
		UIAlertController *intoxicatedAlert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Intoxicated is Turned On for \"%@\"", applicationDisplayName]
												message:@"You can turn off Intoxicated for this app in Settings."
												preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *acceptAlert = [UIAlertAction actionWithTitle:@"OK"
								style:UIAlertActionStyleCancel
								handler:^(UIAlertAction * _Nonnull action) {
									return;
							}];

		UIAlertAction *openAnyway = [UIAlertAction actionWithTitle:@"Open"
								style:UIAlertActionStyleDestructive
								handler:^(UIAlertAction * _Nonnull action) {
									%orig(arg1);
							}];

		UIAlertAction *openSettings = [UIAlertAction actionWithTitle:@"Settings"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction * _Nonnull action) {
									SBApplication *settingsApplication = [[%c(SBApplicationController) sharedInstanceIfExists] applicationWithBundleIdentifier:@"com.apple.Preferences"];
									[[%c(SBUIController) sharedInstanceIfExists] activateApplication:settingsApplication fromIcon:nil location:0 activationSettings:nil actions:nil];
								}];
        [intoxicatedAlert addAction:acceptAlert];
        [intoxicatedAlert addAction:openAnyway];
        [intoxicatedAlert addAction:openSettings];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:intoxicatedAlert animated:YES completion:nil];
    } else {
		%orig(arg1);
	}
}
%end