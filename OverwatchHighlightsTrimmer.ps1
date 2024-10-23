# Set the working directory to the script's location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptDir

# Define output directory and merged video path
$outputDir = "$scriptDir\CroppedVideos"
$finalOutput = "$scriptDir\merged_highlights.mp4"

# Define the intro and ending durations to crop (in seconds)
$introDuration = 4        # Adjust as needed
$endingDuration = 8       # Adjust as needed

# Create output directory if it doesn't exist
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir
}

# Temporary text file to list cropped videos for merging
$mergeList = "$outputDir\merge_list.txt"
if (Test-Path $mergeList) { Remove-Item $mergeList }

# Loop through all video files in the same directory as the script
Get-ChildItem -Path $scriptDir -Filter "*.mp4" | ForEach-Object {
    $inputFile = $_.FullName
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($_)
    $outputFile = "$outputDir\$filename-cropped.mp4"

    # Get the duration of the video using ffprobe
    $duration = & ffprobe -v error -show_entries format=duration `
        -of default=noprint_wrappers=1:nokey=1 "$inputFile"
    $duration = [math]::Round([double]$duration)

    # Calculate the duration of the cropped segment
    $newDuration = $duration - $introDuration - $endingDuration

    # Ensure the new duration is valid (greater than 0)
    if ($newDuration -gt 0) {
        # Crop the intro and ending, and save to the output file
        & ffmpeg -y -i "$inputFile" -ss $introDuration -t $newDuration `
            -c copy "$outputFile"

        # Add the cropped video to the merge list
        Add-Content $mergeList "file '$outputFile'"
    } else {
        Write-Host "Skipping $filename.mp4 - too short to crop."
    }
}

# Merge all cropped videos into one
if (Test-Path $mergeList) {
    & ffmpeg -y -f concat -safe 0 -i $mergeList -c copy "$finalOutput"
    Write-Host "All videos merged into: $finalOutput"
} else {
    Write-Host "No valid videos to merge."
}

# Clean up temporary files
Remove-Item $mergeList -ErrorAction SilentlyContinue
