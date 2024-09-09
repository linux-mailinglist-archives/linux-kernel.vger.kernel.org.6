Return-Path: <linux-kernel+bounces-321665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF8971DC9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FF8B234EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169B7BB14;
	Mon,  9 Sep 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W4bxVadk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445094963A;
	Mon,  9 Sep 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894925; cv=none; b=Xi9JMtG5eJicGGD9TnvV8MsIc9s3fvnIxEuoOkuAPYj6OTZ/2zqb0sxXnIEw/brL9LC/Ft5ZIkAm7KcR7m79cegGYBcIYKWr4B5D2fF9tHZJxP/2mx0a1bqqeonVUEwtXOo4zTHBatlAqVefnahRM8FWvoj1ISpMtoqQThgV25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894925; c=relaxed/simple;
	bh=r4GYCCAPrezVJF9S4lAxcxW+jn6P9wg342VL0Po3ozE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CSCBo33HxfWpbApUTf/gWDmhLcan8J4/326EU/mstPN3aMo0IDxRVV4ze2EUa0P5E8/WIqasU67C38PDR4df7wxCG9OeG6n2q/XwXh0h33NfmyFkj8xabR6X980bp5vNNEDmQWLdRP94OKQr5dfoFeeZgFbfVN+XWeWLUaBJkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W4bxVadk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894924; x=1757430924;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r4GYCCAPrezVJF9S4lAxcxW+jn6P9wg342VL0Po3ozE=;
  b=W4bxVadkpZ9Zlft3mqLNGlhk8MiUE+4EALk1DAeJhedt2wNmBxkk7f9b
   v2BiCsVkKFbVpbxAFbYvikG8RlCZyEqjtZfk+mNtKAU4CUyeT+l7FmaXO
   cDqPbGAo5HjJCwOqBxFhX7rmtqsP3gv0hA8Xlu4cKUzbUuo7MOnaBnFYE
   y7pCOkzLcvIdLzeucfOnFMPrzWrIv2dSz0rdg8aZiirveoSPkzvBL4N1B
   hiunge9OfakDt97XdJsloltc+uWMwhZ0x71j2khiz9sBqeuQ6rJhyavUg
   2d66y0sx91IFHdrTgKTr3os0KGsBytC8fOovk6F09vyjeL2CU8iwYGnlP
   A==;
X-CSE-ConnectionGUID: /ltMKKTeRqSXWxXLFfJz/g==
X-CSE-MsgGUID: yMs9w0RmSQCdshHUtdFUwQ==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="31514507"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:15:01 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:14:59 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 9 Sep 2024 17:14:43 +0200
Subject: [PATCH v2 3/9] phy: sparx5-serdes: add constant for the number of
 CMU's
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-3-d695bcb57b84@microchip.com>
References: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
In-Reply-To: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
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


