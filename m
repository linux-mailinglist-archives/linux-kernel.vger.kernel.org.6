Return-Path: <linux-kernel+bounces-361104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B2999A375
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572431F219B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37B216A32;
	Fri, 11 Oct 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t2mqG7Jh"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073A21791B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648629; cv=none; b=AqjqXNtnaUe3oR0zGKWuiSsmohd3c0MIW/pXe2n9WZ01U6WdknYjOueB1gosjGuaPgkJI2EzsoEspH6IwbqgHk+3qyl/KQM7JcUqnjeM6xkfKk6jL9WeL8CzOnCh3EL+8W2zrauORRJOgU9YcXpPjTB/Jm59Lgi6ElAxW5vG3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648629; c=relaxed/simple;
	bh=ynOxMnbXos2NXkFd5V5zZmg92ZIYEBr+8vmtUcjRTxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5cTxqWJeP0jWrnz72LXoAjAO5mb2RJTJxW2QQDI8CKntZWsRfWCnbkYQo3V5LtGbA+qvD1JkGwXKAjAndf6XYfODx+hrYOyPFnV8+dFWrWpM835jjpV/GckKDuVT2WivrBBAu2t3fiDiuqU6RLrot173eZWrhq3pcFiguGdQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t2mqG7Jh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5D0D6E79;
	Fri, 11 Oct 2024 14:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728648528;
	bh=ynOxMnbXos2NXkFd5V5zZmg92ZIYEBr+8vmtUcjRTxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2mqG7JhlbMkdoQD6Onw2vMvAoXPykaMyqP6bVjkzT4qFPp5S2JFBk51SOlK2ffrN
	 J5akYsbt4gZak0JB5r/EVIagPtHrTy9NosTFa5sRJWQtI+0IxZ2jGF64R0OPcMglyL
	 bGt2rnhvP4iSd/bFsL96zHaVpswa/R3lqDNAjiNc=
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
Subject: [PATCH v2 3/6] staging: vchiq_core: Indent copy_message_data() on a single line
Date: Fri, 11 Oct 2024 17:39:07 +0530
Message-ID: <20241011120910.74045-4-umang.jain@ideasonboard.com>
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

Fix the copy_message_data() indentation in queue_message_sync().

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 0324dfe59dca..e9cd012e2b5f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1197,9 +1197,8 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
 		VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
-	callback_result =
-		copy_message_data(copy_callback, context,
-				  header->data, size);
+	callback_result = copy_message_data(copy_callback, context,
+					    header->data, size);
 
 	if (callback_result < 0) {
 		mutex_unlock(&state->slot_mutex);
-- 
2.45.2


