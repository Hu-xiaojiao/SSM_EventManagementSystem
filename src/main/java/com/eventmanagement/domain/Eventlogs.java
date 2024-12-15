package com.sample;


public class Eventlogs {

  private long logId;
  private long eventId;
  private long userId;
  private String action;
  private String details;
  private java.sql.Timestamp logTimestamp;


  public long getLogId() {
    return logId;
  }

  public void setLogId(long logId) {
    this.logId = logId;
  }


  public long getEventId() {
    return eventId;
  }

  public void setEventId(long eventId) {
    this.eventId = eventId;
  }


  public long getUserId() {
    return userId;
  }

  public void setUserId(long userId) {
    this.userId = userId;
  }


  public String getAction() {
    return action;
  }

  public void setAction(String action) {
    this.action = action;
  }


  public String getDetails() {
    return details;
  }

  public void setDetails(String details) {
    this.details = details;
  }


  public java.sql.Timestamp getLogTimestamp() {
    return logTimestamp;
  }

  public void setLogTimestamp(java.sql.Timestamp logTimestamp) {
    this.logTimestamp = logTimestamp;
  }

}
