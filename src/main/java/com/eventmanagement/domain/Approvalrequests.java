package com.sample;


public class Approvalrequests {

  private long requestId;
  private long eventId;
  private long requesterId;
  private long approverId;
  private String status;
  private String comments;
  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;


  public long getRequestId() {
    return requestId;
  }

  public void setRequestId(long requestId) {
    this.requestId = requestId;
  }


  public long getEventId() {
    return eventId;
  }

  public void setEventId(long eventId) {
    this.eventId = eventId;
  }


  public long getRequesterId() {
    return requesterId;
  }

  public void setRequesterId(long requesterId) {
    this.requesterId = requesterId;
  }


  public long getApproverId() {
    return approverId;
  }

  public void setApproverId(long approverId) {
    this.approverId = approverId;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }


  public String getComments() {
    return comments;
  }

  public void setComments(String comments) {
    this.comments = comments;
  }


  public java.sql.Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(java.sql.Timestamp createdAt) {
    this.createdAt = createdAt;
  }


  public java.sql.Timestamp getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(java.sql.Timestamp updatedAt) {
    this.updatedAt = updatedAt;
  }

}
