Return-Path: <linux-kernel+bounces-330451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8B979EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750901C22DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFD414D439;
	Mon, 16 Sep 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S1Val37B"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45B14A4C1;
	Mon, 16 Sep 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480232; cv=none; b=RDfnkMu7XuJHdQ9/IJt5tiR4BkunpjYrrdRMBAh1QO/0i0NB8aLRti71JgjV2M0SiuktUzNkr+ewQsLskHHTAXfCuTmzR9bgvDpxiOg9cf0+pXEcabeV1ZF9Vbw10h1GHP9sW/Cd8p7FROrAnZYoP1Aq+UOasU+tztFZ3XldbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480232; c=relaxed/simple;
	bh=3snNzhZdAaieMyjpY/9scwKbiNQl/gdpYsT+IY699NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kPbVtvQaWijJh8SSRig8gnOkRERLrDI0oJO3+YS9VgyNqhCYFeNHscA0OvC01dv7vC5rTABdTLyzqTJVKPF3xKfLnU553OLdEKxgNCglRIyy3rX+Gwj61tKWKpkvf6XotD7dU8DbPmQ8N9+KueV/+qaFiUxDfCh+6kDNyPfSMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S1Val37B; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726480231; x=1758016231;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3snNzhZdAaieMyjpY/9scwKbiNQl/gdpYsT+IY699NI=;
  b=S1Val37BF9fzuqyq9JCLIEH+MQ1+8y5xJXz9MI79O5XZh0rFaTOULeaS
   Cm9xFPbH+JLKmKfTHmaH36IJsR77e6s20qa92wWD1JwJGW+dZ63+Dfy4o
   vugQSj1tY/uElor+fYu9LRJnvCWdT0o8CKJHAXv0nPZ5bn/aIsiBp7xkd
   vSK55m+PKVdkOQUNhqHo27Ykt7bkbntcxQ7HJ02SKL0OoEuzPLJLMDMTN
   D3OZoz60VqjxmjqUbiG/zMKe3DWG4KbaKhSG7tkBLWPjYLmJmy7Fh8grk
   ZWyo6qFiCWOkg4p0kwcEioJpdid99vStj36Tb5op9THM2LMZeKZ/ZIIgI
   A==;
X-CSE-ConnectionGUID: As66prBtTYKW6R/VrMccAw==
X-CSE-MsgGUID: 2jWW2n5pRUSoqnM+mjjQPg==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="262821348"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:50:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:50:21 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:50:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 16 Sep 2024 11:49:21 +0200
Subject: [PATCH 3/4] clk: lan966x: prepare driver for lan969x support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240916-lan969x-clock-v1-3-0e150336074d@microchip.com>
References: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
In-Reply-To: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x support, add private match data for lan966x
and add variables for: peripheral clock names, clock gate names, number
of total clocks and number of generic clocks. Use the variables
throughout.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/clk/clk-lan966x.c | 56 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index 4dbd4eb0e507..b25330159446 100644
--- a/drivers/clk/clk-lan966x.c
+++ b/drivers/clk/clk-lan966x.c
@@ -24,7 +24,7 @@
 
 #define DIV_MAX		255
 
-static const char * const clk_names[N_CLOCKS] = {
+static const char * const lan966x_clk_names[] = {
 	"qspi0", "qspi1", "qspi2", "sdmmc0",
 	"pi", "mcan0", "mcan1", "flexcom0",
 	"flexcom1", "flexcom2", "flexcom3",
@@ -53,7 +53,7 @@ struct clk_gate_soc_desc {
 	int bit_idx;
 };
 
-static const struct clk_gate_soc_desc clk_gate_desc[] = {
+static const struct clk_gate_soc_desc lan966x_clk_gate_desc[] = {
 	{ "uhphs", 11 },
 	{ "udphs", 10 },
 	{ "mcramc", 9 },
@@ -61,6 +61,22 @@ static const struct clk_gate_soc_desc clk_gate_desc[] = {
 	{ }
 };
 
+struct lan966x_match_data {
+	char *name;
+	const char * const *clk_name;
+	const struct clk_gate_soc_desc *clk_gate_desc;
+	u8 num_generic_clks;
+	u8 num_total_clks;
+};
+
+static struct lan966x_match_data lan966x_desc = {
+	.name = "lan966x",
+	.clk_name = lan966x_clk_names,
+	.clk_gate_desc = lan966x_clk_gate_desc,
+	.num_total_clks = 18,
+	.num_generic_clks = 14,
+};
+
 static DEFINE_SPINLOCK(clk_gate_lock);
 static void __iomem *base;
 
@@ -186,24 +202,26 @@ static struct clk_hw *lan966x_gck_clk_register(struct device *dev, int i)
 };
 
 static int lan966x_gate_clk_register(struct device *dev,
+				     const struct lan966x_match_data *data,
 				     struct clk_hw_onecell_data *hw_data,
 				     void __iomem *gate_base)
 {
-	int i;
+	for (int i = data->num_generic_clks; i < data->num_total_clks; ++i) {
+		int idx = i - data->num_generic_clks;
+		const struct clk_gate_soc_desc *desc;
 
-	for (i = GCK_GATE_UHPHS; i < N_CLOCKS; ++i) {
-		int idx = i - GCK_GATE_UHPHS;
+		desc = &data->clk_gate_desc[idx];
 
 		hw_data->hws[i] =
-			devm_clk_hw_register_gate(dev, clk_gate_desc[idx].name,
-						  "lan966x", 0, gate_base,
-						  clk_gate_desc[idx].bit_idx,
+			devm_clk_hw_register_gate(dev, desc->name,
+						  data->name, 0, gate_base,
+						  desc->bit_idx,
 						  0, &clk_gate_lock);
 
 		if (IS_ERR(hw_data->hws[i]))
 			return dev_err_probe(dev, PTR_ERR(hw_data->hws[i]),
 					     "failed to register %s clock\n",
-					     clk_gate_desc[idx].name);
+					     desc->name);
 	}
 
 	return 0;
@@ -211,13 +229,19 @@ static int lan966x_gate_clk_register(struct device *dev,
 
 static int lan966x_clk_probe(struct platform_device *pdev)
 {
+	const struct lan966x_match_data *data;
 	struct clk_hw_onecell_data *hw_data;
 	struct device *dev = &pdev->dev;
 	void __iomem *gate_base;
 	struct resource *res;
 	int i, ret;
 
-	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, N_CLOCKS),
+	data = device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws,
+						data->num_total_clks),
 			       GFP_KERNEL);
 	if (!hw_data)
 		return -ENOMEM;
@@ -228,10 +252,10 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 
 	init.ops = &lan966x_gck_ops;
 
-	hw_data->num = GCK_GATE_UHPHS;
+	hw_data->num = data->num_generic_clks;
 
-	for (i = 0; i < GCK_GATE_UHPHS; i++) {
-		init.name = clk_names[i];
+	for (i = 0; i < data->num_generic_clks; i++) {
+		init.name = data->clk_name[i];
 		hw_data->hws[i] = lan966x_gck_clk_register(dev, i);
 		if (IS_ERR(hw_data->hws[i])) {
 			dev_err(dev, "failed to register %s clock\n",
@@ -246,9 +270,9 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 		if (IS_ERR(gate_base))
 			return PTR_ERR(gate_base);
 
-		hw_data->num = N_CLOCKS;
+		hw_data->num = data->num_total_clks;
 
-		ret = lan966x_gate_clk_register(dev, hw_data, gate_base);
+		ret = lan966x_gate_clk_register(dev, data, hw_data, gate_base);
 		if (ret)
 			return ret;
 	}
@@ -257,7 +281,7 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lan966x_clk_dt_ids[] = {
-	{ .compatible = "microchip,lan966x-gck", },
+	{ .compatible = "microchip,lan966x-gck", .data = &lan966x_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lan966x_clk_dt_ids);

-- 
2.34.1


