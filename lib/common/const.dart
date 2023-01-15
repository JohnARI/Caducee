import 'package:caducee/models/drug.dart';
import 'package:caducee/screens/home/drugs/drug_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiSecretKey = dotenv.env['API_SECRET_KEY'];

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 0.2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: myDarkGreen, width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
);

final textColor = TextStyle(color: Colors.grey[700]);

const myDarkGreen = Color(0xFF1B8C5C);
const myPastelGreen = Color(0xFF315C4e);
const myGreen = Color(0xFF23cc8c);
const myLightGreen = Color(0xFF80e4c4);
const myTransparent = Colors.transparent;

BoxShadow myBoxShadow = const BoxShadow(
  color: Colors.white12,
  offset: Offset(-6, -6),
  blurRadius: 20,
);

BoxShadow myBoxShadow2 = const BoxShadow(
  color: Colors.black26,
  offset: Offset(6, 6),
  blurRadius: 20,
);

SizedBox tabSearchBar(
    Function(String) onChanged, TextEditingController controller, String hint) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
      child: TextField(
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: const Icon(
            Icons.search,
            color: myGreen,
            size: 30,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: myGreen),
          ),
        ),
        onChanged: onChanged,
      ),
    ),
  );
}

Container drugTile(
    BuildContext context,
    AppDrugData drug,
    bool isFavorite,
    Function toggleFavorite,
    Function addToFavorites,
    Function removeFromFavorites) {
  return Container(
    margin:
        const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          offset: const Offset(-6, -6),
          blurRadius: 20,
        ),
        myBoxShadow2,
      ],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DrugInfoPage(drug: drug),
          ),
        );
      },
      child: ListTile(
        leading: const SizedBox(
          width: 48.0,
          height: 48.0,
          child: Center(
            child: Image(
              image: AssetImage('assets/images/iconLogo.png'),
              height: 40.0,
              width: 40.0,
            ),
          ),
        ),
        title: Text(
          drug.name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith( // bodyText1 is black
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        subtitle: Text(drug.molecule,
            style: Theme.of(context).textTheme.bodyText2!.copyWith( // bodyText2 is grey (blacl54)
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                )),
        trailing: IconButton(
          icon: bookmarkIcon(isFavorite),
          onPressed: () {
            if (isFavorite) {
              removeFromFavorites(drug);
            } else {
              addToFavorites(drug);
            }
            toggleFavorite();
          },
        ),
      ),
    ),
  );
}

bookmarkIcon(bool isFavorite) {
  if (isFavorite) {
    return const Icon(
      Icons.bookmark,
      color: myGreen,
      size: 30.0,
    );
  } else {
    return const Icon(
      Icons.bookmark_border,
      color: myGreen,
      size: 30.0,
    );
  }
}
