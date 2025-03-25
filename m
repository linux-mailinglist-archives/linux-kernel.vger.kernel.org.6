Return-Path: <linux-kernel+bounces-575677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F364EA705B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AE716A99B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FF25D1E2;
	Tue, 25 Mar 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J70eifHM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27B25332E;
	Tue, 25 Mar 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918196; cv=none; b=Jo5PF6/z8YhlSFG++E5ympMZT73SbRpbUs/s8RFI+dTaVFphFKuGwQEV3aHkESeCykEIsHSnL5OIYJMZuyam6R7pqzT1tW1dgkZION5GCLd8KizmFy5sn5ABvofCiSJk5M74FtGdnmCdi4Iodg4pNeLHh88iR3gV4S+nBipPCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918196; c=relaxed/simple;
	bh=njhp2XtVb4PhtB0KA2dZs1VqgKACFt3lVxVn3QeR+2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDwkltri/EN5cslF7LZgsncfvGkhRzQB9+pA2APz/eSK1qgAj1CHjAnZA+Esf/ZrRgLai8xFuq57/LPyGHkRmtDFHiBAvHkLgewszL16fh6b9OYbpUYRR3mngoCzPj84oQN0d5W1d9DJNw94fb6edBlxy3uvFXGXkEo7Iu6WCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J70eifHM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742918194; x=1774454194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=njhp2XtVb4PhtB0KA2dZs1VqgKACFt3lVxVn3QeR+2o=;
  b=J70eifHM+wtALNmE/TrY7nmKr6ZQXrB/eMiMDP8fmPNvJlRFiOBjeV1l
   Bv2bgUDhlkC5B6cHMY2Ea9lGnqj+QAdxD75Z88XIidK1PuuC9+5Ou5MjH
   oNK64jVvEGzWQwNyziwmutBng4XYeSXmjTy8rzyNC4LeK2kvHwOZ+JH7H
   Oz2FRX42+qMuAfaxNZqp/WnR7XZglLaBuEqnO6Ymyd1tPE7fz3NwFyJj2
   KCD5odw4gvhpIFArxKqARFYvGp0bWoL6dmp6SvTNipcL3Y3GXNGNQUgfm
   lnxNKHRilA2QHlWDdLj7aItIaHc4LGkjT0oBw6jZzVxcV+ncZ+XNZJlHU
   Q==;
X-CSE-ConnectionGUID: 5ZRRXf5LQVCIU2dRAgtdWw==
X-CSE-MsgGUID: do4csKX9TtyoN10bzub/Vw==
X-IronPort-AV: E=Sophos;i="6.14,275,1736838000"; 
   d="scan'208";a="40152229"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2025 08:55:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 08:54:53 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 25 Mar 2025 08:54:53 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>
CC: <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 1/4] clk: at91: sckc: Fix parent_data struct for slow osc
Date: Tue, 25 Mar 2025 08:55:07 -0700
Message-ID: <d470bb761530827889beaa2c2815e127fc8b412e.1742916867.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742916867.git.Ryan.Wanner@microchip.com>
References: <cover.1742916867.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

The slow xtal is not described correctly as a parent, the driver looks for a
"slow_xtal" string which is incorrect and will not work with the new
formating of xtals.

To avoid this and keep this driver backwards compatible the
parent_data.fw_name is replaced with parent_data.name and the original
parent_data.name is replaced with parent_data.index. Using the index is
safe due to the driver requiring only 1 xtal.

Fixes: 8aa1db9ccee0e ("clk: at91: sckc: switch to parent_data/parent_hw")

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/sckc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 021d1b412af4..952a805b6f7e 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -374,7 +374,7 @@ static void __init at91sam9x5_sckc_register(struct device_node *np,
 	const char *xtal_name;
 	struct clk_hw *slow_rc, *slow_osc, *slowck;
 	static struct clk_parent_data parent_data = {
-		.name = "slow_xtal",
+		.index = 0,
 	};
 	const struct clk_hw *parent_hws[2];
 	bool bypass;
@@ -407,7 +407,7 @@ static void __init at91sam9x5_sckc_register(struct device_node *np,
 	if (!xtal_name)
 		goto unregister_slow_rc;
 
-	parent_data.fw_name = xtal_name;
+	parent_data.name = xtal_name;
 
 	slow_osc = at91_clk_register_slow_osc(regbase, "slow_osc",
 					      &parent_data, 1200000, bypass, bits);
@@ -476,7 +476,7 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 	const char *xtal_name;
 	const struct clk_hw *parent_hws[2];
 	static struct clk_parent_data parent_data = {
-		.name = "slow_xtal",
+		.index = 0,
 	};
 	bool bypass;
 	int ret;
@@ -494,7 +494,7 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 	if (!xtal_name)
 		goto unregister_slow_rc;
 
-	parent_data.fw_name = xtal_name;
+	parent_data.name = xtal_name;
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 	slow_osc = at91_clk_register_slow_osc(regbase, "slow_osc",
 					      &parent_data, 5000000, bypass,
@@ -592,7 +592,7 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 	const char *xtal_name;
 	const struct clk_hw *parent_hws[2];
 	static struct clk_parent_data parent_data = {
-		.name = "slow_xtal",
+		.index = 0,
 	};
 	int ret;
 
@@ -609,7 +609,7 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 	xtal_name = of_clk_get_parent_name(np, 0);
 	if (!xtal_name)
 		goto unregister_slow_rc;
-	parent_data.fw_name = xtal_name;
+	parent_data.name = xtal_name;
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
 	if (!osc)
-- 
2.43.0


