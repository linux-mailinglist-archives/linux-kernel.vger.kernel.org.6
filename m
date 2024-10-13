Return-Path: <linux-kernel+bounces-362775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB6399B931
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A0B20FD8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACE145B0C;
	Sun, 13 Oct 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CCxGhpT6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70788143C5D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728818504; cv=none; b=WbMluGURSeWYKyMt4YGDO+DKVyzj8mbIVqpxwiy2MwbbcEpY84tjeTRv8fYmJ9GGr8ORqiNavsW5s+u9yscpppr5LgsIvZZAGIFFxVvecyWHOML19M8OXZy0cXriPV0tc6wdF8z671RDvCRyaZNbSm8rswrpH/H38JW9fRr6BH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728818504; c=relaxed/simple;
	bh=ynOxMnbXos2NXkFd5V5zZmg92ZIYEBr+8vmtUcjRTxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABDk3QkAa5S0hbWYKFuUpnCn9UqsSZhlxAtoS5ohDCTgtwTfD4EZjY6W2jgst/ROVw1HF6XQuMiVDv/9sU/o3bz20t4vr58TW72h24YTrEIoOnR4odNJ63gYlvDAyqQV7C4LVzXQq/xsgq9BIUousTmcss3y+XsVyZ21CVnTjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CCxGhpT6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7059EE7C;
	Sun, 13 Oct 2024 13:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728818402;
	bh=ynOxMnbXos2NXkFd5V5zZmg92ZIYEBr+8vmtUcjRTxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCxGhpT6f1QG4SGaoVACtco3Q/MHIDbDjfR06nlHNLSCYbkUDCST1TVIrcZ69EvtO
	 OT6SByUBnpPwN/n/IbqrUx43GoToavYdDe/FDm65HvW9wEnGyngvPjQ+knhw7aS6gw
	 BBuVV+UoecsUlkxD7ubJLXzEpqHUoTIHN3Pkriq4=
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
Subject: [PATCH v4 3/6] staging: vchiq_core: Indent copy_message_data() on a single line
Date: Sun, 13 Oct 2024 16:51:25 +0530
Message-ID: <20241013112128.397249-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013112128.397249-1-umang.jain@ideasonboard.com>
References: <20241013112128.397249-1-umang.jain@ideasonboard.com>
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


