void main(){
  // p. 67 레코드 , dart3 부터 추가된 타입
  //튜플 = 값의 묶음
    //익명 : 레코드에 속한 값들은 꼭 'key'를 가질 필요가 없다.

  //1. 레코드 생성하는 방법1
  var recod = ('firs' , a :2 , b: true, 'last');
  print(recod);

  //2. 레코드 생성하는 방법2 : 명시적 타입
  (String , int) record2;
  record2 = ('안녕' , 40); print(record2);

  //3. 레코드의 값 호출 *구조 분해 할당 가능*
  print(recod.$1 ); //key 가 존재하지 않은 value 첫번째 값
  print(recod.a); //'a' 라는 key의 값 반환
  print(recod.b); // 'b' 라는 key의 값 반환
  print(recod.$2); //key 가 존재하지 않은 value 두번째 값

  //4. JSON 형식
  var json ={'name' : 'Dash' , 'age' : 10 , 'color' : 'blue'}; //-> dynamic도 가능
  print(json);



}