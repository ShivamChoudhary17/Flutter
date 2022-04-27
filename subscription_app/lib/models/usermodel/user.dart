//Creating a class user to store the data;
class User {
  final String id;
  final String uid;
  final String email;
  final String bank_name;
  final String bankAccNum;
 final String fullname;
 final String contact;
 final String bank_acc_no;
 final String ifsc_code;
 final String bank_branch;
 final String location;
 final String panno;
 final String message;
 final String firebase_token;
 final String agree;
 final String timestamp;
 final String status;

  User(
      {this.fullname="NAME",
        this.uid='js',
      this.contact="0802807427",
      this.email = "DNKJD@HKD",
      this.bank_name="DFKADJFN",
      this.bankAccNum='2',
      this.id='A',
      this. bank_acc_no='D',
      this.ifsc_code='SD',
      this.bank_branch='S',
      this.location='S',
      this.panno='S',
        this.message="jd",
        this.status='nds',
        this.timestamp='fjs',
        this.agree="dss",
        this.firebase_token="dnf",
      });

  factory User.fromMap(Map json) {
    return User(
        fullname: json["fullname"],
        uid: json["uid"],
        contact: json["contact"],
        email: json["email"],
        bank_name: json["bank_name"],
        bankAccNum: json["bank_acc_no"],
        ifsc_code: json["ifsc_code"],
        bank_branch: json["bank_branch"],
        location: json["location"],
        panno: json["panno"],
        message: json["message"],
        firebase_token: json["firebase_token"],
        agree: json["agree"],
        timestamp: json["timestamp"],
        status: json["status"]);
  }
}
