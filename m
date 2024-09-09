Return-Path: <linux-kernel+bounces-321666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2634971DCA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76631B23559
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A4136326;
	Mon,  9 Sep 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HK8iw3Tp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBA3DBB6;
	Mon,  9 Sep 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894926; cv=none; b=DpYuh0CD1XhlpX8SXGj7bO5yRNod7V0kAIa68CQDlJd2+2lHdWLO6ttZvslgoenAUGtC+ZxbSJjhR73YmtrBLMNa5yjFGRb1DEysSej/M1nnHf2P5Lv/cA9Gu5f/bg4GmOP4ByhRkcX2HPZcBVpBiRflLcNqArtLtfJj21GYCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894926; c=relaxed/simple;
	bh=pbm+e8RlELy0SuLLhozJgphfQNaU2znVcUGcpSphMQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jCAIFNX5jGdrqghlPDornZ8TCwck8RGaiVtGQw9c5zl+EbGWA9DqDP2WnrJzL8wCepo7vPNNWCcEBhab6TdX+yTGat8fOdktIe/l+C/0PH6lmYIvAb7igYWaff2E6VWGYEt8DXJII3tvFlPyRU8/kyAWbp4amIRLoX2NnIJz2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HK8iw3Tp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894923; x=1757430923;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pbm+e8RlELy0SuLLhozJgphfQNaU2znVcUGcpSphMQ0=;
  b=HK8iw3TpXf4CpzJuovfUdV7xSqDWMlORswFzajJi7EwSj5SmAjFGvcxY
   SmGR4xPg+X18cI+FhlVplNbekAoRPAo1nOCnyoFBrgCZfZhmuGnyO6RsN
   vBAcXDHgpcH0CmsKngUyDxbEKnLk+kL9rqfYrC9iE4FBIPyFNKAR/FXFe
   hetV2o7rfrSoW4Z+lIx0r22J1kRJbWJV3eBece3oDGhrhZ+CICaxL+63a
   MApH/BPldNyKC+rkrtO5aYByc7gVVfGQrCpkzjZKM1jMBfIkCQF7r/FNk
   0gytCd4LQXK1joBBe4zTfBhoC0TnjeJ3yUxs6R5KTK/TNn4aMAo1/GUVY
   w==;
X-CSE-ConnectionGUID: /ltMKKTeRqSXWxXLFfJz/g==
X-CSE-MsgGUID: Yr4XJKMqRJuGa9jUd/4l+A==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="31514494"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:14:56 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:14:54 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 9 Sep 2024 17:14:41 +0200
Subject: [PATCH v2 1/9] phy: sparx5-serdes: add support for private match
 data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-1-d695bcb57b84@microchip.com>
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


