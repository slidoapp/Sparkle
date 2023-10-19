//
//  SparkleTestsObjc.m
//  SparkleTestsObjc
//
//  Created by Jozef Izso on 19.10.2023.
//  Copyright © 2023 Sparkle Project. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Sparkle/Sparkle-Swift.h"

@interface SUStandardVersionComparatorTestCase : XCTestCase {
}
@end

@implementation SUStandardVersionComparatorTestCase

- (void)test_init_standardComparatorCanBeInitialized
{
    // Arrange & Act
    SUStandardVersionComparator *comparator = [[SUStandardVersionComparator alloc] init];

    // Assert
    XCTAssertNotNil(comparator);
}

- (void)test_defaultComparator_comparatorIsAccessibleFromObjC
{
    // Arrange & Act
    SUStandardVersionComparator *comparator = [SUStandardVersionComparator defaultComparator];

    // Assert
    XCTAssertNotNil(comparator);
}


- (void)test_compareVersion_sameNumericVersionsAreEqual
{
    SUStandardVersionComparator *comparator = [[SUStandardVersionComparator alloc] init];
    
    // Act
    NSComparisonResult actualResult = [comparator compareVersion:@"1.0" toVersion:@"1.0"];
    
    // Assert
    XCTAssertEqual(actualResult, NSOrderedSame);
}


@end
