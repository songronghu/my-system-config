#!/bin/bash
word=$1
#echo loginpass | sudo -S runuser -l libretranslate -f -c "argos-translate --from en --to zh '$word'"
#echo $word
translation="$(wget -U "Mozilla/5.0" -q -O - --post-data="q=$(echo $word | sed "s/\"/\\\"/g")&source=en&target=zh&format=text&apikey=" http://localhost:5000/translate)"
#echo $translation
# Remove last word from the translation (a long hash).
translation=$(echo "$translation" | sed s/'[{\"translatedText\":|\"}]'//g)
# Remove empty lines.
translation=$(echo $translation | sed /^$/d)
echo "$translation"
