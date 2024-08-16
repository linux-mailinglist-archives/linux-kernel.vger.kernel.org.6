Return-Path: <linux-kernel+bounces-289821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C57954BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794BA286641
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BD1C68AC;
	Fri, 16 Aug 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBgB6liB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE061C6891;
	Fri, 16 Aug 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817327; cv=none; b=HFYtelp6Gm3Rdm90IzulNio8C8PVNRfj8s2nXS05t38PBJ1U/t/b+542VQZhgu54ZOCwfa+Tqin3ralRj9sKFg//J9Dy7iNQRJk8gEGVLJzIGXfH4TTGY4oblELJdWXsZTD5+CKfNIkfTMXnsjiNM7IKIIfiEon6LPwmCJpObR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817327; c=relaxed/simple;
	bh=93w/ASZfzWrnv/uCVUGHvBklgBaRWfbpAL8bkpVo3O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFk5feOKY7T9giBipXff/Brp7xmmF3DDQ/+m97+26l14fB90o1mDx7ASsGG4RFiGx9HLpNM+thOhTQQbWTxZSWALiQXr67U5xO/l9IGPv0cj40gYhrdOV2P9kehoyyDhNqpmfvBXq4dhmOlI+SwkakgIGukqCwSGaOR8RzUXzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBgB6liB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817326; x=1755353326;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=93w/ASZfzWrnv/uCVUGHvBklgBaRWfbpAL8bkpVo3O8=;
  b=aBgB6liBmxaOY8vkTg9TR0Y+Prv27tMjhEhVHDSJ/pvNQIg5jcTS1MNK
   7ENUgZSQ/WiiNuMYS+QbIGK5fVnlLDoXMwkqDI6HUdbJp52X51k2JOdRx
   aaFfGOOQtgqS5moXN/VQJXhdNvgZsRf40qcREBs4xT1JpGozMqqmfdAaH
   6v4vNROUaZ0W4Ms2xIyxsHUpF8wcfqUUBgl3gjjJSC6nlbP9naquuzC2s
   8zqF3XU3pgwt2u/ByBD6XGjDWXVpTuef6B/nsNBziDYWQBpoPYRzULICy
   fkOPeyRl7GUpK5yfvKkCn4h9hb+JhJbk/EJruh61PRIIIxcv1u9wYxCI2
   w==;
X-CSE-ConnectionGUID: 2eDcTkl5T2O8GTi/A7Oraw==
X-CSE-MsgGUID: fxDSwUl/Rfalvr8KZY9EEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22085322"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22085322"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:46 -0700
X-CSE-ConnectionGUID: elovYeeMSOKF+vhBMVw+GQ==
X-CSE-MsgGUID: GJ82H05WSpi7HKsM8nBBEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64571666"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:44 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:21 -0500
Subject: [PATCH RESEND v2 16/18] tools/testing/cxl: Make event logs dynamic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-16-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=15039;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=93w/ASZfzWrnv/uCVUGHvBklgBaRWfbpAL8bkpVo3O8=;
 b=miaoJLoChHiqe2ZkufDTonMjdqsLXGh0J+dLWMq1WhA1Dpn9BeSNJ2SVmDQkvLFjOrq2yRTvE
 CeoXAC+5YmeAKOqHdEqvbbn7ZsgCEu5bG2TWJjEixZNXwY6RS6CHxD5
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The test event logs were created as static arrays as an easy way to mock
events.  Dynamic Capacity Device (DCD) test support requires events be
created dynamically when extents are created/destroyed.

Modify the event log storage to be dynamically allocated.  Thus they can
accommodate the dynamic events required by DCD.  Reuse the static event
data to create the dynamic events in the new logs without inventing
complex event injection through the test sysfs.  Simplify the processing
of the logs by using the event log array index as the handle.  Add a
lock to manage concurrency to come with DCD extent testing.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 276 ++++++++++++++++++++++++++-----------------
 1 file changed, 170 insertions(+), 106 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 51be202fabd0..6a036c8d215d 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -118,18 +118,27 @@ static struct {
 
 #define PASS_TRY_LIMIT 3
 
-#define CXL_TEST_EVENT_CNT_MAX 15
+#define CXL_TEST_EVENT_CNT_MAX 17
 
 /* Set a number of events to return at a time for simulation.  */
 #define CXL_TEST_EVENT_CNT 3
 
+/*
+ * @next_handle: next handle (index) to be stored to
+ * @cur_handle: current handle (index) to be returned to the user on get_event
+ * @nr_events: total events in this log
+ * @nr_overflow: number of events added past the log size
+ * @lock: protect these state variables
+ * @events: array of pending events to be returned.
+ */
 struct mock_event_log {
-	u16 clear_idx;
-	u16 cur_idx;
+	u16 next_handle;
+	u16 cur_handle;
 	u16 nr_events;
 	u16 nr_overflow;
-	u16 overflow_reset;
-	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
+	rwlock_t lock;
+	/* 1 extra slot to accommodate that handles can't be 0 */
+	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX+1];
 };
 
 struct mock_event_store {
@@ -163,64 +172,76 @@ static struct mock_event_log *event_find_log(struct device *dev, int log_type)
 	return &mdata->mes.mock_logs[log_type];
 }
 
-static struct cxl_event_record_raw *event_get_current(struct mock_event_log *log)
-{
-	return log->events[log->cur_idx];
-}
-
-static void event_reset_log(struct mock_event_log *log)
-{
-	log->cur_idx = 0;
-	log->clear_idx = 0;
-	log->nr_overflow = log->overflow_reset;
-}
-
-/* Handle can never be 0 use 1 based indexing for handle */
-static u16 event_get_clear_handle(struct mock_event_log *log)
-{
-	return log->clear_idx + 1;
-}
-
 /* Handle can never be 0 use 1 based indexing for handle */
-static __le16 event_get_cur_event_handle(struct mock_event_log *log)
+static void event_inc_handle(u16 *handle)
 {
-	u16 cur_handle = log->cur_idx + 1;
-
-	return cpu_to_le16(cur_handle);
-}
-
-static bool event_log_empty(struct mock_event_log *log)
-{
-	return log->cur_idx == log->nr_events;
+	*handle = (*handle + 1) % CXL_TEST_EVENT_CNT_MAX;
+	if (!*handle)
+		*handle = *handle + 1;
 }
 
+/* Add the event or free it on 'overflow' */
 static void mes_add_event(struct mock_event_store *mes,
 			  enum cxl_event_log_type log_type,
 			  struct cxl_event_record_raw *event)
 {
+	struct device *dev = mes->mds->cxlds.dev;
 	struct mock_event_log *log;
+	u16 handle;
 
 	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
 		return;
 
 	log = &mes->mock_logs[log_type];
 
-	if ((log->nr_events + 1) > CXL_TEST_EVENT_CNT_MAX) {
+	write_lock(&log->lock);
+
+	handle = log->next_handle;
+	if ((handle + 1) == log->cur_handle) {
 		log->nr_overflow++;
-		log->overflow_reset = log->nr_overflow;
-		return;
+		dev_dbg(dev, "Overflowing %d\n", log_type);
+		devm_kfree(dev, event);
+		goto unlock;
 	}
 
-	log->events[log->nr_events] = event;
+	dev_dbg(dev, "Log %d; handle %u\n", log_type, handle);
+	event->hdr.handle = cpu_to_le16(handle);
+	log->events[handle] = event;
+	event_inc_handle(&log->next_handle);
 	log->nr_events++;
+
+unlock:
+	write_unlock(&log->lock);
+}
+
+static void mes_del_event(struct device *dev,
+			  struct mock_event_log *log,
+			  u16 handle)
+{
+	struct cxl_event_record_raw *cur;
+
+	lockdep_assert(lockdep_is_held(&log->lock));
+
+	dev_dbg(dev, "Clearing event %u; cur %u\n", handle, log->cur_handle);
+	cur = log->events[handle];
+	if (!cur) {
+		dev_err(dev, "Mock event index %u empty? nr_events %u",
+			handle, log->nr_events);
+		return;
+	}
+	log->events[handle] = NULL;
+
+	event_inc_handle(&log->cur_handle);
+	log->nr_events--;
+	devm_kfree(dev, cur);
 }
 
 static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
-	u16 nr_overflow;
 	u8 log_type;
+	u16 handle;
 	int i;
 
 	if (cmd->size_in != sizeof(log_type))
@@ -233,30 +254,38 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 	if (log_type >= CXL_EVENT_TYPE_MAX)
 		return -EINVAL;
 
-	memset(cmd->payload_out, 0, cmd->size_out);
-
 	log = event_find_log(dev, log_type);
-	if (!log || event_log_empty(log))
+	if (!log)
 		return 0;
 
+	memset(cmd->payload_out, 0, cmd->size_out);
 	pl = cmd->payload_out;
 
-	for (i = 0; i < CXL_TEST_EVENT_CNT && !event_log_empty(log); i++) {
-		memcpy(&pl->records[i], event_get_current(log),
-		       sizeof(pl->records[i]));
-		pl->records[i].hdr.handle = event_get_cur_event_handle(log);
-		log->cur_idx++;
+	read_lock(&log->lock);
+
+	handle = log->cur_handle;
+	dev_dbg(dev, "Get log %d handle %u next %u\n",
+		log_type, handle, log->next_handle);
+	for (i = 0;
+	     i < CXL_TEST_EVENT_CNT && handle != log->next_handle;
+	     i++, event_inc_handle(&handle)) {
+		struct cxl_event_record_raw *cur;
+
+		cur = log->events[handle];
+		dev_dbg(dev, "Sending event log %d handle %d idx %u\n",
+			log_type, le16_to_cpu(cur->hdr.handle), handle);
+		memcpy(&pl->records[i], cur, sizeof(pl->records[i]));
 	}
 
 	pl->record_count = cpu_to_le16(i);
-	if (!event_log_empty(log))
+	if (log->nr_events > i)
 		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
 
 	if (log->nr_overflow) {
 		u64 ns;
 
 		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
-		pl->overflow_err_count = cpu_to_le16(nr_overflow);
+		pl->overflow_err_count = cpu_to_le16(log->nr_overflow);
 		ns = ktime_get_real_ns();
 		ns -= 5000000000; /* 5s ago */
 		pl->first_overflow_timestamp = cpu_to_le64(ns);
@@ -265,16 +294,17 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 		pl->last_overflow_timestamp = cpu_to_le64(ns);
 	}
 
+	read_unlock(&log->lock);
 	return 0;
 }
 
 static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
-	struct mock_event_log *log;
 	u8 log_type = pl->event_log;
+	struct mock_event_log *log;
+	int nr, rc = 0;
 	u16 handle;
-	int nr;
 
 	if (log_type >= CXL_EVENT_TYPE_MAX)
 		return -EINVAL;
@@ -283,24 +313,23 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 	if (!log)
 		return 0; /* No mock data in this log */
 
-	/*
-	 * This check is technically not invalid per the specification AFAICS.
-	 * (The host could 'guess' handles and clear them in order).
-	 * However, this is not good behavior for the host so test it.
-	 */
-	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
-		dev_err(dev,
-			"Attempting to clear more events than returned!\n");
-		return -EINVAL;
-	}
+	write_lock(&log->lock);
 
 	/* Check handle order prior to clearing events */
-	for (nr = 0, handle = event_get_clear_handle(log);
-	     nr < pl->nr_recs;
-	     nr++, handle++) {
+	handle = log->cur_handle;
+	for (nr = 0;
+	     nr < pl->nr_recs && handle != log->next_handle;
+	     nr++, event_inc_handle(&handle)) {
+
+		dev_dbg(dev, "Checking clear of %d handle %u plhandle %u\n",
+			log_type, handle,
+			le16_to_cpu(pl->handles[nr]));
+
 		if (handle != le16_to_cpu(pl->handles[nr])) {
-			dev_err(dev, "Clearing events out of order\n");
-			return -EINVAL;
+			dev_err(dev, "Clearing events out of order %u %u\n",
+				handle, le16_to_cpu(pl->handles[nr]));
+			rc = -EINVAL;
+			goto unlock;
 		}
 	}
 
@@ -308,25 +337,12 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 		log->nr_overflow = 0;
 
 	/* Clear events */
-	log->clear_idx += pl->nr_recs;
-	return 0;
-}
+	for (nr = 0; nr < pl->nr_recs; nr++)
+		mes_del_event(dev, log, le16_to_cpu(pl->handles[nr]));
 
-static void cxl_mock_event_trigger(struct device *dev)
-{
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
-	struct mock_event_store *mes = &mdata->mes;
-	int i;
-
-	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
-		struct mock_event_log *log;
-
-		log = event_find_log(dev, i);
-		if (log)
-			event_reset_log(log);
-	}
-
-	cxl_mem_get_event_records(mes->mds, mes->ev_status);
+unlock:
+	write_unlock(&log->lock);
+	return rc;
 }
 
 struct cxl_event_record_raw maint_needed = {
@@ -429,8 +445,29 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-static void cxl_mock_add_event_logs(struct mock_event_store *mes)
+/* Create a dynamically allocated event out of a statically defined event. */
+static void add_event_from_static(struct mock_event_store *mes,
+				  enum cxl_event_log_type log_type,
+				  struct cxl_event_record_raw *raw)
+{
+	struct device *dev = mes->mds->cxlds.dev;
+	struct cxl_event_record_raw *rec;
+
+	rec = devm_kzalloc(dev, sizeof(*rec), GFP_KERNEL);
+	if (!rec) {
+		dev_err(dev, "Failed to alloc event for log\n");
+		return;
+	}
+
+	memcpy(rec, raw, sizeof(*rec));
+	mes_add_event(mes, log_type, rec);
+}
+
+static void cxl_mock_add_event_logs(struct cxl_mockmem_data *mdata)
 {
+	struct mock_event_store *mes = &mdata->mes;
+	struct device *dev = mes->mds->cxlds.dev;
+
 	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
 			   &gen_media.validity_flags);
 
@@ -438,43 +475,60 @@ static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
 			   &dram.validity_flags);
 
-	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
-	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
+	dev_dbg(dev, "Generating fake event logs %d\n",
+		CXL_EVENT_TYPE_INFO);
+	add_event_from_static(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
+	add_event_from_static(mes, CXL_EVENT_TYPE_INFO,
 		      (struct cxl_event_record_raw *)&gen_media);
-	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
+	add_event_from_static(mes, CXL_EVENT_TYPE_INFO,
 		      (struct cxl_event_record_raw *)&mem_module);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
 
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	dev_dbg(dev, "Generating fake event logs %d\n",
+		CXL_EVENT_TYPE_FAIL);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
+		      (struct cxl_event_record_raw *)&mem_module);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&dram);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&gen_media);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&mem_module);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&dram);
 	/* Overflow this log */
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
 
-	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
+	dev_dbg(dev, "Generating fake event logs %d\n",
+		CXL_EVENT_TYPE_FATAL);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+	add_event_from_static(mes, CXL_EVENT_TYPE_FATAL,
 		      (struct cxl_event_record_raw *)&dram);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
 }
 
+static void cxl_mock_event_trigger(struct device *dev)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct mock_event_store *mes = &mdata->mes;
+
+	cxl_mock_add_event_logs(mdata);
+	cxl_mem_get_event_records(mes->mds, mes->ev_status);
+}
+
 static int mock_gsl(struct cxl_mbox_cmd *cmd)
 {
 	if (cmd->size_out < sizeof(mock_gsl_payload))
@@ -1391,6 +1445,14 @@ static ssize_t event_trigger_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(event_trigger);
 
+static void init_event_log(struct mock_event_log *log)
+{
+	rwlock_init(&log->lock);
+	/* Handle can never be 0 use 1 based indexing for handle */
+	log->cur_handle = 1;
+	log->next_handle = 1;
+}
+
 static int __cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1458,7 +1520,9 @@ static int __cxl_mock_mem_probe(struct platform_device *pdev)
 		return rc;
 
 	mdata->mes.mds = mds;
-	cxl_mock_add_event_logs(&mdata->mes);
+	for (int i = 0; i < CXL_EVENT_TYPE_MAX; i++)
+		init_event_log(&mdata->mes.mock_logs[i]);
+	cxl_mock_add_event_logs(mdata);
 
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))

-- 
2.45.2


