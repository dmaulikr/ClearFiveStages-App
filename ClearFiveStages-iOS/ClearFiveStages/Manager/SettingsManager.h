//
//  SettingsManager.h
//
//  mike ironapegames.com
//
/*
* 
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

#import <Foundation/Foundation.h>

@interface SettingsManager : NSObject {
	NSMutableDictionary* settings;
    NSMutableDictionary* objectData;
}

-(NSString *) getString:(NSString*)keyString;
-(int) getInt:(NSString*)keyString;
-(float) getFloat:(NSString*)keyString;
-(double) getDouble:(NSString*)keyString;
-(CGPoint) getCGPoint:(NSString*)keyString;
-(bool) getBool:(NSString*)keyString;
-(CGSize) getCGSize:(NSString*)keyString;
-(CGRect) getCGRect:(NSString*)keyString;
-(id) getObject:(NSString*)keyString;

-(void) setString:(NSString*)value keyString:(NSString *)keyString;
-(void) setInteger:(int)value keyString:(NSString*)keyString;
-(void) setFloat:(float)value keyString:(NSString*)keyString;
-(void) setDouble:(double)value keyString:(NSString*)keyString;
-(void) setCGPoint:(CGPoint)value keyString:(NSString*)keyString;
-(void) setBool:(bool)value keyString:(NSString*)keyString;
-(void) setCGSize:(CGSize)value keyString:(NSString*)keyString;
-(void) setCGRect:(CGRect)value keyString:(NSString*)keyString;
-(void) setObject:(id)value keyString:(NSString*)keyString;

-(void) saveToNSUserDefaults:(NSString*)appName;
-(void) loadFromNSUserDefaults:(NSString*)appName;
-(void) saveToFile:(NSString*) fileName;
-(void) saveToDataFile:(NSString*) fileName;
-(void) loadFromFile:(NSString*) fileName;
-(void) loadDataFromFile:(NSString*) fileName;

// --Added-- in IOS 5 its reported that users will now have direct access to the Documents directory
// So they can delete or change your settings, But can't access files in library folder
// Its recommended to use loadFromFileInLibraryDirectory and saveToFileInLibraryDirectory if 
// you don't want the user accessing your settings
-(void) loadFromFileInLibraryDirectory:(NSString*) fileName;
-(void) saveToFileInLibraryDirectory:(NSString*) fileName;

-(void) logSettings;
-(void) logData;
-(void) purgeSettings;

+(SettingsManager*)sharedSettingsManager;

@end
