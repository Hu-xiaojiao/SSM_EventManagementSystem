package com.eventmanagement.domain;


public class Event {

  private long eventId;
  private String eventName;
  private String eventDescription;
  private java.sql.Timestamp eventStartDate;
  private java.sql.Timestamp eventEndDate;
  private String location;
  private long organizerId;
  private String status;
  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;


  public long getEventId() {
    return eventId;
  }

  public void setEventId(long eventId) {
    this.eventId = eventId;
  }


  public String getEventName() {
    return eventName;
  }

  public void setEventName(String eventName) {
    this.eventName = eventName;
  }


  public String getEventDescription() {
    return eventDescription;
  }

  public void setEventDescription(String eventDescription) {
    this.eventDescription = eventDescription;
  }


  public java.sql.Timestamp getEventStartDate() {
    return eventStartDate;
  }

  public void setEventStartDate(java.sql.Timestamp eventStartDate) {
    this.eventStartDate = eventStartDate;
  }


  public java.sql.Timestamp getEventEndDate() {
    return eventEndDate;
  }

  public void setEventEndDate(java.sql.Timestamp eventEndDate) {
    this.eventEndDate = eventEndDate;
  }


  public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }


  public long getOrganizerId() {
    return organizerId;
  }

  public void setOrganizerId(long organizerId) {
    this.organizerId = organizerId;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
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
