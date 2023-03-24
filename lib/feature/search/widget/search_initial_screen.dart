import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/search/widget/recommended_search.dart';
import 'package:demandium/feature/search/widget/suggested_search.dart';
import 'recent_search.dart';

class SearchSuggestion extends StatelessWidget {
  const SearchSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.WEB_MAX_WIDTH,
      child: Padding(
        padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecentSearch(),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
            SuggestedSearch(),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
            RecommendedSearch()
          ],
        ),
      ),
    );
  }
}
