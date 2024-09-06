Return-Path: <linux-kernel+bounces-318892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91196F4B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AEB1C23A15
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151FD1CE718;
	Fri,  6 Sep 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E1r6V57U"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758181CCB34;
	Fri,  6 Sep 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627208; cv=none; b=m9L6wqylSce77APxw6JbJ9dfxykpp8W3uRfJNZx/wgy9V+RaJi0svqppmooiMLHhY6gBBiEmvqRpC6zeu40JEJe4VYo9Urr4N4WSQqbpdsLXa8CnV+Bkg5l4ZUjYIzUnOTWRYCgTGqB/yHvVJNxciqSrmcI1qpytAgHYVS2Nlgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627208; c=relaxed/simple;
	bh=1AJHRHcGfmD/9YGKz72ENNmKG33hLzSx1mSxJxpOXls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J7RlexBumJOKUsIh876v05ccNDxUh9bYECs36CV22DSczmZSFbzsllZNH6oDALIO++zO76BViv49EyuS8m1BMYI05aZmwD0n9Ma2BCu0MxVT1LRHBlftdqfmuAY4ChaWPAjBzanl2icNdIZ3JKG3S0bHCSVnI3qZe3dpdsXyVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E1r6V57U; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627206; x=1757163206;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1AJHRHcGfmD/9YGKz72ENNmKG33hLzSx1mSxJxpOXls=;
  b=E1r6V57ULtBqG7A8QT9zu79UEdSh6HnMI/CVKXhj3Ou6/PKrIkjqrAVt
   CS3yrJbbB+smYN9SVfOW4rtapKL7xDAIuN1GuC12kZuHTuGO9SiTHnT91
   Gsti2KhL1pTmHrzTXZ8ChE/dwCiCPobBpU5rMksiZd40u2QAEsL/KA6mf
   D9adz0E95GMXbUqkZ0gQK3tBvYmwmU4bgzw9Jchk7+PjU2Uk9RdVQdLaX
   H1Gts83c/SjRi5h/RmH22t8MZyJu4aXRStGVy4Q3hMpaeUg4+mgoW6/ua
   OXY6svWTwsVWSXxdtSmMJy7xMURmATiSS97SwR9LcwPEXV71mhBoLgUXK
   w==;
X-CSE-ConnectionGUID: aks78ZCLRxOyTJZTZgJsDQ==
X-CSE-MsgGUID: 2DeEyVSsTsyPQ8Fks5jYjw==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34534554"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:53:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:17 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:15 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Sep 2024 14:52:39 +0200
Subject: [PATCH 2/9] phy: sparx5-serdes: add constants to match data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-2-8d630614c58a@microchip.com>
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

We need to handle a few different constants that differ for Sparx5 and
lan969x. Add a new struct: sparx5_serdes_consts for this purpose. We
populate it with an initial field for the number of SERDES'es: sd_max.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 7 +++++--
 drivers/phy/microchip/sparx5_serdes.h | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 5427e8627a78..c3ed028fc74e 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -2510,6 +2510,9 @@ static struct sparx5_serdes_io_resource sparx5_serdes_iomap[] =  {
 static const struct sparx5_serdes_match_data sparx5_desc = {
 	.iomap = sparx5_serdes_iomap,
 	.iomap_size = ARRAY_SIZE(sparx5_serdes_iomap),
+	.consts = {
+		.sd_max       = 33,
+	},
 };
 
 /* Client lookup function, uses serdes index */
@@ -2526,7 +2529,7 @@ static struct phy *sparx5_serdes_xlate(struct device *dev,
 	sidx = args->args[0];
 
 	/* Check validity: ERR_PTR(-ENODEV) if not valid */
-	for (idx = 0; idx < SPX5_SERDES_MAX; idx++) {
+	for (idx = 0; idx < priv->data->consts.sd_max; idx++) {
 		struct sparx5_serdes_macro *macro =
 			phy_get_drvdata(priv->phys[idx]);
 
@@ -2594,7 +2597,7 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 
 		priv->regs[iomap->id] = iomem + iomap->offset;
 	}
-	for (idx = 0; idx < SPX5_SERDES_MAX; idx++) {
+	for (idx = 0; idx < priv->data->consts.sd_max; idx++) {
 		err = sparx5_phy_create(priv, idx, &priv->phys[idx]);
 		if (err)
 			return err;
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 128f8c53172f..8c27cfde4938 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -26,7 +26,12 @@ enum sparx5_serdes_mode {
 	SPX5_SD_MODE_SFI,
 };
 
+struct sparx5_serdes_consts {
+	int sd_max;
+};
+
 struct sparx5_serdes_match_data {
+	const struct sparx5_serdes_consts consts;
 	const struct sparx5_serdes_io_resource *iomap;
 	int iomap_size;
 };

-- 
2.34.1


