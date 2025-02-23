Return-Path: <linux-kernel+bounces-527804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58562A40FA6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B16C173821
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C417083A;
	Sun, 23 Feb 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RxLrC+au"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59511757F3;
	Sun, 23 Feb 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740326777; cv=none; b=ljDxNadzZ6UnkPG1bMetOnmfbeXjjv3ZwOWr74Z22TO3mlOoTq0YAl6Sau3OIOz9I67rDaIgnZ/ngXNI4wu1Rtxmhz71wQ/UyBdcVgKoGIcsKVo463ojmGTMSWGkTiZbzg1E5FWkbiLZHRFIAZmLVxPX7MsjfLqKIO2Qys054Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740326777; c=relaxed/simple;
	bh=0+Nvn8cX6GI4R1DniyFi3unyhSBXeHvaoQlWCJNx56g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9zKgyk/T+i2Kvp9M3jTkquQucu08w7kWD0JlFr5BKaYCDJUWxamvi/TZdPfH61TidUQzACfF6TKTOySulvDWxpimH5F9gXAfk1WBuA4LUBhCMnzdgE5ZQmdgVAHclX8/S9li72VkzePKLIsAr8SCPke6zQ0gnwFZzO0Ru70xXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RxLrC+au; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=1znzIw5Ur+KNtuAQFIn0e9fm114BbhJeBjBikMs86rQ=; b=RxLrC+aui/e9VrGv
	naL6Girhfd7EA9uioNfjOuZ4X5PenPiEvlOpM66l99rmdnRPNmOhUsq6vO4cESC+9fEOmDxlwBqRF
	eVOZiGnM/8+Mq7B4Dkz5znqTYMPXXOXcVTMLZHfsYNBIULQnCDK22rbBn5QlS+Ys/EsSz2HSRpKHb
	+UIFclrUm4Rt7mUO9lTU1VnHKm+HN6ItEbp4fZGv0ZOoc38Fm2zZTEbuk1GjXtFNbYGbe0QKRidiO
	Zw77MBXbTfTJSQqTjg0KcyRX8bp8/G3uTtv095li8HuAbqSUmyX4OaFug6MDRoL6sDDmUPJQ1+vWV
	dHTorL7tuq6IUTm5RQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tmEUU-000C2n-24;
	Sun, 23 Feb 2025 16:06:02 +0000
From: linux@treblig.org
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] usb: olpi: Remove unused otg_ulpi_create
Date: Sun, 23 Feb 2025 16:06:02 +0000
Message-ID: <20250223160602.91916-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

otg_ulpi_create() has been unused since 2022's
commit 8ca79aaad8be ("ARM: pxa: remove unused pxa3xx-ulpi")

Remove it.

The devm_ variant is still used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/usb/phy/phy-ulpi.c | 23 -----------------------
 include/linux/usb/ulpi.h   |  9 ---------
 2 files changed, 32 deletions(-)

diff --git a/drivers/usb/phy/phy-ulpi.c b/drivers/usb/phy/phy-ulpi.c
index e683a37e3a7a..4df63e67bb37 100644
--- a/drivers/usb/phy/phy-ulpi.c
+++ b/drivers/usb/phy/phy-ulpi.c
@@ -255,29 +255,6 @@ static void otg_ulpi_init(struct usb_phy *phy, struct usb_otg *otg,
 	otg->set_vbus	= ulpi_set_vbus;
 }
 
-struct usb_phy *
-otg_ulpi_create(struct usb_phy_io_ops *ops,
-		unsigned int flags)
-{
-	struct usb_phy *phy;
-	struct usb_otg *otg;
-
-	phy = kzalloc(sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return NULL;
-
-	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
-	if (!otg) {
-		kfree(phy);
-		return NULL;
-	}
-
-	otg_ulpi_init(phy, otg, ops, flags);
-
-	return phy;
-}
-EXPORT_SYMBOL_GPL(otg_ulpi_create);
-
 struct usb_phy *
 devm_otg_ulpi_create(struct device *dev,
 		     struct usb_phy_io_ops *ops,
diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
index 5050f502c1ed..4b651065738a 100644
--- a/include/linux/usb/ulpi.h
+++ b/include/linux/usb/ulpi.h
@@ -49,19 +49,10 @@
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_USB_ULPI)
-struct usb_phy *otg_ulpi_create(struct usb_phy_io_ops *ops,
-					unsigned int flags);
-
 struct usb_phy *devm_otg_ulpi_create(struct device *dev,
 				     struct usb_phy_io_ops *ops,
 				     unsigned int flags);
 #else
-static inline struct usb_phy *otg_ulpi_create(struct usb_phy_io_ops *ops,
-					      unsigned int flags)
-{
-	return NULL;
-}
-
 static inline struct usb_phy *devm_otg_ulpi_create(struct device *dev,
 						   struct usb_phy_io_ops *ops,
 						   unsigned int flags)
-- 
2.48.1


