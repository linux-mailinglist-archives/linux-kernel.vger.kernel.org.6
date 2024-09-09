Return-Path: <linux-kernel+bounces-321664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EAC971DC7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4251F23E49
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD26A039;
	Mon,  9 Sep 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CN+SAD63"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19746B91;
	Mon,  9 Sep 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894925; cv=none; b=BYTtxbRajKVH9eou2lUI5fCPh0dKQvOeAjcNeL7OUDY9TWjSBdpa2bYus4y+BSyTeOXOYeSf6x8BQajcpHqcnDKa9X1JUtZm2iGtN4idfKWj6KhsX8x0WAvWABi+yZpFivuq6rLMKQRTzw23YHrF0SBb9AnkgpzAMe/AfoeV6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894925; c=relaxed/simple;
	bh=1AJHRHcGfmD/9YGKz72ENNmKG33hLzSx1mSxJxpOXls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oiXBBAC4//aK5UmFz2+DobTOWmfdIPt0HBXVXy7twRV6ygzbQvDpQFWuxsEb4y3Tfrhb7S9sUozZIvoZj+jbf9RUDgE1KF9emXweJ2ndfhAPtYXgI1HwQmNg1NjoWVx86KmR/kqjVX6JspkjG1aS+/iO/WlK1ELmZ+luiD/Ymrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CN+SAD63; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894924; x=1757430924;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1AJHRHcGfmD/9YGKz72ENNmKG33hLzSx1mSxJxpOXls=;
  b=CN+SAD63Ha+XWvVaGHm4r7HE/V9MDH9CsFIw5ACDFI8zC4USZ914qZHT
   g7lvVOVJPj8Wd/cgr05xmsh89GmfNJXeDPJ+yyV+2FNCU7WLBqoJFkgbK
   SIw88EoiftMjU73MxLx3WpA5Gn6WivsJJ56VwtzHetacIjvaj51cmAu+3
   zNf82/GTVBP8H7EjG0A/zYfoWRsrVwnHt2DSf/ZJXSoG8apNl++K+XSHB
   lrpuf6/sGi+f/8+TcgA9xLGjveHaXgAdKHn/prHiKD/O0moxLTLX2i0L1
   uIUSPRCVukQV7kjdCNRFoAYCgcuLPblebZsZEzacAdXV/c8GPOILJ3ZUf
   g==;
X-CSE-ConnectionGUID: /ltMKKTeRqSXWxXLFfJz/g==
X-CSE-MsgGUID: bKvqNuDfQLii5spaWCHo/A==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="31514505"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:14:59 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:14:57 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 9 Sep 2024 17:14:42 +0200
Subject: [PATCH v2 2/9] phy: sparx5-serdes: add constants to match data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-2-d695bcb57b84@microchip.com>
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


