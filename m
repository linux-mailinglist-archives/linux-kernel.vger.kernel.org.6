Return-Path: <linux-kernel+bounces-239250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21792587F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D3B249B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98816132A;
	Wed,  3 Jul 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hWkPTwx3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD9142904;
	Wed,  3 Jul 2024 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002433; cv=none; b=JYUSyTr63WCKcTKJZFC6yiVnp0S3xi0o5BUco4XWSRhL0Sf77hOQHLj+TUgiFjTp+7eG+j2H6LVUef2Dc/v1vV0AFolUbTpM1K8vHfL5TIfSUgjUFRjHxqg1kFPzyMq0ssPRZ+D8FHXmR3mCSgirALiZUxxjg9CfPlh4dJDH6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002433; c=relaxed/simple;
	bh=xw6HVneEx8JYTYqdGhN1CmrkEfyjnYCH2FyHmFQQEfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWCkpEG1YDiN9un0P2SLPrM3W5Xj8yAuthNdx+2qxuP2dnOTWu582haatgcvWTB8TlDhABCkrO+BwwlwDD79zxYoJKdcyhF9viJsLAexP4/wboZ2KAuqGtHbl5KpZvtSXJg0s1nYs3N1SREd3y6F0vqCVJ0lEXMFOrVqkNI1KmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hWkPTwx3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002432; x=1751538432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xw6HVneEx8JYTYqdGhN1CmrkEfyjnYCH2FyHmFQQEfw=;
  b=hWkPTwx366GCT5D0J9SbwUpJeu0ZYwwFvDLxiMvIYTkVaOFaBN0gFtZN
   qCEfzvNuaToheqrv+RMQ5Y5ImXN02madsKUawxk+mGlr8PHUT0UC7eb+9
   HOOBbf55hCrYHcO9V0UI2lo0jOXuhRTQVT3yglqv3pG2JUNQTw0V8kSiw
   UkLxWdkQWlr1j+iNNwmP3nslv+YZs8RkVLAqHTfEhUhdaq6cUHZSg1/+l
   DdPdZX4WTAQfdeEOK6RfVqdhECR6EYQDqhgN2NthD13/93WdQhTyKtn6C
   RL4w0uIQFBL0YwU1wG5kJVullAhdp74vz2oKNxFHFvoKS9MiJxs7BH+Ss
   Q==;
X-CSE-ConnectionGUID: w0yhcqfIRYGSYZjuOSPU/g==
X-CSE-MsgGUID: Q9GYbNYbSfqnPTiWe75Yzw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28804703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:27:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:26:40 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:26:36 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 02/27] dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
Date: Wed, 3 Jul 2024 15:56:30 +0530
Message-ID: <20240703102630.195382-1-varshini.rajendran@microchip.com>
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

Add microchip,sam9x7-ssc to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/misc/atmel-ssc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index f9fb412642fe..894875826de9 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: "atmel,at91rm9200-ssc" or "atmel,at91sam9g45-ssc"
+	       or "microchip,sam9x7-ssc", "atmel,at91sam9g45-ssc"
 	- atmel,at91rm9200-ssc: support pdc transfer
 	- atmel,at91sam9g45-ssc: support dma transfer
 - reg: Should contain SSC registers location and length
-- 
2.25.1


