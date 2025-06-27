# eKYC Example Project

## Overview
A brief introduction to the project:
- This example app demonstrates how to integrate **IDLiveFaceCaptureIAD** and **IDLiveDocCaptureIAD** capture libraries.
- It shows how to make a network request to the eKYC REST API.
- [MainViewController](./eKYCExample/MainViewController.swift) handles the UI logic, while [EnrollmentNetworkService](./eKYCExample/Network/EKYCNetworkService.swift) manages network calls.

---

## Prerequisites
- **Xcode 14 or later** (iOS 15+ for async/await).
- **Swift 5.5+**.

---

## Obtaining Libraries & Licenses

1. **IDLiveFaceCaptureIAD** and **IDLiveDocCaptureIAD** Libraries  
   - Download them from [our developer portal](https://dev.idrnd.net/products/EKYC/extra-files). Specifically, you’ll need:
     - **`idlive-face-capture-ios-VERSION_NUMBER.tar.gz`** – iOS IDLiveFaceCaptureIAD  
     - **`iad-doc-capture-ios-VERSION_NUMBER.zip`** – iOS IDLiveDocCaptureIAD  
   - After extracting these `.tar` files, place the resulting `.xcframework` folders into the `Frameworks` folder of this Xcode project.

2. **Licenses**  
   - The same [portal page](https://dev.idrnd.net/products/EKYC/extra-files) also provides licenses for the detectors:
     - **`idlive-face-detector-eval-license-yyyy-mm-dd.zip`** – License for Face Detector `IDLiveFaceDetection`
     - **`idlive-document-detector-eval-license-yyyy-mm-dd.zip`** – License for Document Detector `DocSdkMobile`
   - Each library requires a valid license key.
   - Make sure to set the corresponding keys in [AppDelegate](./eKYCExample/AppDelegate.swift).
   
> **Note on Shared Libraries**: When downloading both the Face and Document libraries, you may find some frameworks appear in **both** archives.
The **final list** of libraries you need in your `Frameworks` folder is:
> - `IDLiveFaceCaptureIAD.xcframework`
> - `IDLiveDocCaptureIAD.xcframework`
> - `CaptureCommon.xcframework`
> - `IADCommon.xcframework`
> - `IDLiveFaceDetection.xcframework`
> - `DocSdkMobile.xcframework`
>
> After copying these six `.xcframework`s into your project, you’ll have everything needed for both Face and Document capture.

---

## Obtaining an API Key
- Sign in to [ID R&D’s Customer Portal](https://dev.idrnd.net/products/EKYC/cloud) to obtain your **API key**.
- Replace the placeholder (`YOUR_API_KEY_HERE`) in [MainViewController.swift](./eKYCExample/MainViewController.swift) with your actual key.

---

## Embedding Libraries in Xcode

### Option A: Quick Copy-Paste for the Example Project

If you just want to **run this example** as-is, do the following:

1. **Locate the frameworks** you received or downloaded:

   - `IDLiveFaceCaptureIAD.xcframework`
   - `IDLiveDocCaptureIAD.xcframework`
   - `CaptureCommon.xcframework`
   - `IADCommon.xcframework`
   - `IDLiveFaceDetection.xcframework`
   - `DocSdkMobile.xcframework`   
   
2. **Copy/Paste** all of these **`.xcframework`** files into the **`Frameworks/`** folder in this Xcode project.
3. **Open** the project in Xcode. You should see the frameworks listed under **Project Navigator** → **eKYCExample Target** → **Frameworks**.
4. **Build & Run**. Xcode should automatically link these frameworks if the project is set up accordingly.

> **Note**: This approach is the fastest way to get the example app up and running. However, if you’re integrating these libraries into **another** app, follow **Option B** below.

### Option B: Manual Embedding into Your Own Xcode Project

If you need to integrate these frameworks into an **existing** or **new** Xcode project:

1. **Drag & Drop the Frameworks**  
   - In Xcode’s **Project Navigator**, **right-click** on your project or a “Frameworks” group.  
   - Select **Add Files to YourProjectName…**.  
   - Choose the **`.xcframework`** files:
       - `IDLiveFaceCaptureIAD.xcframework`
       - `IDLiveDocCaptureIAD.xcframework`
       - `CaptureCommon.xcframework`
       - `IADCommon.xcframework`
       - `IDLiveFaceDetection.xcframework`
       - `DocSdkMobile.xcframework`
   - Make sure **“Copy items if needed”** is checked if the frameworks are outside your project folder.  
   - Click **Add**.

2. **Link & Embed**  
   - Go to **Target** → **General** tab.  
   - In **“Frameworks, Libraries, and Embedded Content”**, click **“+”** to add each framework if it isn’t already listed.  
   - Make sure **“Embed & Sign”** is selected.

3. **Build & Run**  
   - Clean and build your project (**Cmd+Shift+K**, then **Cmd+B**).  
   - If everything is configured correctly, Xcode will link and embed the frameworks in your app’s bundle.

---

## Build & Run Instructions

1. **Open the Project in Xcode**  
   - iOS 15+, Xcode 14 or later
   
2. **Connect a Physical iOS Device**  
   - This example app uses the device camera for face/document capture.  
   - The simulator does **not** provide a camera, so the main capture flow will not work on a simulator.

3. **Build & Run**  
   - Press **Cmd+R** or go to **Product > Run**.

---

## Support
For issues or questions:
- Check our [Developer Portal](https://dev.idrnd.net).
- Or [contact us](https://www.idrnd.ai/contact-us/).

---

## License
This example project is distributed under the **MIT License**.  
See [LICENSE.md](./LICENSE.md) for details.
