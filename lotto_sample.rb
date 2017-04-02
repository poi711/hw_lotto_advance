require ('open-uri') # 웹 페이지 open 에 필요.
require ('json')     # JSON을 Hash로 변환하는데 필요.

# get_info hash 에 이번주 로또 정보 가져오기.
get_info = JSON.parse(open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read)

# 이번 주 추첨 번호를 저장할 drw_numbers 배열 생성.
drw_numbers = []

# 보너스 번호를 제외한 번호 6개를 drw_numbers 배열에 저장.
get_info.each do |k, v|    # get_info 해시의 모든 key-value 를 돌며,
    if k.include?('drwtNo')    # key 에 'drwtNo' 라는 문자열이 있으면(추첨 번호면) 
        drw_numbers << v          # 그 value(번호) 를 drw_num 에 저장. 
    end
end
drw_numbers.sort!    #drw_numbers 배열을 오름차순 정렬.

# 보너스 번호를 bonus_number 에 저장.
bonus_number = get_info["bnusNo"]

# 내가 추첨한 로또 번호 6개를 오름차순 정렬하여 my_numbers 배열에 저장.
my_numbers = [*1..45].sample(6).sort

# drw_numbers 과 my_numbers 중 겹치는 숫자들(배열)을 match_numbers 에 저장.
match_numbers = my_numbers & drw_numbers

# match_numbers 의 갯수를 match_cnt(count) 에 저장.
match_cnt = match_numbers.count    

# 이번주 번호와 내가 추첨한 번호 비교, 분석하기. (if/else 구문)
if(match_cnt == 6)
    result = '1등'
elsif((match_cnt == 5) && my_numbers.include?(bonus_number))
    result = '2등'
elsif match_cnt == 5 
    result = '3등'
elsif match_cnt == 4
    result = '4등'
elsif match_cnt == 3
    result =  '5등'
else
    result = '꽝'
end

# 결과 출력.
print "이번주 로또 번호는 #{drw_numbers} 이고,  보너스 번호는 #{bonus_number} 입니다."
puts    # 줄 바꾸기
print "추첨한 로또 번호는 #{my_numbers} 입니다."
puts
print "겹치는 번호는 #{match_numbers} 입니다."
puts
puts  "결과는 #{result} 입니다."