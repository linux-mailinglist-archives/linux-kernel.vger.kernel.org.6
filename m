Return-Path: <linux-kernel+bounces-358769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDAF998375
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94081F2384B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F661BF7F0;
	Thu, 10 Oct 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JXxZANZc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515781BE864
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555807; cv=none; b=D6Yo2I91vWu+CQgLPpzgO4A6ZTGOerfEZTzWLN/Fp58nEtxYiTIUY5ej1eYx5/eRMcnUdKcGOZJGEYo/L13hGkTcfeWA3kktiuBCUAe6in42pzYLpsR7hHinZy6dx2BwCn56chKXC6fFEDZV6gHJVp3VVtW4QKpuRxlzJoCbCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555807; c=relaxed/simple;
	bh=Xk26YmG8YZvKNYWqttFrrO9FHmUMrgYYlfGadiP9nis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWp60XN4OrDk84QkX8IZApQRfyyHffDC9UFD0qTnW5BNact1zFAp1Bl8Cn7A/umcKBPEWdotqQECTE/WuRnS05Ea46J76va7xDQHLWPUCog7861IEIJ20QhQmzuvAUEsIx+zevP98EvkZNHMrb5EE7oEE4J1UShtedXu811NGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JXxZANZc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90C9F5B2;
	Thu, 10 Oct 2024 12:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728555700;
	bh=Xk26YmG8YZvKNYWqttFrrO9FHmUMrgYYlfGadiP9nis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXxZANZck0sii3z5UxIULCQ4nNvtVIVKg1CCcQDIxLvMP3kJF1sDtUUEDaXTmOxoy
	 VIqYy1kq7k8vJgnDxqMPH/Z2A4OjvgkZU20f/I/EnqtKdfRC5J0g09GtEVBNz9Z4Kw
	 wiOCIENlSbeOFcIhpIAv7wDEBcplsWnqbMik8K+w=
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
	Hridesh MG <hridesh699@gmail.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/5] staging: vchiq_core: Fix white space indentation error
Date: Thu, 10 Oct 2024 15:52:45 +0530
Message-ID: <20241010102250.236545-2-umang.jain@ideasonboard.com>
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

From: Hridesh MG <hridesh699@gmail.com>

Replace spaces with tabs to adhere to kernel coding style. No
functional changes intended in this patch.

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 1281f3bc5548..dfd68d853214 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3111,13 +3111,13 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 		state->id, service->localport, dir_char, queue->local_insert,
 		queue->remote_insert, queue->process);
 
-        if (bulk_waiter) {
-                bulk_waiter->bulk = bulk;
+	if (bulk_waiter) {
+		bulk_waiter->bulk = bulk;
 		if (wait_for_completion_killable(&bulk_waiter->event))
 			status = -EINTR;
-                else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
-                        status = -EINVAL;
-        }
+		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
+			status = -EINVAL;
+	}
 
 	return status;
 
-- 
2.45.2


