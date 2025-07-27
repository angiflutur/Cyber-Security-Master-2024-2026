import org.opencv.core.*;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.objdetect.CascadeClassifier;

import java.util.HashMap;
import java.util.Map;

class DetectFaces {
    public static void detect() {
        System.out.println("\n----- Running DetectFacesOpenCV -----\n");

        Mat imageFace = Imgcodecs.imread("face.jpg");
        Mat imageBody = Imgcodecs.imread("body3.jpg");

        if (imageFace.empty() || imageBody.empty()) {
            System.out.println("Error loading image(s).");
            System.exit(1);
        }

        Map<String, String> cascadeMapFace = new HashMap<>();
        cascadeMapFace.put("Frontal Face", "haarcascade_frontalface_default.xml");
        cascadeMapFace.put("Profile Face", "haarcascade_profileface.xml");
        cascadeMapFace.put("Eye", "haarcascade_eye.xml");
        cascadeMapFace.put("Eye Glasses", "haarcascade_eye_tree_eyeglasses.xml");
        cascadeMapFace.put("Right Eye", "haarcascade_righteye_2splits.xml");
        cascadeMapFace.put("Left Eye", "haarcascade_lefteye_2splits.xml");
        cascadeMapFace.put("Nose", "nose.xml");
        cascadeMapFace.put("Mouth", "mouth.xml");
        cascadeMapFace.put("Smile", "haarcascade_smile.xml");
        cascadeMapFace.put("Right Ear", "right_ear.xml");
        cascadeMapFace.put("Left Ear", "left_ear.xml");

        Map<String, String> cascadeMapBody = new HashMap<>();
        cascadeMapBody.put("Full Body", "haarcascade_fullbody.xml");
        cascadeMapBody.put("Upper Body", "haarcascade_upperbody.xml");
        cascadeMapBody.put("Lower Body", "haarcascade_lowerbody.xml");
        cascadeMapBody.put("Palm", "palm.xml");

        int totalDetectedParts = 0;

        // ---------- Detect on face image ----------
        for (Map.Entry<String, String> entry : cascadeMapFace.entrySet()) {
            String label = entry.getKey();
            String cascadeFile = entry.getValue();

            CascadeClassifier cascade = new CascadeClassifier(cascadeFile);
            if (cascade.empty()) {
                System.out.println("Error loading cascade: " + cascadeFile);
                continue;
            }

            MatOfRect detections = new MatOfRect();
            cascade.detectMultiScale(imageFace, detections);
            Rect[] rects = detections.toArray();
            System.out.println("Detected " + label + " (face): " + rects.length);

            if (rects.length != 0) {
                totalDetectedParts++;
                Rect bestRect = getLargest(rects);

                Imgproc.rectangle(imageFace, new Point(bestRect.x, bestRect.y),
                        new Point(bestRect.x + bestRect.width, bestRect.y + bestRect.height),
                        new Scalar(0, 255, 0), 2);
                Imgproc.putText(imageFace, label, new Point(bestRect.x, bestRect.y - 5),
                        Imgproc.FONT_HERSHEY_SIMPLEX, 0.5, new Scalar(0, 255, 0), 1);
            }
        }

        // ---------- Detect on body image ----------
        for (Map.Entry<String, String> entry : cascadeMapBody.entrySet()) {
            String label = entry.getKey();
            String cascadeFile = entry.getValue();

            CascadeClassifier cascade = new CascadeClassifier(cascadeFile);
            if (cascade.empty()) {
                System.out.println("Error loading cascade: " + cascadeFile);
                continue;
            }

            MatOfRect detections = new MatOfRect();
            cascade.detectMultiScale(imageBody, detections);
            Rect[] rects = detections.toArray();
            System.out.println("Detected " + label + " (body): " + rects.length);

            if (rects.length != 0) {
                totalDetectedParts++;
                Rect bestRect = getLargest(rects);

                Imgproc.rectangle(imageBody, new Point(bestRect.x, bestRect.y),
                        new Point(bestRect.x + bestRect.width, bestRect.y + bestRect.height),
                        new Scalar(255, 0, 0), 2);
                Imgproc.putText(imageBody, label, new Point(bestRect.x, bestRect.y - 5),
                        Imgproc.FONT_HERSHEY_SIMPLEX, 0.5, new Scalar(255, 0, 0), 1);
            }
        }

        System.out.println("Total parts detected: " + totalDetectedParts);
        Imgcodecs.imwrite("detected_face.jpg", imageFace);
        Imgcodecs.imwrite("detected_body.jpg", imageBody);
    }

    private static Rect getLargest(Rect[] rects) {
        Rect best = rects[0];
        double maxArea = best.area();
        for (int i = 1; i < rects.length; i++) {
            double area = rects[i].area();
            if (area > maxArea) {
                best = rects[i];
                maxArea = area;
            }
        }
        return best;
    }
}

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, OpenCV!");

        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        DetectFaces.detect();
        System.out.println("Terminat; ies explicit.");
        System.exit(0);

    }
}