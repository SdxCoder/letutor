# Scola Tutoring App

![Current app state](scola.gif)

## To run

1. Add Google.infolist file from firebase // iOS
2. Add google-services.json file from firebase // Android

## 1st Stage

User Functionality:
- Login (Facebook, Google, Apple[mandatory] for iOS?)
- Track his tutoring bookings
- Search for tutors
- Book lessons

Tutor Functionality
- Track his tutoring lessons
- Add his availability
- Track his earnings

Admin Functionality
- Search tutor by email 
* Edit tutor profile (courses and academic level)
* See tutor availability
- Confirm Bookings: Initially bookings will be created on `unconfirmed`. When payments is made (off app) then the admin will confirm the booking. This will consist only in a button on the booking screen.

Push Notifications:
- To admin on new booking.
- To tutor when booking is confirmed.
- To user 15min before booking.

Web:
- Launch beta flutter web.

## 2nd Stage
User Functionality:
- Group tutorings: add up to 10 people into a tutoring. Discount applied.
- Payments: Local payment providers.

## 3rd Stage
User Functionality:
- Apply discount
* Gamification: collect `Scola Coins` on each booking and redeem those coins.
- WebRTC backend to allow video calls within app.

