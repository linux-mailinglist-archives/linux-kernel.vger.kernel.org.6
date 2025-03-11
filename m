Return-Path: <linux-kernel+bounces-555760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44231A5BC73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7642C1721D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF322B8D0;
	Tue, 11 Mar 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWDtLVfK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eT3avxLd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59D1684AC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686055; cv=none; b=lTx+uNWi2CSK0a5tYI0AfFRDIULR0Vty+VQKsNSxoN5ppJ1/GIdBTltSd48xP58ae0OrYRt1+bfNtDSBleCCmXxzzVWPJc9r6gKWuads5gDtBW090aVRHNve1cTENz3v3qKKuPompXnYiZ89K9teQhd9A5vPVdPWbSWlTSzb8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686055; c=relaxed/simple;
	bh=T2RL5FvlpDx3pcSNkchBEZ9+japix25e6QOHe8IfPqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=auMM4zm0/ri+vDDzgtLJJ5SRwIMsFF4+tB9zBtZzFr+sqTEcTE8om/wZJcXQKX7UiG6Sh6+wLDyn9IomhIK6NJbl3Pza8biM8WUgUVlWKM6fbRnJCb6yym3OuIukDCysgXdvojULdZQ0yiKf4Dq/811Wpgd3ifXrmhslrxZCySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWDtLVfK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eT3avxLd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741686051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cxUaUXph+qalu1x0mGPUAK6C8ivUi3ekwPtjHAKlLHs=;
	b=KWDtLVfKCALfzKKF3mKH8+WYAyz5UzQfGj2FJmWRO22Fd7sALAKiNytR3YpZ/ZaWRg7Ga6
	ohPoQZEfq8TZp4QRM3HXl4q8aS3qa87UPzih/N7xFNeyKJQesGt6LV1iWYzeXssLGQ6Zpp
	PmyTScJY2SNTiW6UIvigkxwNGVJ0BiBxif3NM70yDnyIrVDz9lNomtF+lxxnxABQogVW67
	keW0+4KpqAnZZwy8e0IojVEo6wIKFNr6yG/HnYGavlTzwnEAjx6JGrHfGB+WP9SNcrKrPX
	LbaAhvkZ4qdxEFwHk8zRGJ4H2NWwcISyjZb9pLFmoI4f9I8/tGixkSBGzUl3OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741686051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cxUaUXph+qalu1x0mGPUAK6C8ivUi3ekwPtjHAKlLHs=;
	b=eT3avxLd6EWCMfCOfGNWgJYxQRVaZkVXONUXtJHKetWLESgJ6L/IY3tl1eRDV+q45FubLC
	scrpeQpwlSCNCaDw==
Date: Tue, 11 Mar 2025 10:40:49 +0100
Subject: [PATCH v2] staging: vchiq_arm: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250311-restricted-pointers-vchiq_arm-v2-1-a14e1c0681fc@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACAF0GcC/43NQQ6CMBCF4auQWTumLWCIK+9hiAE6yCTa4rQ2G
 MLdrZzA5fcW/1shkDAFOBcrCCUO7F2GORQwTJ27E7LNBqNMrUqtUChE4SGSxdmziyQB0zDx69b
 JE3WjdD829lRWPeTGLDTysvevbfbEIXr57HdJ/9Z/y0mjRmtVNRrVENX15cHuHcU7Xo6WoN227
 QtR2ESPzgAAAA==
X-Change-ID: 20250310-restricted-pointers-vchiq_arm-1801bf8d634b
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741686051; l=18993;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=T2RL5FvlpDx3pcSNkchBEZ9+japix25e6QOHe8IfPqk=;
 b=/hbXVzrW/Qj0iSLPmHukUu8SngJNJ2Xt3Ury0UFgAMWR5FaNO1AUfmtGEjKVqev29FS+BiTxn
 GrJRb1rFs3NDt7lZWvYqO/Du2xs9SU/fsU9DjwG6NSgztRzCARDO+b6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Fix wrong replacement with invalid %K (Dan Carpenter)
- Link to v1: https://lore.kernel.org/r/20250310-restricted-pointers-vchiq_arm-v1-1-dd04f208ee55@linutronix.de
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  6 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 64 +++++++++++-----------
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  | 14 ++---
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a4e83e5d619bc95f1d4ba311a201bba8c05cd030..2db219e4786f236ce4c37afa86a12615a091c637 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -271,7 +271,7 @@ static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state
 		return -ENXIO;
 	}
 
-	dev_dbg(&pdev->dev, "arm: vchiq_init - done (slots %pK, phys %pad)\n",
+	dev_dbg(&pdev->dev, "arm: vchiq_init - done (slots %p, phys %pad)\n",
 		vchiq_slot_zero, &slot_phys);
 
 	mutex_init(&drv_mgmt->connected_mutex);
@@ -368,7 +368,7 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 				 &instance->bulk_waiter_list, list) {
 		list_del(&waiter->list);
 		dev_dbg(instance->state->dev,
-			"arm: bulk_waiter - cleaned up %pK for pid %d\n",
+			"arm: bulk_waiter - cleaned up %p for pid %d\n",
 			waiter, waiter->pid);
 		kfree(waiter);
 	}
@@ -622,7 +622,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		dev_dbg(instance->state->dev, "arm: saved bulk_waiter %pK for pid %d\n",
+		dev_dbg(instance->state->dev, "arm: saved bulk_waiter %p for pid %d\n",
 			waiter, current->pid);
 	}
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8d5795db4f39f8003310a54ba369367c95e6c079..e2cac0898b8faa3c255de6b8562c7096a9683c49 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -470,7 +470,7 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 		cb_userdata = bulk->cb_userdata;
 	}
 
-	dev_dbg(service->state->dev, "core: %d: callback:%d (%s, %pK, %pK %pK)\n",
+	dev_dbg(service->state->dev, "core: %d: callback:%d (%s, %p, %p %p)\n",
 		service->state->id, service->localport, reason_names[reason],
 		header, cb_data, cb_userdata);
 	status = service->base.callback(service->instance, reason, header, service->handle,
@@ -778,7 +778,7 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 		complete(&quota->quota_event);
 	} else if (count == 0) {
 		dev_err(state->dev,
-			"core: service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)\n",
+			"core: service %d message_use_count=%d (header %p, msgid %x, header->msgid %x, header->size %x)\n",
 			port, quota->message_use_count, header, msgid,
 			header->msgid, header->size);
 		WARN(1, "invalid message use count\n");
@@ -799,11 +799,11 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 			 * it has dropped below its quota
 			 */
 			complete(&quota->quota_event);
-			dev_dbg(state->dev, "core: %d: pfq:%d %x@%pK - slot_use->%d\n",
+			dev_dbg(state->dev, "core: %d: pfq:%d %x@%p - slot_use->%d\n",
 				state->id, port, header->size, header, count - 1);
 		} else {
 			dev_err(state->dev,
-				"core: service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)\n",
+				"core: service %d slot_use_count=%d (header %p, msgid %x, header->msgid %x, header->size %x)\n",
 				port, count, header, msgid, header->msgid, header->size);
 			WARN(1, "bad slot use count\n");
 		}
@@ -845,7 +845,7 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 		 */
 		rmb();
 
-		dev_dbg(state->dev, "core: %d: pfq %d=%pK %x %x\n",
+		dev_dbg(state->dev, "core: %d: pfq %d=%p %x %x\n",
 			state->id, slot_index, data, local->slot_queue_recycle,
 			slot_queue_available);
 
@@ -868,7 +868,7 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
 				dev_err(state->dev,
-					"core: pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x\n",
+					"core: pfq - pos %x: header %p, msgid %x, header->msgid %x, header->size %x\n",
 					pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
@@ -1060,7 +1060,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		int tx_end_index;
 		int slot_use_count;
 
-		dev_dbg(state->dev, "core: %d: qm %s@%pK,%zx (%d->%d)\n",
+		dev_dbg(state->dev, "core: %d: qm %s@%p,%zx (%d->%d)\n",
 			state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
 			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
@@ -1117,7 +1117,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
-		dev_dbg(state->dev, "core: %d: qm %s@%pK,%zx (%d->%d)\n",
+		dev_dbg(state->dev, "core: %d: qm %s@%p,%zx (%d->%d)\n",
 			state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
 			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
@@ -1204,7 +1204,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 				state->id, oldmsgid);
 	}
 
-	dev_dbg(state->dev, "sync: %d: qms %s@%pK,%x (%d->%d)\n",
+	dev_dbg(state->dev, "sync: %d: qms %s@%p,%x (%d->%d)\n",
 		state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
 		VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
@@ -1539,7 +1539,7 @@ create_pagelist(struct vchiq_instance *instance, struct vchiq_bulk *bulk)
 	pagelist = dma_alloc_coherent(instance->state->dev, pagelist_size, &dma_addr,
 				      GFP_KERNEL);
 
-	dev_dbg(instance->state->dev, "arm: %pK\n", pagelist);
+	dev_dbg(instance->state->dev, "arm: %p\n", pagelist);
 
 	if (!pagelist)
 		return NULL;
@@ -1692,7 +1692,7 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 	unsigned int num_pages = pagelistinfo->num_pages;
 	unsigned int cache_line_size;
 
-	dev_dbg(instance->state->dev, "arm: %pK, %d\n", pagelistinfo->pagelist, actual);
+	dev_dbg(instance->state->dev, "arm: %p, %d\n", pagelistinfo->pagelist, actual);
 
 	drv_mgmt = dev_get_drvdata(instance->state->dev);
 
@@ -1849,7 +1849,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	payload = (struct vchiq_open_payload *)header->data;
 	fourcc = payload->fourcc;
-	dev_dbg(state->dev, "core: %d: prs OPEN@%pK (%d->'%p4cc')\n",
+	dev_dbg(state->dev, "core: %d: prs OPEN@%p (%d->'%p4cc')\n",
 		state->id, header, localport, &fourcc);
 
 	service = get_listening_service(state, fourcc);
@@ -1976,14 +1976,14 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			service = get_connected_service(state, remoteport);
 			if (service)
 				dev_warn(state->dev,
-					 "core: %d: prs %s@%pK (%d->%d) - found connected service %d\n",
+					 "core: %d: prs %s@%p (%d->%d) - found connected service %d\n",
 					 state->id, msg_type_str(type), header,
 					 remoteport, localport, service->localport);
 		}
 
 		if (!service) {
 			dev_err(state->dev,
-				"core: %d: prs %s@%pK (%d->%d) - invalid/closed service %d\n",
+				"core: %d: prs %s@%p (%d->%d) - invalid/closed service %d\n",
 				state->id, msg_type_str(type), header, remoteport,
 				localport, localport);
 			goto skip_message;
@@ -2003,7 +2003,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 
 	if (((unsigned long)header & VCHIQ_SLOT_MASK) +
 	    calc_stride(size) > VCHIQ_SLOT_SIZE) {
-		dev_err(state->dev, "core: header %pK (msgid %x) - size %x too big for slot\n",
+		dev_err(state->dev, "core: header %p (msgid %x) - size %x too big for slot\n",
 			header, (unsigned int)msgid, (unsigned int)size);
 		WARN(1, "oversized for slot\n");
 	}
@@ -2022,7 +2022,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			service->peer_version = payload->version;
 		}
 		dev_dbg(state->dev,
-			"core: %d: prs OPENACK@%pK,%x (%d->%d) v:%d\n",
+			"core: %d: prs OPENACK@%p,%x (%d->%d) v:%d\n",
 			state->id, header, size, remoteport, localport,
 			service->peer_version);
 		if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
@@ -2037,7 +2037,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 	case VCHIQ_MSG_CLOSE:
 		WARN_ON(size); /* There should be no data */
 
-		dev_dbg(state->dev, "core: %d: prs CLOSE@%pK (%d->%d)\n",
+		dev_dbg(state->dev, "core: %d: prs CLOSE@%p (%d->%d)\n",
 			state->id, header, remoteport, localport);
 
 		mark_service_closing_internal(service, 1);
@@ -2049,7 +2049,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			&service->base.fourcc, service->localport, service->remoteport);
 		break;
 	case VCHIQ_MSG_DATA:
-		dev_dbg(state->dev, "core: %d: prs DATA@%pK,%x (%d->%d)\n",
+		dev_dbg(state->dev, "core: %d: prs DATA@%p,%x (%d->%d)\n",
 			state->id, header, size, remoteport, localport);
 
 		if ((service->remoteport == remoteport) &&
@@ -2069,7 +2069,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_CONNECT:
-		dev_dbg(state->dev, "core: %d: prs CONNECT@%pK\n",
+		dev_dbg(state->dev, "core: %d: prs CONNECT@%p\n",
 			state->id, header);
 		state->version_common =	((struct vchiq_slot_zero *)
 					 state->slot_data)->version;
@@ -2102,7 +2102,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			if ((int)(queue->remote_insert -
 				queue->local_insert) >= 0) {
 				dev_err(state->dev,
-					"core: %d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)\n",
+					"core: %d: prs %s@%p (%d->%d) unexpected (ri=%d,li=%d)\n",
 					state->id, msg_type_str(type), header, remoteport,
 					localport, queue->remote_insert, queue->local_insert);
 				mutex_unlock(&service->bulk_mutex);
@@ -2120,7 +2120,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			bulk->actual = *(int *)header->data;
 			queue->remote_insert++;
 
-			dev_dbg(state->dev, "core: %d: prs %s@%pK (%d->%d) %x@%pad\n",
+			dev_dbg(state->dev, "core: %d: prs %s@%p (%d->%d) %x@%pad\n",
 				state->id, msg_type_str(type), header, remoteport,
 				localport, bulk->actual, &bulk->dma_addr);
 
@@ -2140,12 +2140,12 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_PADDING:
-		dev_dbg(state->dev, "core: %d: prs PADDING@%pK,%x\n",
+		dev_dbg(state->dev, "core: %d: prs PADDING@%p,%x\n",
 			state->id, header, size);
 		break;
 	case VCHIQ_MSG_PAUSE:
 		/* If initiated, signal the application thread */
-		dev_dbg(state->dev, "core: %d: prs PAUSE@%pK,%x\n",
+		dev_dbg(state->dev, "core: %d: prs PAUSE@%p,%x\n",
 			state->id, header, size);
 		if (state->conn_state == VCHIQ_CONNSTATE_PAUSED) {
 			dev_err(state->dev, "core: %d: PAUSE received in state PAUSED\n",
@@ -2162,7 +2162,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSED);
 		break;
 	case VCHIQ_MSG_RESUME:
-		dev_dbg(state->dev, "core: %d: prs RESUME@%pK,%x\n",
+		dev_dbg(state->dev, "core: %d: prs RESUME@%p,%x\n",
 			state->id, header, size);
 		/* Release the slot mutex */
 		mutex_unlock(&state->slot_mutex);
@@ -2179,7 +2179,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 
 	default:
-		dev_err(state->dev, "core: %d: prs invalid msgid %x@%pK,%x\n",
+		dev_err(state->dev, "core: %d: prs invalid msgid %x@%p,%x\n",
 			state->id, msgid, header, size);
 		WARN(1, "invalid message\n");
 		break;
@@ -2400,7 +2400,7 @@ sync_func(void *v)
 
 		if (!service) {
 			dev_err(state->dev,
-				"sync: %d: sf %s@%pK (%d->%d) - invalid/closed service %d\n",
+				"sync: %d: sf %s@%p (%d->%d) - invalid/closed service %d\n",
 				state->id, msg_type_str(type), header, remoteport,
 				localport, localport);
 			release_message_sync(state, header);
@@ -2422,7 +2422,7 @@ sync_func(void *v)
 					header->data;
 				service->peer_version = payload->version;
 			}
-			dev_err(state->dev, "sync: %d: sf OPENACK@%pK,%x (%d->%d) v:%d\n",
+			dev_err(state->dev, "sync: %d: sf OPENACK@%p,%x (%d->%d) v:%d\n",
 				state->id, header, size, remoteport, localport,
 				service->peer_version);
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
@@ -2435,7 +2435,7 @@ sync_func(void *v)
 			break;
 
 		case VCHIQ_MSG_DATA:
-			dev_dbg(state->dev, "sync: %d: sf DATA@%pK,%x (%d->%d)\n",
+			dev_dbg(state->dev, "sync: %d: sf DATA@%p,%x (%d->%d)\n",
 				state->id, header, size, remoteport, localport);
 
 			if ((service->remoteport == remoteport) &&
@@ -2449,7 +2449,7 @@ sync_func(void *v)
 			break;
 
 		default:
-			dev_err(state->dev, "sync: error: %d: sf unexpected msgid %x@%pK,%x\n",
+			dev_err(state->dev, "sync: error: %d: sf unexpected msgid %x@%p,%x\n",
 				state->id, msgid, header, size);
 			release_message_sync(state, header);
 			break;
@@ -2926,13 +2926,13 @@ release_service_messages(struct vchiq_service *service)
 			int port = VCHIQ_MSG_DSTPORT(msgid);
 
 			if ((port == service->localport) && (msgid & VCHIQ_MSGID_CLAIMED)) {
-				dev_dbg(state->dev, "core:  fsi - hdr %pK\n", header);
+				dev_dbg(state->dev, "core:  fsi - hdr %p\n", header);
 				release_slot(state, slot_info, header, NULL);
 			}
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
 				dev_err(state->dev,
-					"core: fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x\n",
+					"core: fsi - pos %x: header %p, msgid %x, header->msgid %x, header->size %x\n",
 					pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
@@ -3091,7 +3091,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	 */
 	wmb();
 
-	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK\n",
+	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %p\n",
 		state->id, service->localport, service->remoteport,
 		dir_char, bulk->size, &bulk->dma_addr, bulk->cb_data);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 454f4341650306654d1365653ab3b570795f3331..3b20ba5c736221ce1cacfc9ce86eca623382a30b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -270,7 +270,7 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 		}
 	} else {
 		dev_err(service->state->dev,
-			"arm: header %pK: bufsize %x < size %x\n",
+			"arm: header %p: bufsize %x < size %x\n",
 			header, args->bufsize, header->size);
 		WARN(1, "invalid size\n");
 		ret = -EMSGSIZE;
@@ -328,7 +328,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 			ret = -ESRCH;
 			goto out;
 		}
-		dev_dbg(service->state->dev, "arm: found bulk_waiter %pK for pid %d\n",
+		dev_dbg(service->state->dev, "arm: found bulk_waiter %p for pid %d\n",
 			waiter, current->pid);
 
 		status = vchiq_bulk_xfer_waiting(instance, args->handle,
@@ -366,7 +366,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		dev_dbg(service->state->dev, "arm: saved bulk_waiter %pK for pid %d\n",
+		dev_dbg(service->state->dev, "arm: saved bulk_waiter %p for pid %d\n",
 			waiter, current->pid);
 
 		ret = put_user(mode_waiting, mode);
@@ -512,7 +512,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 			/* This must be a VCHIQ-style service */
 			if (args->msgbufsize < msglen) {
 				dev_err(service->state->dev,
-					"arm: header %pK: msgbufsize %x < msglen %x\n",
+					"arm: header %p: msgbufsize %x < msglen %x\n",
 					header, args->msgbufsize, msglen);
 				WARN(1, "invalid message size\n");
 				if (ret == 0)
@@ -588,7 +588,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long ret = 0;
 	int i, rc;
 
-	dev_dbg(instance->state->dev, "arm: instance %pK, cmd %s, arg %lx\n", instance,
+	dev_dbg(instance->state->dev, "arm: instance %p, cmd %s, arg %lx\n", instance,
 		((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) && (_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
 		ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
 
@@ -874,12 +874,12 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	if (!status && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK)) {
 		dev_dbg(instance->state->dev,
-			"arm: ioctl instance %pK, cmd %s -> status %d, %ld\n",
+			"arm: ioctl instance %p, cmd %s -> status %d, %ld\n",
 			instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 			ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
 	} else {
 		dev_dbg(instance->state->dev,
-			"arm: ioctl instance %pK, cmd %s -> status %d\n, %ld\n",
+			"arm: ioctl instance %p, cmd %s -> status %d\n, %ld\n",
 			instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 			ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
 	}

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250310-restricted-pointers-vchiq_arm-1801bf8d634b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


