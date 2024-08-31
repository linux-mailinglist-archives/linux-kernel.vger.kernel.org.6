Return-Path: <linux-kernel+bounces-309982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E59672AD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72595282B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10001183094;
	Sat, 31 Aug 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EWK7WIAr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8F180A80
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121503; cv=none; b=aq80aBXza3pbOVbDVV/g/MCJoNtJirETwakxrppwn7fAwwl8FxVCBs7d4is96gbo7gTfHKAgz2zhZ6KPTRwio2CzikmCP43UswYKvG1qhLVOVEBmEbYJc7blUNckEWqQ5bk5XsePqYBB8ON2AMWv94hwXcCHhGHdWeK0nw/c7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121503; c=relaxed/simple;
	bh=TEhZVTOS1lBt2Hzure3UecnExS790qu6ZbIg1MYXEj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zp9QnV1lkZh3rvJHwoXTx4nOGHZVszuTpXGXLZeSPWXO4xYZYHmqxiCsKQLLQ1Q6VVwuK6sfF1FE5QVQdJlbSiZ4i5BYNf5OFMFRrD3V3pUCreYWkH2tThB4Ppjm/iAfl+0cahjiTz+xaqo7X/nunceKOC6+XKdxi/KsJ02EuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EWK7WIAr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E18B667;
	Sat, 31 Aug 2024 18:23:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121431;
	bh=TEhZVTOS1lBt2Hzure3UecnExS790qu6ZbIg1MYXEj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWK7WIAr1BcxBG4t3ij96XcCd8uIolgWtKRxHJmFBLayx75DPb1NF3CXgbyG7eUn0
	 zsPJRw0/761jzg6/3svD1YdWA6aOQevFXb2w4gsgGMz5HOzEKXkwy5UekKM8Ayu8iH
	 jQ+drgZI3xTi8usv6SkNn9qWsdfjL6d/n1J/g7vA=
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
Subject: [PATCH v2 6/7] staging: vchiq_core: Remove unused function argument
Date: Sat, 31 Aug 2024 21:54:34 +0530
Message-ID: <20240831162435.191084-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240831162435.191084-1-umang.jain@ideasonboard.com>
References: <20240831162435.191084-1-umang.jain@ideasonboard.com>
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
index f333d1747917..4459b35b1a87 100644
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
@@ -3143,7 +3143,7 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
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


