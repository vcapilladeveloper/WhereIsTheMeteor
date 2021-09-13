# Welcome to WhereIsTheMeteor!

I have tried to comply as much as possible with the specifications of the document in the shortest possible time. I'm not really happy with the test, it have many missing things.

## Basic definition

All the code inside this project is make it by me, without using external libraries.

- For persistent data I used CoreData.
- The Arq Patter that I used is MVVM-C. Form the Clean I only use the repository layer.
- For the map I use the native MapKit.
- In the BuildSettings I create 2 User-Defined settings, one for the App Token and the other for the base URL.

### First View
- This view have a button for show a Picker with Year selector. When you turn the wheel and this stops, on click the X button, the data is refreshed.
- Bottom this, I put a SegmentedControl for the Filters, It's filters the actual data without request another time.
- The Table View have a custom UITableViewCell and, for refesh the information, the user must make Pull-to-refresh on the tableView.
- The cell have a button with an image of a star, that is used for check or uncheck the element like a favorite. When you click to make a new favorite, is saved on the CoreData layer.

# Missing Things
- More Tests.
- More documentation.
