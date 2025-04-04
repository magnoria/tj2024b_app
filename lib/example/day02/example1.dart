
void main(){

  // p.70 ~ p. 73 연산자

  //+ 덧셈
  int a = 2;
  int b = 1;
  print(a+b);

  String firstName = 'Jeongjoo';
  String lastName = "Lee";
  String fullName = lastName + ''+ firstName;
  print(fullName);

  //- 뺄셈
  print(a-b);

  //- 표현식
  print(-a);// 양수인 경우 음수 , 음수인경우 양수가 됨

  //- 곱셈
  print(a*b);

  print('*' * 5);// 문자열에 자연수 n을 곱하는 경우, 해당 문자열을 n번 반복

  //나눗셈

  int c = 10;
  int d = 4;
  print(c / d ); // 2.5

  //------- 아래 두개 결과 잘 보기

  // ~/
  print(c ~/d); // 2 결과가 정수인 나눗셈(나눗셈의 몫) 따라서, 정수 int끼리의 나눗셈의 결과는 정수가 됨

  // %
  print(c % d); //2 나눗셈의 나머지

  //++변수
  print(++a); // a=2 였음 연산자가 앞에 있으므로 "선반영"
  print(a);

  // 변수++
  print(a++);
  print(a); // 연산자가 뒤에 있으므로 "후반영" 되는것
  
  // --변수
  print(--b); // b 1임
  print(b);

  //변수--
  print(b--);
  print(b); //-1 연산자가 뒤에 있으므로 "후반영" 되는것

  // 두값이 같은지 비교
  print(a==b); //false 나옴 두값이 같은경우 true 아닌경우 false

  // !=
  print(a != b); // true

  // >
  print(a > b); // true 한 값이 다른 값보다 큰지 비교

  //<
  print(a < b); // false

  //>=
  print(a >= b); // true 한 값이 다른값보다 크거나 같은지 비교 왼쪽에 위치한 값이 크거나 같은 경우 true

  //<=

  print(a <= b); // false 이하 동문

  //=
  print(a); // 4
  a= 10;
  print(a); // 10 제할당

  // += , -+, *= 변수에 사칙연산 이후 재할당
  a*= 2; // a = a * 2
  print(a); // 20

  // !표현식
  bool result = a > b ;
  print(result); // true
  print(!result);// false 표현식의 결과를 뒤집음 true인 경우 false, false인경우 true

  // ||
  print(a > b); // true
  print(b > c); //false
  print(a > b || b > c);// true 여러개의 표현식을 or 조건으로 이어줌 여러개의 표현식중 하나의 표현식만 true여도 true

  // &&
  print(a > b); //true
  print(b > c); // false
  print(a<b && b>c); // false 여러개의 표현식 모두가 true 여야만 true


}