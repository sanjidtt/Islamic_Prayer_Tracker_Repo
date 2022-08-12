int curInd = 0;
String ayahTitle = 'Ayah of the day';
String ayahBody =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
String hadithTitle = 'Hadith of the day';
String hadithBody =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.';

bool tempCheckValue = false;

class CheckBoxState {
  final String tempTitle;
  bool tempValue;

  CheckBoxState({required this.tempTitle, this.tempValue = false});
}
