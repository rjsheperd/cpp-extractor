class Vehicle {
private:
  int m_axles;

public:
  int Axles() {
    return(m_axles);
  }

  bool Available;

  Vehicle() {
    Available=false;
    m_axles=2;
  }

  Vehicle(int ax) {
    Available=false;
    m_axles=ax;
  }
};
