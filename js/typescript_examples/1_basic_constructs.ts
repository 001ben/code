// Basic TS Example ====
function greeter(person) {
  return "Hello, " + person;
}

let user = "Jane User";
let greeting = greeter(user);
if (!!document) {
  document.getElementById('basic-greeter').innerHTML = greeting;
}
// ===

// Class TS Example ====
class Student {
  public fullName: string;
  constructor(public firstName: string, public middleInitial: string, public lastName: string) {
      this.fullName = `${firstName} ${middleInitial} ${lastName}`;
  }
}

interface IPerson {
  firstName: string;
  lastName: string;
}

function greeter2(person: IPerson) {
  return `Hello, ${person.firstName} ${person.lastName}`;
}
let user2 = new Student('John', 'D.', 'Doe');
let greeting2 =  greeter2(user2);
if (!!document) {
  document.getElementById('class-greeter').innerHTML = greeting2;
}
// ===
