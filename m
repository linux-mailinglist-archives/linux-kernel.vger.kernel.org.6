Return-Path: <linux-kernel+bounces-528578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F54A41946
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4CD1885B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1A24503A;
	Mon, 24 Feb 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S7jX+c6c"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A478F2E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389781; cv=none; b=i0UnUGpBAUBPRzLq+DxG1NuJm9U0hLqJz0NJWsAnXwIHPqfJwx4mdrRKeB7huYhBrIwozOVok4KlCXV/nTT0GaC8a9OOS85j3z1qpIpwJNJ//0I6LCTZpjSeV6cgosbXmE6y/XivELxjHlDwA3LIlrewvAksQV4FRvyI/ClElo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389781; c=relaxed/simple;
	bh=FWYWFNS+oT7mj2E21f3jXpR3gYQLoWEmXq14pHcLk7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkc52+RqpArEpLHL/k1nT3AjO9FGlOlS8e1UMpsjP0NDKr74yNFYPHzxdCv6G9QyvUHpBwo2Kyq/bqnHWEjudnXhAR+Kl4yuuR2DoPQH1dwcphbUaOJpl/7wIWcgsTrrFQtPZBR7vD+MRkrzywidXrXHZIU8Ens9XnRHYbVsXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S7jX+c6c; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740389779; x=1771925779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FWYWFNS+oT7mj2E21f3jXpR3gYQLoWEmXq14pHcLk7o=;
  b=S7jX+c6clB5J/Vn/lSQeXthCa+ZHahgjGovRI5jayuEXeCybJZxwv6Pu
   irv9HMEIu+4CJ0QYu+5W1mlr8erJXUAsjNEkmZn7Mk2UWUqEDn5UdVdEN
   YvzY0NHZsEvWHocltNAIHvx2CEVQbDtNyvEThoiNfIIcDuwwAtekF/wYb
   IE8ugFKNUoDIkQGEp0R4sfqrjxMBRRE9TtAUCvxlGRlKxRzJnhUckGuee
   hYpj6EsrL5HXEDxeSrSrJRq7kPqDodjVUpIKMwuX6powfz3VojHlpIAQt
   xxkHBdwqmtf50FqMtw2ohQZzdADw7RMdbXGeUEfbUokhPla3wAW3ETgT0
   w==;
X-CSE-ConnectionGUID: UsE/WXwmTmibXe7m321U4A==
X-CSE-MsgGUID: OrAZ7Jx8RAeeUXHDGrzUBg==
X-IronPort-AV: E=Sophos;i="6.13,309,1732604400"; 
   d="scan'208";a="42160288"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2025 02:36:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 24 Feb 2025 02:36:17 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 24 Feb 2025 02:36:15 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <p.zabel@pengutronix.de>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<herve.codina@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] reset: mchp: sparx5: Fix for lan966x
Date: Mon, 24 Feb 2025 10:29:23 +0100
Message-ID: <20250224092923.2648680-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With the blamed commit it seems that lan966x doesn't seem to boot
anymore when the internal CPU is used.
The reason seems to be the usage of the devm_of_iomap, if we replace
this with of_iomap, this seems to fix the issue as we use the same
region also for other devices.

Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/reset/reset-microchip-sparx5.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index aa5464be7053b..5a75f9833a91a 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -8,6 +8,7 @@
  */
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -72,14 +73,17 @@ static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
 						    struct device_node *syscon_np)
 {
 	struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
-	resource_size_t size;
+	struct resource res;
 	void __iomem *base;
 
-	base = devm_of_iomap(dev, syscon_np, 0, &size);
-	if (IS_ERR(base))
-		return ERR_CAST(base);
+	if (of_address_to_resource(syscon_np, 0, &res))
+		return ERR_PTR(-ENOMEM);
 
-	regmap_config.max_register = size - 4;
+	base = of_iomap(syscon_np, 0);
+	if (!base)
+		return ERR_PTR(-ENOMEM);
+
+	regmap_config.max_register =  resource_size(&res) - 4;
 
 	return devm_regmap_init_mmio(dev, base, &regmap_config);
 }
-- 
2.34.1


