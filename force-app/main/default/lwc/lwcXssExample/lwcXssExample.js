import { LightningElement, track } from 'lwc';
export default class App extends LightningElement {
    richText = '<a href="http://www.evilsite.com/?data=sensitivedata" > Salesforce</a>'
   demographics = [
      {
         state: 'Washington',
         population: 7100000
      },
      {
         state: 'California',
         population: 270000000
      },
      {
         state: '<img src=x onerror=console.log(document.cookie) />',
         population: 21000000
      }
   ];
   renderedCallback() {
      const el1 = this.template.querySelector('.myList');
      const el2 = this.template.querySelector('.container');
      this.demographics.forEach((d) => {
         const li1 = document.createElement('li');
         li1.innerHTML = `${d.state} (pop: ${d.population})`;
         el1.appendChild(li1);

         const li2 = document.createElement('li');
         li2.innerHTML = `${d.state} (pop: ${d.population})`;
         el2.appendChild(li2);
      })
   }
}