import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../bloc/verification_page_bloc.dart';

class VerificationPage extends StatelessWidget {
  final VerificationPageBloc _bloc = VerificationPageBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final codeTextFieldController = TextEditingController();
  final codeFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  late GlobalKey timerKey;

  VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('휴대폰 본인인증'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 5.0,
          ),
          child: ListView(primary: true, children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🔑",
                    style: TextStyle(
                      fontFamily: "Tossface",
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTitle("이메일"),
                  buildTitle("본인인증"),
                  const SizedBox(height: 7),
                  const Text(
                    "이메일 주소 입력 후, 인증번호를 입력해 주세요.",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                        stream: _bloc.emailTextFieldStream,
                        builder: (context, textStream) {
                          return Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: '이메일',
                                hintText: '유니스트 이메일 사용 불가',
                                errorText: textStream.hasData
                                    ? textStream.data!.validationString
                                    : null,
                              ),
                              enabled: textStream.hasData
                                  ? textStream.data!.isEnabled
                                  : true,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: true,
                              onChanged: (String text) {
                                _bloc.updateEmailTextField(text);
                              },
                              focusNode: emailFocusNode,
                              onSaved: _bloc.onEmailSaved,
                              onFieldSubmitted: ((textStream.hasData
                                          ? textStream.data!.validationString
                                          : null) ==
                                      null)
                                  ? (s) {
                                      _formKey.currentState!.save();
                                      _bloc.onCodeSendButtonPressed();
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        FocusScope.of(context)
                                            .requestFocus(codeFocusNode);
                                      });
                                      codeTextFieldController.clear();
                                    }
                                  : null,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Column(
                        children: [
                          StreamBuilder(
                            stream: _bloc.sendCodeButtonStream,
                            builder: (context, stream) {
                              return SizedBox(
                                height: 60,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 236, 231),
                                    foregroundColor: Colors.black,
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    disabledBackgroundColor:
                                        const Color.fromARGB(
                                            255, 220, 216, 216),
                                  ),
                                  onPressed: (stream.hasData
                                          ? stream.data!.isEnabled
                                          : false)
                                      ? () {
                                          _formKey.currentState!.save();
                                          _bloc.onCodeSendButtonPressed();
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            FocusScope.of(context)
                                                .requestFocus(codeFocusNode);
                                          });
                                          codeTextFieldController.clear();
                                        }
                                      : null,
                                  child: Text(
                                    '인증번호 전송',
                                    style: TextStyle(
                                        color: (stream.hasData
                                                ? stream.data!.isEnabled
                                                : false)
                                            ? const Color(0xFFFF6332)
                                            : Colors.grey[800],
                                        fontSize: 15),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: _bloc.codeTextFieldStream,
                    builder: (context, textStream) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: '인증번호',
                          hintText: 'XXXX',
                          errorText: textStream.hasData
                              ? textStream.data!.validationString
                              : null,
                          errorStyle: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                        focusNode: codeFocusNode,
                        controller: codeTextFieldController,
                        enabled: textStream.hasData
                            ? textStream.data!.isEnabled
                            : false,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        onChanged: (String text) =>
                            _bloc.updateCodeTextField(text),
                        onSaved: _bloc.onCodeSaved,
                        onFieldSubmitted: ((textStream.hasData
                                    ? textStream.data!.validationString
                                    : null) ==
                                null)
                            ? (s) {
                                _formKey.currentState!.save();
                                _bloc.onCheckCodeButtonPressed();
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocusNode);
                                });
                              }
                            : null,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StreamBuilder(
        stream: _bloc.checkCodeButtonStream,
        builder: (context, stream) {
          // timerKey = GlobalKey();
          return Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                backgroundColor: const Color(0xFFFF6332),
                foregroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
                disabledBackgroundColor:
                    const Color.fromARGB(255, 220, 216, 216),
              ),
              onPressed: (stream.hasData ? stream.data!.isEnabled : false)
                  ? () {
                      _formKey.currentState!.save();
                      _bloc.onCheckCodeButtonPressed();
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      });
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '인증번호 확인',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: (stream.hasData ? stream.data!.isEnabled : false)
                            ? Colors.white
                            : Colors.grey[800],
                        fontSize: 17),
                  ),
                  if (stream.hasData
                      ? (stream.data!.timeRemaining != '')
                      : false)
                    const SizedBox(width: 5),
                  if (stream.hasData
                      ? (stream.data!.timeRemaining != '')
                      : false)
                    Text(
                      stream.data!.timeRemaining,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: (stream.hasData ? stream.data!.isEnabled : false)
                            ? Colors.white
                            : Colors.grey[800],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildTitle(text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w800,
    ),
  );
}
