import UIKit

//MARK: - Protocol

protocol Row {

    associatedtype Model

    func configure(with model: Model)

}

struct Product { }

//MARK: - Constrained Type Erasure

struct AnyRow<I>: Row {

    //MARK: - Private properties

    private let configureClosure: (I) -> Void

    //MARK: - Initialization

    init<T: Row>(_ row: T) where T.Model == I {
        configureClosure = row.configure
    }

    //MARK: - Public

    func configure(with model: I) {
        configureClosure(model)
    }

}

//MARK: - ProductCell

class ProductCell: Row {

    //MARK: - Public properties

    typealias Model = Product
    let name: String

    //MARK: - Initialization

    init(name: String) {
        self.name = name
    }

    //MARK: - Public

    func configure(with model: Model) {
        print("Configured based on \(type(of: self))")
    }

}

//MARK: - ProductDetailsCell

class ProductDetailsCell: Row {

    //MARK: - Public properties

    typealias Model = Product
    let name: String
    let category: String

    //MARK: - Initialization

    init(name: String, category: String) {
        self.name = name
        self.category = category
    }

    //MARK: - Public

    func configure(with model: Model) {
        print("Configured based on \(type(of: self))")
    }

}

let productCell = ProductCell(name: "SomeProduct")
let productDetailsCell = ProductDetailsCell(name: "SomeProductDetail", category: "SomeCategory")
let cells: [AnyRow<Product>] = [AnyRow(productCell), AnyRow(productDetailsCell)]
let product = Product()
cells.forEach { cell in cell.configure(with: product) }
