Return-Path: <linux-kernel+bounces-358773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269A998379
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D69282C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09C1BE87C;
	Thu, 10 Oct 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MI+MInJ6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBD1C232C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555813; cv=none; b=ddiivg2NJxdwzsO5zK8ETnmFu7Enq+DznuWiSFSTvala5us7uhlwGUiOcQBIp4jhwzzlKUVpIj3PLLahtfcoIZbVFykJxpwefEGWPEtr3Njh8Y6rQrdaN1vnGKSD9bFJDSPYpxlfCNNp/TEeWF5T3KbhZqhyNnXFwQFeqM7NGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555813; c=relaxed/simple;
	bh=yR4DKd0m1IBq6/oDJ5UmIzyKp+RttK8hpY774cjmi2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHxEttJDPAMgMsLcGDjiuSZ4TUfmaR+OwSuWTU7DdF2Sd4TGrj1XqDv8hJjOW3AKGqScgIfFszdEKrMOwgoKWBT9sHmF22EJ1jKxjqqQFD4t1yBhtQuySf2bWbMwIjiUMiidmTB+CELX7CsYVmGrk5LUxbDFPgAJK9f8omA/E0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MI+MInJ6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 407111371;
	Thu, 10 Oct 2024 12:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728555707;
	bh=yR4DKd0m1IBq6/oDJ5UmIzyKp+RttK8hpY774cjmi2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MI+MInJ64sULz7zmENLmcLISqQuqvAyuoAYIYPKFz6m4VgZLq1ZL8y1pk8XvlPFZK
	 QYgDEwM3HpvrvfxevdpTTbUEtQ5X4YiqmyuXJXOZR0HbqE+DAQduhvY8jEVy5GfJ6n
	 DeilAqrw7eFStC3KummuSnYTaguV5t5idbkTeJek=
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
Subject: [PATCH 4/5] staging: vchiq_core: Macros indentation fix
Date: Thu, 10 Oct 2024 15:52:48 +0530
Message-ID: <20241010102250.236545-5-umang.jain@ideasonboard.com>
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

Make sure that MAKE_* macros fit within 80 columns instead of spanning
in a single line.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8be2dcf3658c..d03b67f9cdb7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -50,18 +50,19 @@
 	((unsigned short)(msgid) & 0xfff)
 
 #define MAKE_CONNECT			(VCHIQ_MSG_CONNECT << TYPE_SHIFT)
-#define MAKE_OPEN(srcport) \
-	((VCHIQ_MSG_OPEN << TYPE_SHIFT) | ((srcport) << 12))
-#define MAKE_OPENACK(srcport, dstport) \
-	((VCHIQ_MSG_OPENACK << TYPE_SHIFT) | ((srcport) << 12) | ((dstport) << 0))
-#define MAKE_CLOSE(srcport, dstport) \
-	((VCHIQ_MSG_CLOSE << TYPE_SHIFT) | ((srcport) << 12) | ((dstport) << 0))
-#define MAKE_DATA(srcport, dstport) \
-	((VCHIQ_MSG_DATA << TYPE_SHIFT) | ((srcport) << 12) | ((dstport) << 0))
+#define MAKE_OPEN(srcport)		((VCHIQ_MSG_OPEN << TYPE_SHIFT) | \
+					 ((srcport) << 12))
+#define MAKE_OPENACK(srcport, dstport)	((VCHIQ_MSG_OPENACK << TYPE_SHIFT) | \
+					 ((srcport) << 12) | ((dstport) << 0))
+#define MAKE_CLOSE(srcport, dstport)	((VCHIQ_MSG_CLOSE << TYPE_SHIFT) | \
+					 ((srcport) << 12) | ((dstport) << 0))
+#define MAKE_DATA(srcport, dstport)	((VCHIQ_MSG_DATA << TYPE_SHIFT) | \
+					 ((srcport) << 12) | ((dstport) << 0))
 #define MAKE_PAUSE			(VCHIQ_MSG_PAUSE << TYPE_SHIFT)
 #define MAKE_RESUME			(VCHIQ_MSG_RESUME << TYPE_SHIFT)
 #define MAKE_REMOTE_USE			(VCHIQ_MSG_REMOTE_USE << TYPE_SHIFT)
-#define MAKE_REMOTE_USE_ACTIVE		(VCHIQ_MSG_REMOTE_USE_ACTIVE << TYPE_SHIFT)
+#define MAKE_REMOTE_USE_ACTIVE		(VCHIQ_MSG_REMOTE_USE_ACTIVE \
+					 << TYPE_SHIFT)
 
 #define PAGELIST_WRITE			0
 #define PAGELIST_READ			1
-- 
2.45.2


