Return-Path: <linux-kernel+bounces-321669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA12971DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781511F22A36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB913CFBC;
	Mon,  9 Sep 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qbjQ3ZW1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7413CFBB;
	Mon,  9 Sep 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894934; cv=none; b=FqIzEnQyJePQS8bcBfZ9l/STuTEkeGIM+i7vzUZMLeDx4UH+43gPNBTS76YpaqA4hhiBMyXtZEfaMoLxS9Chp4udePNMGw+T5S+vx96PjrNucHFRYg5N/s35kNk+DSchHDAPnyKaOySm4GQxyfsX9wtpfGP0WR6n60x+Mao9Cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894934; c=relaxed/simple;
	bh=AlVAS36lPr5nte9AlFxlAgXuPIW2QqGeW0nzZYxYbUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XpBI43CgJ28e1kJe1hAw+v7BpoddV/u1BpjgGsNngh3uY1pv/gOfsQ4ToF2gcjCbPex4dy7+EYnet1MS7txkcxE015qU2C9WhkjaawC8ogVAmxYkLURwo8bmbq1JcUnrTXOmoFAJlBJ29iu7BPnX5ZXRt70tbhX0JPfvyJc5ZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qbjQ3ZW1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894932; x=1757430932;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AlVAS36lPr5nte9AlFxlAgXuPIW2QqGeW0nzZYxYbUo=;
  b=qbjQ3ZW17InO6Mble4OYYR4MC8J6tKnMS0QLiMjBDf+NcnVP5Q/yAzPK
   blhwigk6Xghq+bOE9iZ6ivoP6LqZkBWtPjza3FgbUtj5nidcZ3HCpQleZ
   dC57AywHxDK3994P/PjMJEWUdGmEyqws+4RQUdj7blJk9MThFd4hYe82W
   5Te150cVy7NzWyFHFssfAEntlPZk9GVuEYgQ/pO81c4kqVfptvmQCecdw
   UoWh7isxxKEzhNg9QruJWeb3MGe3qI6a7fj9NTq5P6GvDLJxsfss3Pt+g
   p1wcdGXCzu87bs9M1WRrAFbcCyauZCV16uN4n3FxUxojCcxQtvFQJH+m9
   g==;
X-CSE-ConnectionGUID: 2asziJ13SmWKAWPwHD4niQ==
X-CSE-MsgGUID: /v6hnBtQRSi5YR2s2+JPHw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="198959135"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:15:06 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:15:04 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 9 Sep 2024 17:14:45 +0200
Subject: [PATCH v2 5/9] phy: sparx5-serdes: add function for getting the
 CMU index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-5-d695bcb57b84@microchip.com>
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

The SERDES to CMU mapping is different on Sparx5 and lan969x. Therefore
create a function for getting the CMU index on Sparx5.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 11 ++---------
 drivers/phy/microchip/sparx5_serdes.h |  9 +++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index b1376a142b14..5b918a2716dd 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -28,14 +28,6 @@
 /* Optimal power settings from GUC */
 #define SPX5_SERDES_QUIET_MODE_VAL 0x01ef4e0c
 
-enum sparx5_10g28cmu_mode {
-	SPX5_SD10G28_CMU_MAIN = 0,
-	SPX5_SD10G28_CMU_AUX1 = 1,
-	SPX5_SD10G28_CMU_AUX2 = 3,
-	SPX5_SD10G28_CMU_NONE = 4,
-	SPX5_SD10G28_CMU_MAX,
-};
-
 enum sparx5_sd25g28_mode_preset_type {
 	SPX5_SD25G28_MODE_PRESET_25000,
 	SPX5_SD25G28_MODE_PRESET_10000,
@@ -1648,7 +1640,7 @@ static int sparx5_sd10g28_apply_params(struct sparx5_serdes_macro *macro,
 	if (params->skip_cmu_cfg)
 		return 0;
 
-	cmu_idx = sparx5_serdes_cmu_get(params->cmu_sel, lane_index);
+	cmu_idx = priv->data->ops.serdes_cmu_get(params->cmu_sel, macro->sidx);
 	err = sparx5_cmu_cfg(priv, cmu_idx);
 	if (err)
 		return err;
@@ -2520,6 +2512,7 @@ static const struct sparx5_serdes_match_data sparx5_desc = {
 	},
 	.ops = {
 		.serdes_type_set      = &sparx5_serdes_type_set,
+		.serdes_cmu_get       = &sparx5_serdes_cmu_get,
 	},
 };
 
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 785c7fe0bbeb..a7e92c1330e9 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -26,6 +26,14 @@ enum sparx5_serdes_mode {
 	SPX5_SD_MODE_SFI,
 };
 
+enum sparx5_10g28cmu_mode {
+	SPX5_SD10G28_CMU_MAIN = 0,
+	SPX5_SD10G28_CMU_AUX1 = 1,
+	SPX5_SD10G28_CMU_AUX2 = 3,
+	SPX5_SD10G28_CMU_NONE = 4,
+	SPX5_SD10G28_CMU_MAX,
+};
+
 struct sparx5_serdes_macro {
 	struct sparx5_serdes_private *priv;
 	u32 sidx;
@@ -44,6 +52,7 @@ struct sparx5_serdes_consts {
 
 struct sparx5_serdes_ops {
 	void (*serdes_type_set)(struct sparx5_serdes_macro *macro, int sidx);
+	int (*serdes_cmu_get)(enum sparx5_10g28cmu_mode mode, int sd_index);
 };
 
 struct sparx5_serdes_match_data {

-- 
2.34.1


