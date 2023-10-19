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

- (void)test_defaultComparator_comparatorIsAccessibleFromObjC
{
    // Arrange & Act
    SUStandardVersionComparator *comparator = [SUStandardVersionComparator defaultComparator];

    // Assert
    XCTAssertNotNil(comparator);
}

@end
