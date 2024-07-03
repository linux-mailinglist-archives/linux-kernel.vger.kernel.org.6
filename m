Return-Path: <linux-kernel+bounces-239275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7047A9258BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C3A290F89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A1A16C448;
	Wed,  3 Jul 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wldcbtw6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E151176FA0;
	Wed,  3 Jul 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002614; cv=none; b=BSXXbrUvlfi4mMgQBYvXUiLeqVMAjrLkz6wRl90iCe9clVXIpOL/hRUehwiuN+cuwCYx0w5xf0yp+cRKahgBU+NxfZeRvy0SfCtVf1rBozJQSRrNBJ21dyyGSEvhQ6MMIE9Q/QgwBwti97bXQuORqlKT04bMkY9/FR9NbnU6oew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002614; c=relaxed/simple;
	bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1qJ9gJwQDqhyzWBP+ezFaax9+FeSVUrcf4ZFCBKOmesnjErgxg0jO3evbEgY78VKbv3Bh5rR6UfU6pHioU/dFnlJjbeR6F2Bjm1+nyAjxElGuwREfxDDzXj0qjpdSd3/Z/2SCeG6yoUx3PWgUhErs59RTuBEkWP2gBRv5nNi1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wldcbtw6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002613; x=1751538613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
  b=Wldcbtw6Iec00tl8VArPbQgqOkfbLgXcCFJlnxKxTO3EFEriO42rZols
   voecWQASntRhv0udOIMhXqw/JBDwH7KuXxE34G6h3LNMeqGt0EVXBZMwL
   LnDjdOBzCLqAv2gWZAcU5sBFAi/Gmkg3HX7EgD9YXcGuON28UXWnJCNwQ
   TfwSu0dLAZx5rRZDDSFQ6Wm0Rkd/p+krbn/KU7IcJ3HjFiuUkDyMYSrlH
   QJTJQINdVfeb3iOeZbps1eoUxLmC1udJcDDBrawEh8QtR2kOVMO0yVRtQ
   06H06smCbRayqbKLoNaVJyliL2HwTG3uRUKzqXBNkU28EG5XRveKdXiQJ
   w==;
X-CSE-ConnectionGUID: hLLhwY7cQcOyno5TMnxZqQ==
X-CSE-MsgGUID: vS98msG8QLSgNJkd/SwUsQ==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="29441574"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:30:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:29:02 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:28:57 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <p.zabel@pengutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 21/27] dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
Date: Wed, 3 Jul 2024 15:58:54 +0530
Message-ID: <20240703102854.196354-1-varshini.rajendran@microchip.com>
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

Add documentation for SAM9X7 reset controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/reset/atmel,at91sam9260-reset.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 98465d26949e..c3b33bbc7319 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -26,6 +26,10 @@ properties:
       - items:
           - const: atmel,sama5d3-rstc
           - const: atmel,at91sam9g45-rstc
+      - items:
+          - enum:
+              - microchip,sam9x7-rstc
+          - const: microchip,sam9x60-rstc
 
   reg:
     minItems: 1
-- 
2.25.1


