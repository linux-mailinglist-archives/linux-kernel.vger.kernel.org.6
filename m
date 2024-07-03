Return-Path: <linux-kernel+bounces-239258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CECA925891
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B191C21CA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D381741DC;
	Wed,  3 Jul 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lMn+lhYg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDD171085;
	Wed,  3 Jul 2024 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002489; cv=none; b=u7jPDLvy5ELxZtDCot9VmqAVK1nPkxbBK6RmrGrzRpFxMtP2e+5QnF4I2iPTWgljkHvqC4MqYoDu5GpCmVXGyodymDAMOWsSO3RULi77yQF1eBY0JCiKQiS8RW/xMMjmZ7TxHoYnuQkfsJbUgPvSbLJD9GHyVxUZurc1D5YyoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002489; c=relaxed/simple;
	bh=NycM/6GqLRtFrGB/KY1v7hoKxrqUj+TND0uXU/YfnHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8CM2kX7p60k/BVxX52MBJuMY3v6Kf8UVw+qp/Fk763dgKWHF+OxdyQj3HF2HBsCHMCqXwBeN5KO8d/jkkjamRDBtyLbbrNin6qBtBPuU5YbBillUrsBGAHNSauzWvokVs02QMEw8/Qxv0PpFh+jAVXHusCUlnIND+r42hfDIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lMn+lhYg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002488; x=1751538488;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NycM/6GqLRtFrGB/KY1v7hoKxrqUj+TND0uXU/YfnHk=;
  b=lMn+lhYgsMtRyqGxUevQSScM1siVVACqznmjgX4IML/Iebm951qQzpWs
   nQJ2TvwhLvoA7GO/Pi9Dyok7KGZiTWXz+kEJ8vf1GpG07gXfxyKcwGiD9
   bKuWB07i/QnhH0gbn+/DVv8V/C3bUXjkQ89/d7X7oNtyI1PL0GLJJFQ85
   PMeHK6zkMxCZDeG2TyaRHEsEOROzXyXB3iQauovtHDNzPR4J3Ecrc1Ykg
   if+dWFNtO4gOQ54KqHl0foRPlJ04F0XdARlaa4rz65lkqSAmPs3g5+4om
   4OWVqdcBUJc/3vMeWuOgMYXpUv+MAcUqFUaL4NDE6yqo8h177h69o92to
   w==;
X-CSE-ConnectionGUID: C1sswkSrQy+pa1d+oVi69g==
X-CSE-MsgGUID: 542unQ1TRLOWZ3Tvaz8tKQ==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="29441489"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:27:43 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:27:39 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/27] clk: at91: sam9x7: add support for HW PLL freq dividers
Date: Wed, 3 Jul 2024 15:57:36 +0530
Message-ID: <20240703102736.195810-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for hardware dividers for PLL IDs in sam9x7 SoC. The system
PLL - PLLA and the system PLL divided by 2 - PLLADIV2 with PLL ID 0 and
4 respectively, both have a hardware divider /2. This has to be taken into
account in the software to obtain the right frequencies. Support for the
same is added in the PLL driver.

fcorepllack -----> HW Div = 2 -+--> fpllack
                               |
                               +--> HW Div = 2 ---> fplladiv2ck

In this case the corepll freq is 1600 MHz. So, the plla freq is 800 MHz
after the hardware divider and the plladiv2 freq is 400 MHz after the
hardware divider (given that the DIVPMC is 0).

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v5:
- Corrected typos in commit message.
- Rewrote the conditional statement.
---
 drivers/clk/at91/clk-sam9x60-pll.c | 30 ++++++++++++++++++++++++++++--
 drivers/clk/at91/pmc.h             |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index b0314dfd7393..fda041102224 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -73,9 +73,15 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	unsigned long freq;
 
-	return parent_rate * (frac->mul + 1) +
+	freq = parent_rate * (frac->mul + 1) +
 		DIV_ROUND_CLOSEST_ULL((u64)parent_rate * frac->frac, (1 << 22));
+
+	if (core->layout->div2)
+		freq >>= 1;
+
+	return freq;
 }
 
 static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
@@ -432,6 +438,12 @@ static unsigned long sam9x60_div_pll_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST_ULL(parent_rate, (div->div + 1));
 }
 
+static unsigned long sam9x60_fixed_div_pll_recalc_rate(struct clk_hw *hw,
+						       unsigned long parent_rate)
+{
+	return parent_rate >> 1;
+}
+
 static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
 					unsigned long *parent_rate,
 					unsigned long rate)
@@ -606,6 +618,16 @@ static const struct clk_ops sam9x60_div_pll_ops_chg = {
 	.restore_context = sam9x60_div_pll_restore_context,
 };
 
+static const struct clk_ops sam9x60_fixed_div_pll_ops = {
+	.prepare = sam9x60_div_pll_prepare,
+	.unprepare = sam9x60_div_pll_unprepare,
+	.is_prepared = sam9x60_div_pll_is_prepared,
+	.recalc_rate = sam9x60_fixed_div_pll_recalc_rate,
+	.round_rate = sam9x60_div_pll_round_rate,
+	.save_context = sam9x60_div_pll_save_context,
+	.restore_context = sam9x60_div_pll_restore_context,
+};
+
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			      const char *name, const char *parent_name,
@@ -725,10 +747,14 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
-	if (flags & CLK_SET_RATE_GATE)
+
+	if (layout->div2)
+		init.ops = &sam9x60_fixed_div_pll_ops;
+	else if (flags & CLK_SET_RATE_GATE)
 		init.ops = &sam9x60_div_pll_ops;
 	else
 		init.ops = &sam9x60_div_pll_ops_chg;
+
 	init.flags = flags;
 
 	div->core.id = id;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index bb9da35198d9..91d1c6305d95 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -64,6 +64,7 @@ struct clk_pll_layout {
 	u8 frac_shift;
 	u8 div_shift;
 	u8 endiv_shift;
+	u8 div2;
 };
 
 extern const struct clk_pll_layout at91rm9200_pll_layout;
-- 
2.25.1


