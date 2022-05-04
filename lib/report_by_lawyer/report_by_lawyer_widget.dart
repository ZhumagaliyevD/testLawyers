import '../auth/auth_util.dart';
import '../backend/firebase_storage/storage.dart';
import '../backend/push_notifications/push_notifications_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportByLawyerWidget extends StatefulWidget {
  const ReportByLawyerWidget({Key key}) : super(key: key);

  @override
  _ReportByLawyerWidgetState createState() => _ReportByLawyerWidgetState();
}

class _ReportByLawyerWidgetState extends State<ReportByLawyerWidget> {
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ReportByLawyer'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryColor,
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
        title: Text(
          'Report',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Cairo',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22,
              ),
        ),
        actions: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
              child: FaIcon(
                FontAwesomeIcons.filePdf,
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('Button-ON_TAP');
                logFirebaseEvent('Button-Upload-Photo-Video');
                final selectedMedia = await selectMediaWithSourceBottomSheet(
                  context: context,
                  allowPhoto: true,
                  allowVideo: true,
                );
                if (selectedMedia != null &&
                    selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context))) {
                  showUploadMessage(
                    context,
                    'Uploading file...',
                    showLoading: true,
                  );
                  final downloadUrls = await Future.wait(selectedMedia.map(
                      (m) async => await uploadData(m.storagePath, m.bytes)));
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  if (downloadUrls != null) {
                    setState(() => uploadedFileUrl = downloadUrls.first);
                    showUploadMessage(
                      context,
                      'Success!',
                    );
                  } else {
                    showUploadMessage(
                      context,
                      'Failed to upload media',
                    );
                    return;
                  }
                }

                logFirebaseEvent('Button-Trigger-Push-Notification');
                triggerPushNotification(
                  notificationTitle: 'LOX',
                  notificationText: 'LOX',
                  notificationImageUrl: currentUserPhoto,
                  notificationSound: 'default',
                  userRefs: [currentUserReference],
                  initialPageName: 'sdfsdfsdfsdf',
                  parameterData: {},
                );
              },
              text: 'PUSH ME',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Cairo',
                      color: Colors.white,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
