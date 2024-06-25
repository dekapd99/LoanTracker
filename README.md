# LoanTracker
API Endpoint: [https://raw.githubusercontent.com/andreascandle/p2p_json_test/main/api/json/loans.json](https://raw.githubusercontent.com/andreascandle/p2p_json_test/main/api/json/loans.json)

Objective: Membuat aplikasi iOS yang memungkinkan pengguna untuk melihat dan mengelola detail pinjaman. Aplikasi tersebut harus mengambil data pinjaman dari API yang disediakan dan menampilkannya kepada pengguna dengan cara yang terorganisir.

## Preview
<p align="center">
  <a href="#" target="_blank"><img src="1.gif" width="200"></a>
</p>

## Main Feature

* Sorting by Name, Risk Rating, Term (Ascending & Descending)
* Searching by Name
* Terdiri dari 2 Halaman: Home dan Detail
* Async / Await API Integration Handler
* MVVM Architecture
* SwiftUI as Interface Builder
* Displaying Documents / Image

## Build With:

* [Swift](https://www.swift.org/documentation/)
* [SwiftUI](https://developer.apple.com/documentation/swiftui/)
* [Xcode 15.4](https://developer.apple.com/xcode/)
* [iOS Simulator 17.0](https://developer.apple.com/xcode/)
* [iPhone 15](https://developer.apple.com/xcode/)

## Spesifikasi
* Minimum Target iOS: iOS 13.0
* Maximum Target iOS (Recommended): iOS 17.0
* XCode Version: 15.4
* Aplikasi tidak bisa dijalankan di iOS 12.0 dan Versi Lawas lainnya karena Interface Builder menggunakan SwiftUI.

<!-- How to Install -->
## Installation
Untuk menggunakan repositori ini, ikutilah petunjuk penggunaan berikut dan pastikan git sudah terinstall pada komputer (semua perintah dilaksanakan pada `cmd.exe` atau `terminal`):

1. Lakukan download .zip atau `clone` repositori dengan cara:
```bash
git clone https://github.com/dekapd99/LoanTracker.git
```

2. Jika sudah selesai melakukan Clone Repository silahkan buka Project di Xcode atau jika mendownload .zip file maka buka File LoanTracker.xcodeproj.
3. Pastikan untuk memilih iPhone pada Target Simulator (Kolom Device dibagian atas Xcode) dengan spesifikasi Minimum Target iOS = 13.0 dan Maximum Target iOS (Recommended) = 17.0. 
4. Build & Run (CMD + R).

## Simulation & Approach
1. Fetching Loan Data from Provided API and Display the Information from API in a Custom Card. 


2. Display Detail Information in a Custom Card


3. Adding Search Feature


4. Adding Sort Feature
