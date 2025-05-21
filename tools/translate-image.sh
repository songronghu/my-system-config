#!/usr/bin/env bash
# Image with text to translate.
image=$1
# 3-letter ISO Language code.
from_lang=eng
# Language to translate into.
to_lang=chi
# If set, translation will be displayed in a message box.
display=true
# Two-letter language code, used for Google Translate.
to_lang=${to_lang:0:2}

# Extract text from an image using a language code.
# 2> /dev/null - is used to suppress possible errors/warnings.
# So, if you want to debug the script, just remove it.
text="$(tesseract -l $from_lang $image stdout 2> /dev/null)"

# Translate the text using Google API.
#translation="$(wget -U "Mozilla/5.0" -qO - \
#"http://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$to_lang&dt=t&q=\
#$(echo $text | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2, $6}')"

#translation="$(wget -U "Mozilla/5.0" -qO - \
#"https://dict.youdao.com/search?q=%\
#$(echo $text | sed "s/[\"'<>]//g")%")"
translation="$(wget -U "Mozilla/5.0" -q -O - --post-data="q=$(echo $text | sed "s/[\"'<>]//g")&source=en&target=zh&format=text&apikey=" http://localhost:5000/translate)"
#echo $translation
# Remove last word from the translation (a long hash).
translation=$(echo "$translation" | sed s/'[{\"translatedText\":|\"}]'//g)
# Remove empty lines.
translation=$(echo $translation | sed /^$/d)

if [[ $display == true ]]; then
    # Show translation in a zenity box.
    zenity --width=400 --height=400 --info --text "<span font='18'>$translation</span>"
else
    # Print the translated text.
    echo "$translation"
fi
