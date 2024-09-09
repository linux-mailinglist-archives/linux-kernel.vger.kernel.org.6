Return-Path: <linux-kernel+bounces-321671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D32971DD8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87082B21A39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250814E2CB;
	Mon,  9 Sep 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gXa1g1TS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61213C68E;
	Mon,  9 Sep 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894936; cv=none; b=o4ezgSXJmQKV5FjamcB+AovGNr2fF56BMBZAm1rOLM+gynr77mqj5I+5iMm0T3ZB7E7nCmgxF+15GgIuIUlk+4JdGIcmY5XmXvY1jv3XM+Y8NsZuxJ94DWHIFpF7+RU/x4X5O5kJtMLFO+e3UtzMGgUkqQ1a3kJldm9t+Ur4DOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894936; c=relaxed/simple;
	bh=On7oQSERags6XaDtW1E8fxE7K+my80Se0j1QxVQOoII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lae0vAM1wd5ruQW7SHYJaHc179Ot7KdYfxEEjxCfpjx4c9s97TD+vaUYqD54YpqAckjbX4X7F20C/z1vXu7KC9Mn2eiIYQPt3SJ88UcBebeHlfMJP6PIqoSGa0t7qHjXciYw1aMwrKOOtkNQ7zsWuzxAXf/1SPwDsDTAxOXjAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gXa1g1TS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894934; x=1757430934;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=On7oQSERags6XaDtW1E8fxE7K+my80Se0j1QxVQOoII=;
  b=gXa1g1TSRjVv38y1y+avup8afJsbtwSbiU4DqRItcCJhNLEOjb27im9y
   rxHSl9sN4ob1i88eOTTemuZC+bQSwTTYW98ske+dHZSh1H+Q1YJNRzYcP
   kL54e7aye5UoVM+tNWomho1oH4YK1OEQgBkFAWYTBqTfeYsjyu7QGms7R
   Vy3qVeWpRPZnxIPh7ZOg09eE+Xztrq858tBxVDBkdcNINY0LbPzQ3eMAl
   0Ioe6s+QX09gWDkjSJlu+WncvtWIsaeR0X33ujQqsMLCNDlE5OD74+rRO
   8tJnSlv+FxRlrqIYMWyyiEKbF1VRVykb2qGiC9BzowRN0IcnYaHUb65X1
   g==;
X-CSE-ConnectionGUID: 2asziJ13SmWKAWPwHD4niQ==
X-CSE-MsgGUID: 3w9YeV8PQ7GOBjHkvudBIw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="198959149"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:15:15 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:15:13 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 9 Sep 2024 17:14:49 +0200
Subject: [PATCH v2 9/9] phy: lan969x-serdes: add support for lan969x serdes
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-9-d695bcb57b84@microchip.com>
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

Add support for lan969x SERDES driver. Lan969x has ten 10G SERDES'es
which share the same features and data rates as the Sparx5 SERDES'es.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 88 +++++++++++++++++++++++++++++++++++
 drivers/phy/microchip/sparx5_serdes.h |  2 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 05fdf225ff43..320cf5b50a8c 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -25,6 +25,8 @@
 #define SPX5_SERDES_25G_START 25
 #define SPX5_SERDES_6G10G_CNT SPX5_SERDES_25G_START
 
+#define LAN969X_SERDES_10G_CNT 10
+
 /* Optimal power settings from GUC */
 #define SPX5_SERDES_QUIET_MODE_VAL 0x01ef4e0c
 
@@ -36,6 +38,13 @@ const unsigned int sparx5_serdes_tsize[TSIZE_LAST] = {
 	[TC_SD_LANE] = 25,
 };
 
+const unsigned int lan969x_serdes_tsize[TSIZE_LAST] = {
+	[TC_SD10G_LANE] = 10,
+	[TC_SD_CMU] = 6,
+	[TC_SD_CMU_CFG] = 6,
+	[TC_SD_LANE] = 10,
+};
+
 /* Pointer to the register target size table */
 const unsigned int *tsize;
 
@@ -1096,6 +1105,24 @@ static int sparx5_serdes_cmu_get(enum sparx5_10g28cmu_mode mode, int sd_index)
 	return sparx5_serdes_cmu_map[mode][sd_index];
 }
 
+/* Map of 6G/10G serdes mode and index to CMU index. */
+static const int
+lan969x_serdes_cmu_map[SPX5_SD10G28_CMU_MAX][LAN969X_SERDES_10G_CNT] = {
+	[SPX5_SD10G28_CMU_MAIN] = { 2, 2, 2, 2, 2,
+				    2, 2, 2, 5, 5 },
+	[SPX5_SD10G28_CMU_AUX1] = { 0, 0, 3, 3, 3,
+				    3, 3, 3, 3, 3 },
+	[SPX5_SD10G28_CMU_AUX2] = { 1, 1, 1, 1, 4,
+				    4, 4, 4, 4, 4 },
+	[SPX5_SD10G28_CMU_NONE] = { 1, 1, 1, 1, 4,
+				    4, 4, 4, 4, 4 },
+};
+
+static int lan969x_serdes_cmu_get(enum sparx5_10g28cmu_mode mode, int sd_index)
+{
+	return lan969x_serdes_cmu_map[mode][sd_index];
+}
+
 static void sparx5_serdes_cmu_power_off(struct sparx5_serdes_private *priv)
 {
 	void __iomem *cmu_inst, *cmu_cfg_inst;
@@ -2184,6 +2211,10 @@ static int sparx5_serdes_clock_config(struct sparx5_serdes_macro *macro)
 {
 	struct sparx5_serdes_private *priv = macro->priv;
 
+	/* Clock is auto-detected in 100Base-FX mode on lan969x */
+	if (priv->data->type == SPX5_TARGET_LAN969X)
+		return 0;
+
 	if (macro->serdesmode == SPX5_SD_MODE_100FX) {
 		u32 freq = priv->coreclock == 250000000 ? 2 :
 			priv->coreclock == 500000000 ? 1 : 0;
@@ -2395,6 +2426,12 @@ static void sparx5_serdes_type_set(struct sparx5_serdes_macro *macro, int sidx)
 	}
 }
 
+static void lan969x_serdes_type_set(struct sparx5_serdes_macro *macro, int sidx)
+{
+	macro->serdestype = SPX5_SDT_10G;
+	macro->stpidx = macro->sidx;
+}
+
 static int sparx5_phy_create(struct sparx5_serdes_private *priv,
 			   int idx, struct phy **phy)
 {
@@ -2519,6 +2556,41 @@ static struct sparx5_serdes_io_resource sparx5_serdes_iomap[] =  {
 	{ TARGET_SD_LANE_25G + 7, 0x5c8000 }, /* 0x610dd0000: sd_lane_25g_32 */
 };
 
+static const struct sparx5_serdes_io_resource lan969x_serdes_iomap[] =  {
+	{ TARGET_SD_CMU,               0x0     }, /* 0xe3410000 */
+	{ TARGET_SD_CMU +  1,          0x8000  }, /* 0xe3418000 */
+	{ TARGET_SD_CMU +  2,          0x10000 }, /* 0xe3420000 */
+	{ TARGET_SD_CMU +  3,          0x18000 }, /* 0xe3428000 */
+	{ TARGET_SD_CMU +  4,          0x20000 }, /* 0xe3430000 */
+	{ TARGET_SD_CMU +  5,          0x28000 }, /* 0xe3438000 */
+	{ TARGET_SD_CMU_CFG,           0x30000 }, /* 0xe3440000 */
+	{ TARGET_SD_CMU_CFG +  1,      0x38000 }, /* 0xe3448000 */
+	{ TARGET_SD_CMU_CFG +  2,      0x40000 }, /* 0xe3450000 */
+	{ TARGET_SD_CMU_CFG +  3,      0x48000 }, /* 0xe3458000 */
+	{ TARGET_SD_CMU_CFG +  4,      0x50000 }, /* 0xe3460000 */
+	{ TARGET_SD_CMU_CFG +  5,      0x58000 }, /* 0xe3468000 */
+	{ TARGET_SD10G_LANE,           0x60000 }, /* 0xe3470000 */
+	{ TARGET_SD10G_LANE +  1,      0x68000 }, /* 0xe3478000 */
+	{ TARGET_SD10G_LANE +  2,      0x70000 }, /* 0xe3480000 */
+	{ TARGET_SD10G_LANE +  3,      0x78000 }, /* 0xe3488000 */
+	{ TARGET_SD10G_LANE +  4,      0x80000 }, /* 0xe3490000 */
+	{ TARGET_SD10G_LANE +  5,      0x88000 }, /* 0xe3498000 */
+	{ TARGET_SD10G_LANE +  6,      0x90000 }, /* 0xe34a0000 */
+	{ TARGET_SD10G_LANE +  7,      0x98000 }, /* 0xe34a8000 */
+	{ TARGET_SD10G_LANE +  8,      0xa0000 }, /* 0xe34b0000 */
+	{ TARGET_SD10G_LANE +  9,      0xa8000 }, /* 0xe34b8000 */
+	{ TARGET_SD_LANE,             0x100000 }, /* 0xe3510000 */
+	{ TARGET_SD_LANE +  1,        0x108000 }, /* 0xe3518000 */
+	{ TARGET_SD_LANE +  2,        0x110000 }, /* 0xe3520000 */
+	{ TARGET_SD_LANE +  3,        0x118000 }, /* 0xe3528000 */
+	{ TARGET_SD_LANE +  4,        0x120000 }, /* 0xe3530000 */
+	{ TARGET_SD_LANE +  5,        0x128000 }, /* 0xe3538000 */
+	{ TARGET_SD_LANE +  6,        0x130000 }, /* 0xe3540000 */
+	{ TARGET_SD_LANE +  7,        0x138000 }, /* 0xe3548000 */
+	{ TARGET_SD_LANE +  8,        0x140000 }, /* 0xe3550000 */
+	{ TARGET_SD_LANE +  9,        0x148000 }, /* 0xe3558000 */
+};
+
 static const struct sparx5_serdes_match_data sparx5_desc = {
 	.type = SPX5_TARGET_SPARX5,
 	.iomap = sparx5_serdes_iomap,
@@ -2534,6 +2606,21 @@ static const struct sparx5_serdes_match_data sparx5_desc = {
 	},
 };
 
+static const struct sparx5_serdes_match_data lan969x_desc = {
+	.type = SPX5_TARGET_LAN969X,
+	.iomap = lan969x_serdes_iomap,
+	.iomap_size = ARRAY_SIZE(lan969x_serdes_iomap),
+	.tsize = lan969x_serdes_tsize,
+	.consts = {
+		.sd_max       = 10,
+		.cmu_max      = 6,
+	},
+	.ops = {
+		.serdes_type_set      = &lan969x_serdes_type_set,
+		.serdes_cmu_get       = &lan969x_serdes_cmu_get,
+	}
+};
+
 /* Client lookup function, uses serdes index */
 static struct phy *sparx5_serdes_xlate(struct device *dev,
 				     const struct of_phandle_args *args)
@@ -2635,6 +2722,7 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 
 static const struct of_device_id sparx5_serdes_match[] = {
 	{ .compatible = "microchip,sparx5-serdes", .data = &sparx5_desc },
+	{ .compatible = "microchip,lan9691-serdes", .data = &lan969x_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sparx5_serdes_match);
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 1beaa3d05a5d..d7093d0b09c0 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -36,6 +36,8 @@ enum sparx5_10g28cmu_mode {
 
 enum sparx5_target {
 	SPX5_TARGET_SPARX5,
+	SPX5_TARGET_LAN969X,
+
 };
 
 struct sparx5_serdes_macro {

-- 
2.34.1


