Return-Path: <linux-kernel+bounces-239262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4E92589B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9801F236AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B317277F;
	Wed,  3 Jul 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ubmXMT7B"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022C15B984;
	Wed,  3 Jul 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002526; cv=none; b=ayKRvT+1HWz1jpgGM2wptDExjPfVLGKk4UVrq0X1e3EGYAt2DrdicYPxjTS+6FavKEqeepaOAWX9WWB5E3c21TO35108S6qWSWmn1XEaszvh/nY3I1uIQXIVuHUm8rYdtac/0H8wXBXGOojzbLzDbRkzNiAtL4+8mM/ocSM0mmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002526; c=relaxed/simple;
	bh=CmJesmNxIPY2fznL1g2fgRBGnbSimFBYGTSZFAcUZo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3adS5tXgX75FetBLwd0/O7gZ7y2Ot4xxM+SZfKBGbVf651XXIrLNcRqS7EcQgR/s8ahSK1a6NDB+EdKEyZc9ZMTv7iDaJDU2/fo1wezcnGXKOY+bb20NFxfpAHYbQnR1fHqCwziOh80uItKeFBq/1Auq5ER/PoFoQmqzL3yWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ubmXMT7B; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002525; x=1751538525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CmJesmNxIPY2fznL1g2fgRBGnbSimFBYGTSZFAcUZo0=;
  b=ubmXMT7BifY0adHoC884usACQDVGp+dHWzMeRY8OssbCXoEdc2AXNpoS
   tYUZhlaEWsa8QnQJZDmPzLjJ3YCr+1W86Tx1P4rca7oe5rMWidr8b6Bzk
   oRfKFd3j8adW87AoGtR2306hrlnOENks/hlljIpS/3BnC6jB7ANa+uuYF
   U3SVLqInLPeePmDyRWd1tFc7R883a+3Xb9A4yeFoC5rnE9Iji2J6FhmWC
   RB2tlnE8+qsZfD7UOybbcq+/wsrd5Qr+A+WVWSUlvi84fwgs4fM0zW/RA
   uXDTexOisT8C+Gp8jh21tb8UT0wkwTXMRVohX0JPES25EX7VyZPtKt9QM
   A==;
X-CSE-ConnectionGUID: ywlN1IFORca1IOesWlMguw==
X-CSE-MsgGUID: jnuJLQ9cSDe1Ka2QVXOd1A==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28804765"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:28:14 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:28:09 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dharma.b@microchip.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v5 14/27] dt-bindings: interrupt-controller: Add support for sam9x7 aic
Date: Wed, 3 Jul 2024 15:58:06 +0530
Message-ID: <20240703102806.196014-1-varshini.rajendran@microchip.com>
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

Document the support added for the Advanced interrupt controller(AIC)
chip in the sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v5:
- Adapted the patch to the new yaml file.
- Removed the Acked-by tag due to the TXT to schema change.
---
 .../bindings/interrupt-controller/atmel,aic.yaml | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
index d4658fe3867c..9c5af9dbcb6e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -17,12 +17,16 @@ description:
 
 properties:
   compatible:
-    enum:
-      - atmel,at91rm9200-aic
-      - atmel,sama5d2-aic
-      - atmel,sama5d3-aic
-      - atmel,sama5d4-aic
-      - microchip,sam9x60-aic
+    oneOf:
+      - enum:
+          - atmel,at91rm9200-aic
+          - atmel,sama5d2-aic
+          - atmel,sama5d3-aic
+          - atmel,sama5d4-aic
+          - microchip,sam9x60-aic
+      - items:
+          - const: microchip,sam9x7-aic
+          - const: microchip,sam9x60-aic
 
   reg:
     maxItems: 1
-- 
2.25.1


