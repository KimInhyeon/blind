/*
A:65, Z:90, a:97, z:122, Ａ:65313, Ｚ:65338, ａ:65345, ｚ:65370, 0:48, 9:57, ０:65296, ９:65305
12353:ぁ, 12354:あ, 12355:ぃ, 12356:い, 12357:ぅ, 12358:う, 12359:ぇ, 12360:え, 12361:ぉ, 12362:お
12363:か, 12364:が, 12365:き, 12366:ぎ, 12367:く, 12368:ぐ, 12369:け, 12370:げ, 12371:こ, 12372:ご
12373:さ, 12374:ざ, 12375:し, 12376:じ, 12377:す, 12378:ず, 12379:せ, 12380:ぜ, 12381:そ, 12382:ぞ
12383:た, 12384:だ, 12385:ち, 12386:ぢ, 12387:っ, 12388:つ, 12389:づ, 12390:て, 12391:で, 12392:と, 12393:ど
12394:な, 12395:に, 12396:ぬ, 12397:ね, 12398:の
12399:は, 12400:ば, 12401:ぱ, 12402:ひ, 12403:び, 12404:ぴ, 12405:ふ, 12406:ぶ, 12407:ぷ, 12408:へ, 12409:べ, 12410:ぺ, 12411:ほ, 12412:ぼ, 12413:ぽ
12414:ま, 12415:み, 12416:む, 12417:め, 12418:も
12419:ゃ, 12420:や, 12421:ゅ, 12422:ゆ, 12423:ょ, 12424:よ
12425:ら, 12426:り, 12427:る, 12428:れ, 12429:ろ
12430:ゎ, 12431:わ, 12432:ゐ, 12433:ゑ, 12434:を, 12435:ん
12436:ゔ, 12437:ゕ, 12438:ゖ, 12439:NUL, 12440:NUL
12441:゙, 12442:゚, 12443:゛, 12444:゜, 12445:ゝ, 12446:ゞ, 12447:ゟ, 12448:゠
12449:ァ, 12450:ア, 12451:ィ, 12452:イ, 12453:ゥ, 12454:ウ, 12455:ェ, 12456:エ, 12457:ォ, 12458:オ
12459:カ, 12460:ガ, 12461:キ, 12462:ギ, 12463:ク, 12464:グ, 12465:ケ, 12466:ゲ, 12467:コ, 12468:ゴ
12469:サ, 12470:ザ, 12471:シ, 12472:ジ, 12473:ス, 12474:ズ, 12475:セ, 12476:ゼ, 12477:ソ, 12478:ゾ
12479:タ, 12480:ダ, 12481:チ, 12482:ヂ, 12483:ッ, 12484:ツ, 12485:ヅ, 12486:テ, 12487:デ, 12488:ト, 12489:ド
12490:ナ, 12491:ニ, 12492:ヌ, 12493:ネ, 12494:ノ
12495:ハ, 12496:バ, 12497:パ, 12498:ヒ, 12499:ビ, 12500:ピ, 12501:フ, 12502:ブ, 12503:プ, 12504:ヘ, 12505:ベ, 12506:ペ, 12507:ホ, 12508:ボ, 12509:ポ
12510:マ, 12511:ミ, 12512:ム, 12513:メ, 12514:モ
12515:ャ, 12516:ヤ, 12517:ュ, 12518:ユ, 12519:ョ, 12520:ヨ
12521:ラ, 12522:リ, 12523:ル, 12524:レ, 12525:ロ
12526:ヮ, 12527:ワ, 12528:ヰ, 12529:ヱ, 12530:ヲ, 12531:ン
12532:ヴ, 12533:ヵ, 12534:ヶ, 12535:ヷ, 12536:ヸ, 12537:ヹ, 12538:ヺ
12539:・, 12539:・, 12540:ー, 12541:ヽ, 12542:ヾ, 12543:ヿ
 */
package com.ksinfo.blind.util;

import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

@Component
public class SearchCompanyNameManager {
	private static final String searchCompanyNameRegex = "^[0-9A-Za-zぁ-ゖァ-ヶー]*$";

	private void convertFullToHalf(StringBuilder searchKeyword) {
		for (int i = searchKeyword.length() - 1; i > -1; --i) {
			char c = searchKeyword.charAt(i);
			if (('０' <= c && c <= '９') || ('Ａ' <= c && c <= 'Ｚ') || ('ａ' <= c && c <= 'ｚ')) {
				searchKeyword.setCharAt(i, (char) (c - 65248));
			}
		}
	}

	private void convertToKatakana(StringBuilder searchKeyword) {
		for (int i = searchKeyword.length() - 1; i > -1; --i) {
			char c = searchKeyword.charAt(i);
			if ('ぁ' <= c && c <= 'ゖ') {
				searchKeyword.setCharAt(i, (char) (c + 96));
			}
		}
	}

	private List<String> getSearchKeywordList(StringBuilder searchKeyword, int size, int step) {
		List<String> searchKeywordList = new ArrayList<>(size);
		searchKeyword.append('%');
		searchKeywordList.add(searchKeyword.toString());
		for (int c = searchKeyword.charAt(0) + step, range = c + (size - 1) * step; c < range; c += step) {
			searchKeyword.setCharAt(0, (char) c);
			searchKeywordList.add(searchKeyword.toString());
		}

		return searchKeywordList;
	}

	private List<String> getSearchKeywordListOfTaLine() {
		List<String> searchKeywordList = new ArrayList<>(8);
		searchKeywordList.add("タ%");
		searchKeywordList.add("ダ%");
		searchKeywordList.add("チ%");
		searchKeywordList.add("ツ%");
		searchKeywordList.add("テ%");
		searchKeywordList.add("デ%");
		searchKeywordList.add("ト%");
		searchKeywordList.add("ド%");

		return searchKeywordList;
	}

	public boolean isSearchCompanyName(StringBuilder searchKeyword) {
		convertFullToHalf(searchKeyword);
		if (Pattern.matches(searchCompanyNameRegex, searchKeyword)) {
			convertToKatakana(searchKeyword);

			return true;
		}

		return false;
	}

	public List<String> getSearchKeywordList(StringBuilder searchKeyword) {
		List<String> searchKeywordList;
		int searchKeywordLength = searchKeyword.length();
		if (searchKeywordLength == 1) {
			switch (searchKeyword.charAt(0)) {
				case 'A':
				case 'a':
					searchKeywordList = getSearchKeywordList(searchKeyword, 26, 1);
					break;
				case 'ア':
					searchKeywordList = getSearchKeywordList(searchKeyword, 5, 2);
					break;
				case '0':
				case 'カ':
				case 'サ':
					searchKeywordList = getSearchKeywordList(searchKeyword, 10, 1);
					break;
				case 'タ':
					searchKeywordList = getSearchKeywordListOfTaLine();
					break;
				case 'ナ':
				case 'マ':
				case 'ラ':
					searchKeywordList = getSearchKeywordList(searchKeyword, 5, 1);
					break;
				case 'ハ':
					searchKeywordList = getSearchKeywordList(searchKeyword, 15, 1);
					break;
				case 'ヤ':
					searchKeywordList = getSearchKeywordList(searchKeyword, 3, 2);
					break;
				case 'ワ':
				default:
					searchKeywordList = getSearchKeywordList(searchKeyword, 1, 1);
					break;
			}
		} else {
			searchKeywordList = new ArrayList<>(1);
			searchKeyword.insert(0, '%').append('%');
			searchKeywordList.add(searchKeyword.toString());
		}

		return searchKeywordList;
	}
}