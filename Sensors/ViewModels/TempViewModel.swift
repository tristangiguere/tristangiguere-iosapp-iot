import SwiftUI

class TempViewModel: ObservableObject {
    
    init(){
        //getAllData()
    }
    
    func getAllData(){
        getLastDayData()
        getLastWeekData()
        getLastMonthData()
        getLastData()
    }
    
    // Variables to hold the data for the first sensor
    @Published var sensor1_last_temp: Double = 0.0
    @Published var sensor1_last_humidity: Double = 0.0
    @Published var sensor1_lastDay_temp = [DataRecord(data: 0.0, data_type: "temperature", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor1_lastDay_humidity = [DataRecord(data: 0.0, data_type: "humidity", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor1_last7Days_temp = [DataRecord(data: 0.0, data_type: "temperature", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor1_last7Days_hum = [DataRecord(data: 0.0, data_type: "humidity", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor1_lastMonth_temp = [DataRecord(data: 0.0, data_type: "temperature", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor1_lastMonth_hum = [DataRecord(data: 0.0, data_type: "humidity", date_time: "", id: 0, pi_id: 0)]
    @Published var lastUpdated: String = "Never"
    
    // Variables to hold the data for the first sensor
    @Published var sensor2_last_temp: Double = 0.0
    @Published var sensor2_last_humidity: Double = 0.0
    @Published var sensor2_lastDay_temp = [DataRecord(data: 0.0, data_type: "temperature", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor2_lastDay_humidity = [DataRecord(data: 0.0, data_type: "humidity", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor2_last7Days_temp = [DataRecord(data: 0.0, data_type: "temperature", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor2_last7Days_hum = [DataRecord(data: 0.0, data_type: "humidity", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor2_lastMonth_temp = [DataRecord(data: 0.0, data_type: "temperature", date_time: "", id: 0, pi_id: 0)]
    @Published var sensor2_lastMonth_hum = [DataRecord(data: 0.0, data_type: "humidity", date_time: "", id: 0, pi_id: 0)]
    
    var base_url = "https://dmitryg.pythonanywhere.com/data"
    
    
    // Get temperature & humidity data for last month
    func getLastMonthData(){
        guard let url = URL(string: "\(base_url)/timerange/month") else { fatalError("Missing URL") }
                
            var urlRequest = URLRequest(url: url)
            let token = UserDefaults.standard.string(forKey: "authToken")
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async { [self] in
                        do {
                            let decodedValues = try JSONDecoder().decode([DataRecord].self, from: data)
                            let monthCombinedData = decodedValues
                            self.sensor1_lastMonth_temp = []
                            self.sensor2_lastMonth_temp = []
                            self.sensor1_lastMonth_hum = []
                            self.sensor2_lastMonth_hum = []

                            for dataRecord in monthCombinedData {
                                if(dataRecord.pi_id == 1 && dataRecord.data_type == "temperature") {
                                    self.sensor1_lastMonth_temp.append(dataRecord)
                                    print("\(dataRecord.data)ºC - \(dataRecord.date_time) - MONTH from PI \(dataRecord.pi_id) ")
                                    
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "temperature"){
                                    self.sensor2_lastMonth_temp.append(dataRecord)
                                    print("\(dataRecord.data)ºC - \(dataRecord.date_time) - MONTH from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 1 && dataRecord.data_type == "humidity") {
                                    self.sensor1_lastMonth_hum.append(dataRecord)
                                    print("\(dataRecord.data)% - \(dataRecord.date_time) - MONTH from PI \(dataRecord.pi_id) ")
                                    
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "humidity"){
                                    self.sensor2_lastMonth_hum.append(dataRecord)
                                    print("\(dataRecord.data)% - \(dataRecord.date_time) - MONTH from PI \(dataRecord.pi_id) ")
                                }
                                
                                else { print("No values corresponding to PIs in array.") }
                            }
                            
                            setLastUpdatedDate()
                            
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
            dataTask.resume()
            
        
        }
    
    // Get temperature & humidity data for last month
    func getLastWeekData(){
        guard let url = URL(string: "\(base_url)/timerange/week") else { fatalError("Missing URL") }
                
            var urlRequest = URLRequest(url: url)
            let token = UserDefaults.standard.string(forKey: "authToken")
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async { [self] in
                        do {
                            let decodedValues = try JSONDecoder().decode([DataRecord].self, from: data)
                            let monthCombinedData = decodedValues
                            self.sensor1_last7Days_temp = []
                            self.sensor2_last7Days_temp = []
                            self.sensor1_last7Days_hum = []
                            self.sensor2_last7Days_hum = []

                            for dataRecord in monthCombinedData {
                                if(dataRecord.pi_id == 1 && dataRecord.data_type == "temperature") {
                                    self.sensor1_last7Days_temp.append(dataRecord)
                                    print("\(dataRecord.data)ºC - \(dataRecord.date_time) - from PI \(dataRecord.pi_id) ")
                                    
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "temperature"){
                                    self.sensor2_last7Days_temp.append(dataRecord)
                                    print("\(dataRecord.data)ºC - \(dataRecord.date_time) - from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 1 && dataRecord.data_type == "humidity") {
                                    self.sensor1_last7Days_hum.append(dataRecord)
                                    print("\(dataRecord.data)% - \(dataRecord.date_time) - from PI \(dataRecord.pi_id) ")
                                    
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "humidity"){
                                    self.sensor2_last7Days_hum.append(dataRecord)
                                    print("\(dataRecord.data)% - \(dataRecord.date_time) - from PI \(dataRecord.pi_id) ")
                                }
                                
                                else { print("No values corresponding to PIs in array.") }
                            }

                            setLastUpdatedDate()
                            
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    
    // Get temperature & humidity data for last day
    func getLastDayData(){
        guard let url = URL(string: "\(base_url)/timerange/day") else { fatalError("Missing URL") }
                
            var urlRequest = URLRequest(url: url)
            let token = UserDefaults.standard.string(forKey: "authToken")
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async { [self] in
                        do {
                            let decodedValues = try JSONDecoder().decode([DataRecord].self, from: data)
                            let monthCombinedData = decodedValues
                            self.sensor1_lastDay_temp = []
                            self.sensor2_lastDay_temp = []
                            self.sensor1_lastDay_humidity = []
                            self.sensor2_lastDay_humidity = []

                            for dataRecord in monthCombinedData {
                                if(dataRecord.pi_id == 1 && dataRecord.data_type == "temperature") {
                                    self.sensor1_lastDay_temp.append(dataRecord)
                                    print("\(dataRecord.data)ºC - \(dataRecord.date_time) - (DAY) from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "temperature"){
                                    self.sensor2_lastDay_temp.append(dataRecord)
                                    print("\(dataRecord.data)ºC - \(dataRecord.date_time) - (DAY) from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 1 && dataRecord.data_type == "humidity") {
                                    self.sensor1_lastDay_humidity.append(dataRecord)
                                    print("\(dataRecord.data)% - \(dataRecord.date_time) - (DAY) from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "humidity"){
                                    self.sensor2_lastDay_humidity.append(dataRecord)
                                    print("\(dataRecord.data)% - \(dataRecord.date_time) - (DAY) from PI \(dataRecord.pi_id) ")
                                }
                                
                                else { print("No values corresponding to PIs in array.") }
                            }

                            setLastUpdatedDate()
                            
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    
    // Get the most recent temperature & humidity data
    func getLastData(){
        guard let url = URL(string: "\(base_url)/last") else { fatalError("Missing URL") }
                
            var urlRequest = URLRequest(url: url)
            let token = UserDefaults.standard.string(forKey: "authToken")
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async { [self] in
                        do {
                            let decodedValues = try JSONDecoder().decode([DataRecord].self, from: data)
                            let monthCombinedData = decodedValues

                            for dataRecord in monthCombinedData {
                                if(dataRecord.pi_id == 1 && dataRecord.data_type == "temperature") {
                                    self.sensor1_last_temp = dataRecord.data
                                    print("\(dataRecord.data)ºC - (LAST DATA)from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "temperature"){
                                    self.sensor2_last_temp = dataRecord.data
                                    print("\(dataRecord.data)ºC - (LAST DATA)from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 1 && dataRecord.data_type == "humidity") {
                                    self.sensor1_last_humidity = dataRecord.data
                                    print("\(dataRecord.data)ºC - (LAST DATA)from PI \(dataRecord.pi_id) ")
                                }
                                
                                else if(dataRecord.pi_id == 2 && dataRecord.data_type == "humidity"){
                                    self.sensor2_last_humidity = dataRecord.data
                                    print("\(dataRecord.data)ºC - (LAST DATA)from PI \(dataRecord.pi_id) ")
                                }
                                
                                else { print("No values corresponding to PIs in array.") }
                            }

                            setLastUpdatedDate()
                            
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    
    func setLastUpdatedDate(){
        // get the current date and time
        let currentDateTime = Date()

        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        
        self.lastUpdated = formatter.string(from: currentDateTime)
    }
}
