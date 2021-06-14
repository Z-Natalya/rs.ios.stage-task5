import Foundation

class StockMaximize {
    
    func countProfit(prices: [Int]) -> Int {
        var prisesNew = prices
        var profit = 0
        var result = 0
        
        if prices.count > 0 {
           for  indexNumMin in 1..<prisesNew.count  {
                let numMin = prisesNew.reduce(Int.max, { min($0, $1) })
                let numMax = prisesNew.reduce(Int.min, { max($0, $1) })
                let indexNumMin = prisesNew.firstIndex(of: numMin)
                let indexNumMax = prisesNew.firstIndex(of: numMax)
                if indexNumMax! > indexNumMin! {
                    profit = numMax - numMin
                    prisesNew.remove(at: indexNumMin!)
                }
                else {
                    prisesNew.remove(at: indexNumMax!)
                    profit = 0
                }
                result += profit
            }
           
        }
        return result
    }
}
