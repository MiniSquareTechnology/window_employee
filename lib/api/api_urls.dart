class ApiBaseUrl{

  static const baseUrl = "https://windows.minisquaretechnologies.com";

  static const login = "$baseUrl/api/v1/user/login";
  static const logout = "$baseUrl/api/v1/user/logout";
  static const createTicket = "$baseUrl/api/v1/user/create/ticket";
  static const ticketList = "$baseUrl/api/v1/user/ticketList";
  static const changeTicketStatus = "$baseUrl/api/v1/user/changeTicketStatus";
  static const sendMessage = "$baseUrl/api/v1/user/sendMessage";
  static const getMessages = "$baseUrl/api/v1/user/getMessages";
  static const updateStatus = "$baseUrl/api/v1/user/time/status/update";
  static const historyList = "$baseUrl/api/v1/user/get/history";
}