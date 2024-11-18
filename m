Return-Path: <linux-kernel+bounces-413225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C89D1551
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40671F22EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAD1BD9C1;
	Mon, 18 Nov 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yfv+TlgA"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A522F19;
	Mon, 18 Nov 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947180; cv=none; b=VKp85CAm0X7Zm224TgMQHVUAYv0WDApjLl8hNen1Q/gr0jlLjOhx817QpbfEEOytUip8xq8LIerq3mPRVFO+IQCWPOqBkYQaWVqdq10Ba3ve7K068sTFFyiT0HYsigGKHD1twoPoIwmxNf556AsQ8D1YoaZCmuJlBZgGk0IvsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947180; c=relaxed/simple;
	bh=ow2cF86U44ZKrjMC4p4R2g6++coHt4MuFVUhgRu2wH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BIlr2a66jp+Lm6VPn0mYJvH7cRLa/TU3bRJnO21LfSHuxHgWiOda2maGFXYupuUIBTifES8p8nAyoTHjgCaLkLNDivizPzf5piAlFuQufXHGeY1pLZGu0+jYMrqhSZodGfbqVOTnVOBIFOCvtHjl0jkIx1lm5IU8OTW7OONQ2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yfv+TlgA; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=DTE7WcVU6vyEjFIXWDfjjXFcih9Z/kgq1N2n76/y5LE=;
	b=Yfv+TlgAZbVTqXRlH9XHDMPkxskYq+OfN6t33jNmf6nWQJiXpwWhE/ZYPgiShu
	xKjNIqb9zuL5wGN7fMmDyd0Zq3cziXspLNrxTwUEYUC5dm9GHUDpwMXChMq17MCU
	7JDWiuIQ4/WnIqEx4hIA9MIGQ0PIpoRLAOBlPuhld7gQg=
Received: from localhost.localdomain (unknown [114.98.57.165])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v4OVajtn33vqAw--.1368S2;
	Tue, 19 Nov 2024 00:26:05 +0800 (CST)
From: =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH] xhci: Remove redundant parentheses when checking for port reset.
Date: Mon, 18 Nov 2024 08:25:56 -0800
Message-Id: <20241118162556.3392-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v4OVajtn33vqAw--.1368S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy3Wry3XFW5WF4kJr17GFg_yoWxArg_uF
	y8Cr4xGrWkKFWqyr18Aa4I9rW0yayrXr1kZa1Iy34fC3WrAFnav3sxuwsaqa1rWF4xGF98
	CrWFgry8Zwn7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtkucJUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBMRubq2c7RSSBBAABsj

When checking if the port status has been reset,
no additional parentheses are needed

Signed-off-by: 李哲 <sensor1010@163.com>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 8d774f19271e..6b494a2e8140 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1690,7 +1690,7 @@ int xhci_hub_status_data(struct usb_hcd *hcd, char *buf)
 			buf[(i + 1) / 8] |= 1 << (i + 1) % 8;
 			status = 1;
 		}
-		if ((temp & PORT_RC))
+		if (temp & PORT_RC)
 			reset_change = true;
 		if (temp & PORT_OC)
 			status = 1;
-- 
2.17.1


