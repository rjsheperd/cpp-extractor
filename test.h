namespace AddressBook {

  struct Point {
    double x;
    double y;
  };

  enum LocationType {
    Home,
    Work,
    Other
  };

  class Address {
  public:
    Address(char* street, char* city, Point p);
    ~Address();

    void setStreet(char* street);
    char* getStreet();

    void setCity(char* city);
    char* getCity();

    void setPoint(Point p);
    Point getPoint();

  private:
    char* _street;
    char* _city;
    Point p;
  };

}
