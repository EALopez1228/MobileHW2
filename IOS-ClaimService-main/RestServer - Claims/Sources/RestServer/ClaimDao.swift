//
//  ClaimDao.swift
//  RestServer


import SQLite3
import Foundation
// Textbook uses JSONSerialization API (in Foundation module)
// JSONEncoder/JSONDecoder

struct Claim : Codable {
    var id : UUID?
    var title : String
    var date : String
    var isSolved : Bool?
    
    init(this_id : UUID?, this_title:String, this_date: String,this_isSolved:Bool?) {
            id = this_id
            title = this_title
            date = this_date
            isSolved = this_isSolved
    }
    init( this_title:String, this_date: String) {
            title = this_title
            date = this_date
    }
}

class ClaimDao {
    
    func addClaim(pObj : Claim) {
        let sqlStmt = String(format:"insert into Claim (id, title, date, isSolved) values ('%@', '%@', '%@','%@')", UUID().uuidString, (pObj.title), pObj.date,"0")
        // get database connection
        let conn = Database.getInstance().getDbConnection()
        // submit the insert sql statement
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let errcode = sqlite3_errcode(conn)
            print("Failed to insert a Claim record due to error \(errcode)")
        }
        // close the connection 
        sqlite3_close(conn)
    }
    
    func getAll() -> [Claim] {
        var pList = [Claim]()
        var resultSet : OpaquePointer?
        let sqlStr = "select id, title, date, isSolved from Claim"
        let conn = Database.getInstance().getDbConnection()
        if sqlite3_prepare_v2(conn, sqlStr, -1, &resultSet, nil) == SQLITE_OK {
            while(sqlite3_step(resultSet) == SQLITE_ROW) {
                // Convert the record into a Claim object
                // Unsafe_Pointer<CChar> Sqlite3
                let id_val = sqlite3_column_text(resultSet, 0)
                let id = UUID(uuidString: String(cString: id_val!))
                let title_val = sqlite3_column_text(resultSet, 1)
                let title = String(cString: title_val!)
                let date_val = sqlite3_column_text(resultSet, 2)
                let date = String(cString: date_val!)
                let isSolved_val = sqlite3_column_text(resultSet, 3)
                let isSolved = Bool(exactly: (Int(String(cString: isSolved_val!)))! as NSNumber)
                pList.append(Claim(this_id:id,this_title:title,this_date:date,this_isSolved:isSolved))
            }
        }
        return pList
    }
}
