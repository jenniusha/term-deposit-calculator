# Term Deposit Calculator – Salesforce DX Project

A Salesforce DX project that implements a Term Deposit Calculator using **Apex classes** and **Lightning Web Components (LWC)**. Includes test classes, configuration, and step‑by‑step deployment instructions.

---

## 🚀 Prerequisites

- [Salesforce CLI (sfdx)](https://developer.salesforce.com/tools/sfdxcli) installed
- [Visual Studio Code](https://code.visualstudio.com/) with [Salesforce Extensions](https://developer.salesforce.com/tools/vscode/)
- Access to a Salesforce **Developer Org** or ability to create a **Scratch Org**

---

## 🛠️ Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/term-deposit-calculator.git
cd term-deposit-calculator
```

### 2. Authorize Your Org
```bash
sfdx auth:web:login -a MyDevOrg
```

### 3. (Optional) Create a Scratch Org
```bash
sfdx force:org:create -s -f config/project-scratch-def.json -a TermDepositScratch
```

### 4. Push Source to Org
```bash
sfdx force:source:push -u MyDevOrg
```

### 5. Assign Permission Set
```bash
sfdx force:user:permset:assign -n TermDepositCalculatorPermissions -u MyDevOrg
```


### 6. Run Apex Tests
```bash
sfdx force:apex:test:run -u MyDevOrg --result-format human --code-coverage
```


### 7. Open Org
```bash
sfdx force:org:open -u MyDevOrg
```

### 8. Add Component to Lightning Page
Navigate to Setup → Lightning App Builder

Create or edit a Lightning page

Drag TermDepositCalculator LWC onto the page

Save and activate the page

## 📂 Project Structure

- force-app/main/default/classes → Apex classes & test classes  
- force-app/main/default/lwc/termDepositCalculator → LWC (JS, HTML, CSS)  
- sfdx-project.json → Project configuration


## 🧩 Troubleshooting

- **Auth issues** → Run `sfdx auth:web:login` again  
- **Push failures** → Ensure you’re targeting the correct org with `-u MyDevOrg`  
- **Test failures** → Run `sfdx force:apex:test:run --code-coverage` and check logs  


## 📜 License
This project is licensed under the MIT License.


### 🔹 Step 3: Commit and Push
```powershell
git add README.md
git commit -m "Update README.md with full setup guide"
git push origin main

## 📊 Usage Example

Suppose you enter:
- Principal: ₹10,000  
- Interest Rate: 1.10% per annum  
- Tenure: 3 years  
- Interest Frequency: Maturity  

The calculator will display:  
**Maturity Amount = ₹10,330.00**

### 🔎 Calculation
Formula for simple interest at maturity:


\[
Final\ Amount = Principal \times (1 + Rate \times Years)
\]


Substitute values:


\[
10{,}000 \times (1 + 0.011 \times 3) = 10{,}330
\]


