Return-Path: <linux-kernel+bounces-318893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D077296F4B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864CD1F28031
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC281C9EBB;
	Fri,  6 Sep 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dwI54FzV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF041CCEDC;
	Fri,  6 Sep 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627208; cv=none; b=YZfOEwxDxh18mcJ2Fcq5bzgKTSFqFTaBJPdb4Kq2t7SNkGQKj1OYO5aTaPPla0vzbgBHPTu2jvGOPabnFAtPjEosMXbi7DvsCjYR1kbDpo2+hCztC7Fsr//STPl+Nmfkm9qvC6DccDz++GDTV7Pi5W0NgCAbyqbz2CaPwQ/wKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627208; c=relaxed/simple;
	bh=r4GYCCAPrezVJF9S4lAxcxW+jn6P9wg342VL0Po3ozE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t968JI0oA5InKORKiWybLKUmThld0ptmDjk+R3pE+0877U+06xJRH/DX6NsQpzyflAtLJUUeVn8Hav8Z8GJ6ViEfpi+e9p7iNyeZC2G8rJ19SNufCYehtAI9cXjDlcztXwbw/n3N+AgsdHW4D/DSvYK8gtVp27MFCh8Kw89llNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dwI54FzV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627206; x=1757163206;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r4GYCCAPrezVJF9S4lAxcxW+jn6P9wg342VL0Po3ozE=;
  b=dwI54FzVTMpVXxPP+6nkctBFC0z9bqYEvQotXVh4XcBFRKO/CmW9WlLN
   HQCcHoU9FJ0ERnqNPtIXqpnaskzo+YBgyd1VkFOnCWW80hR7IPleKHaNR
   HDcPtm7m4irIEfqRSEXn05coGvQ72zs8q1tT4yjbYhaBToZIEvYKXR4iH
   hTAOGbaAuFyJR9DT73sOPNCgKb6ZiMJXr8IMQ5vaC4mlpNDi+1C+sOa/Q
   BspCqDyfw9bC6sU8bBg9n8Y0K0lRlsmne4hxCF5O8cUj4Ul5uz39JLhHl
   o3aUjmWTmNnqeCN8fVUqDIHnYxRqOT/d9Xe3eRrHSMmAx++YK+da3x/5u
   w==;
X-CSE-ConnectionGUID: aks78ZCLRxOyTJZTZgJsDQ==
X-CSE-MsgGUID: 73P213HoT5uPEg8Zku63CA==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34534555"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:53:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:20 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:18 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Sep 2024 14:52:40 +0200
Subject: [PATCH 3/9] phy: sparx5-serdes: add constant for the number of
 CMU's
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-3-8d630614c58a@microchip.com>
References: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
In-Reply-To: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

The number of CMU's differ for Sparx5 and lan969x, so add a new field:
cmu_max and use it throughout.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 5 ++---
 drivers/phy/microchip/sparx5_serdes.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index c3ed028fc74e..9c91545dd8e1 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -21,8 +21,6 @@
 
 #include "sparx5_serdes.h"
 
-#define SPX5_CMU_MAX          14
-
 #define SPX5_SERDES_10G_START 13
 #define SPX5_SERDES_25G_START 25
 #define SPX5_SERDES_6G10G_CNT SPX5_SERDES_25G_START
@@ -1101,7 +1099,7 @@ static void sparx5_serdes_cmu_power_off(struct sparx5_serdes_private *priv)
 	int i;
 
 	/* Power down each CMU */
-	for (i = 0; i < SPX5_CMU_MAX; i++) {
+	for (i = 0; i < priv->data->consts.cmu_max; i++) {
 		cmu_inst = sdx5_inst_get(priv, TARGET_SD_CMU, i);
 		cmu_cfg_inst = sdx5_inst_get(priv, TARGET_SD_CMU_CFG, i);
 
@@ -2512,6 +2510,7 @@ static const struct sparx5_serdes_match_data sparx5_desc = {
 	.iomap_size = ARRAY_SIZE(sparx5_serdes_iomap),
 	.consts = {
 		.sd_max       = 33,
+		.cmu_max      = 14,
 	},
 };
 
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 8c27cfde4938..87c44bbaf368 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -28,6 +28,7 @@ enum sparx5_serdes_mode {
 
 struct sparx5_serdes_consts {
 	int sd_max;
+	int cmu_max;
 };
 
 struct sparx5_serdes_match_data {

-- 
2.34.1


