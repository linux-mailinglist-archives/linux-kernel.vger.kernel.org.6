Return-Path: <linux-kernel+bounces-310127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944096754B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043E1B22029
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199A14B973;
	Sun,  1 Sep 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OtoHRZA3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88214A087
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725171517; cv=none; b=uYD8BeNP9R8ZoYHW2UndU3YThsYqosMJJJnPKWxumauTL2SJXcH1xXvwDacYmyF9WUNyNqKx5DzW+pE/GJ3X7OWVtEv92X5Q7ySPGGUVn6JzHO8LbM7Tut7FJk7kMh3gAiGjC+ugul4kajwlAc+eqGuP/NrBWs22TI0SwIGGtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725171517; c=relaxed/simple;
	bh=2+QGbtBtppBAuoH/G3NKQwrHNz2t60xodmI+rnJQsqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBgrBi1eLIWJISozgDr/Rk43Ck0m7JSZIjE1UkY4TCM8smN5iFHEAc8+KsXI1tWU9r+XogoVKxJ6TK00gkbGg0E+Q+3CuZZZJExSllA1wQ7O0hl/ZME9FwXHSFyVOEuPKPdzpF1ubZmtjMbeMXwir3XyMR+VbJM9tb8FAnimEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OtoHRZA3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 422D94CF;
	Sun,  1 Sep 2024 08:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725171443;
	bh=2+QGbtBtppBAuoH/G3NKQwrHNz2t60xodmI+rnJQsqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtoHRZA3mRSxiZMBBxBaSxJ5fZ5NZEpBz3FKYTGTsTQ5W9O/hw+lBAa8AIWKC6Fxt
	 Fzwpuub66Q1sKvqHHDKjffQgiS2NzdI5xYKpaGAW7IwaJi7ttEkXpcuD9EwCa6bkAh
	 iktn5KEEyUh48DwhfTe2U9rWkzzSmCkIe7BdJmwk=
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
Subject: [PATCH v3 6/7] staging: vchiq_core: Remove unused function argument
Date: Sun,  1 Sep 2024 11:48:07 +0530
Message-ID: <20240901061808.187895-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240901061808.187895-1-umang.jain@ideasonboard.com>
References: <20240901061808.187895-1-umang.jain@ideasonboard.com>
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
index 164bab54019c..880f7f7e23fa 100644
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


