Return-Path: <linux-kernel+bounces-318900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A031296F4C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28F3B23C21
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A611CEEBE;
	Fri,  6 Sep 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mWHF30Wy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705741CE704;
	Fri,  6 Sep 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627256; cv=none; b=o9CkxBl39xx5UjRRuHc1PiuYSExEa+mvfmaiIWLqvWNiJBPtjebO5yHPSiCi2ISSraAgnKD8Q84hXrv8B5zn7vp9CLihcfGloHIQ2B18pNPhTh0RVmDkA7nvjp/AvUATxjil2R047SK5LIT9iaueF4uBvLLijek/iV7wfZiOUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627256; c=relaxed/simple;
	bh=tjcjEhjpTxjl2BLDskeVYj2Lk7MhcvUneySLl+PKUE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V/kVp+5cNfa6OHtCmS8MlDLco/QnOT0CT85TWao1Eg70xA3qKhmF6Qf2ZiytFO/uWhzV9ayo4ekOOQWRKruxLIO02QzDfAgVBRRPbLm0NdHV/uLhCIfHUkw1nnxEyYi9y/VjKAxYA6wn3UcDoLmXN2WBltEadcISMSIOk0l7TG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mWHF30Wy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627254; x=1757163254;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tjcjEhjpTxjl2BLDskeVYj2Lk7MhcvUneySLl+PKUE8=;
  b=mWHF30WyqsRdk1fpgnAOd9GpIllP9xNlUzFvp/rpbYoF7xm+OvdaZd4M
   3jAERdBoAM+z4bP8riiCq3jd+n9BGxsRG7gnBmVnkGyr0GsbnKjSDOebi
   dEFLmoIWZlDD1QMZvmJhukBdUR09B0ksVNY82xlGZdrBsvpULXgV7eyMC
   YA8i8RjUW6cSKMq28RKdQUVes6Y9Yy5/p1pPmAGu9WXMVCdIX1j06KO7A
   996pU9wj/vEfNsmAaNC47iUeNFV8wlGdRPiLDGc7rsuJ/doMwdxhDBfVH
   crHhVyddn28mOZumnJbuiA0DBSS0LBFou6R64/rWkE+i9MN3Ex4TyuMjH
   Q==;
X-CSE-ConnectionGUID: aGkh2dtQQfCI8QG2frKi1g==
X-CSE-MsgGUID: b7FA8d3ASK2gCHjhEpqjfw==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="262386468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:54:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:29 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:27 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Sep 2024 14:52:44 +0200
Subject: [PATCH 7/9] phy: sparx5-serdes: add support for branching on chip
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-7-8d630614c58a@microchip.com>
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

In preparation for lan969x, add a way to branch out on code that is to
be executed on either Sparx5 or lan969x.  Initially, this is required to
branch out when checking the SERDES types and SERDES speeds, since the
handling of these differ on the two platforms. This will also be used by
the lan969x driver introduced in a subsequent patch.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 29 ++++++++++++++++++-----------
 drivers/phy/microchip/sparx5_serdes.h |  5 +++++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 8a716bfaa023..05fdf225ff43 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -2298,10 +2298,12 @@ static int sparx5_serdes_set_speed(struct phy *phy, int speed)
 {
 	struct sparx5_serdes_macro *macro = phy_get_drvdata(phy);
 
-	if (macro->sidx < SPX5_SERDES_10G_START && speed > SPEED_5000)
-		return -EINVAL;
-	if (macro->sidx < SPX5_SERDES_25G_START && speed > SPEED_10000)
-		return -EINVAL;
+	if (macro->priv->data->type == SPX5_TARGET_SPARX5) {
+		if (macro->sidx < SPX5_SERDES_10G_START && speed > SPEED_5000)
+			return -EINVAL;
+		if (macro->sidx < SPX5_SERDES_25G_START && speed > SPEED_10000)
+			return -EINVAL;
+	}
 	if (speed != macro->speed) {
 		macro->speed = speed;
 		if (macro->serdesmode != SPX5_SD_MODE_NONE)
@@ -2338,11 +2340,14 @@ static int sparx5_serdes_validate(struct phy *phy, enum phy_mode mode,
 	if (macro->speed == 0)
 		return -EINVAL;
 
-	if (macro->sidx < SPX5_SERDES_10G_START && macro->speed > SPEED_5000)
-		return -EINVAL;
-	if (macro->sidx < SPX5_SERDES_25G_START && macro->speed > SPEED_10000)
-		return -EINVAL;
-
+	if (macro->priv->data->type == SPX5_TARGET_SPARX5) {
+		if (macro->sidx < SPX5_SERDES_10G_START &&
+		    macro->speed > SPEED_5000)
+			return -EINVAL;
+		if (macro->sidx < SPX5_SERDES_25G_START &&
+		    macro->speed > SPEED_10000)
+			return -EINVAL;
+	}
 	switch (submode) {
 	case PHY_INTERFACE_MODE_1000BASEX:
 		if (macro->speed != SPEED_100 && /* This is for 100BASE-FX */
@@ -2515,6 +2520,7 @@ static struct sparx5_serdes_io_resource sparx5_serdes_iomap[] =  {
 };
 
 static const struct sparx5_serdes_match_data sparx5_desc = {
+	.type = SPX5_TARGET_SPARX5,
 	.iomap = sparx5_serdes_iomap,
 	.iomap_size = ARRAY_SIZE(sparx5_serdes_iomap),
 	.tsize = sparx5_serdes_tsize,
@@ -2618,8 +2624,9 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	/* Power down all CMUs by default */
-	sparx5_serdes_cmu_power_off(priv);
+	/* Power down all CMU's by default */
+	if (priv->data->type == SPX5_TARGET_SPARX5)
+		sparx5_serdes_cmu_power_off(priv);
 
 	provider = devm_of_phy_provider_register(priv->dev, sparx5_serdes_xlate);
 
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 50900bf06c4c..1beaa3d05a5d 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -34,6 +34,10 @@ enum sparx5_10g28cmu_mode {
 	SPX5_SD10G28_CMU_MAX,
 };
 
+enum sparx5_target {
+	SPX5_TARGET_SPARX5,
+};
+
 struct sparx5_serdes_macro {
 	struct sparx5_serdes_private *priv;
 	u32 sidx;
@@ -56,6 +60,7 @@ struct sparx5_serdes_ops {
 };
 
 struct sparx5_serdes_match_data {
+	enum sparx5_target type;
 	const struct sparx5_serdes_consts consts;
 	const struct sparx5_serdes_ops ops;
 	const struct sparx5_serdes_io_resource *iomap;

-- 
2.34.1


