Return-Path: <linux-kernel+bounces-239260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2452925898
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256E51F27761
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E754D176ACF;
	Wed,  3 Jul 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hHUkGnc4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130617554E;
	Wed,  3 Jul 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002493; cv=none; b=P2qyjjvGjyrD7fo456er43ZIwAPCPP+OzEj5HFC/HmfZ1+BsbSpbywtO8Rl3+oTOSdWCFSXslrHXHb8FUnwdCBp2nZVyv7EMr7euTpRemLcZ5IGyPG7aI22y4vWvu4/UcRuuI/EEffeBIHFq0O02lCM9q4/poSY9grDkASC5kf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002493; c=relaxed/simple;
	bh=f1dps+oGiDe/KHzYb18t8lFz4154pwNNCSulv4GCbrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHaNIe/F5KjMlvVGO89oj+MFySkWlbbx0Vaz0MhP4Q4i96HiMWkT9/GG9AcYzWhzFsp8Y2Yc7MmtnlQa8ATF8qXI5piik31jqNMCK5kvXOQxYuIlKDxVtNjHz/1OWLbZpnFRnYfZnf7oAd9r2KpJBRrdNH8sNLJ1drymcSFv2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hHUkGnc4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002492; x=1751538492;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=f1dps+oGiDe/KHzYb18t8lFz4154pwNNCSulv4GCbrs=;
  b=hHUkGnc4oCaZJIu56QKUqICQDqofEIYNAFEvXdqrvNy+1s+uPdob1I1+
   ZfzVvAWkS25w2VT1snMCWWrGLRNx0jkGX7sUXyEm6Up5sjXLynNNxxDIL
   l1EN0oQ0CM1xImgNWJVSlWLs60RD0GUoTQ58pNlLEtUzJKhF475bGUQKn
   cv1zLnWHxdAFGcbn1A3+itVpXfIg91t6+0SSDi/hIiZN4RDuGV7xT6oqV
   20/xISbNpAdQWwj8FvK7I/7Uez/AiMJo5zRaHmA60kZV8x5m9H7+uaEML
   aL9QSwfHDrCtooRS37tmVqoMo4z/e62fCodQHw4cxow7Ou/R4/HlYofK4
   g==;
X-CSE-ConnectionGUID: zAkMoDX+T3uCd+MLD1u0xA==
X-CSE-MsgGUID: IM/BieWZRxmhDsd3pr44FA==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28804743"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:27:49 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:27:46 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 11/27] clk: at91: sama7g5: move mux table macros to header file
Date: Wed, 3 Jul 2024 15:57:43 +0530
Message-ID: <20240703102743.195858-1-varshini.rajendran@microchip.com>
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

Move the mux table init and fill macro function definitions from the
sama7g5 pmc driver to the pmc.h header file since they will be used
by other SoC's pmc drivers as well like sam9x7.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/pmc.h     | 16 ++++++++++++++++
 drivers/clk/at91/sama7g5.c | 35 ++++++++++-------------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 91d1c6305d95..4fb29ca111f7 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -121,6 +121,22 @@ struct at91_clk_pms {
 
 #define ndck(a, s) (a[s - 1].id + 1)
 #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
+
+#define PMC_INIT_TABLE(_table, _count)			\
+	do {						\
+		u8 _i;					\
+		for (_i = 0; _i < (_count); _i++)	\
+			(_table)[_i] = _i;		\
+	} while (0)
+
+#define PMC_FILL_TABLE(_to, _from, _count)		\
+	do {						\
+		u8 _i;					\
+		for (_i = 0; _i < (_count); _i++) {	\
+			(_to)[_i] = (_from)[_i];	\
+		}					\
+	} while (0)
+
 struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 				   unsigned int nperiph, unsigned int ngck,
 				   unsigned int npck);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index e6eb5afba93d..6706d1305baa 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -16,21 +16,6 @@
 
 #include "pmc.h"
 
-#define SAMA7G5_INIT_TABLE(_table, _count)		\
-	do {						\
-		u8 _i;					\
-		for (_i = 0; _i < (_count); _i++)	\
-			(_table)[_i] = _i;		\
-	} while (0)
-
-#define SAMA7G5_FILL_TABLE(_to, _from, _count)		\
-	do {						\
-		u8 _i;					\
-		for (_i = 0; _i < (_count); _i++) {	\
-			(_to)[_i] = (_from)[_i];	\
-		}					\
-	} while (0)
-
 static DEFINE_SPINLOCK(pmc_pll_lock);
 static DEFINE_SPINLOCK(pmc_mck0_lock);
 static DEFINE_SPINLOCK(pmc_mckX_lock);
@@ -1119,17 +1104,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		if (!mux_table)
 			goto err_free;
 
-		SAMA7G5_INIT_TABLE(mux_table, 3);
-		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
-				   sama7g5_mckx[i].ep_count);
+		PMC_INIT_TABLE(mux_table, 3);
+		PMC_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
+			       sama7g5_mckx[i].ep_count);
 		for (j = 0; j < sama7g5_mckx[i].ep_count; j++) {
 			u8 pll_id = sama7g5_mckx[i].ep[j].pll_id;
 			u8 pll_compid = sama7g5_mckx[i].ep[j].pll_compid;
 
 			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
 		}
-		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
-				   sama7g5_mckx[i].ep_count);
+		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
+			       sama7g5_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
 				   num_parents, NULL, parent_hws, mux_table,
@@ -1215,17 +1200,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		if (!mux_table)
 			goto err_free;
 
-		SAMA7G5_INIT_TABLE(mux_table, 3);
-		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
-				   sama7g5_gck[i].pp_count);
+		PMC_INIT_TABLE(mux_table, 3);
+		PMC_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
+			       sama7g5_gck[i].pp_count);
 		for (j = 0; j < sama7g5_gck[i].pp_count; j++) {
 			u8 pll_id = sama7g5_gck[i].pp[j].pll_id;
 			u8 pll_compid = sama7g5_gck[i].pp[j].pll_compid;
 
 			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
 		}
-		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
-				   sama7g5_gck[i].pp_count);
+		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
+			       sama7g5_gck[i].pp_count);
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama7g5_pcr_layout,
-- 
2.25.1


