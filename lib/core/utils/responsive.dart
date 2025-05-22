import 'package:flutter/material.dart';

class Responsive
{
  static late MediaQueryData _mediaQueryData;
  static late double widthscreen;
  static late double hightscreen;
  static Orientation ? _orientation;

  void init(BuildContext context )
  {
    _mediaQueryData=MediaQuery.of(context);
    widthscreen=_mediaQueryData.size.width;
    hightscreen=_mediaQueryData.size.height;
    _orientation=_mediaQueryData.orientation;
  }
}

double getHscreen( double higtscreen)
{
  return(higtscreen / 815) *
    Responsive.hightscreen;
}
double getWscreen( double widthscreen)
{
  return(widthscreen / 315) *
      Responsive.widthscreen;
}
double getFontSize( double fontsize)
{
  return(fontsize / 375) *
      Responsive.widthscreen;
}

