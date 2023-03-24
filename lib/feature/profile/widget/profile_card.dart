import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';


class ProfileCardItem extends StatelessWidget {
  final String leadingIcon;
  final bool? isDarkItem;
  final String title;
  final IconData? trailingIcon;
  final Function()? onTap;
  const ProfileCardItem({Key? key,this.trailingIcon=Icons.arrow_forward_ios,required this.title,required this.leadingIcon,this.onTap,this.isDarkItem=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Container(
        height: 70,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: Theme.of(context).hoverColor,
          boxShadow: Get.isDarkMode ? null: cardShadow,
        ),

        child: Center(
          child: ListTile(
            title: Row(
              children: [
                Image.asset(leadingIcon,width: Dimensions.PROFILE_ITEM__SIZE,),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                Text(title),
              ],
            ),
            trailing: isDarkItem==false?Icon(trailingIcon,size: Dimensions.fontSizeDefault,color: Theme.of(context).colorScheme.primary,):
            GetBuilder<ThemeController>(builder: (themeController){
              return Switch(value: themeController.darkTheme, onChanged: (value){
                themeController.toggleTheme();
              });
            }),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
