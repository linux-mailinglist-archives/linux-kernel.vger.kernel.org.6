Return-Path: <linux-kernel+bounces-265208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F993EE00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68911F236A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9812D1E0;
	Mon, 29 Jul 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CISnNhmX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AA12C7FD;
	Mon, 29 Jul 2024 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236829; cv=none; b=IWzoGJIhzik4rSRv/Kul0eI68AOVLc8MIE76zPTNolK+6L4EDW527BihwpS/jGeNiJj1Xen9wyRf74vGBJ5e7a4KZu+zXtvY4cTUo51pCiAQIPMuCDFkZLwjMpXzwIkVB0qfo7iqM+2rY96gtKk7hY/H0rPV05QM0ZhGp1A8Pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236829; c=relaxed/simple;
	bh=PSn+93YxahuM4/eEil9r4edmIQw42eptfiHBu+CeLF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgIdjUF3SNURuZPA/ajOMqPUorG2Pji0OwL3kwCNmZPTWnGPGe84TwAcjfnTdpT+OSomsz4xmo4vYiuVEuuSx04vxGX0/OfA3o7/D6EjIKuORq0lBrIs5lxgt2nxZQubZ6BlJT1BuiZ0BqIC1IAxgbLbYj3YWqXTorCy2iasWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CISnNhmX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236828; x=1753772828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSn+93YxahuM4/eEil9r4edmIQw42eptfiHBu+CeLF0=;
  b=CISnNhmX4A0Ka59HNgpTR1BOZYhCRxOco/OTM4A/SJXr6WHjXOeBmtVM
   AOtBPo+aJMDgdP7M8TBO60jlZhkdD7nYl20WYi0gsuMP8p3r8jKzKgGG6
   ZNhCINJCRQ1dnAdOiHdbzlV2ls+YQTHjIBM4P1kuY1DwFLDNjc4VqOMad
   cmFGhmDoSde7tIXPP2+8r/DjLrt4YiGCaoSkwTimbbm1UlUNL52+KN0fR
   dWm4Bv5xoMGEmDhW3KyZiROnzbqIiWQQktEFvQ9Jn5uCib+2qwZYJaCa7
   fMM7owor9lU/a9LI5JLrptqMmIaaRGOIrc1R9SB+UaciI5TJ+fvpXEsYt
   g==;
X-CSE-ConnectionGUID: pQjOSLNzTjuj0oMDb/547w==
X-CSE-MsgGUID: yLpZle7ZSI6AhsOFjTjvyw==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="197213810"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:06:58 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:06:54 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <conor@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v6 05/27] dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x7 compatible
Date: Mon, 29 Jul 2024 12:36:49 +0530
Message-ID: <20240729070649.1990427-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for sam9x7 device compatible.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v6:

- New patch in v6 to document tcb compatible.
---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index a46411149571..2c7275c4503b 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -15,13 +15,19 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - atmel,at91rm9200-tcb
-          - atmel,at91sam9x5-tcb
-          - atmel,sama5d2-tcb
-      - const: simple-mfd
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - atmel,at91rm9200-tcb
+              - atmel,at91sam9x5-tcb
+              - atmel,sama5d2-tcb
+          - const: simple-mfd
+          - const: syscon
+      - items:
+          - const: microchip,sam9x7-tcb
+          - const: atmel,sama5d2-tcb
+          - const: simple-mfd
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.25.1


