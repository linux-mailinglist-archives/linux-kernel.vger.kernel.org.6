Return-Path: <linux-kernel+bounces-358942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0382998596
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4412AB21F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29711C4600;
	Thu, 10 Oct 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P9owJyML"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F31C3F38;
	Thu, 10 Oct 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561932; cv=none; b=Bl04bNs1v205DhhhlxSur5OwvCMEVDHZVs0JcArA32fDaknTUJt70EcmYysT/8NZkw74qYbZaaKNYKiOKilROWbw+a1OqMcOfhTcCurowEVYEcWUxBKvzTM5ctC6iPL7VbU2Du13XFaVK2A0tPuZHiEHPpUHwq6uiNxuLpL/CyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561932; c=relaxed/simple;
	bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/bNYQ67tFDePrM4o2RpMGzIr/FuDFRSYd0ZeHujclr3INcd6c+3Akm/amGS0hNoJM+dzswnfvBCRgt5rAGA8AFDbwxExjy4DobkBf/6Eqvi6LG2g1B2sP8Asu32I2HONZ6lJ4zMRWETbLBVcegU8BUEiR0HN9+/rIJqQLIqmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P9owJyML; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561930; x=1760097930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
  b=P9owJyMLBE+e9z311f4VAXm8Kgy3QjBpvrrZbfxMC5vNor4FnzkWQ1WW
   e18TN6n6GikAjeYSN82opmigdCMZZ/xb6svm5ykS7qhyu1iIoz63an0fS
   /JvYX7ioAX7kHP3CiP4z82dNk8VoXfn5brpyrH9jDdalWiuW7VvX6F0DI
   GERo/f2o6sxgjYikIZnhvfQyNLUmYx9gQ6LGFkNnXh6ZLw3JjMnjZ6UZl
   WLatrHWIowk33+grC2SxD/0lSsZJAdgHctiZXS1x2VFpeLpz0rAMWm/7v
   O/FUzPQ3GVh9eYVMiO+c9jHgoEn2OFrFjizyom0BBM/SOKTSziyoNIw1h
   g==;
X-CSE-ConnectionGUID: cCb3ViA+RauNt3gRhi7X4Q==
X-CSE-MsgGUID: GkBvXm0zSECJD9+cUnCpsQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="263902636"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:05:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 05:04:24 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 05:04:20 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <p.zabel@pengutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 5/9] dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
Date: Thu, 10 Oct 2024 17:34:19 +0530
Message-ID: <20241010120419.93043-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
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


