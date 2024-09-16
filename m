Return-Path: <linux-kernel+bounces-330452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA59979EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381821F23C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E314EC62;
	Mon, 16 Sep 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="piRD7OgD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECC14B967;
	Mon, 16 Sep 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480233; cv=none; b=tXa6ofZF8eYhAOYvkvq0TRDl8kTtTdo5GL2emsTUlnSeygowRUHtNvCXV+grVVSC5ShEuZCXQuqOo5k7EQH4owly14PkefWzxmNxu45cFpLUo+B5uP0wvLm689lnVTa0EFbz1beuPYW1wH+eRtRhwByk56w4hxmmLW7sAqaf2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480233; c=relaxed/simple;
	bh=H6Nu1y3r53qFCPxeekFdxSYffwC7CBXCt9G5Ob+GsR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jGiIhSAmQFxy4SyCZ3xqPxoHFLGoyYfjedV480gGy3pxR8K0lRQZ5Wd6zJZKV9vhqZ8qYlKxz9X4/ubqZ5nL5RduoJel5EyH7LvfDYM9YRnue9qR317SFt35VFb9Mh0TDG9bnC6jfEiLanWICTMhM8Ij4w1ctPOKrWOoCsc/okI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=piRD7OgD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726480233; x=1758016233;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=H6Nu1y3r53qFCPxeekFdxSYffwC7CBXCt9G5Ob+GsR0=;
  b=piRD7OgD2eHxSDDdPXgV3tXO9haKac/LksPjHTPgEkuofH1kOJajOZfy
   SYONLQdOz4KpILVhRInfkxfVsrEMQftHB2ftyhg9ZhsvA1W8CSHtbRAG/
   kBzeoZBQlJCk4q0h/7Qdhi/DMXV9e2Y/Bh/k51X7DxNoUmL94knT20txh
   YZD2d8UI9r80Evg3c0MAHKu3js7L05FWq/ZVAMNw/dLtBQDjhHRxbbFI8
   g8SfeUsLe56CMHksRbcTyHbFP2rSvwTn1e1EmKGqQjUNmgFyzrngB/n4b
   r4eqT5NJhhNJV/KX4o31h7+RzyQhYg/2SLQuKSzxweTfI/cfw8nWKv7yw
   Q==;
X-CSE-ConnectionGUID: As66prBtTYKW6R/VrMccAw==
X-CSE-MsgGUID: J4pw1vvcTTqwz1VwMuEp6Q==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="262821349"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:50:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:50:23 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:50:21 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 16 Sep 2024 11:49:22 +0200
Subject: [PATCH 4/4] clk: lan966x: add support for lan969x SoC clock driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240916-lan969x-clock-v1-4-0e150336074d@microchip.com>
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

Add support for the lan969x SoC clock driver in the existing lan966x
driver. The lan969x clock controller contains 3 PLLs - cpu_clk, ddr_clk
and sys_clk (same as lan966x) which generates and supplies the clock to
various peripherals within the SoC.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/clk/clk-lan966x.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index b25330159446..9b928e4a1c62 100644
--- a/drivers/clk/clk-lan966x.c
+++ b/drivers/clk/clk-lan966x.c
@@ -31,6 +31,13 @@ static const char * const lan966x_clk_names[] = {
 	"flexcom4", "timer1", "usb_refclk",
 };
 
+static const char * const lan969x_clk_names[] = {
+	"qspi0", "qspi2", "sdmmc0", "sdmmc1",
+	"mcan0", "mcan1", "flexcom0",
+	"flexcom1", "flexcom2", "flexcom3",
+	"timer1", "usb_refclk",
+};
+
 struct lan966x_gck {
 	struct clk_hw hw;
 	void __iomem *reg;
@@ -61,6 +68,13 @@ static const struct clk_gate_soc_desc lan966x_clk_gate_desc[] = {
 	{ }
 };
 
+static const struct clk_gate_soc_desc lan969x_clk_gate_desc[] = {
+	{ "usb_drd", 10 },
+	{ "mcramc", 9 },
+	{ "hmatrix", 8 },
+	{ }
+};
+
 struct lan966x_match_data {
 	char *name;
 	const char * const *clk_name;
@@ -77,6 +91,14 @@ static struct lan966x_match_data lan966x_desc = {
 	.num_generic_clks = 14,
 };
 
+static struct lan966x_match_data lan969x_desc = {
+	.name = "lan969x",
+	.clk_name = lan969x_clk_names,
+	.clk_gate_desc = lan969x_clk_gate_desc,
+	.num_total_clks = 15,
+	.num_generic_clks = 12,
+};
+
 static DEFINE_SPINLOCK(clk_gate_lock);
 static void __iomem *base;
 
@@ -282,6 +304,7 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 
 static const struct of_device_id lan966x_clk_dt_ids[] = {
 	{ .compatible = "microchip,lan966x-gck", .data = &lan966x_desc },
+	{ .compatible = "microchip,lan9691-gck", .data = &lan969x_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lan966x_clk_dt_ids);

-- 
2.34.1


