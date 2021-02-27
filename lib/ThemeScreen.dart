import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_theme/Providers/ThemeProvider.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {


  // Widget buildSwitchListTitle(String title,String desc,bool currentVal,Function updateValue){
  //   return SwitchListTile(value: currentVal, onChanged: updateValue,title: Text(title),subtitle: Text(desc),inactiveTrackColor: Colors.black,);
  // }

  Widget buildRadioListTitle(ThemeMode themeVal1,String txt,IconData icon,BuildContext ctx){
    return RadioListTile(value: themeVal1, groupValue: Provider.of<ThemeProvider>(ctx,listen: true).themeMode, 
      onChanged: (newThemeVal)=> Provider.of<ThemeProvider>(ctx,listen: false).themeModeChange(newThemeVal),
      secondary: Icon(icon,color: Theme.of(ctx).buttonColor,),title: Text(txt),);
  }


  ListTile buildListTitle(BuildContext context,txt){
    var primaryColor =  Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor =  Provider.of<ThemeProvider>(context,listen: true).accentColor;

    return ListTile(
      title: Text("Choose your $txt color",style: Theme.of(context).textTheme.headline6),
      trailing: CircleAvatar(
        backgroundColor: txt == "primary"?primaryColor:accentColor,
      ),
      onTap: (){
      showDialog(context: context,builder: (BuildContext ctx){
        return AlertDialog(

         title: Text(" title"),
          elevation: 4,
            titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: txt == "primary"?Provider.of<ThemeProvider>(ctx,listen: true).primaryColor:
              Provider.of<ThemeProvider>(ctx,listen: true).accentColor,
              onColorChanged: (newColor)=>
              Provider.of<ThemeProvider>(context,listen: false).onChange(newColor, txt =="primary" ?1:2),
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: false,
              displayThumbColor: true,
              showLabel: false,
            ),
          ),
        );
      });
      },
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text("Adjust Your Theme",style: Theme.of(context).textTheme.headline6,),
        ),
        Expanded(child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text("Adjust Your Theme",style: Theme.of(context).textTheme.headline6,),
            ),
            buildRadioListTitle(ThemeMode.system, "System Default Theme", null, context),
            buildRadioListTitle(ThemeMode.light, "Light Theme", Icons.wb_sunny_outlined, context),
            buildRadioListTitle(ThemeMode.dark, "Dark Theme", Icons.nights_stay_outlined, context),
            buildListTitle(context, "primary"),
            buildListTitle(context, "accent")


          ],
        ))
      ],),
    );
  }
}
