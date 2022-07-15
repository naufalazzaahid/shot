# Shot
Shot is a dependency injection framework based on Sourcery. Upon compilation, it will generate the dependency injector classes. If you are not familiar with dependency injection, please read here https://stackify.com/dependency-injection/.

# Setup
1. Add `source 'https://github.com/naufalazzaahid/shot'` to your podfile
2. Add `pod 'Shot', 'x.y.z'` to your podfile
3. Add script for generating file (path are relative from script dir)
```yml
sources:
  - <Path to pods source>
templates:
  - <Path to pods root>/Pods/Shot/templates/ShotDI.stencil
output:
  path: <Path for output>
args:
  imports:
    # You can add another imports that are missing later
    - Shot
```
![script eg](https://user-images.githubusercontent.com/33716301/179170100-d3daf02b-48aa-4e12-8e69-5f6f85d313d6.png)

4. Add this script below to post execution build </br>
```
<Path to pods root>/Sourcery/bin/sourcery --config <Path to script from step 3>
```

# Try to build dependencies injection
1. Create Module
Module is a class for defining all of the dependencies. Module can define its object lifetime by implementing those protocol below:
- FactoryModule: Will recreated every time when the is used as dependencies/injection.
- ClassModule: Will created ONLY ONCE when used/called as dependencies/injection. But the lifetime is tied to the injected class.
- SingletonModule: Will created ONLY ONCE and used as a singelon.

Example:
```swift
class CarPartsModule: FactoryModule {
  func provideWheel() -> Wheel {
    return WheelImpl()
  }
  
  func provideEngine() -> Engine {
    return EngineImpl()
  }
}

class CarModule: FactoryModule {
  //Lets say you need Wheel and Engine for a car, just state it in the parameter
  func provideCar(wheel: Wheel, engine: Engine) -> Car {
    return CarImpl(wheel, engine)
  }
}

```
Based on the class above we already know how to make a Car. CarModule state that Car need wheel and engine for creating it. And the creation of wheel and engine is provided also from the CarPartsModule. Now lets connect all of those module.

2. Create Component
Component is a class that will aggregate all of the modules. Lets create a component for aggregating all of the module in step 1.
Example:
```swift
class MyComponent: DIComponent {
  //Listing all of the modules here
  var carPartsModule: CarPartsModule { get }
  var carModule: CarModule { get }

  //Builder - Need to create this for component
  func builder()
}
```
In component class above, CarPartsModule and CarModule are already defined. Try to build your apps right now. It should be generating a folder called `shot_generated` and it will some generated file. You must manually link all of those file to your project.
Note: If you miss a dependencies that needed by a class, the compile will be error.

3. Init component in App
After build, it will generated a class called `Shot${ComponentName}`. In our case it will be ShotMyComponent. Call this function on App class for init the component:
```
ShotMyComponent.create()
```

4. Add class that will be injected
Now all of the class in your module are ready to be injected. Lets say we want to inject our Car into our CarShow class. Lets add that into our component first
```swift
class MyComponent: DIComponent {
  //Listing all of the modules here
  var carPartsModule: CarPartsModule { get }
  var carModule: CarModule { get }

  //Builder - Need to create this for component
  func builder()
  
  //Inject - class that will be injected is CarShow. You can add multiple method here
  func inject(carshow: CarShow)
}
```
Build your app, then lets inject it to the class directly
```swift
class CarShow {
  //Actually we can also inject all of the class that defined in modules
  @Inject var car: Car!
  
  //Inject will automatically generated to instantiate the @Inject object!
  init() {
    inject()
  }
}
```
And thats it! Now you can use the Car, and the inject will take care of the object creation!

# Advanced Topic
This will cover some advanced topic related to dependency injection

## Named object provider
Sometimes we need a same base class but with different implementation. What is that and how we do it? Lets take an example:

```swift
class CarPartsModule: FactoryModule {
  // sourcery: named = "smoothWheel"
  func provideSmoothWheel() -> Wheel {
    return SmoothWheelImpl()
  }
  
  // sourcery: named = "spikyWheel"
  func provideSpikyWheel() -> Wheel {
    return SpikyWheelImpl()
  }
  
  func provideEngine() -> Engine {
    return EngineImpl()
  }
}

class CarModule: FactoryModule {
  func provideSmoothCar(
    // sourcery: named = "smoothWheel"
    wheel: Wheel, 
    engine: Engine
  ) -> Car {
    return CarImpl(wheel, engine)
  }
  
  func provideSpikyCar(
    // sourcery: named = "spikyWheel"
    wheel: Wheel, 
    engine: Engine
  ) -> Car {
    return CarImpl(wheel, engine)
  }
}

```
So as you can see above if you give a `// sourcery: named = "smoothWheel"` to the module provider, it become unique and later can be defined as dependency also.
- provideSmoothCar will use a Whell class that named `smoothWheel`
- provideSpikyCar will use a Whell class that named `spikyWheel`

NOTE: THE NAMED SHOULD BE UNIQUE!
