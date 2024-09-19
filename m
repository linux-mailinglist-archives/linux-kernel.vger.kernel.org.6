Return-Path: <linux-kernel+bounces-333576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1797CAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DF61F235D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBF1A01BA;
	Thu, 19 Sep 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lCPwC6O7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D21A00EE
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755712; cv=none; b=glAZA7FspW1SaxLtnW6HtYPNk745ciZsiVegB5d/tpJOwOZTGue4RqSLtcW5LuGOxIM4PnfG4G/waa0tqxgyF+JV8oDrRKaeR61gIBf2WrZ8KNZBS9NXE2uzjNLlkv56JfImf+EaZnFOqsMd8pINOeFNaIaPSkXuxcLxBOy1zS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755712; c=relaxed/simple;
	bh=+G1ALUjL+2EMlZ/KTTRa4nLLszzAdAcmC+aiCIRahjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbEg/fyYY797w+Lv5YAkytR+cPN+r5O6SfNXhKkRxeBekevYmV/D9ZpdryHzNKmPgZts6D3OOnKUALRE/P3HYQVb/bPfsx5lcaMGAcAB9DrQFzB+DPG1nlY2hU/kR8KMbjgwmKHnpmSG6wFRbi5kIl2Dd5RLal+E1xJKS3TKcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lCPwC6O7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57076FF6;
	Thu, 19 Sep 2024 16:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726755625;
	bh=+G1ALUjL+2EMlZ/KTTRa4nLLszzAdAcmC+aiCIRahjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCPwC6O79Dn3Zym20FK7+k1qE0vlzxuiNYt8sjl/ePObMZCVGIzEdHpYghik0oV8W
	 h/vRnBqrFFyZSmkvv1gWtFm6Mn1woScpk2P9UuNZxv1/UMbCW77qbBbqNQeAtv2M5W
	 5TWSgDBvLsjTCNWep/4i5KDKEHUj1igoGH1ESNro=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 3/3] staging: vchiq_core: Drop vchiq_pagelist.h
Date: Thu, 19 Sep 2024 19:51:30 +0530
Message-ID: <20240919142130.1331495-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
References: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vchiq_pagelist.h only defines one struct and a couple of macros.
It can be merged with vchiq_core since all the pagelist related
function helpers are now in vchiq_core for bulk transfers.

Move the struct and related macros to vchiq_core header and drop
vchiq_pagelist.h.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          |  4 ++++
 .../interface/vchiq_arm/vchiq_core.h          | 11 +++++++++-
 .../interface/vchiq_arm/vchiq_pagelist.h      | 21 -------------------
 3 files changed, 14 insertions(+), 22 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 586c41cd1ed5..1281f3bc5548 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -63,6 +63,10 @@
 #define MAKE_REMOTE_USE			(VCHIQ_MSG_REMOTE_USE << TYPE_SHIFT)
 #define MAKE_REMOTE_USE_ACTIVE		(VCHIQ_MSG_REMOTE_USE_ACTIVE << TYPE_SHIFT)
 
+#define PAGELIST_WRITE			0
+#define PAGELIST_READ			1
+#define PAGELIST_READ_WITH_FRAGMENTS	2
+
 #define BELL2	0x08
 
 /* Ensure the fields are wide enough */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 6662dd21e827..400472f1aa06 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -17,7 +17,6 @@
 
 #include "../../include/linux/raspberrypi/vchiq.h"
 #include "vchiq_cfg.h"
-#include "vchiq_pagelist.h"
 
 /* Do this so that we can test-build the code on non-rpi systems */
 #if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
@@ -411,6 +410,16 @@ struct vchiq_state {
 	struct opaque_platform_state *platform_state;
 };
 
+struct pagelist {
+	u32 length;
+	u16 type;
+	u16 offset;
+	u32 addrs[1];	/* N.B. 12 LSBs hold the number
+			 * of following pages at consecutive
+			 * addresses.
+			 */
+};
+
 struct vchiq_pagelist_info {
 	struct pagelist *pagelist;
 	size_t pagelist_buffer_size;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
deleted file mode 100644
index ebd12bfabb63..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
-
-#ifndef VCHIQ_PAGELIST_H
-#define VCHIQ_PAGELIST_H
-
-#define PAGELIST_WRITE 0
-#define PAGELIST_READ 1
-#define PAGELIST_READ_WITH_FRAGMENTS 2
-
-struct pagelist {
-	u32 length;
-	u16 type;
-	u16 offset;
-	u32 addrs[1];	/* N.B. 12 LSBs hold the number
-			 * of following pages at consecutive
-			 * addresses.
-			 */
-};
-
-#endif /* VCHIQ_PAGELIST_H */
-- 
2.45.2


