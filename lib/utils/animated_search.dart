import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';

class AnimSearchBar extends StatefulWidget {
  ///  width - double ,isRequired : Yes
  ///  textController - TextEditingController  ,isRequired : Yes
  ///  onSuffixTap - Function, isRequired : Yes
  ///  onSubmitted - Function, isRequired : Yes
  ///  rtl - Boolean, isRequired : No
  ///  autoFocus - Boolean, isRequired : No
  ///  style - TextStyle, isRequired : No
  ///  closeSearchOnSuffixTap - bool , isRequired : No
  ///  suffixIcon - Icon ,isRequired :  No
  ///  prefixIcon - Icon  ,isRequired : No
  ///  animationDurationInMilli -  int ,isRequired : No
  ///  helpText - String ,isRequired :  No
  ///  inputFormatters - TextInputFormatter, Required - No
  ///  boxShadow - bool ,isRequired : No
  ///  textFieldColor - Color ,isRequired : No
  ///  searchIconColor - Color ,isRequired : No
  ///  textFieldIconColor - Color ,isRequired : No

  final double width;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;

  // ignore: prefer_typing_uninitialized_variables
  final onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? helpTextColor;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;

  const AnimSearchBar({
    Key? key,

    /// The width cannot be null
    required this.width,

    /// The textController cannot be null
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",
    this.helpTextColor,

    /// choose your custom color
    this.color = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.textFieldColor = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.searchIconColor = Colors.black,

    /// choose your custom color for the search when it is expanded
    this.textFieldIconColor = Colors.black,

    /// The onSuffixTap cannot be null
    required this.onSuffixTap,
    this.animationDurationInMilli = 375,

    /// The onSubmitted cannot be null
    required this.onSubmitted,

    /// make the search bar to open from right to left
    this.rtl = false,

    /// make the keyboard to show automatically when the searchbar is expanded
    this.autoFocus = false,

    /// TextStyle of the contents inside the searchbar
    this.style,

    /// close the search on suffix tap
    this.closeSearchOnSuffixTap = false,

    /// enable/disable the box shadow decoration
    this.boxShadow = true,

    /// can add list of inputformatters to control the input
    this.inputFormatters,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimSearchBarState createState() => _AnimSearchBarState();
}

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

/// * use this variable to check current text from OnChange
String textFieldValue = '';

class _AnimSearchBarState extends State<AnimSearchBar>
    with SingleTickerProviderStateMixin {
  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .05,

      ///if the rtl is true, search bar will be from right to left
      alignment:
          widget.rtl ? Alignment.centerRight : const Alignment(-1.0, 0.0),

      ///Using Animated container to expand and shrink the widget
      child: AnimatedContainer(

        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: MediaQuery.sizeOf(context).height * .038,
        width: (toggle == 0)
            ? MediaQuery.sizeOf(context).height * .038
            : widget.width-MediaQuery.sizeOf(context).height * .038,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          /// can add custom  color or the color will be white
          color: toggle == 1 ? widget.textFieldColor : widget.color,
          borderRadius: BorderRadius.circular(30.0),

          /// show boxShadow unless false was passed
          boxShadow: !widget.boxShadow
              ? null
              : [
                  const BoxShadow(
                    color: Colors.black26,
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ///Using Animated Positioned widget to expand and shrink the widget

            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              right: 4,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    /// can add custom color or the color will be white
                    color: widget.color,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                    child: GestureDetector(
                      onTap: () {
                        try {
                          ///trying to execute the onSuffixTap function
                          widget.onSuffixTap();
                          // * if field empty then the user trying to close bar
                          if (textFieldValue == '') {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });

                            ///reverse == close
                            _con.reverse();
                          }

                          // * why not clear textfield here?
                          widget.textController.clear();
                          textFieldValue = '';

                          ///closeSearchOnSuffixTap will execute if it's true
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                          }
                        } catch (e) {
                          ///print the error if the try block fails
                        }
                      },

                      ///suffixIcon is of type Icon
                      child: widget.suffixIcon ??
                          Icon(
                            Icons.close,
                            size: MediaQuery.of(context).size.height * .02,
                            color: widget.textFieldIconColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0)
                  ? MediaQuery.of(context).size.height * .020
                  : MediaQuery.of(context).size.height * .03,
              curve: Curves.easeOut,

              ///Using Animated opacity to change the opacity of th textField while expanding
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    ///Text Controller. you can manipulate the text inside this textField by calling this controller.
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,

                    // cursorHeight: MediaQuery.sizeOf(context).height * .02,
                    onChanged: (value) {
                      textFieldValue = value;
                      widget.onSubmitted(value);
                    },
                    onSubmitted: (value) => {
                      // widget.onSubmitted(value),
                      unfocusKeyboard(),
                      setState(() {
                        toggle = 0;
                      }),
                      widget.textController.clear(),
                    },
                    onEditingComplete: () {
                      /// on editing complete the keyboard will be closed and the search bar will be closed
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },

                    ///style is of type TextStyle, the default is just a color black
                    style: widget.style ?? const TextStyle(color: Colors.black),
                    cursorColor: widget.helpTextColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: widget.helpText,
                      hintStyle: TextStyle(
                        color: widget.helpTextColor ?? greyColor,
                        fontSize: MediaQuery.of(context).size.height * .016,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Material(

                  /// can add custom color or the color will be white
                  /// toggle button color based on toggle state
                  color: toggle == 0 ? widget.color : widget.textFieldColor,
                  borderRadius: BorderRadius.circular(30.0),
                  child: GestureDetector(
                    ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                    ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                    ///prefixIcon is of type Icon
                    child: widget.prefixIcon != null
                        ? toggle == 1
                            ? Icon(
                                Icons.arrow_back_ios,
                                color: widget.textFieldIconColor,
                                size: MediaQuery.of(context).size.height * .025,
                              ).paddingOnly(left: 10)
                            : widget.prefixIcon!
                        : toggle == 0
                            ? Center(
                                child: Icon(
                                  Icons.search,
                                  // search icon color when closed
                                  color: widget.searchIconColor,
                                  size:
                                      MediaQuery.of(context).size.height * .025,
                                ),
                              )
                            : Icon(
                                toggle == 1
                                    ? Icons.arrow_back_ios
                                    : Icons.search,
                                // search icon color when closed
                                color: toggle == 0
                                    ? widget.searchIconColor
                                    : widget.textFieldIconColor,
                                size: MediaQuery.of(context).size.height * .02,
                              ).paddingOnly(left: 10),
                    onTap: () {
                      setState(
                        () {
                          ///if the search bar is closed
                          if (toggle == 0) {
                            toggle = 1;

                            setState(() {
                              ///if the autoFocus is true, the keyboard will pop open, automatically
                              if (widget.autoFocus) {
                                FocusScope.of(context).requestFocus(focusNode);
                              }
                            });

                            ///forward == expand
                            _con.forward();
                          } else {
                            ///if the search bar is expanded
                            toggle = 0;

                            ///if the autoFocus is true, the keyboard will close, automatically
                            setState(() {
                              if (widget.autoFocus) unfocusKeyboard();
                            });

                            ///reverse == close
                            _con.reverse();
                          }
                        },
                      );
                    },
                  )),
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
          ],
        ),
      ),
    );
  }
}
