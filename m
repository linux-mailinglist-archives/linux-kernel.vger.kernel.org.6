Return-Path: <linux-kernel+bounces-318334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329896EBEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3F3285A53
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C6156F57;
	Fri,  6 Sep 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UakSXYNS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1415666B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607539; cv=none; b=KhunziqtVekXPX+gRsKkGYhkmoZp4sb9KIdurov7Ui6jT9eE/SiEzIKlfI+mbSBRRDXpE0lulkhtFIJ2wuFAxf47DRGmuIiijsfodWDmqmYKVwpZs9b/jpiEAt1+NhoDZ2t/8Cj2PBnb25Y5JWfcDNXGKfk4x8ikW62odzzAKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607539; c=relaxed/simple;
	bh=/NIxQUR9UvnxChFc2ZB+3NJ1dMvYgFcPyk783EbQagM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kexuJnHNc8gJrsXqAZT3lLqLAAr60fktt2DdRJ6ypBrx3imWSglUV7h1yxTR90R96pQqiVZXY2jSKD79S02fQZjWqSlmsiyWSAUmN5NCGbmWdWWs3t8iTxN67/+t4SKwWC8DcckIWtB5O+jbyDTdyw00e/m47pZBZ+q0qrA0Jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UakSXYNS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:c173:4b:4a04:3a21])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF7EEEF3;
	Fri,  6 Sep 2024 09:24:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725607461;
	bh=/NIxQUR9UvnxChFc2ZB+3NJ1dMvYgFcPyk783EbQagM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UakSXYNSPWh+EGu/P+/itSrPvV4nrPLQ3/FbiKljNB+rfpYks+9jTdnnjpx17Dy3p
	 oulFcg4bsAyLnQreAwfDrZ1o1/2ms1/tYG0IpRd3IX3fNqdg+5BTA9qB1TjgviagZe
	 0w5fgQUzw0iLQRN9CZrwOYIyljysitYvGG4H4Q8o=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 6/7] staging: vchiq_core: Remove unused function argument
Date: Fri,  6 Sep 2024 12:55:05 +0530
Message-ID: <20240906072506.174026-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072506.174026-1-umang.jain@ideasonboard.com>
References: <20240906072506.174026-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The argument 'is_blocking' in queue_message_sync() is not
used in the function. Drop it.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 9b0009d1906e..497c09d991b3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1146,7 +1146,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		   int msgid,
 		   ssize_t (*copy_callback)(void *context, void *dest,
 					    size_t offset, size_t maxsize),
-		   void *context, int size, int is_blocking)
+		   void *context, int size)
 {
 	struct vchiq_shared_state *local;
 	struct vchiq_header *header;
@@ -1524,7 +1524,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 		/* Acknowledge the OPEN */
 		if (service->sync) {
 			if (queue_message_sync(state, NULL, openack_id, memcpy_copy_callback,
-					       &ack_payload, sizeof(ack_payload), 0) == -EAGAIN)
+					       &ack_payload, sizeof(ack_payload)) == -EAGAIN)
 				goto bail_not_ready;
 
 			/* The service is now open */
@@ -3135,7 +3135,7 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		break;
 	case VCHIQ_SRVSTATE_OPENSYNC:
 		status = queue_message_sync(service->state, service, data_id,
-					    copy_callback, context, size, 1);
+					    copy_callback, context, size);
 		break;
 	default:
 		status = -EINVAL;
-- 
2.45.2


