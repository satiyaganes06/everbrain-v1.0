
abstract class HmsRepository{

  Future<dynamic> initUrlCheck()  ;

  Future<dynamic> shutdownUrlCheck()  ;

  Future<dynamic> urlCheck(String url) ;

  Future<void> initUserDetect() ;

  Future<dynamic> shutdownUserDetect() ;

  Future<String?> userDetection() ;

}