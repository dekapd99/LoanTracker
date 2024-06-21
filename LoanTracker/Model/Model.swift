import Foundation

struct Loan: Codable, Identifiable {
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

struct Document: Codable {
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
