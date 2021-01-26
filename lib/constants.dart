class Constants {
  String email = 'Dummy_email';
  String domain = 'dummy.com';
  String fullName = 'Dummy Name';
  String name = 'Dummy';
  String surName = 'Name';
  String categoryForHome = 'All';
  String password = 'dummypass';
  String version = '0.7';
  String currentDate = DateTime.now().toLocal().toString().split(' ')[0];

  void setEmail(String param) {
    this.email = param.split('@')[0];
    this.domain = param.split('@')[1];
  }

  void setName(String param) {
    this.fullName = param;
    this.name = this.fullName.split(' ')[0];
    this.surName =
        this.fullName.split(' ')[this.fullName.split(' ').length - 1];
  }
}

Constants ob = new Constants();
