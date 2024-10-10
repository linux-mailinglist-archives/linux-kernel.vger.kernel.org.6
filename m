Return-Path: <linux-kernel+bounces-358772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B31B998378
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFFE1F23A30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3291C243A;
	Thu, 10 Oct 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="k8KZvuPc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998A1BFE1A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555812; cv=none; b=sb4iVmbL04KP5kSBd1EQfABN0qdHRmD2B/xYU+TByi5b5oGJAq9V2/ciUpl/Jaz5mC6xTq8u1qCkJu8RdCJ9HWxnNOnNmaTh3o2jlJv3cCmGPukMzcTpsLE4DDz9VSeppKo/27tmig+Kj7BkV0Tcb9R0AgQAiarK6Tbffn17qTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555812; c=relaxed/simple;
	bh=/EcI/XV+/Sh4a+TZw9I3cKKIBdcOZg82XQwjyZRX5mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAf/u2/KBPOvelr72iUF2QpMr8mGRAgj5g2Ev1OnwqVk0XoNco/bTTOfCLOQoj1asENyDwMumefPkqCjkjMxIsgShtabd07ABy6PEkzT9NuR1ObhXcz8DBpAGw68eoaaaIQSveLnjbqUidTnNC6PaW9VtxQhRrAJi2BbvaZ8I9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=k8KZvuPc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00B66A8F;
	Thu, 10 Oct 2024 12:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728555704;
	bh=/EcI/XV+/Sh4a+TZw9I3cKKIBdcOZg82XQwjyZRX5mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8KZvuPcEqXxicFmFSSrNdXn3qw67Ie2tet7dugHqXFWsAUim6shmuqhkNgWhWX4P
	 5IVK0MXrRQGADytBm0fkzlRCLzfKjmkRfMLuHdl4kRmwyno7WS0xOBsxam5hiec8Ty
	 hCU37mHlbWuUWk7OBjFGR8CALxGuiG1zJHnDWrNA=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 3/5] staging: vchiq_core: Reflow long lines to 80 columns
Date: Thu, 10 Oct 2024 15:52:47 +0530
Message-ID: <20241010102250.236545-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010102250.236545-1-umang.jain@ideasonboard.com>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to respect the coding style, wrap long lines in vchiq_core.c
to fit in 80 columns.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 267 +++++++++++-------
 1 file changed, 168 insertions(+), 99 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 1e4b2978c186..8be2dcf3658c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -227,7 +227,8 @@ set_service_state(struct vchiq_service *service, int newstate)
 	service->srvstate = newstate;
 }
 
-struct vchiq_service *handle_to_service(struct vchiq_instance *instance, unsigned int handle)
+struct vchiq_service *handle_to_service(struct vchiq_instance *instance,
+					unsigned int handle)
 {
 	int idx = handle & (VCHIQ_MAX_SERVICES - 1);
 
@@ -249,7 +250,8 @@ find_service_by_handle(struct vchiq_instance *instance, unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	dev_dbg(instance->state->dev, "core: Invalid service handle 0x%x\n", handle);
+	dev_dbg(instance->state->dev, "core: Invalid service handle 0x%x\n",
+		handle);
 	return NULL;
 }
 
@@ -289,12 +291,15 @@ find_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	dev_dbg(instance->state->dev, "core: Invalid service handle 0x%x\n", handle);
+	dev_dbg(instance->state->dev, "core: Invalid service handle 0x%x\n",
+		handle);
+
 	return NULL;
 }
 
 struct vchiq_service *
-find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
+find_closed_service_for_instance(struct vchiq_instance *instance,
+				 unsigned int handle)
 {
 	struct vchiq_service *service;
 
@@ -311,7 +316,9 @@ find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int h
 		return service;
 	}
 	rcu_read_unlock();
-	dev_dbg(instance->state->dev, "core: Invalid service handle 0x%x\n", handle);
+	dev_dbg(instance->state->dev, "core: Invalid service handle 0x%x\n",
+		handle);
+
 	return service;
 }
 
@@ -462,8 +469,8 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 	dev_dbg(service->state->dev, "core: %d: callback:%d (%s, %pK, %pK)\n",
 		service->state->id, service->localport, reason_names[reason],
 		header, bulk_userdata);
-	status = service->base.callback(service->instance, reason, header, service->handle,
-					bulk_userdata);
+	status = service->base.callback(service->instance, reason, header,
+					service->handle, bulk_userdata);
 	if (status && (status != -EAGAIN)) {
 		dev_warn(service->state->dev,
 			 "core: %d: ignoring ERROR from callback to service %x\n",
@@ -483,7 +490,9 @@ vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate)
 	enum vchiq_connstate oldstate = state->conn_state;
 
 	dev_dbg(state->dev, "core: %d: %s->%s\n",
-		state->id, conn_state_names[oldstate], conn_state_names[newstate]);
+		state->id, conn_state_names[oldstate],
+		conn_state_names[newstate]);
+
 	state->conn_state = newstate;
 	vchiq_platform_conn_state_changed(state, oldstate, newstate);
 }
@@ -524,7 +533,10 @@ remote_event_wait(wait_queue_head_t *wq, struct remote_event *event)
 			return ret;
 		}
 		event->armed = 0;
-		/* Ensure that the peer sees that we are not waiting (armed == 0). */
+		/*
+		 * Ensure that the peer sees that we are not waiting
+		 * (armed == 0).
+		 */
 		wmb();
 	}
 
@@ -578,8 +590,10 @@ remote_event_poll(wait_queue_head_t *wq, struct remote_event *event)
 void
 remote_event_pollall(struct vchiq_state *state)
 {
-	remote_event_poll(&state->sync_trigger_event, &state->local->sync_trigger);
-	remote_event_poll(&state->sync_release_event, &state->local->sync_release);
+	remote_event_poll(&state->sync_trigger_event,
+			  &state->local->sync_trigger);
+	remote_event_poll(&state->sync_release_event,
+			  &state->local->sync_release);
 	remote_event_poll(&state->trigger_event, &state->local->trigger);
 	remote_event_poll(&state->recycle_event, &state->local->recycle);
 }
@@ -614,8 +628,7 @@ get_listening_service(struct vchiq_state *state, int fourcc)
 		struct vchiq_service *service;
 
 		service = rcu_dereference(state->services[i]);
-		if (service &&
-		    service->public_fourcc == fourcc &&
+		if (service && service->public_fourcc == fourcc &&
 		    (service->srvstate == VCHIQ_SRVSTATE_LISTENING ||
 		     (service->srvstate == VCHIQ_SRVSTATE_OPEN &&
 		      service->remoteport == VCHIQ_PORT_FREE)) &&
@@ -679,7 +692,8 @@ request_poll(struct vchiq_state *state, struct vchiq_service *service,
 	wmb();
 
 	/* ... and ensure the slot handler runs. */
-	remote_event_signal_local(&state->trigger_event, &state->local->trigger);
+	remote_event_signal_local(&state->trigger_event,
+				  &state->local->trigger);
 }
 
 /*
@@ -789,11 +803,13 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 			 */
 			complete(&quota->quota_event);
 			dev_dbg(state->dev, "core: %d: pfq:%d %x@%pK - slot_use->%d\n",
-				state->id, port, header->size, header, count - 1);
+				state->id, port, header->size,
+				header, count - 1);
 		} else {
 			dev_err(state->dev,
 				"core: service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)\n",
-				port, count, header, msgid, header->msgid, header->size);
+				port, count, header, msgid,
+				header->msgid, header->size);
 			WARN(1, "bad slot use count\n");
 		}
 	}
@@ -858,7 +874,8 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 			if (pos > VCHIQ_SLOT_SIZE) {
 				dev_err(state->dev,
 					"core: pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x\n",
-					pos, header, msgid, header->msgid, header->size);
+					pos, header, msgid,
+					header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -894,8 +911,8 @@ memcpy_copy_callback(void *context, void *dest, size_t offset, size_t maxsize)
 }
 
 static ssize_t
-copy_message_data(ssize_t (*copy_callback)(void *context, void *dest, size_t offset,
-					   size_t maxsize),
+copy_message_data(ssize_t (*copy_callback)(void *context, void *dest,
+					   size_t offset, size_t maxsize),
 	void *context,
 	void *dest,
 	size_t size)
@@ -1049,8 +1066,8 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		int slot_use_count;
 
 		dev_dbg(state->dev, "core: %d: qm %s@%pK,%zx (%d->%d)\n",
-			state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
-			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
+			state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header,
+			size, VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
 		WARN_ON(flags & (QMFLAGS_NO_MUTEX_LOCK |
 				 QMFLAGS_NO_MUTEX_UNLOCK));
@@ -1099,15 +1116,16 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 
 		if (slot_use_count)
 			dev_dbg(state->dev, "core: %d: qm:%d %s,%zx - slot_use->%d (hdr %p)\n",
-				state->id, service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-				size, slot_use_count, header);
+				state->id, service->localport,
+				msg_type_str(VCHIQ_MSG_TYPE(msgid)), size,
+				slot_use_count, header);
 
 		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
 		dev_dbg(state->dev, "core: %d: qm %s@%pK,%zx (%d->%d)\n",
-			state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
-			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
+			state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header,
+			size, VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
 			/*
 			 * It is assumed for now that this code path
@@ -1136,8 +1154,10 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
 		dev_dbg(state->dev, "core_msg: Sent Msg %s(%u) to %p4cc s:%u d:%d len:%zu\n",
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
-			&svc_fourcc, VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid), size);
+			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+			VCHIQ_MSG_TYPE(msgid), &svc_fourcc,
+			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid),
+			size);
 	}
 
 	/* Make sure the new header is visible to the peer. */
@@ -1256,7 +1276,8 @@ release_slot(struct vchiq_state *state, struct vchiq_slot_info *slot_info,
 	if (header) {
 		int msgid = header->msgid;
 
-		if (((msgid & VCHIQ_MSGID_CLAIMED) == 0) || (service && service->closing)) {
+		if (((msgid & VCHIQ_MSGID_CLAIMED) == 0) ||
+		    (service && service->closing)) {
 			mutex_unlock(&state->recycle_mutex);
 			return;
 		}
@@ -1377,8 +1398,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		status = 0;
 
 	if (status == -EAGAIN)
-		request_poll(service->state, service, (queue == &service->bulk_tx) ?
-			     VCHIQ_POLL_TXNOTIFY : VCHIQ_POLL_RXNOTIFY);
+		request_poll(service->state, service,
+			     (queue == &service->bulk_tx) ? VCHIQ_POLL_TXNOTIFY
+							  : VCHIQ_POLL_RXNOTIFY);
 
 	return status;
 }
@@ -1405,7 +1427,8 @@ poll_services_of_group(struct vchiq_state *state, int group)
 		service_flags = atomic_xchg(&service->poll_flags, 0);
 		if (service_flags & BIT(VCHIQ_POLL_REMOVE)) {
 			dev_dbg(state->dev, "core: %d: ps - remove %d<->%d\n",
-				state->id, service->localport, service->remoteport);
+				state->id, service->localport,
+				service->remoteport);
 
 			/*
 			 * Make it look like a client, because
@@ -1441,7 +1464,8 @@ poll_services(struct vchiq_state *state)
 }
 
 static void
-cleanup_pagelistinfo(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo)
+cleanup_pagelistinfo(struct vchiq_instance *instance,
+		     struct vchiq_pagelist_info *pagelistinfo)
 {
 	if (pagelistinfo->scatterlist_mapped) {
 		dma_unmap_sg(instance->state->dev, pagelistinfo->scatterlist,
@@ -1451,7 +1475,8 @@ cleanup_pagelistinfo(struct vchiq_instance *instance, struct vchiq_pagelist_info
 	if (pagelistinfo->pages_need_release)
 		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
 
-	dma_free_coherent(instance->state->dev, pagelistinfo->pagelist_buffer_size,
+	dma_free_coherent(instance->state->dev,
+			  pagelistinfo->pagelist_buffer_size,
 			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
 }
 
@@ -1518,8 +1543,8 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 	/* Allocate enough storage to hold the page pointers and the page
 	 * list
 	 */
-	pagelist = dma_alloc_coherent(instance->state->dev, pagelist_size, &dma_addr,
-				      GFP_KERNEL);
+	pagelist = dma_alloc_coherent(instance->state->dev, pagelist_size,
+				      &dma_addr, GFP_KERNEL);
 
 	dev_dbg(instance->state->dev, "arm: %pK\n", pagelist);
 
@@ -1572,8 +1597,10 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 		}
 		/* do not try and release vmalloc pages */
 	} else {
-		actual_pages = pin_user_pages_fast((unsigned long)ubuf & PAGE_MASK, num_pages,
-						   type == PAGELIST_READ, pages);
+		actual_pages =
+			pin_user_pages_fast((unsigned long)ubuf & PAGE_MASK,
+					    num_pages, type == PAGELIST_READ,
+					    pages);
 
 		if (actual_pages != num_pages) {
 			dev_dbg(instance->state->dev, "arm: Only %d/%d pages locked\n",
@@ -1664,15 +1691,16 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 }
 
 static void
-free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo,
-	      int actual)
+free_pagelist(struct vchiq_instance *instance,
+	      struct vchiq_pagelist_info *pagelistinfo, int actual)
 {
 	struct vchiq_drv_mgmt *drv_mgmt;
 	struct pagelist *pagelist = pagelistinfo->pagelist;
 	struct page **pages = pagelistinfo->pages;
 	unsigned int num_pages = pagelistinfo->num_pages;
 
-	dev_dbg(instance->state->dev, "arm: %pK, %d\n", pagelistinfo->pagelist, actual);
+	dev_dbg(instance->state->dev, "arm: %pK, %d\n",
+		pagelistinfo->pagelist, actual);
 
 	drv_mgmt = dev_get_drvdata(instance->state->dev);
 
@@ -1685,16 +1713,17 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 	pagelistinfo->scatterlist_mapped = 0;
 
 	/* Deal with any partial cache lines (fragments) */
-	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS && drv_mgmt->fragments_base) {
+	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS &&
+	    drv_mgmt->fragments_base) {
 		char *fragments = drv_mgmt->fragments_base +
 			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
 			drv_mgmt->fragments_size;
 		int head_bytes, tail_bytes;
 
 		head_bytes = (drv_mgmt->info->cache_line_size - pagelist->offset) &
-			(drv_mgmt->info->cache_line_size - 1);
+			     (drv_mgmt->info->cache_line_size - 1);
 		tail_bytes = (pagelist->offset + actual) &
-			(drv_mgmt->info->cache_line_size - 1);
+			     (drv_mgmt->info->cache_line_size - 1);
 
 		if ((actual >= 0) && (head_bytes != 0)) {
 			if (head_bytes > actual)
@@ -1731,8 +1760,8 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 }
 
 static int
-vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk, void *offset,
-			void __user *uoffset, int size, int dir)
+vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk,
+			void *offset, void __user *uoffset, int size, int dir)
 {
 	struct vchiq_pagelist_info *pagelistinfo;
 
@@ -1759,7 +1788,8 @@ static void
 vchiq_complete_bulk(struct vchiq_instance *instance, struct vchiq_bulk *bulk)
 {
 	if (bulk && bulk->remote_data && bulk->actual)
-		free_pagelist(instance, (struct vchiq_pagelist_info *)bulk->remote_data,
+		free_pagelist(instance,
+			      (struct vchiq_pagelist_info *)bulk->remote_data,
 			      bulk->actual);
 }
 
@@ -1796,8 +1826,8 @@ abort_outstanding_bulks(struct vchiq_service *service,
 			dev_dbg(service->state->dev,
 				"core_msg: %s %p4cc d:%d ABORTED - tx len:%d, rx len:%d\n",
 				is_tx ? "Send Bulk to" : "Recv Bulk from",
-				&service->base.fourcc,
-				service->remoteport, bulk->size, bulk->remote_size);
+				&service->base.fourcc, service->remoteport,
+				bulk->size, bulk->remote_size);
 		} else {
 			/* fabricate a matching dummy bulk */
 			bulk->data = 0;
@@ -1845,7 +1875,8 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 		/* Version mismatch */
 		dev_err(state->dev, "%d: service %d (%p4cc) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
 			state->id, service->localport, &fourcc,
-			service->version, service->version_min, version, version_min);
+			service->version, service->version_min,
+			version, version_min);
 		vchiq_service_put(service);
 		service = NULL;
 		goto fail_open;
@@ -1864,15 +1895,18 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 		/* Acknowledge the OPEN */
 		if (service->sync) {
-			if (queue_message_sync(state, NULL, openack_id, memcpy_copy_callback,
-					       &ack_payload, sizeof(ack_payload)) == -EAGAIN)
+			if (queue_message_sync(state, NULL, openack_id,
+					       memcpy_copy_callback,
+					       &ack_payload,
+					       sizeof(ack_payload)) == -EAGAIN)
 				goto bail_not_ready;
 
 			/* The service is now open */
 			set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
 		} else {
-			if (queue_message(state, NULL, openack_id, memcpy_copy_callback,
-					  &ack_payload, sizeof(ack_payload), 0) == -EINTR)
+			if (queue_message(state, NULL, openack_id,
+					  memcpy_copy_callback, &ack_payload,
+					  sizeof(ack_payload), 0) == -EINTR)
 				goto bail_not_ready;
 
 			/* The service is now open */
@@ -1957,14 +1991,15 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				dev_warn(state->dev,
 					 "core: %d: prs %s@%pK (%d->%d) - found connected service %d\n",
 					 state->id, msg_type_str(type), header,
-					 remoteport, localport, service->localport);
+					 remoteport, localport,
+					 service->localport);
 		}
 
 		if (!service) {
 			dev_err(state->dev,
 				"core: %d: prs %s@%pK (%d->%d) - invalid/closed service %d\n",
-				state->id, msg_type_str(type), header, remoteport,
-				localport, localport);
+				state->id, msg_type_str(type), header,
+				remoteport, localport, localport);
 			goto skip_message;
 		}
 		break;
@@ -1976,9 +2011,11 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			     : VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
 	dev_dbg(state->dev, "core_msg: Rcvd Msg %s(%u) from %p4cc s:%d d:%d len:%d\n",
-		msg_type_str(type), type, &svc_fourcc, remoteport, localport, size);
+		msg_type_str(type), type, &svc_fourcc,
+		remoteport, localport, size);
 	if (size > 0)
-		vchiq_log_dump_mem(state->dev, "Rcvd", 0, header->data, min(16, size));
+		vchiq_log_dump_mem(state->dev, "Rcvd", 0, header->data,
+				   min(16, size));
 
 	if (((unsigned long)header & VCHIQ_SLOT_MASK) +
 	    calc_stride(size) > VCHIQ_SLOT_SIZE) {
@@ -2025,7 +2062,8 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			goto bail_not_ready;
 
 		dev_dbg(state->dev, "core: Close Service %p4cc s:%u d:%d\n",
-			&service->base.fourcc, service->localport, service->remoteport);
+			&service->base.fourcc, service->localport,
+			service->remoteport);
 		break;
 	case VCHIQ_MSG_DATA:
 		dev_dbg(state->dev, "core: %d: prs DATA@%pK,%x (%d->%d)\n",
@@ -2036,8 +2074,9 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			header->msgid = msgid | VCHIQ_MSGID_CLAIMED;
 			claim_slot(state->rx_info);
 			DEBUG_TRACE(PARSE_LINE);
-			if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
-						  NULL) == -EAGAIN) {
+			if (make_service_callback(service,
+						  VCHIQ_MESSAGE_AVAILABLE,
+						  header, NULL) == -EAGAIN) {
 				DEBUG_TRACE(PARSE_LINE);
 				goto bail_not_ready;
 			}
@@ -2082,8 +2121,10 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				queue->local_insert) >= 0) {
 				dev_err(state->dev,
 					"core: %d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)\n",
-					state->id, msg_type_str(type), header, remoteport,
-					localport, queue->remote_insert, queue->local_insert);
+					state->id, msg_type_str(type), header,
+					remoteport, localport,
+					queue->remote_insert,
+					queue->local_insert);
 				mutex_unlock(&service->bulk_mutex);
 				break;
 			}
@@ -2100,13 +2141,15 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			queue->remote_insert++;
 
 			dev_dbg(state->dev, "core: %d: prs %s@%pK (%d->%d) %x@%pad\n",
-				state->id, msg_type_str(type), header, remoteport,
-				localport, bulk->actual, &bulk->data);
+				state->id, msg_type_str(type), header,
+				remoteport, localport,
+				bulk->actual, &bulk->data);
 
 			dev_dbg(state->dev, "core: %d: prs:%d %cx li=%x ri=%x p=%x\n",
 				state->id, localport,
 				(type == VCHIQ_MSG_BULK_RX_DONE) ? 'r' : 't',
-				queue->local_insert, queue->remote_insert, queue->process);
+				queue->local_insert, queue->remote_insert,
+				queue->process);
 
 			DEBUG_TRACE(PARSE_LINE);
 			WARN_ON(queue->process == queue->local_insert);
@@ -2133,8 +2176,8 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		if (state->conn_state != VCHIQ_CONNSTATE_PAUSE_SENT) {
 			/* Send a PAUSE in response */
-			if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
-					  QMFLAGS_NO_MUTEX_UNLOCK) == -EINTR)
+			if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL,
+					  0, QMFLAGS_NO_MUTEX_UNLOCK) == -EINTR)
 				goto bail_not_ready;
 		}
 		/* At this point slot_mutex is held */
@@ -2362,7 +2405,8 @@ sync_func(void *v)
 		int type;
 		unsigned int localport, remoteport;
 
-		ret = remote_event_wait(&state->sync_trigger_event, &local->sync_trigger);
+		ret = remote_event_wait(&state->sync_trigger_event,
+					&local->sync_trigger);
 		if (ret)
 			return ret;
 
@@ -2380,8 +2424,8 @@ sync_func(void *v)
 		if (!service) {
 			dev_err(state->dev,
 				"sync: %d: sf %s@%pK (%d->%d) - invalid/closed service %d\n",
-				state->id, msg_type_str(type), header, remoteport,
-				localport, localport);
+				state->id, msg_type_str(type), header,
+				remoteport, localport, localport);
 			release_message_sync(state, header);
 			continue;
 		}
@@ -2389,9 +2433,11 @@ sync_func(void *v)
 		svc_fourcc = service->base.fourcc;
 
 		dev_dbg(state->dev, "sync: Rcvd Msg %s from %p4cc s:%d d:%d len:%d\n",
-			msg_type_str(type), &svc_fourcc, remoteport, localport, size);
+			msg_type_str(type), &svc_fourcc, remoteport, localport,
+			size);
 		if (size > 0)
-			vchiq_log_dump_mem(state->dev, "Rcvd", 0, header->data, min(16, size));
+			vchiq_log_dump_mem(state->dev, "Rcvd", 0, header->data,
+					   min(16, size));
 
 		switch (type) {
 		case VCHIQ_MSG_OPENACK:
@@ -2406,7 +2452,8 @@ sync_func(void *v)
 				service->peer_version);
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 				service->remoteport = remoteport;
-				set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
+				set_service_state(service,
+						  VCHIQ_SRVSTATE_OPENSYNC);
 				service->sync = 1;
 				complete(&service->remove_event);
 			}
@@ -2419,7 +2466,9 @@ sync_func(void *v)
 
 			if ((service->remoteport == remoteport) &&
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
-				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
+				if (make_service_callback(service,
+							  VCHIQ_MESSAGE_AVAILABLE,
+							  header,
 							  NULL) == -EAGAIN)
 					dev_err(state->dev,
 						"sync: error: synchronous callback to service %d returns -EAGAIN\n",
@@ -2488,7 +2537,8 @@ vchiq_init_slots(struct device *dev, void *mem_base, int mem_size)
 }
 
 int
-vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev)
+vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero,
+		 struct device *dev)
 {
 	struct vchiq_shared_state *local;
 	struct vchiq_shared_state *remote;
@@ -2569,7 +2619,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	((struct vchiq_header *)
 		SLOT_DATA_FROM_INDEX(state, local->slot_sync))->msgid =
 							VCHIQ_MSGID_PADDING;
-	remote_event_signal_local(&state->sync_release_event, &local->sync_release);
+	remote_event_signal_local(&state->sync_release_event,
+				  &local->sync_release);
 
 	local->debug[DEBUG_ENTRIES] = DEBUG_MAX;
 
@@ -2581,7 +2632,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	 * bring up slot handler thread
 	 */
 	snprintf(threadname, sizeof(threadname), "vchiq-slot/%d", state->id);
-	state->slot_handler_thread = kthread_create(&slot_handler_func, (void *)state, threadname);
+	state->slot_handler_thread = kthread_create(&slot_handler_func,
+						    (void *)state, threadname);
 
 	if (IS_ERR(state->slot_handler_thread)) {
 		dev_err(state->dev, "couldn't create thread %s\n", threadname);
@@ -2590,7 +2642,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	set_user_nice(state->slot_handler_thread, -19);
 
 	snprintf(threadname, sizeof(threadname), "vchiq-recy/%d", state->id);
-	state->recycle_thread = kthread_create(&recycle_func, (void *)state, threadname);
+	state->recycle_thread = kthread_create(&recycle_func, (void *)state,
+					       threadname);
 	if (IS_ERR(state->recycle_thread)) {
 		dev_err(state->dev, "couldn't create thread %s\n", threadname);
 		ret = PTR_ERR(state->recycle_thread);
@@ -2599,7 +2652,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	set_user_nice(state->recycle_thread, -19);
 
 	snprintf(threadname, sizeof(threadname), "vchiq-sync/%d", state->id);
-	state->sync_thread = kthread_create(&sync_func, (void *)state, threadname);
+	state->sync_thread = kthread_create(&sync_func, (void *)state,
+					    threadname);
 	if (IS_ERR(state->sync_thread)) {
 		dev_err(state->dev, "couldn't create thread %s\n", threadname);
 		ret = PTR_ERR(state->sync_thread);
@@ -2647,7 +2701,8 @@ void vchiq_msg_queue_push(struct vchiq_instance *instance, unsigned int handle,
 }
 EXPORT_SYMBOL(vchiq_msg_queue_push);
 
-struct vchiq_header *vchiq_msg_hold(struct vchiq_instance *instance, unsigned int handle)
+struct vchiq_header *vchiq_msg_hold(struct vchiq_instance *instance,
+				    unsigned int handle)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct vchiq_header *header;
@@ -2849,7 +2904,8 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 		if (service->srvstate != VCHIQ_SRVSTATE_CLOSEWAIT)
 			dev_err(service->state->dev,
 				"core: %d: osi - srvstate = %s (ref %u)\n",
-				service->state->id, srvstate_names[service->srvstate],
+				service->state->id,
+				srvstate_names[service->srvstate],
 				kref_read(&service->ref_count));
 		status = -EINVAL;
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
@@ -2904,15 +2960,18 @@ release_service_messages(struct vchiq_service *service)
 			int msgid = header->msgid;
 			int port = VCHIQ_MSG_DSTPORT(msgid);
 
-			if ((port == service->localport) && (msgid & VCHIQ_MSGID_CLAIMED)) {
-				dev_dbg(state->dev, "core:  fsi - hdr %pK\n", header);
+			if ((port == service->localport) &&
+			    (msgid & VCHIQ_MSGID_CLAIMED)) {
+				dev_dbg(state->dev, "core:  fsi - hdr %pK\n",
+					header);
 				release_slot(state, slot_info, header, NULL);
 			}
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
 				dev_err(state->dev,
 					"core: fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x\n",
-					pos, header, msgid, header->msgid, header->size);
+					pos, header, msgid,
+					header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -2972,7 +3031,8 @@ close_service_complete(struct vchiq_service *service, int failstate)
 		return -EINVAL;
 	}
 
-	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED, NULL, NULL);
+	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED,
+				       NULL, NULL);
 
 	if (status != -EAGAIN) {
 		int uc = service->service_use_count;
@@ -3059,7 +3119,8 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	bulk->size = size;
 	bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
 
-	if (vchiq_prepare_bulk_data(service->instance, bulk, offset, uoffset, size, dir))
+	if (vchiq_prepare_bulk_data(service->instance, bulk,
+				    offset, uoffset, size, dir))
 		goto unlock_error_exit;
 
 	/*
@@ -3266,7 +3327,8 @@ vchiq_free_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	dev_dbg(state->dev, "core: %d: fsi - (%d)\n", state->id, service->localport);
+	dev_dbg(state->dev, "core: %d: fsi - (%d)\n",
+		state->id, service->localport);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPENING:
@@ -3277,7 +3339,8 @@ vchiq_free_service_internal(struct vchiq_service *service)
 		break;
 	default:
 		dev_err(state->dev, "core: %d: fsi - (%d) in state %s\n",
-			state->id, service->localport, srvstate_names[service->srvstate]);
+			state->id, service->localport,
+			srvstate_names[service->srvstate]);
 		return;
 	}
 
@@ -3290,7 +3353,8 @@ vchiq_free_service_internal(struct vchiq_service *service)
 }
 
 int
-vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance)
+vchiq_connect_internal(struct vchiq_state *state,
+		       struct vchiq_instance *instance)
 {
 	struct vchiq_service *service;
 	int status = 0;
@@ -3342,7 +3406,8 @@ int
 vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	/* Unregister the service */
-	struct vchiq_service *service = find_service_by_handle(instance, handle);
+	struct vchiq_service *service = find_service_by_handle(instance,
+							       handle);
 	int status = 0;
 
 	if (!service)
@@ -3476,8 +3541,8 @@ vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
 		goto error_exit;
 
 
-	status = vchiq_bulk_xfer_queue_msg_killable(service, offset, uoffset, size,
-						    userdata, mode, dir);
+	status = vchiq_bulk_xfer_queue_msg_killable(service, offset, uoffset,
+						    size, userdata, mode, dir);
 
 error_exit:
 	vchiq_service_put(service);
@@ -3614,7 +3679,8 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 	return status;
 }
 
-int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int handle, void *data,
+int vchiq_queue_kernel_message(struct vchiq_instance *instance,
+			       unsigned int handle, void *data,
 			       unsigned int size)
 {
 
@@ -3666,7 +3732,8 @@ release_message_sync(struct vchiq_state *state, struct vchiq_header *header)
 }
 
 int
-vchiq_get_peer_version(struct vchiq_instance *instance, unsigned int handle, short *peer_version)
+vchiq_get_peer_version(struct vchiq_instance *instance, unsigned int handle,
+		       short *peer_version)
 {
 	int status = -EINVAL;
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
@@ -3803,8 +3870,8 @@ vchiq_dump_shared_state(struct seq_file *f, struct vchiq_state *state,
 		struct vchiq_slot_info slot_info =
 						*SLOT_INFO_FROM_INDEX(state, i);
 		if (slot_info.use_count != slot_info.release_count) {
-			seq_printf(f, "      %d: %d/%d\n", i, slot_info.use_count,
-				   slot_info.release_count);
+			seq_printf(f, "      %d: %d/%d\n", i,
+				   slot_info.use_count, slot_info.release_count);
 		}
 	}
 
@@ -3836,7 +3903,8 @@ vchiq_dump_service_state(struct seq_file *f, struct vchiq_service *service)
 				"%u", service->remoteport);
 
 			if (service->public_fourcc != VCHIQ_FOURCC_INVALID)
-				scnprintf(remoteport + len2, sizeof(remoteport) - len2,
+				scnprintf(remoteport + len2,
+					  sizeof(remoteport) - len2,
 					  " (client 0x%x)", service->client_id);
 		} else {
 			strscpy(remoteport, "n/a", sizeof(remoteport));
@@ -3909,7 +3977,8 @@ void vchiq_dump_state(struct seq_file *f, struct vchiq_state *state)
 
 	if (VCHIQ_ENABLE_STATS) {
 		seq_printf(f, "  Stats: ctrl_tx_count=%d, ctrl_rx_count=%d, error_count=%d\n",
-			   state->stats.ctrl_tx_count, state->stats.ctrl_rx_count,
+			   state->stats.ctrl_tx_count,
+			   state->stats.ctrl_rx_count,
 			   state->stats.error_count);
 	}
 
-- 
2.45.2


