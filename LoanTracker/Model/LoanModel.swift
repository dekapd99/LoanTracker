import Foundation

struct LoanModel: Codable, Identifiable {
    let id: String
    let amount: Double
    let interestRate: Double
    let term: Int
    let purpose: String
    let riskRating: String
    let borrower: Borrower
    let collateral: Collateral
    let documents: [Document]
    let repaymentSchedule: RepaymentSchedule
}

struct Borrower: Codable {
    let id: String
    let name: String
    let email: String
    let creditScore: Int
}

struct Collateral: Codable {
    let type: String
    let value: Double
}

struct Document: Codable, Identifiable {
    var id: String { url }
    let type: String
    let url: String
}

struct RepaymentSchedule: Codable {
    let installments: [Installment]
}

struct Installment: Codable {
    let dueDate: String
    let amountDue: Double
}

// Sample data for preview
extension LoanModel {
    static var mockLoanModel: LoanModel {
        return LoanModel(
            id: "658539b43f5498ccae79105b",
            amount: 5000,
            interestRate: 0.8,
            term: 120,
            purpose: "Business Expansion",
            riskRating: "C",
            borrower: Borrower(
                id: "658539b489fdaab6eae418f3",
                name: "Shelly Valenzuela",
                email: "shellyvalenzuela@orbaxter.com",
                creditScore: 650
            ),
            collateral: Collateral(
                type: "Real Estate",
                value: 100000
            ),
            documents: [
                Document(
                    type: "Income Statement",
                    url: "/loans/documents/income_statement/slip-gaji-karyawan-pertamina.jpeg"
                )
            ],
            repaymentSchedule: RepaymentSchedule(
                installments: [
                    Installment(
                        dueDate: "2023-01-15",
                        amountDue: 500
                    ),
                    Installment(
                        dueDate: "2023-02-15",
                        amountDue: 500
                    )
                ]
            )
        )
    }
}
