//
//  MLStyle.h
//  medilifts
//
//  Created by Saurabh on 4/17/16.
//  Copyright © 2016 Saurabh. All rights reserved.
//

#ifndef MLStyle_h
#define MLStyle_h

#define kLightFontName @"HelveticaNeue-Light"
#define kRegularFontName @"HelveticaNeue"
#define kMediumFontName @"HelveticaNeue-Medium"
#define kBoldFontName @"HelveticaNeue-Bold"

#define RGB(x, y, z) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:1.0]
#define RGBA(x, y, z, a) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:a]
#define GRAYA(x, a) [UIColor colorWithWhite:x alpha:a]
#define GRAY(x) [UIColor colorWithWhite:x alpha:1.0]

#define LIGHT(x) [UIFont fontWithName:kLightFontName size:x]
#define REGULAR(x) [UIFont fontWithName:kRegularFontName size:x]
#define MEDIUM(x) [UIFont fontWithName:kMediumFontName size:x]
#define BOLD(x) [UIFont fontWithName:kBoldFontName size:x]

#define kHomePlaceholderImage [UIImage imageNamed:@"graphic_unavailable_home_icon"]

#define kMainPlaceholderColor GRAY(0.7)
#define kMainTextFieldFontColor GRAY(0.1)

#define kLinkBlueColor RGB(2.0, 119.0, 189.0)
#define kLinkHighlightedBlueColor RGBA(2.0, 119.0, 189.0, 0.5)

#define kRedColor RGB(237.0, 28.0, 36.0)
//#define kCustomCyanColor RGB(0.0, 160.0, 172.0)
#define kCustomCyanColor kBlueColor
#define kAccountsAlertBGColor RGB(255.0, 239.0, 161.0)

#define kLoginBackgroundColor RGB(245.0, 245.0, 245.0)
#define kLoginTableFooterColor RGB(147.0, 147.0, 147.0)
#define kCustomGreenColor RGB(102.0, 180.0, 118.0)
#define kShakeGreenColor RGB(65.0, 177.0, 85.0)
#define kPickerViewBackGroundColor GRAYA(1.0, 0.8)
#define kWalletBGRedColor RGB(255.0, 0.0, 0.0)

#define kBlueColor RGB(4.0, 169.0, 244.0)
//#define kBlueColor kTextBlueColor
#define kBlueColorForBottomBarButton kBlueColor

#define kRatingBlueColor RGB(59.0, 153.0, 217.0)

#define kPageInidicatorColor GRAY(0.7)

#define kCardShadowColor GRAY(0.2)
// Custom Alert Specs

#define kAlertDefaultDescHeight 40.0
#define kAlertDefaultTitleHeight 44.0

// Payment history

#define kPaymentHistoryCellSidePadding 10.0
#define kPaymentHistoryCellVerticalPadding 10.0

// Wynk Pay //

#define kRechargeComponentsVerticalPadding 16.0
#define kRechargeTableCellHeight 48.0
#define kRechargeContentMaxInset 20.0
#define kRechargeContentMinWidth 288.0

#define kRechargeContentMinWidth 288.0
#define kRechargeContentMaxInset 20.0

#define kContactCellImageTextPadding 12.0
#define kRechargeBarHeight 44.0

#define kRechargeContentInset [[MAUtility shared] rechargeContentPadding]
#define kGenericTopPadding 14.0
#define kGenericLeftPadding 14.0

#define kContainerViewSidePadding 10.0

#define kPackUnselectedColor GRAY(0.7)
#define kRechargeOptionsHeaderFont MEDIUM(13.0)
#define kRechargeOptionsUnderlineThickness 4.0
#define kRechargeOptionsUnderlineExtension 8.0


// Global

#define kPagerHeaderSeparatorColor GRAYA(0.0, 0.2)
#define kThinOutlineTransparentColor GRAYA(0.0, 0.3)
#define kThinImageOutlineColor GRAYA(0.0, 0.2)
#define kAlertButtonHeight 44.0
#define kOffWhiteColor GRAY(0.95)
#define kAppBackgroundColor GRAY(1.0)
#define kSeparatorColor GRAY(0.84)
#define kMyPlanBottomBarColor RGB(20.0, 151.0, 242.0)
#define kMyPlanTopBarColor RGB(255.0, 240.0, 163.0)

#define kMainBackgroundColor GRAY(0.92)

#define kKeyboardAccessoryHeight 44.0f
#define kPickerDefaultHeight 216.0f
#define kDefaultBarHeight 44.0
#define kDefaultHomeTabBarHeight 54.0

#define kBlackFontColor GRAY(0.2)
#define kDarkerGrayFontColor GRAY(0.4)
#define kGrayFontColor GRAY(0.5)
#define kLightGrayColor GRAY(0.6)
#define kTVPlaceholderColor GRAY(0.7)
#define kLoaderGrayColor GRAY(0.3)
#define kWhiteColor RGB(255, 255, 255)

//#define kTextBlueColor RGB(2.0, 119.0, 189.0)
#define kTextBlueColor kBlueColor
#define kErrorTitleRedColor RGB(238.0, 95.0, 91.0)
#define kMainTextButtonFont REGULAR(15.0)

#define kAlertOrangeColor RGB(255.0, 133.0, 95.0)

#define kItemCornerRadius 4.0
#define kGenericSidePadding 20.0

#define kGenericNoteFont LIGHT(13.0)

#define kSwipeButtonFont REGULAR(17.0)
#define kDarkGrayColor GRAY(0.3)
#define kLayoverContentInset [[MAUtility shared] layoverContentPadding]


#define kAccessoryButtonFont REGULAR(15.0)
#define kTextButtonFont MEDIUM(15.0)
#define kTextButtonHeight 36.0
#define kTextButtonInternalPadding 12.0

#define kFloatingButtonFont REGULAR(15.0)

#define kLoaderViewTopPadding 16.0
#define kTableViewErrorFont LIGHT(17.0)
#define kPAisaVasoolHeaderFOnt LIGHT(20.0)
#define KPAisaVasoolManagePlanWidth 160.0

#define planOwnerWidth 90.0

// Table View Generic

#define kTableViewSidePadding 16.0
#define kTableViewVerticalPadding 16.0
#define kTableViewInternalPadding 16.0
#define kTableViewLongListPadding 12.0

#define kTableViewUserOTPVerificationFontSize BOLD(20.0)

#define kTableViewPGRegFontSize REGULAR(16.0)
#define kTableViewPGFontSize LIGHT(16.0)
#define kTableViewFirstFont LIGHT(15.0)
#define kTableViewSecondFont LIGHT(14.0)
#define kTableViewThirdFont LIGHT(11.0)
#define kTableViewRightFont REGULAR(15.0)
#define kNavBarTitleFont REGULAR(19.0)
#define kTableSectionHeaderFont REGULAR(14.0)

#define kTableViewCenterRightFont REGULAR(15.0)
#define kTableViewCenterLeftFont LIGHT(15.0)
#define kTableViewCenterRightLargeFont MEDIUM(15.0)
#define kTableViewCenterLeftLargeFont REGULAR(15.0)
#define kTableViewBigFont LIGHT(16.0)
#define kHamBurgerFont LIGHT(16.0)

#define kLoaderViewFont LIGHT(16.0)

#define kTableViewLineSpacing 4.0

#define kTableViewSelectionColor GRAY(0.92)
#define kTableViewButtonOutlineWidth 1.0
#define kTableViewButtonSize ((CGSize) {80.0, 32.0})
#define kTableViewButtonSizeHelloTune ((CGSize) {80.0, 32})

#define kTextFieldFont REGULAR(16.0)
#define kTickButtonInternalPadding 12.0

#define kTickButtonFont LIGHT(14.0)
#define kTickButtonSecondLineFont LIGHT(12.0)

// Section Header

#define kHomeCardHeaderFontSize MEDIUM(14.0)
#define kHomeCardHeaderColor GRAY(0.4)

#define kSectionHeaderLabelFont REGULAR(15.0)
#define kSectionHeaderTopBottomPadding 8.0
#define kSectionHeaderFooterEmptyHeight 8.0

// Text field with title

#define kReferTitleFont REGULAR(18.0)
#define kTFTitleFont LIGHT(14.0)
#define kTFBigTitleFont LIGHT(18.0)
#define kTFIWTTitleFont LIGHT(16.0)
#define kTFTitleTextFieldHeight 40.0
#define kTextViewHeight 120.0
#define kTFTitleAndFieldPadding (kTableViewSmallPadding)

#define kAccountNavigationItemHeight 40.0
#define kNavigationMiddleViewWidth 250.0

// Home Screen

#define kHomeItemMainFont LIGHT(17.0)
#define kHomeItemThirdFont LIGHT(15.0)
#define kHomeItemSecondFont LIGHT(14.0)
#define kHomeItemAlertFont REGULAR(13.0)
#define kHomeItemGenericFont LIGHT(13.0)

#define kHomeAmountFont MEDIUM(14.0)
#define kHomeLOBFont MEDIUM(13.0)
#define kProductPhoneNoFont LIGHT(13.0)
#define kHomeAmountSecondFont LIGHT(12.0)

#define kHomeAmountSecondColor kCustomGreenColor

#define kVerticalTextSpacePercent 0.45
#define kHorizontalPaddingInAirtelButton 24.0

#define kHomeLineSpacing 4.0
#define kHomeListIconSize 64.0

#define kHomeCustomTileTitleFont REGULAR(13.0)
#define kHomeCustomTileDescFont LIGHT(15.0)

#define kPageIndicatorHeight 20.0
#define kTableViewFooterHeight 20.0

#define kIWantToToolBarFont REGULAR(17.0)

// All Pack Cell

#define kAllPackCellHeading MEDIUM(15.0)

// Page Header

#define kPageHeaderFont REGULAR(17.0)
#define kPageHeaderUnselectedColor GRAY(0.75)
#define kPageHeaderBarHeight 44.0

// LOB Padding

#define kTableViewSmallPadding 8.0
#define kTableViewMediumPadding 16.0
#define kTableViewLargePadding 24.0

// LOB bottom Bar

#define kLOBSeparatorMargin 20.0
#define kLOBBigContentWidth 280.0
#define kIWTTFWidth 240.0

#define kLOBBottomBarFont REGULAR(12.0)
#define kLOBBottomBarTextColor GRAY(0.4)
#define kLOBBottomBarHeight 80.0
#define kLOBBottomBarImageSize 48.0
#define kLOBBottomBarImageTextGap 2.0
#define kLOBNormalButtonColor GRAY(0.4)

#define kAccountTitleBarHeight 40.0

// My Bill

#define kMyBillHistoryItemPadding 8.0

#define kMainAmountFont MEDIUM(32.0)
#define kMainAmountMediumFont MEDIUM(22.0)
#define kMyBillNormalFont LIGHT(16.0)
#define kMyBillMediumFont LIGHT(25.0)

#define kMyBalanceTextFieldWidth 180.0

#define kMyBillFooterFont LIGHT(14.0)
#define kMyBillFooterNoteFont LIGHT(13.0)
#define kMyBillFooterDateFont MEDIUM(14.0)
#define kMyBillFooterTitleFont REGULAR(15.0)
#define kMyBillFooterAmountFont MEDIUM(18.0)

//Email Header

#define KEmailHeaderTextFont LIGHT(15.0)
#define KEmailIdTextFont REGULAR (15.0)

//My Data

#define kMyDataUnitFont MEDIUM(16.0)
#define kDeltaDataUnitFont BOLD(14.0)
#define kDeltaDataFont BOLD(25.0)

//My Bill Summary

#define kMyBilSummaryParaSpacing 8.0
#define kMyBillSummaryAmountFont MEDIUM(15.0)
#define kMyBillSummaryNormalFont LIGHT(14.0)

// Coupon

#define kCouponImageRatio 1.635
#define kCoupnWidth 0.4
#define kCouponMerchantNamePadding 4.0
#define kCouponPlusMinusPadding 10.0
#define kCouponMerchantFont REGULAR(14.0)
#define kCouponInfoFont LIGHT(14.0)
#define kCouonCellFooterHeight 24.0
#define kCouonQtyFont REGULAR(16.0)
#define kCouponsLineSpacing 8.0

#define kCouponMessageFont REGULAR(14.0)

// Credit Card details

#define kCreditCardTFHeight 32.0
#define kCardAreaLabelAndTextPadding 4.0
#define kCardAreaSidePadding 12.0
#define kCardAreaVerticalPadding 12.0

#define kCardVisaImageSize (CGSize) {34.0, 20.0}

#define kCardAreaLabelFont REGULAR(12.0)
#define kCardAreaMinWidth 288.0

#define kLoadMoneyInlineCVVHeight 44.0
#define kSaveCardTextImageGap 12.0

#define kBottomBarTitlePadding 2.0

// Side menu

//#define kMenuItemImageSize 40.0
#define kMenuItemImageSize 24.0

//#define kSideMenuWidth 240.0

#define kSideMenuWidth [UIScreen mainScreen].bounds.size.width * 0.72

#define kSideNotificationWidthRatio 0.8

#define kSwitchSize 80.0

#define kAdvanceServicePadding 40.0

#define kAccountsTitlePadding 25.0

#define kDefaultPadding 10.0
#define kSeperatorHeight 1.0 / [UIScreen mainScreen].scale
#define kTitleHeight 22.0
#define kRegistrationCellHeight 40.0
#define kAddCellHeight 50.0
#define kDefaultCellHeight 44.0
#define kMotionOffset 30.0
#define kWantToChoiceButtonSize 36.0

#define kHomeItemImageSize 25.0
#define kPageControlHeight 16.0

#define kHomeBarButtonTitleFont MEDIUM(16.0)
#define kHomeBarButtonSubTitleFont REGULAR(9.0)

#define kDimOutViewColor GRAYA(0.0, 0.7)

//Activity indicator view

#define kLoadingErrorCellHeight 88.0
#define kLoadingIndicatorPadding 12.0
#define kLoadingTextFont LIGHT(16.0)
#define kLoadingTextColor GRAY(0.6)

#define kLoadingCellHeight 88.0
#define kProgramCellHeight 80.0
#define kTimeLabelSize 70.0


#define kBalanceTextFont MEDIUM(20.0)
#define kBalanceArrowFont LIGHT(10.0)
#define kBalanceLabelFont REGULAR(13.0)

#define kButtonDisabledColor GRAY(0.7)

//Card Display

#define kMaxCVVCharacters 3
#define kExpireDateMaxCharacters 4
#define kMaxCardNoInOneField 4
#define kMaxCharactersForDebitCard 25 // Includes padding of 2 chars per set of 4
#define kMaxCharactersForCreditCard 22 // Includes padding of 2 chars per set of 4

#define kCardExpiryDateFormat @"MM/yy"
#define kYearOnlyFormat @"yyyy"
#define kMonthOnlyFormat @"MM"
#define kYearIntegerFormat @"yy"

#define kMaxCharactersForAMEXCardNumber 21
#define kMaxCharactersForMaestroCardNumber 26
#define kMaxCharactersForCVVAmEx 4

// Products Card

#define kProductsCardHeaderHeight 40
#define kProductsCardFooterHeight 44
#define kOperatorButtonHeight 40

// MPIN

#define kMpinCharacters 4

// Others

#define kRightButtonIcon @"❭"

// I want to

#define kFavDeleteIconSize 24.0

// MPIN Cell

#define kMpinTextFieldHeight 48.0

// Wallet Transaction History

#define kRecharge @"Recharge"
#define kBillPayments @"Bill Payments"
#define kUtilities @"Utilities"
#define kAccountsTypes @"All Accounts Types"


#define kWPPOSIXLocale  [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]
#define kWPIndianEnglishLocale  [NSLocale localeWithLocaleIdentifier:@"en_IN"]

#define kTHFetchDateFormat @"yyyyMMddHHmmss"

#define kInvoiceLabelRatio 0.30

#define kTransactionHistoryHeaderInternalPadding 8.0

#define kTransactionHistoryHeaderLightFont LIGHT(14.0)
#define kTransactionHistoryHeaderRegularFont REGULAR(13.0)
#define kTransactionHistoryHeaderLineSpacing 2.0

#define kTransactionHistoryDateTitleFont LIGHT(14.0)
#define kTransactionHistoryDateTextPadding 8.0

#define kTransactionHistoryCellSidePadding 10.0
#define kTransactionHistoryCellVerticalPadding 10.0

#define kTransactionHistorySectionHeaderCircleDim 24.0
//#define kTransactionHistorySectionHeaderLineWidth 1.0

#define kWindowInfoColor GRAY(0.4)
#define kWindowInfoFont LIGHT(13.0)

#define kInvoiceEmptyPadding 20.0;



// payment options cell

#define kPaymentTextfieldHeight 36.0
#define kLeftLabelFont LIGHT(15.0)


#define kContactsCellImgSize 52.0
#define kNotificationImageSize 52.0
#define kpinnedImageSizeWidth 24.0
#define kpinnedImageSizeHeight 36.0

#define kDropDownImageHeight 5
#define kDropDownImageWidth 9
#define kWalletRegistrationUserImage 96

// Wallet Splash Screen

#define kWalletSplashScreenImagePadding 40.0
#define kWalletAnimationDuration 1.0


#define kMinimumHeightOfProductCell 72.0
#define kWidthAddAccountProducts 110

// Mpin numpad

#define kLayoverNumPadColor GRAY(0.4)
#define kLayoverNumPadFont REGULAR(26.0)
#define kFSAmountPadMinPadHeight 202.0
#define kFSAmountPadDimension 48.0
#define kFSAmountPadTapColor GRAYA(0.0, 0.15)
#define kAmountPadPaddingBetweenButtons kTableViewMediumPadding
#define kAmountPadHeight (4 * kFSAmountPadDimension + 3 * kAmountPadPaddingBetweenButtons)

// Select Operators

#define kMainTableCellHeight 44.0

#define kRechargeBillerUnselectedFont LIGHT(16.0)
#define kRechargeBillerSelectedFont REGULAR(16.0)
#define kRechargeBillerCategoryDetailFont LIGHT(16.0)

#define kRechargeBillerUnselectedFontColor GRAY(0.4)
#define kRechargeBillerSelectedFontColor GRAY(0.1)

#define kRechargeBarHeight 44.0
#define kRechargeOptionsHeaderFont MEDIUM(13.0)
#define kRechargeOptionsUnderlineThickness 4.0
#define kRechargeOptionsUnderlineExtension 8.0


//Saved Cards

#define kCVVTextFieldWidth 130.0
#define kWalletDiscountParaSpacing 2.0
#define kAccessoryImageColor GRAY(0.7)
#define kSavedCardsImageSize 72.0

// split view controller

#define kSplitEvenlyFont REGULAR(13.0)
#define kHeaderAmountFont MEDIUM(26.0)
#define kMainBorderTransparentColor GRAYA(0.0, 0.25)
#define kContactsTextFieldColor GRAYA(0.9, 0.5)

// Mamo offer view

#define kMainTextButtonPadding 16.0
#define kMainTextButtonMinWidth 80.0
#define kMainTextButtonHeight 36.0

#define kMamoOfferTitleFont REGULAR(15.0)
#define kMamoOfferSubtitleFont LIGHT(15.0)

#define kMainSeparatorColor GRAY(0.8)
#define kMamoOfferViewBGColor GRAY(0.92)
#define kMamoOfferTitleColor GRAY(0.4)
#define kMamoOfferSubtitleFontColor GRAY(0.1)


// New Card

#define kSegmentControlSelectedColor [UIColor colorWithRed:255.0/255 green:70.0/255 blue:18.0/255 alpha:1]
#define kSegementControlTintColor GRAY(0.84)
#define kSegmentControlFont REGULAR(14.0)

#define kSegmemtControlFontColor GRAY(0.5)

// Custom Bank Button

#define kBankButtonImageTextPadding 6.0
#define kCellImageSize 52.0
#define kBankButtonTextColor GRAY(0.4)
#define kBankButtonTextFont LIGHT(13.0)

#define kTextViewInset 8.0

// p2p

#define kP2PTextViewHeight 80.0

#define kRadioButtonUnselectedColor GRAY(0.4)
#define kRadioButtonFont REGULAR(15.0)
#define kLayoverHeaderColor GRAY(0.4)

#define kAppCuesText REGULAR(17.0)

#define kTransactionHistoryDateTitleFont LIGHT(14.0)
#define kTransactionHistoryDateTextPadding 8.0


#define kTransactionHistorySectionHeaderCircleDim 24.0
#define kTransactionHistorySectionHeaderLineWidth 1/[[UIScreen mainScreen] scale]
#define kTransactionHistoryCellVerticalPadding 10.0

#define kAddNoteMaxCharLabelHeight 12.0

#define kTransactionBelowPadding 44.0

#define kNotificationSideLineWidth 4.0
#define kTransactionHistoryCellSidePadding 10.0
#define kTransctionHistoryCellExtraSpace 11
#define kContactCellImageTextPadding 12.0
#define kTextLineSpacing 4.0
#define kTextLineSpacingModified 2.0
#define kHomeCarViewActionButtonOffset -1.0
#define kTransactionHistoryCellDescriptionFont LIGHT(14.0)
#define kTransactionHistoryCellDescriptionSmallFont LIGHT(12.0)
#define kDateFontColor GRAY(0.7)

#define kRecentContactFont LIGHT(18.0)
#define kRecentContactRegularFont REGULAR(18.0)

// Wallet Notifications
#define kLoadingErrorCellHeight 88.0
#define kRadioButtonBarHeight 52.0
#define kAcknowledgmentLightColor GRAY(0.4)
#define kTransactionHistoryCellTitleAmountFont REGULAR(15.0)
#define kTransactionHistoryCellAmount REGULAR(18.0)
#define kInvoiceHeaderLabelFont REGULAR(17.0)
#define kAcknowledgmentDarkColor GRAY(0.1)
#define kTransactionHistoryCellTitleFont LIGHT(18.0)
#define kTransactionHistoryCellAmountModified LIGHT(15.0)
#define kWalletUserRegistrationHeading LIGHT(21.0)
#define kUnreadBlueColor RGBA(235.0, 248.0, 254.0, 1.0)
#define kGreenColor RGB(139.0, 195.0, 74.0)
#define kUnreadGreenColor RGBA(243.0, 249.0, 237.0, 1.0)

#define kAccountsButtonTableCellHeight 48.0
#define kAccountNormalFont LIGHT(14.0)
#define kAccountRegularFont REGULAR(14.0)
#define kAccountMediumFont MEDIUM(18.0)
#define kAlertViewHeight 30.0
#define kAccountsCardCellsSpace 10.0
#define kAccountsEmailCellHeight 30.0

#define kMainFloatingButtonFont REGULAR(14.0)

#define kAccountsTitleFont REGULAR(18.0)
#define kLastUpdatedFont LIGHT(10.0)

#define kAlertRedColor RGB(255.0, 0.0, 0.0)
#define kAccountSmallFont LIGHT(12.0)
#define kAccountSubtitleFont LIGHT(14.0)
#define kAccountBigFont REGULAR(24.0)

#define KManageServiceTitleFont MEDIUM(16.0)

#define kAcknowledgmentGeneralTextFont LIGHT(18.0)

#define kGenericAnimationDuration 0.3

#define kNavigationMiddleViewWidth 250.0


#endif /* MLStyle_h */
