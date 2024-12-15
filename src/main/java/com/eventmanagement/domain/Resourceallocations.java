package com.sample;


public class Resourceallocations {

  private long allocationId;
  private long eventId;
  private String resourceType;
  private String resourceName;
  private long quantity;
  private long allocatedById;
  private String status;
  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;


  public long getAllocationId() {
    return allocationId;
  }

  public void setAllocationId(long allocationId) {
    this.allocationId = allocationId;
  }


  public long getEventId() {
    return eventId;
  }

  public void setEventId(long eventId) {
    this.eventId = eventId;
  }


  public String getResourceType() {
    return resourceType;
  }

  public void setResourceType(String resourceType) {
    this.resourceType = resourceType;
  }


  public String getResourceName() {
    return resourceName;
  }

  public void setResourceName(String resourceName) {
    this.resourceName = resourceName;
  }


  public long getQuantity() {
    return quantity;
  }

  public void setQuantity(long quantity) {
    this.quantity = quantity;
  }


  public long getAllocatedById() {
    return allocatedById;
  }

  public void setAllocatedById(long allocatedById) {
    this.allocatedById = allocatedById;
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
