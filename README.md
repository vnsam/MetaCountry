# MetaCountry
DEMO CODE

**How to run the project:**

Just open the `MetaCountry.xcworkspace` file.

**Architecture followed:**

MVVM

**Firebase Configuration:**

0.	Created an iOS project in FBase.
1.	Confgiured `no-authentication` - read-only access to database.
2.	Added `.indexOn` rule for property - `countryCode`.
3.	Attached FBase JSON template for reference.
4.	Also attached FBase rule for DB access.

**iOS Project Configuration: [MetaCountry]**

0.	Included Pods directly in the project repo. So we can just pull and build the code.
	[Personal Opinion: Only commit Podfile and Podfile.lock - Let individual devs do a pod install]

1.	All the datasource, delegate conforming parts of code are part of a single class in itself.
	[Opinion: I've seen some devs seperating Delegate, Datasource conforming functions to a seprate UIViewController extension - which IMO is abusing the purpose and power of extensions. I did not do it in this project]

2.	When building paginating JSON objects, I'd expect to see a END OF RESULTS key somewhere in my JSON. I'd use this key to 	stop requesting pages when reached the end of results. It's not configured in the current project JSON. Now, my EOR - 		relies on last row of country - using it's country code. ZW is the last code in the results.

3.	For constants used in only one place, I moved them into private `let` constant properties.

4.	Added comments whereever necessary to explain my thought process and what led me to a particular decision on code.

5.	Added tests for backing view model.

6.	Used .xib files for re-usability of views, cells.

**Approach:**
0.	Tilt the collection view and related views up-side down

Why this approach?
So that I don't have mess around with my datasource array. This'd enable to keep a CLEAN COPY of my datasource array at any given time. (no reversing array tricks...)

**What's not working?**
0.	FBase - `.indexOn` - rule is not working. Trying to figure it out.
	Currently FBase is dowloading all cursors and applying filter on the client.

**App Trivia:**
0.	I named this app - `MetaCountry` - since the data objects contain any nation's meta information like - countryCode, 		currencyCode.
