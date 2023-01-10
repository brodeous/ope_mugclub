
class User {
    String first;
    String last;
    String email;
    String phone;
    String qrCode;
    int visits = 1;

    User({required this.first, required this.last, required this.email, required this.phone, required this.qrCode});
    

    String getFirst() => first;
    String getLast() => last;
    String getemail() => email;
    String getPhone() => phone;
    String getQRCode() => qrCode;
    int getVisits() => visits;

    void setFirst({required String first}) { this.first = first; }
    void setLast({required String last})   { this.last = last; }
    void setEmail({required String email}) { this.email = email; }
    void setPhone({required String phone}) { this.phone = phone; }
    void setQRCode({required String qrCode}) { this.qrCode = qrCode; }
    void addVisit() { visits += 1; }

    Map<String, String> toDict() {
        return {'visits' : '$visits',
                'first'  : first,
                'last'   : last,
                'email'  : email,
                'phone'  : phone,
                'qrCode' : qrCode};
    }
}
