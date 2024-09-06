Return-Path: <linux-kernel+bounces-318891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F048196F4AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA971F281E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089021CDA27;
	Fri,  6 Sep 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CPU5cGsA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89397266AB;
	Fri,  6 Sep 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627207; cv=none; b=aRBPJ8G/WpqjRbPWKt3+h79fSZoGHkp0m7PxPmxARwdbL6ZT003PzlcIJ5m+shvfhjQ7M6DRUA4gGljQeKR10++mfXEvot/yJzDKjYr/fIqQr1d8POjmLrpbV16eskTxafoEn5ewijH6w2k6uUMDXC7xIBI08rhvNBSrB6d5T1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627207; c=relaxed/simple;
	bh=pbm+e8RlELy0SuLLhozJgphfQNaU2znVcUGcpSphMQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bPLMeqPFf06vPK/QyVIPKCuebUJrgtTuiW9Mm+gd6BVAtP4tLfwMqxmzcXrQKWcW1CitjUfbNsGD0qQoGmpuZs5sCU0K7iaDNtIG7Uxr71sMG/f8HY6qMt8sdRGrfveRLo4W8HSo0l9Va3NOSIcFezrlLqye+Io8QbSUA53ovf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CPU5cGsA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627205; x=1757163205;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pbm+e8RlELy0SuLLhozJgphfQNaU2znVcUGcpSphMQ0=;
  b=CPU5cGsAR8vTQ+TOyudK+fP1BZsfAiWF31oVzJMRY5VEqbDK5kO+09a+
   6RoMrKeoOxUpj9GKe0JNrGRRF2tjsjLpHkjIgyJBGNHjwBuIQLSL1zKGy
   nouw4H6TmVWJGLO69KlCWwTu1XlAlWSALGurtv0MJZ6qy4tuM2bjGW8x3
   FPLMJUUPRw0UyEP3wuB+b5QMJFoyYMhqEXMK5QEN9/5Smg03WZt4gnxc7
   q+6iVRKBY+6+RUsyTKZlk5ld6n7rAR8VadDLWfC8ouDy9TmeslEo0uBT6
   /xPl+nH9TlkheCqkr39S3bGdX6Em52zQd0F8DmhhQ6upvm3haWHEunFvi
   Q==;
X-CSE-ConnectionGUID: aks78ZCLRxOyTJZTZgJsDQ==
X-CSE-MsgGUID: ph61CXWcQ0ySPMEcrCqjug==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34534552"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:53:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:15 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:13 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Sep 2024 14:52:38 +0200
Subject: [PATCH 1/9] phy: sparx5-serdes: add support for private match data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-1-8d630614c58a@microchip.com>
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

In order to reuse the existing Sparx5 SERDES driver for lan969x, we add
support for private match data, with initial fields for the iomap and
imap_size.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 16 +++++++++++++---
 drivers/phy/microchip/sparx5_serdes.h |  6 ++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 7cb85029fab3..5427e8627a78 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -2507,6 +2507,11 @@ static struct sparx5_serdes_io_resource sparx5_serdes_iomap[] =  {
 	{ TARGET_SD_LANE_25G + 7, 0x5c8000 }, /* 0x610dd0000: sd_lane_25g_32 */
 };
 
+static const struct sparx5_serdes_match_data sparx5_desc = {
+	.iomap = sparx5_serdes_iomap,
+	.iomap_size = ARRAY_SIZE(sparx5_serdes_iomap),
+};
+
 /* Client lookup function, uses serdes index */
 static struct phy *sparx5_serdes_xlate(struct device *dev,
 				     const struct of_phandle_args *args)
@@ -2555,6 +2560,10 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	priv->dev = &pdev->dev;
 
+	priv->data = device_get_match_data(priv->dev);
+	if (!priv->data)
+		return -EINVAL;
+
 	/* Get coreclock */
 	clk = devm_clk_get(priv->dev, NULL);
 	if (IS_ERR(clk)) {
@@ -2579,8 +2588,9 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 			iores->name);
 		return -ENOMEM;
 	}
-	for (idx = 0; idx < ARRAY_SIZE(sparx5_serdes_iomap); idx++) {
-		struct sparx5_serdes_io_resource *iomap = &sparx5_serdes_iomap[idx];
+	for (idx = 0; idx < priv->data->iomap_size; idx++) {
+		const struct sparx5_serdes_io_resource *iomap =
+			&priv->data->iomap[idx];
 
 		priv->regs[iomap->id] = iomem + iomap->offset;
 	}
@@ -2599,7 +2609,7 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sparx5_serdes_match[] = {
-	{ .compatible = "microchip,sparx5-serdes" },
+	{ .compatible = "microchip,sparx5-serdes", .data = &sparx5_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sparx5_serdes_match);
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 13f94a29225a..128f8c53172f 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -26,11 +26,17 @@ enum sparx5_serdes_mode {
 	SPX5_SD_MODE_SFI,
 };
 
+struct sparx5_serdes_match_data {
+	const struct sparx5_serdes_io_resource *iomap;
+	int iomap_size;
+};
+
 struct sparx5_serdes_private {
 	struct device *dev;
 	void __iomem *regs[NUM_TARGETS];
 	struct phy *phys[SPX5_SERDES_MAX];
 	unsigned long coreclock;
+	const struct sparx5_serdes_match_data *data;
 };
 
 struct sparx5_serdes_macro {

-- 
2.34.1


