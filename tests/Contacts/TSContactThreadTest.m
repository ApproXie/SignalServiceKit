//  Created by Michael Kirk on 11/7/16.
//  Copyright © 2016 Open Whisper Systems. All rights reserved.

#import "TSContactThread.h"
#import "TSStorageManager+identityKeyStore.h"
#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSContactThreadTest : XCTestCase

@property (nonatomic) TSContactThread *contactThread;

@end

@implementation TSContactThreadTest

- (void)setUp
{
    self.contactThread = [TSContactThread getOrCreateThreadWithContactId:@"fake-contact-id"];
    [self.contactThread.storageManager removeIdentityKeyForRecipient:self.contactThread.contactIdentifier];
}

- (void)testHasSafetyNumbersWithoutRemoteIdentity
{
    XCTAssertFalse(self.contactThread.hasSafetyNumbers);
}

- (void)testHasSafetyNumbersWithRemoteIdentity
{
    [self.contactThread.storageManager saveRemoteIdentity:[NSData new]
                                              recipientId:self.contactThread.contactIdentifier];
    XCTAssert(self.contactThread.hasSafetyNumbers);
}

@end

NS_ASSUME_NONNULL_END
