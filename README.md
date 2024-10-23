Here’s the updated `README.md` with the repository link:

---

# **Overwatch Highlights Trimmer 🕹️**

This repository contains a PowerShell script that automates the process of cropping and merging Overwatch highlight videos using `FFmpeg`. The script removes the intro and ending from each highlight and combines all the cropped clips into a single video.

---

## **Prerequisites**

1. **FFmpeg**  
   - Download and install FFmpeg from [https://ffmpeg.org/download.html](https://ffmpeg.org/download.html).
   - Make sure FFmpeg is added to your system's PATH so it can be called from the command line.

2. **PowerShell**  
   - Ensure you are using PowerShell (available on Windows by default).  
   - If on a Unix-based system, you can use [PowerShell Core](https://github.com/PowerShell/PowerShell).

---

## **How to Use**

1. **Clone the repository** and navigate into the folder:
   ```bash
   git clone https://github.com/KevinFromUpThere/OverwatchHighlightsTrimmer.git
   cd OverwatchHighlightsTrimmer
   ```

2. **Place your Overwatch highlight videos** (`.mp4` format) in the same directory as the script.

3. **Run the script** using PowerShell:
   ```powershell
   .\process_highlights.ps1
   ```

4. **Output:**
   - The cropped videos will be saved in a `CroppedVideos` folder.
   - The merged video will be created as `merged_highlights.mp4` in the root folder.

---

## **Script Logic**

- **Input:** All `.mp4` files in the same directory as the script.
- **Cropping:** Trims an intro and ending of customizable lengths (default: 3s intro, 5s ending).
- **Merging:** Combines all valid cropped videos into a single file.
- **Skip Handling:** Videos shorter than the sum of the intro and ending durations are skipped to avoid errors.

---

## **Customization**

You can modify these parameters in the script:
- **`$introDuration`** – Duration to trim from the beginning of each video.
- **`$endingDuration`** – Duration to trim from the end of each video.

---

## **Troubleshooting**

- **FFmpeg not recognized:**  
  Ensure FFmpeg is installed and added to your system’s PATH.

- **Video too short:**  
  If a video is skipped, it’s likely too short to be cropped by the specified durations. Adjust the `introDuration` and `endingDuration` in the script if needed.

---

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## **Contributions**

Contributions, issues, and feature requests are welcome! Please open an issue or submit a pull request.

---
