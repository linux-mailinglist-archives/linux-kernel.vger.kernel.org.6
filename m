Return-Path: <linux-kernel+bounces-324455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87815974CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB21F21C84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78F13D2B2;
	Wed, 11 Sep 2024 08:30:56 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D841C6C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043455; cv=none; b=VMLJ/RJ6xRJ96PzRCJIU00qj/dv1VI9aZJMgtH7Peb7K/2AVb+mpdDsPwksdZOoH5+3/IXX8ZPBtw1xNl5/cyqhGBWKz8DwdETPhfDPXOwgQPIqbz18O7lgd/ByYFuZiuHA9wY1DDtcJ1ZiFI63gfP1QlkDzAKgMbXx5Uq7u7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043455; c=relaxed/simple;
	bh=mcuUN4gbQxzej1JdBwLH5A+2jQGulNuhVQwWSE18QAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wz+JDZOOfdv9gAkb/fpitjejYcWes00RGcHJKEtxzcioDF41itobz66in8ukVzbA0qBUTeMcUsUAzja2LoxLOWQruw3RCcwJeVEqHXPIHzT9WXNvPn8O4G51xGvfp29ToCGFUA/36sU6AKCYj5bzf1RXbJURKAQW35VyL8632j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266e15531bf3-53bfb;
	Wed, 11 Sep 2024 16:30:43 +0800 (CST)
X-RM-TRANSID:2ee266e15531bf3-53bfb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466e15526fd9-c14d9;
	Wed, 11 Sep 2024 16:30:43 +0800 (CST)
X-RM-TRANSID:2ee466e15526fd9-c14d9
From: Ba Jing <bajing@cmss.chinamobile.com>
To: linux-kernel@vger.kernel.org
Cc: bajing@cmss.chinamobile.com
Subject: [PATCH] testusb: Fix the cacography in testusb.c
Date: Mon,  2 Sep 2024 22:32:02 +0800
Message-Id: <20240902143202.6789-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'configuratiens' is wrong, so fix it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/usb/testusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/testusb.c b/tools/usb/testusb.c
index cbaa1b9fdeac..1cc86da27a90 100644
--- a/tools/usb/testusb.c
+++ b/tools/usb/testusb.c
@@ -226,7 +226,7 @@ static int testdev_ifnum(FILE *fd)
 
 	/* the FunctionFS gadget can have the source/sink interface
 	 * anywhere.  We look for an interface descriptor that match
-	 * what we expect.  We ignore configuratiens thou. */
+	 * what we expect.  We ignore configurations thou. */
 
 	if (dev.idVendor == 0x0525 && dev.idProduct == 0xa4ac
 	 && (dev.bDeviceClass == USB_CLASS_PER_INTERFACE
-- 
2.33.0




