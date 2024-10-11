Return-Path: <linux-kernel+bounces-361106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732B99A377
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C054CB255DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE521949C;
	Fri, 11 Oct 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vWFb19TG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A1218D98
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648634; cv=none; b=krh5yxCM8mXVj4KKezZDiweG68XrAAHhKFFm6Y2RDsDAAAFyuPUOfGCRB5qXPNGSMo430WnlxPGhx8ZLhHlYslAGNKKtzZ9cgORLr+2QozcI4V5Pv9CcXGtG7YwUs6uM152kBsygg4y1uUKRNOdABtuxsmIkKjuhoXsOygfKBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648634; c=relaxed/simple;
	bh=K8/PYdHZ3L7Li1BEbSRjHfmt4+8f7SQOKzrR14S2wCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAE4BVsmpkYQ35ofdra8Dc0EqSxS3N6arzWI7iI+I4E1q7/R8UUcZo7k+QROejWgDJIYQ1inNjti0YwGIBdwTZ+Il8HAZuQX97CsQSVX3MkRLqcRu2eoiBbQda5eyNPod/W/PWmXDg1Y8jRIIk1o2rlwo8JqCqxER1aHnETioyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vWFb19TG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E74ECDB;
	Fri, 11 Oct 2024 14:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728648533;
	bh=K8/PYdHZ3L7Li1BEbSRjHfmt4+8f7SQOKzrR14S2wCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vWFb19TGiDy+x4oPopwjeNyVebQ2cGv2ywUZlGnVpiK7gAqa8iPFT7TmrXxmrV7V7
	 v8tAFb58YCbeNkxYfb3KNf8YCdmUq1xUAwU1V/oGj3StjSz0HlvkHK1kT6KPVzjxr0
	 3bEqFMPYr47qdjlvma0iMhSB6krTpJrXc1tEE0eE=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 5/6] staging: vchiq_core: Lower indentation in parse_open()
Date: Fri, 11 Oct 2024 17:39:09 +0530
Message-ID: <20241011120910.74045-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011120910.74045-1-umang.jain@ideasonboard.com>
References: <20241011120910.74045-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the service is not in VCHIQ_SRVSTATE_LISTENING state, it is
implied that the message is dealt with and parse_open() should return.
If this is the case, simply jump the code flow to return site using
'goto done;' statement.

This helps to lower the indentation of
	if (service->srvstate == VCHIQ_SRVSTATE_LISTENING)
conditional branch.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 .../interface/vchiq_arm/vchiq_core.c          | 48 ++++++++++---------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 5509f8b1061a..135b7b9b01ee 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1829,8 +1829,10 @@ static int
 parse_open(struct vchiq_state *state, struct vchiq_header *header)
 {
 	const struct vchiq_open_payload *payload;
+	struct vchiq_openack_payload ack_payload;
 	struct vchiq_service *service = NULL;
 	int msgid, size;
+	int openack_id;
 	unsigned int localport, remoteport, fourcc;
 	short version, version_min;
 
@@ -1865,34 +1867,36 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 	}
 	service->peer_version = version;
 
-	if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
-		struct vchiq_openack_payload ack_payload = {
-			service->version
-		};
-		int openack_id = MAKE_OPENACK(service->localport, remoteport);
+	if (service->srvstate != VCHIQ_SRVSTATE_LISTENING)
+		goto done;
 
-		if (state->version_common <
-		    VCHIQ_VERSION_SYNCHRONOUS_MODE)
-			service->sync = 0;
+	ack_payload.version = service->version;
+	openack_id = MAKE_OPENACK(service->localport, remoteport);
 
-		/* Acknowledge the OPEN */
-		if (service->sync) {
-			if (queue_message_sync(state, NULL, openack_id, memcpy_copy_callback,
-					       &ack_payload, sizeof(ack_payload)) == -EAGAIN)
-				goto bail_not_ready;
+	if (state->version_common < VCHIQ_VERSION_SYNCHRONOUS_MODE)
+		service->sync = 0;
 
-			/* The service is now open */
-			set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
-		} else {
-			if (queue_message(state, NULL, openack_id, memcpy_copy_callback,
-					  &ack_payload, sizeof(ack_payload), 0) == -EINTR)
-				goto bail_not_ready;
+	/* Acknowledge the OPEN */
+	if (service->sync) {
+		if (queue_message_sync(state, NULL, openack_id,
+				       memcpy_copy_callback,
+				       &ack_payload,
+				       sizeof(ack_payload)) == -EAGAIN)
+			goto bail_not_ready;
 
-			/* The service is now open */
-			set_service_state(service, VCHIQ_SRVSTATE_OPEN);
-		}
+		/* The service is now open */
+		set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
+	} else {
+		if (queue_message(state, NULL, openack_id,
+				  memcpy_copy_callback, &ack_payload,
+				  sizeof(ack_payload), 0) == -EINTR)
+			goto bail_not_ready;
+
+		/* The service is now open */
+		set_service_state(service, VCHIQ_SRVSTATE_OPEN);
 	}
 
+done:
 	/* Success - the message has been dealt with */
 	vchiq_service_put(service);
 	return 1;
-- 
2.45.2


