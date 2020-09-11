#!/bin/bash
#
# Run tests in this directory.
#

if [ "$SYNC_FINISHED" != true ]; then
  if [ -z "$ANDROID_BUILD_TOP" ]; then
      echo "Android build environment not set"
      exit -1
  fi

  # ensure we have mm
  . $ANDROID_BUILD_TOP/build/envsetup.sh

  mm

  echo "waiting for device"

  adb root && adb wait-for-device remount && adb sync
fi

# Push the files onto the device.
. $ANDROID_BUILD_TOP/frameworks/av/media/libmediatranscoding/tests/assets/push_assets.sh

echo "========================================"

echo "testing MediaSampleReaderNDK"
adb shell /data/nativetest64/MediaSampleReaderNDKTests/MediaSampleReaderNDKTests

echo "testing MediaSampleQueue"
adb shell /data/nativetest64/MediaSampleQueueTests/MediaSampleQueueTests

echo "testing MediaTrackTranscoder"
adb shell /data/nativetest64/MediaTrackTranscoderTests/MediaTrackTranscoderTests

echo "testing VideoTrackTranscoder"
adb shell /data/nativetest64/VideoTrackTranscoderTests/VideoTrackTranscoderTests

echo "testing PassthroughTrackTranscoder"
adb shell /data/nativetest64/PassthroughTrackTranscoderTests/PassthroughTrackTranscoderTests

echo "testing MediaSampleWriter"
adb shell /data/nativetest64/MediaSampleWriterTests/MediaSampleWriterTests

echo "testing MediaTranscoder"
adb shell /data/nativetest64/MediaTranscoderTests/MediaTranscoderTests