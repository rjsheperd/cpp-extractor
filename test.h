#ifndef _ADDRESSBOOK_H_INCLUDED_
#define _ADDRESSBOOK_H_INCLUDED_

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
    Address(char* street, char* city, LocationType l, Point p);
    ~Address();

    void setStreet(char* street);
    char* getStreet();

    void setCity(char* city);
    char* getCity();

    void setLocationType(LocationType l);
    LocationType getLocationType();

    void setPoint(Point p);
    Point getPoint();

  private:
    char*        _street;
    char*        _city;
    LocationType _l;
    Point        _p;
  };

}

#endif
