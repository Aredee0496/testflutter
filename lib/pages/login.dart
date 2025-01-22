import 'package:flutter/material.dart';
import 'package:starlightserviceapp/helper/dialog-helper.dart';
import 'package:starlightserviceapp/config/env.dart';
import 'package:starlightserviceapp/models/family/auth-model.dart';
import 'package:starlightserviceapp/pages/plant.dart';
import 'package:starlightserviceapp/services/family-service.dart';
import 'package:starlightserviceapp/services/storage-service.dart';
import 'package:starlightserviceapp/utils/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  FamilyService familyService = FamilyService();
  StorageApp storageApp = StorageApp();
  late final WebViewController controller;
  late final PlatformWebViewControllerCreationParams params;
  int progress = 0;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int _progress) {
            // Update loading bar.
            print("WebView is loading (progress : $_progress%)");
            setState(() {
              progress = _progress;
            });
          },
          onPageStarted: (String url) {
            print("onPageStarted : $url");
            setState(() {
              progress = 0;
              isLogin = true;
            });
          },
          onPageFinished: (String url) {
            print("onPageFinished : $url");
            setState(() {
              isLogin = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print("onWebResourceError : ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.startsWith(CALLBACK_OAUTH)) {
              print(request.url);

              await getResponeAuth(request.url);
              setState(() {
                isLogin = true;
              });
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.https(URL_OAUTH, '', {
        'localtoken': TOKEN_OAUTH,
      }));

    super.initState();
  }

  getResponeAuth(String url) async {
    DialogHelper.showLoading(context);
    final parsedUrl = Uri.parse(url);
    final token = parsedUrl.queryParameters["token"] ?? "";
    final acctoken = parsedUrl.queryParameters["acctoken"] ?? "";
    if (token != "" && acctoken != "") {
      try {
        final response =
            await familyService.loginMobile(context, token, acctoken);
        if (response.result == "success") {
          Role checkRole = await storageApp.getRole();
          print("checkRole $checkRole");
          if (checkRole.plantCode!.length > 1) {
            DialogHelper.hideLoading(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const PlantPage()),
                (route) => false);
          } else {
            DialogHelper.hideLoading(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/', (Route<dynamic> route) => false);
          }
        } else {
          DialogHelper.hideLoading(context);
          DialogHelper.showErrorMessageDialog(context, response.message);
          setState(() {
            isLogin = true;
            isLogin = false;
            // controller = controller;
          });
        }
      } catch (e) {
        DialogHelper.hideLoading(context);
        DialogHelper.showErrorMessageDialog(context, "$e");
        setState(() {
          isLogin = true;
          isLogin = false;
          // controller = controller;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: HexColor("#9F74DC"),
        centerTitle: true,
      ),
      body: isLogin
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                Text("WebView is loading (progress : $progress%)")
              ],
            ))
          : WebViewWidget(controller: controller),
    );
  }
}
