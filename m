Return-Path: <linux-kernel+bounces-360653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52B999DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E471C21B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AC20B1EE;
	Fri, 11 Oct 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="irtUpP2P"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672120ADF0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631375; cv=none; b=WFRIt+YMapNyY2zKantg1RIFv15XFmCWopRbjpoDQKEQ+8yb49mfCqi5cxbR+/YCMS2AmwlCh2x4skFUAr101WuBxdFE6KGz17h2Fm6y+dvsBiZ+cgRd73Y+LP4wapAyA70mtJJV2q187MLlhzZ8TbfDV2itUHH5ZKx8Bu05aPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631375; c=relaxed/simple;
	bh=ju7Tgv1YIpsQRNU04x/igU8G/YOvFQuWc2cpRl91hM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G65Nv2dNIZUvWaWSBpjGMTwZ/Tc204q3PMet+IH7hWcLoHp3OZIQlsVgGRaYw7uhq8RXTVB3/cSvLRtg0KJkMQ1RcBSF6igiQ5gSzkLoXbBu4OcYNlrIRED9GWawmTylf9QEaMM60b7nQ87LEczasTlrGj+jJt0AnVnVFaKbGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=irtUpP2P; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F763CDB;
	Fri, 11 Oct 2024 09:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728631274;
	bh=ju7Tgv1YIpsQRNU04x/igU8G/YOvFQuWc2cpRl91hM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irtUpP2PuYNSI1tv5aqDf9S05AVEBS2DZBhO9fpr6HvbF2GPEEFl5g6bymAN/TfkL
	 T5QBe9CGzTvtMZhsNurO1V0p0bP1rVu1TqssW+SVZM3KnzjBaLD2uN9nafFPxuJTU6
	 AL4/JN1ENUJ3RYR/lHo0n2XJa3osZ4vsqeQzNWak=
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
Subject: [PATCH 7/8] staging: vchiq_core: Lower indentation in parse_open()
Date: Fri, 11 Oct 2024 12:52:09 +0530
Message-ID: <20241011072210.494672-8-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011072210.494672-1-umang.jain@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
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
---
 .../interface/vchiq_arm/vchiq_core.c          | 48 ++++++++++---------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 3ed949343608..04401baee9a6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1813,8 +1813,10 @@ static int
 parse_open(struct vchiq_state *state, struct vchiq_header *header)
 {
 	const struct vchiq_open_payload *payload;
+	struct vchiq_openack_payload ack_payload;
 	struct vchiq_service *service = NULL;
 	int msgid, size;
+	int openack_id;
 	unsigned int localport, remoteport, fourcc;
 	short version, version_min;
 
@@ -1849,34 +1851,36 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
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


