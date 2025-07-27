#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/objdetect/objdetect.hpp"
#include <opencv2/dnn.hpp>
#include <filesystem>
#include <iostream>

using namespace cv;
using namespace cv::dnn;
using namespace std;

static
void visualize(Mat& input, Mat& faces, const vector<string>& genders, const vector<string>& ages, int thickness = 2)
{
    Scalar color = Scalar(255, 0, 0);
    for (int i = 0; i < faces.rows; i++)
    {
        // rectangle coordinates of the face: [x, y, w, h]
        Rect faceRect(int(faces.at<float>(i, 0)), int(faces.at<float>(i, 1)), int(faces.at<float>(i, 2)), int(faces.at<float>(i, 3)));
        rectangle(input, faceRect, color, thickness);

        // label (gender + age)
        string label = genders[i] + ", " + ages[i];
        
        // write the label above the rectangle
        putText(input, label, Point(faceRect.x, faceRect.y - 7), FONT_HERSHEY_SIMPLEX, 0.5, Scalar(0, 255, 0), 2);
    }
}

int main(int argc, const char* argv[]) {

    CommandLineParser parser(argc, argv,
        "{help h             |            | Print this message}"
        "{image1 i1          | images/4_male.jpg  | Path to the input image}"
        "{fd_model fd        | models/face_detection_yunet_2023mar.onnx | Path to face detection model}"
        "{age_model am       | models/age_net.caffemodel   | Path to age model}"
        "{age_proto ap       | models/age_deploy.prototxt  | Path to age prototxt}"
        "{gender_model gm    | models/gender_net.caffemodel| Path to gender model}"
        "{gender_proto gp    | models/gender_deploy.prototxt| Path to gender prototxt}"
        "{scale sc           | 1.0        | Scale factor to resize input}"
    );

    // set paths from the parser
    String fd_modelPath = parser.get<String>("fd_model");
    String age_modelPath = parser.get<String>("age_model");
    String age_protoPath = parser.get<String>("age_proto");
    String gender_modelPath = parser.get<String>("gender_model");
    String gender_protoPath = parser.get<String>("gender_proto");

    String inputImagePath = parser.get<String>("image1");
    float scale = parser.get<float>("scale");

    // load face detector model                                             //image size, minimum score accepted                                    
    Ptr<FaceDetectorYN> detector = FaceDetectorYN::create(fd_modelPath, "", Size(320, 320), 0.9, 0.3, 5000);

    // load age & gender networks
    Net ageNet = readNetFromCaffe(age_protoPath, age_modelPath);
    Net genderNet = readNetFromCaffe(gender_protoPath, gender_modelPath);

    // age & gender values
    vector<string> ageList = { "(0-2)", "(4-6)", "(8-12)", "(15-20)", "(25-32)", "(38-43)", "(48-53)", "(60-100)" };
    vector<string> genderList = { "Male", "Female" };

    // read input image 
    Mat image = imread(samples::findFile(inputImagePath));
    if (image.empty()) {
        cerr << "Cannot read image: " << inputImagePath << endl;
        return -1;
    }

    // resize input image 
    int imageWidth = int(image.cols * scale);
    int imageHeight = int(image.rows * scale);
    resize(image, image, Size(imageWidth, imageHeight));

    detector->setInputSize(image.size());

    // detect faces from input image
    Mat faces;
    detector->detect(image, faces);

    if (faces.rows < 1) {
        cerr << "No faces found in image" << endl;
        return -1;
    }

    vector<string> detectedGenders, detectedAges;

    for (int i = 0; i < faces.rows; i++) {
        // get face rectangle coordinates
        int x = int(faces.at<float>(i, 0));
        int y = int(faces.at<float>(i, 1));
        int w = int(faces.at<float>(i, 2));
        int h = int(faces.at<float>(i, 3));

        // create rectangle from coordinates
        Rect faceRect(x, y, w, h);
        
        // crop the face
        Mat face = image(faceRect);

        // convert face into blob for DNN                            mean BGR = normalization
        Mat blob = blobFromImage(face, 1.0, Size(227, 227), Scalar(78.4263377603, 87.7689143744, 114.895847746), false);

        // predict gender
        genderNet.setInput(blob);  // give the blob to gender net  
        Mat genderPreds = genderNet.forward();   // run the net
        float* genderData = (float*)genderPreds.data;  // get the prediction scores
        //get the max index of the best prediction score
        int maxIndexGender = std::distance(genderData, std::max_element(genderData, genderData + genderPreds.total()));
        string gender = genderList[maxIndexGender];   //get the gender label
        detectedGenders.push_back(gender);

        // predict age
        ageNet.setInput(blob);
        Mat agePreds = ageNet.forward();
        float* ageData = (float*)agePreds.data;
        int maxIndexAge = std::distance(ageData, std::max_element(ageData, ageData + agePreds.total()));
        string age = ageList[maxIndexAge];
        detectedAges.push_back(age);

    }

    visualize(image, faces, detectedGenders, detectedAges);

    // save output image
    string outputFile = "recognised_" + inputImagePath;
    imwrite(outputFile, image);

    imshow("Age & Gender Estimation", image);
    waitKey(0);

    return 0;
}