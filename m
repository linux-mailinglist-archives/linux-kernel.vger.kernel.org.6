Return-Path: <linux-kernel+bounces-306555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7396406F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC861C24179
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF111917F4;
	Thu, 29 Aug 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DFmwZCx1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0818E036;
	Thu, 29 Aug 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924379; cv=none; b=a8JP1+qKVGDRl28FvFV47HG0U2tlskmPnZvCbgihxSvPse/38EZo0RP2O07WAsYQVwftBeNL1fbRdqDenriTBMOsk60cF9ei2vqzt9AU3Yyx3Ab16gX/dG4VsnnXANSB9vbiokhTwOuF9YZC84Lkiy9zGTA/cH23YhP1zlZPne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924379; c=relaxed/simple;
	bh=hrHUu0ZRrqD5KoBgpyEKKMKlyY9ehUbHrr9kTIRjzNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E3j5Kn85hMbBKJPb6+/T6qwqaKPWJs6+cyCQlBufgT9gqaCvOw9MlyVAiuEXpU8Q3ARHdZPlewAkLgzVHjK3Lzc5oUZyKHtCVFn37TYCs34pPpncq48S7U8whnjd+RGHRYwDAYCHDUPJbeZPiNvZraqOubxGEzTMCnxU6q8UDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DFmwZCx1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724924376; x=1756460376;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=hrHUu0ZRrqD5KoBgpyEKKMKlyY9ehUbHrr9kTIRjzNA=;
  b=DFmwZCx1LId+l2xtCDoAVC0p8UkFAz6TNlN0EQwhbFqiHsf+AnnGUGXb
   h+VJmynZn+3chCLbS/LOtHTIiyNRU4WNdo+KT7+d7dm+pb9/Is7P7POqy
   7gdQ/mtPGqnoniNEZNs/9A7w2H/dZv6wv9P1+gCGur1zsy+cQiieuJDO3
   YW9JGMvDal+E5sXeZ4eNuL1qIiU8a7cYOTGp65+9sTYXEdEXsRPsD5ACy
   QQFu+6WkPHgx6ZUjovQTX/w2Q9Gd4j0pXNc3+fQkvFVi//uej2J6r+0ps
   XeVwZQrEoAfxCH/pCcBoa/7UsuTgSmc5xWaGwXerwmp6o7gQFNg3PSyUu
   g==;
X-CSE-ConnectionGUID: C4CQGHEMRhSj+xpfm1WZ3Q==
X-CSE-MsgGUID: NEKhYblqRSefQIMq+UjhfQ==
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="198477619"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 02:39:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 02:39:06 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Aug 2024 02:39:02 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Thu, 29 Aug 2024 15:08:45 +0530
Subject: [PATCH] dt-bindings: clock: Add SAMA7D65 PMC compatible string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
X-B4-Tracking: v=1; b=H4sIAKRB0GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3eLE3ETzFDNT3bzUihLdREvDFAMLyyRTs0RjJaCegqLUtMwKsHn
 RsbW1AOaBZEZfAAAA
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724924341; l=1360;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=hrHUu0ZRrqD5KoBgpyEKKMKlyY9ehUbHrr9kTIRjzNA=;
 b=2eKvo5Wj/F/YuULzOi9SIV0jrtgMiAidWgQI/FTRLTRct3C0xrk0ULAuxsWMqElgl1+tdnP8B
 LwmTYA2jw6eCl81XJI7ylQwYDUtApjxzPXFn/q8i/T4wGydN88Vs1xq
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
since the SAMA7D65 PMC shares the same properties and clock requirements
as the SAMA7G5.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
index c9eb60776b4d..885d47dd5724 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
@@ -43,6 +43,7 @@ properties:
               - atmel,sama5d4-pmc
               - microchip,sam9x60-pmc
               - microchip,sam9x7-pmc
+              - microchip,sama7d65-pmc
               - microchip,sama7g5-pmc
           - const: syscon
 
@@ -90,6 +91,7 @@ allOf:
             enum:
               - microchip,sam9x60-pmc
               - microchip,sam9x7-pmc
+              - microchip,sama7d65-pmc
               - microchip,sama7g5-pmc
     then:
       properties:

---
base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
change-id: 20240829-sama7d65-next-a91d089b56a3

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


