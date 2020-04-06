//
//  Command+Index.swift
//  
//
//  Created by Vladislav Fitc on 19/03/2020.
//

import Foundation

extension Command {
  enum Index {}
}

extension Command.Index {
  
  struct DeleteIndex: AlgoliaCommand {
    
    let callType: CallType = .write
    let urlRequest: URLRequest
    let requestOptions: RequestOptions?
    
    init(indexName: IndexName,
         requestOptions: RequestOptions?) {
      self.requestOptions = requestOptions
      let path = .indexesV1 >>> IndexRoute.index(indexName)
      urlRequest = .init(method: .delete,
                         path: path,
                         requestOptions: requestOptions)
    }
    
  }
  
  struct Batch: AlgoliaCommand {
    
    let callType: CallType = .write
    let urlRequest: URLRequest
    let requestOptions: RequestOptions?
    
    init(indexName: IndexName,
         batchOperations: [BatchOperation],
         requestOptions: RequestOptions?) {
      self.requestOptions = requestOptions
      let path = .indexesV1 >>> .index(indexName) >>> IndexCompletion.batch
      let body = FieldWrapper(requests: batchOperations).httpBody
      urlRequest = .init(method: .post,
                         path: path,
                         body: body,
                         requestOptions: requestOptions)
    }
    
  }
  
  struct Operation: AlgoliaCommand {
    
    let callType: CallType = .write
    let urlRequest: URLRequest
    let requestOptions: RequestOptions?
    
    init(indexName: IndexName, operation: IndexOperation, requestOptions: RequestOptions?) {
      self.requestOptions = requestOptions
      let path = .indexesV1 >>> .index(indexName) >>> IndexCompletion.operation
      urlRequest = .init(method: .post, path: path, body: operation.httpBody, requestOptions: requestOptions)
    }
    
  }
  
}
