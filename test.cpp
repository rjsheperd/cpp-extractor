
#include "test.h"

using namespace AddressBook;

Address::Address(char* street, char* city, LocationType l, Point p) {
  _street = street;
  _city = city;
  _l = l;
  _p = p;
};

void Address::setStreet(char* street){
  _street = street;
}

char* Address::getStreet(){
  return _street;
}

void Address::setCity(char* city){
  _city = city;
}

char* Address::getCity(){
  return _city;
}

void Address::setLocationType(LocationType l){
  _l = l;
}

LocationType Address::getLocationType(){
  return _l;
}

void Address::setPoint(Point p){
  _p = p;
}

Point Address::getPoint(){
  return _p;
}
