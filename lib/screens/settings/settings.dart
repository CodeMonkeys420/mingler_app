import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mingler_app/screens/settings/card_settings.dart';
import 'results.dart';
import 'model.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

// void main() => runApp(SettingsPage());

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      home: Settings(),
      theme: ThemeData(
        accentColor: Colors.indigo[400], // background color of card headers
        cardColor: Colors.white, // background color of fields
        backgroundColor: Colors.indigo[100], // color outside the card
        primaryColor: Colors.teal, // color of page header
        buttonColor: Colors.lightBlueAccent[100], // background color of buttons
        textTheme: TextTheme(
          button:
              TextStyle(color: Colors.deepPurple[900]), // style of button text
          subhead: TextStyle(color: Colors.grey[800]), // style of input text
        ),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.lightBlue[50]), // style for headers
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.indigo[400]), // style for labels
        ),
      ),
      darkTheme: ThemeData.dark(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _ponyModel = PonyModel();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _typeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _ageKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _myhairKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _myeyeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _eyecolorKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionlKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _haircolorKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hobbiesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _coatKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _maneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hasSpotsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _spotKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _heightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _weightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _myheightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _myweightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _timeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sliderKey = GlobalKey<FormState>();

  bool _showMaterialonIOS = true;

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Settings"),
        actions: <Widget>[
          Container(
            child: Platform.isIOS
                ? IconButton(
                    icon: Icon(Icons.swap_calls),
                    onPressed: () {
                      setState(() {
                        _showMaterialonIOS = !_showMaterialonIOS;
                      });
                    },
                  )
                : null,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePressed,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _resetPressed,
        ),
      ),
      body: Form(
        key: _formKey,
        child: (orientation == Orientation.portrait)
            ? _buildPortraitLayout()
            : _buildLandscapeLayout(),
      ),
    );
  }

  /* CARDSETTINGS FOR EACH LAYOUT */

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      showMaterialonIOS: _showMaterialonIOS,
      labelWidth: 100,
      children: <CardSettingsSection>[
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'About Me',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            _buildCardSettingsText_Name(),
            _buildCardSettingsNumberPicker(),
            _buildCardSettingsListPicker_MyHair(),
            _buildCardSettingsListPicker_MyEye(),
            _buildCardSettingsParagraph(5),
            _buildCardSettingsMultiselect(),
            _buildCardSettingsDouble_MyHeight(),
            _buildCardSettingsInt_MyWeight(),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'What I Want',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            _buildCardSettingsMultiselectHairColor(),
            _buildCardSettingsMultiselectEyeColor(),
            _buildCardSettingsListPicker_Type(),
            _buildCardSettingsDouble_Height(),
            _buildCardSettingsInt_Weight(),
          ],
        ),
        // CardSettingsSection(
        //   showMaterialonIOS: _showMaterialonIOS,
        //   header: CardSettingsHeader(
        //     label: 'Size',
        //     showMaterialonIOS: _showMaterialonIOS,
        //   ),
        //   children: <Widget>[
        //     _buildCardSettingsDouble_Height(),
        //     _buildCardSettingsInt_Weight(),
        //   ],
        // ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'First Show',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          instructions: _buildCardSettingsInstructions(),
          children: <Widget>[
            _buildCardSettingsDatePicker(),
            _buildCardSettingsTimePicker(),
            _buildCardSettingsCurrency(),
            _buildCardSettingsPhone(),
            _buildCardSettingsDouble_Slider(),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'Security',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            _buildCardSettingsEmail(),
            _buildCardSettingsPassword(),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'Actions',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            _buildCardSettingsButton_Save(),
            _buildCardSettingsButton_Reset(),
          ],
        ),
      ],
    );
  }

  CardSettings _buildLandscapeLayout() {
    return CardSettings.sectioned(
      showMaterialonIOS: _showMaterialonIOS,
      labelPadding: 12.0,
      children: <CardSettingsSection>[
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'Bio',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            _buildCardSettingsText_Name(),
            CardFieldLayout(
              <Widget>[
                _buildCardSettingsListPicker_Type(),
                _buildCardSettingsNumberPicker(labelAlign: TextAlign.right),
              ],
              flexValues: [2, 1],
            ),
            _buildCardSettingsParagraph(3),
            _buildCardSettingsMultiselect(),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'Security',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsEmail(),
              _buildCardSettingsPassword(),
            ]),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'Colors',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsColorPicker_Coat(),
              _buildCardSettingsColorPicker_Mane(),
            ]),
            CardFieldLayout(<Widget>[
              _buildCardSettingsSwitch_Spots(),
              _buildCardSettingsColorPicker_Spot(),
            ]),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'Size',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsDouble_Height(),
              _buildCardSettingsInt_Weight(),
            ]),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'First Show',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            _buildCardSettingsInstructions(),
            CardFieldLayout(<Widget>[
              _buildCardSettingsDatePicker(),
              _buildCardSettingsTimePicker(),
            ]),
            CardFieldLayout(<Widget>[
              _buildCardSettingsCurrency(),
              _buildCardSettingsPhone(),
            ]),
            _buildCardSettingsDouble_Slider(),
          ],
        ),
        CardSettingsSection(
          showMaterialonIOS: _showMaterialonIOS,
          header: CardSettingsHeader(
            label: 'Actions',
            showMaterialonIOS: _showMaterialonIOS,
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsButton_Save(),
              _buildCardSettingsButton_Reset(),
            ]),
          ],
        ),
      ],
    );
  }

  /* BUILDERS FOR EACH FIELD */

  CardSettingsButton _buildCardSettingsButton_Reset() {
    return CardSettingsButton(
      showMaterialonIOS: _showMaterialonIOS,
      label: 'RESET',
      isDestructive: true,
      onPressed: _resetPressed,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
  }

  CardSettingsButton _buildCardSettingsButton_Save() {
    return CardSettingsButton(
      showMaterialonIOS: _showMaterialonIOS,
      label: 'SAVE',
      onPressed: _savePressed,
    );
  }

  CardSettingsPassword _buildCardSettingsPassword() {
    return CardSettingsPassword(
      showMaterialonIOS: _showMaterialonIOS,
      labelWidth: 150.0,
      key: _passwordKey,
      icon: Icon(Icons.lock),
      initialValue: _ponyModel.password,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null) return 'Password is required.';
        if (value.length <= 6) return 'Must be more than 6 characters.';
        return null;
      },
      onSaved: (value) => _ponyModel.password = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.password = value;
        });
        _showSnackBar('Password', value);
      },
    );
  }

  CardSettingsEmail _buildCardSettingsEmail() {
    return CardSettingsEmail(
      showMaterialonIOS: _showMaterialonIOS,
      labelWidth: 150.0,
      key: _emailKey,
      icon: Icon(Icons.person),
      initialValue: _ponyModel.email,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email is required.';
        if (!value.contains('@'))
          return "Email not formatted correctly."; // use regex in real application
        return null;
      },
      onSaved: (value) => _ponyModel.email = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.email = value;
        });
        _showSnackBar('Email', value);
      },
    );
  }

  CardSettingsPhone _buildCardSettingsPhone() {
    return CardSettingsPhone(
      showMaterialonIOS: _showMaterialonIOS,
      key: _phoneKey,
      label: 'Box Office',
      initialValue: _ponyModel.boxOfficePhone,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null && value.toString().length != 10)
          return 'Incomplete number';
        return null;
      },
      onSaved: (value) => _ponyModel.boxOfficePhone = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.boxOfficePhone = value;
        });
        _showSnackBar('Box Office', value);
      },
    );
  }

  CardSettingsCurrency _buildCardSettingsCurrency() {
    return CardSettingsCurrency(
      showMaterialonIOS: _showMaterialonIOS,
      key: _priceKey,
      label: 'Ticket Price',
      initialValue: _ponyModel.ticketPrice,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null && value > 100) return 'No scalpers allowed!';
        return null;
      },
      onSaved: (value) => _ponyModel.ticketPrice = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.ticketPrice = value;
        });
        _showSnackBar('Ticket Price', value);
      },
    );
  }

  CardSettingsTimePicker _buildCardSettingsTimePicker() {
    return CardSettingsTimePicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _timeKey,
      icon: Icon(Icons.access_time),
      label: 'Time',
      initialValue: TimeOfDay(
          hour: _ponyModel.showDateTime.hour,
          minute: _ponyModel.showDateTime.minute),
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustTime(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime =
              updateJustTime(value, _ponyModel.showDateTime);
        });
        _showSnackBar('Show Time', value);
      },
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker() {
    return CardSettingsDatePicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _dateKey,
      justDate: true,
      icon: Icon(Icons.calendar_today),
      label: 'Date',
      initialValue: _ponyModel.showDateTime,
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustDate(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime = value;
        });
        _showSnackBar(
            'Show Date', updateJustDate(value, _ponyModel.showDateTime));
      },
    );
  }

  CardSettingsInstructions _buildCardSettingsInstructions() {
    return CardSettingsInstructions(
      showMaterialonIOS: _showMaterialonIOS,
      text: 'This is when this little horse got her big break',
    );
  }

  CardSettingsInt _buildCardSettingsInt_Weight() {
    return CardSettingsInt(
      showMaterialonIOS: _showMaterialonIOS,
      key: _weightKey,
      label: 'Weight',
      unitLabel: 'lbs',
      initialValue: _ponyModel.weight,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },
      onSaved: (value) => _ponyModel.weight = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.weight = value;
        });
        _showSnackBar('Weight', value);
      },
    );
  }

  CardSettingsInt _buildCardSettingsInt_MyWeight() {
    return CardSettingsInt(
      showMaterialonIOS: _showMaterialonIOS,
      key: _myweightKey,
      label: 'My Weight',
      unitLabel: 'kg',
      initialValue: _ponyModel.myweight,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null) {
          if (value > 300) return 'Are You Sure?';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },
      onSaved: (value) => _ponyModel.myweight = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.myweight = value;
        });
        _showSnackBar('Weight', value);
      },
    );
  }

  CardSettingsDouble _buildCardSettingsDouble_Height() {
    return CardSettingsDouble(
      showMaterialonIOS: _showMaterialonIOS,
      key: _heightKey,
      label: 'Height',
      unitLabel: 'feet',
      decimalDigits: 2,
      initialValue: _ponyModel.height,
      onSaved: (value) => _ponyModel.height = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.height = value;
        });
        _showSnackBar('Height', value);
      },
    );
  }

  CardSettingsDouble _buildCardSettingsDouble_MyHeight() {
    return CardSettingsDouble(
      showMaterialonIOS: _showMaterialonIOS,
      key: _myheightKey,
      label: 'My Height',
      unitLabel: 'cm',
      decimalDigits: 2,
      initialValue: _ponyModel.myheight,
      onSaved: (value) => _ponyModel.myheight = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.myheight = value;
        });
        _showSnackBar('My Height', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Spot() {
    return CardSettingsColorPicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _spotKey,
      label: 'Spot',
      pickerType: CardSettingsColorPickerType.block,
      initialValue: intelligentCast<Color>(_ponyModel.spotColor),
      visible: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.spotColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.type = colorToString(value);
        });
        _showSnackBar('Spot', value);
      },
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Spots() {
    return CardSettingsSwitch(
      showMaterialonIOS: _showMaterialonIOS,
      key: _hasSpotsKey,
      label: 'Does this horse have spots?',
      labelWidth: 240.0,
      initialValue: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.hasSpots = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.hasSpots = value;
        });
        _showSnackBar('Has Spots?', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Mane() {
    return CardSettingsColorPicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _maneKey,
      label: 'Mane',
      initialValue: intelligentCast<Color>(_ponyModel.maneColor),
      autovalidate: _autoValidate,
      pickerType: CardSettingsColorPickerType.material,
      validator: (value) {
        if (value.computeLuminance() > .7) return 'This color is too light.';
        return null;
      },
      onSaved: (value) => _ponyModel.maneColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.maneColor = colorToString(value);
        });
        _showSnackBar('Mane', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Coat() {
    return CardSettingsColorPicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _coatKey,
      label: 'Coat',
      initialValue: intelligentCast<Color>(_ponyModel.coatColor),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.computeLuminance() < .3)
          return 'This color is not cheery enough.';
        return null;
      },
      onSaved: (value) => _ponyModel.coatColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.coatColor = colorToString(value);
        });
        _showSnackBar('Coat', value);
      },
    );
  }

  CardSettingsMultiselect _buildCardSettingsMultiselect() {
    return CardSettingsMultiselect(
      showMaterialonIOS: _showMaterialonIOS,
      key: _hobbiesKey,
      label: 'Hobbies',
      initialValues: _ponyModel.hobbies,
      options: allHobbies,
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one hobby.';

        return null;
      },
      onSaved: (value) => _ponyModel.hobbies = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.hobbies = value;
        });
        _showSnackBar('Hobbies', value);
      },
    );
  }

  CardSettingsMultiselect _buildCardSettingsMultiselectHairColor() {
    return CardSettingsMultiselect(
      showMaterialonIOS: _showMaterialonIOS,
      key: _haircolorKey,
      label: 'Hair Color',
      initialValues: _ponyModel.haircolor,
      options: _ponyModel.haircolor,
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one hair color.';

        return null;
      },
      onSaved: (value) => _ponyModel.haircolor = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.haircolor = value;
        });
        _showSnackBar('Hair Color', value);
      },
    );
  }

  CardSettingsMultiselect _buildCardSettingsMultiselectEyeColor() {
    return CardSettingsMultiselect(
      showMaterialonIOS: _showMaterialonIOS,
      key: _eyecolorKey,
      label: 'Eye Color',
      initialValues: _ponyModel.eyecolor,
      options: _ponyModel.eyecolor,
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one hobby.';

        return null;
      },
      onSaved: (value) => _ponyModel.eyecolor = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.eyecolor = value;
        });
        _showSnackBar('Eye Color', value);
      },
    );
  }

  CardSettingsParagraph _buildCardSettingsParagraph(int lines) {
    return CardSettingsParagraph(
      showMaterialonIOS: _showMaterialonIOS,
      key: _descriptionlKey,
      label: 'Description',
      initialValue: _ponyModel.description,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.description = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.description = value;
        });
        _showSnackBar('Description', value);
      },
    );
  }

  CardSettingsNumberPicker _buildCardSettingsNumberPicker(
      {TextAlign labelAlign}) {
    return CardSettingsNumberPicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _ageKey,
      label: 'Age',
      labelAlign: labelAlign,
      initialValue: _ponyModel.age,
      min: 18,
      max: 65,
      validator: (value) {
        if (value == null) return 'Age is required.';
        return null;
      },
      onSaved: (value) => _ponyModel.age = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.age = value;
        });
        _showSnackBar('Age', value);
      },
    );
  }


  CardSettingsListPicker _buildCardSettingsListPicker_Type() {
    return CardSettingsListPicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _typeKey,
      label: 'Interest',
      initialValue: _ponyModel.type,
      hintText: 'Select One',
      autovalidate: _autoValidate,
      options: <String>['Males', 'Females', 'Males And Females', 'Friends Only', 'All'],
      values: <String>['M', 'F', 'M&F', 'FO', 'A'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.type = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.type = value;
        });
        _showSnackBar('Type', value);
      },
    );
  }

   CardSettingsListPicker _buildCardSettingsListPicker_MyHair() {
    return CardSettingsListPicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _myhairKey,
      label: 'My Hair',
      initialValue: _ponyModel.type,
      hintText: 'Select One',
      autovalidate: _autoValidate,
      options: <String>[
        'Black',
        'Brunette',
        'Blonde',
        'Red',
        'Colorful(Blue,Green,etc.)'],
      values: <String>['BLA', 'BRU', 'BLO', 'RER', 'COL'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a hair color.';
        return null;
      },
      onSaved: (value) => _ponyModel.myhair= value,
      onChanged: (value) {
        setState(() {
          _ponyModel.myhair = value;
        });
        _showSnackBar('Hair Color', value);
      },
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_MyEye() {
    return CardSettingsListPicker(
      showMaterialonIOS: _showMaterialonIOS,
      key: _myeyeKey,
      label: 'My Eyes',
      initialValue: _ponyModel.type,
      hintText: 'Select One',
      autovalidate: _autoValidate,
      options: <String>[
        'Brown',
        'Hazel',
        'Blue',
        'Green',
        'Gray',
        'Amber'
        ],
      values: <String>['BRO', 'HAZ', 'BLU', 'GRE', 'GRA', 'AMB'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a eye color.';
        return null;
      },
      onSaved: (value) => _ponyModel.myeye= value,
      onChanged: (value) {
        setState(() {
          _ponyModel.myeye = value;
        });
        _showSnackBar('Eye Color', value);
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Name() {
    return CardSettingsText(
      showMaterialonIOS: _showMaterialonIOS,
      key: _nameKey,
      label: 'Name',
      hintText: 'something cute...',
      initialValue: _ponyModel.name,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
        return null;
      },
      showErrorIOS: _ponyModel.name == null || _ponyModel.name.isEmpty,
      onSaved: (value) => _ponyModel.name = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.name = value;
        });
        _showSnackBar('Name', value);
      },
    );
  }

  CardSettingsSlider _buildCardSettingsDouble_Slider() {
    return CardSettingsSlider(
      showMaterialonIOS: _showMaterialonIOS,
      key: _sliderKey,
      label: 'Rating',
      initialValue: _ponyModel.rating,
      autovalidate: _autoValidate,
      validator: (double value) {
        if (value == null) return 'You must pick a rating.';
        return null;
      },
      onSaved: (value) => _ponyModel.rating = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.rating = value;
        });
        _showSnackBar('Rating', value);
      },
    );
  }

  /* EVENT HANDLERS */

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      showResults(context, _ponyModel);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _resetPressed() {
    _formKey.currentState.reset();
  }

  void _showSnackBar(String label, dynamic value) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(label + ' = ' + value.toString()),
      ),
    );
  }
}
