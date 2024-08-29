Return-Path: <linux-kernel+bounces-306711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC35964264
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDED91C24848
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105619047E;
	Thu, 29 Aug 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vKkbXT3v"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168D189B95;
	Thu, 29 Aug 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928906; cv=none; b=FSzmbrfydfzi0xKqcF2Eb8HkeLIuTCgU2l6GbzHKa202i/Oh5heEfch0AHmxpp03IwSdFho1Y+gLrrATcGLq29+tf0BKdygRzVSkg+LDfrLfDLPr5DxGEJRHxCC3Rx+7t3IS0+wo1OOPQ9GO0qeFbzDeSSkhcQMlk+gR0jjrmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928906; c=relaxed/simple;
	bh=t5PoyfbtCc3q1wTlJMYyxUEyIDQt5ZPFVQ3ZdRZkAYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tEz8bbGIUCh992+xhQ5m6dH2CyrvzYMpOaXfUSAm21Dc05joOdoAaAAXBtBhAztf+1pLc/44+UaAauD+8M1y1jsKguD+1k+Of+bQTVZ9Z/fQHneMpDnqw6dimWOsy1SCScKU0agRmjedGs+QgTsSSFfuVgy4w6uecdn+D39J77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vKkbXT3v; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724928904; x=1756464904;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=t5PoyfbtCc3q1wTlJMYyxUEyIDQt5ZPFVQ3ZdRZkAYg=;
  b=vKkbXT3v+FthiaT9NLId5uAFolvyewHLnEjtHaReSacZ+OKCnpVcKDj0
   T1mNCgmR4fusdfnNdIi232sOHe7D/vGgEQUJEkreJeNcaIp4zEVAPXb7c
   cpMlvBOUAJsNemW6cEgYsnKwFC/6T7wlDkZFZSCkH75GjQ6HGLPPu9WGi
   6m6aRCaLU7GthlrAgGcCHRx+te/hRo44rWxvjS/W/5fd5cO7vJpqEVww3
   6cwWpVXQbl90QJ/Fh3AlaD0JcNOS5wTFvdGlyD/ODR4qzShW2dzdkmHE8
   ksTholwMhezu1bhQxWhFlU64UpwwvryTLqcolvt0jx303a3lHF8BE7ocF
   Q==;
X-CSE-ConnectionGUID: l+lO9GWMSNi3wu1+kd0hOg==
X-CSE-MsgGUID: VclacZE3QyiP8UIdjR2kkw==
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="198480025"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 03:55:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 03:54:44 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Aug 2024 03:54:39 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Thu, 29 Aug 2024 16:24:37 +0530
Subject: [PATCH] dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240829-sama7d65-sck-v1-1-3e7b19e3cbf9@microchip.com>
X-B4-Tracking: v=1; b=H4sIAGxT0GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3eLE3ETzFDNT3eLkbN3ExCSLFENjYxMz0yQloJaCotS0zAqwcdG
 xtbUAbsGTwV4AAAA=
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724928879; l=988;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=t5PoyfbtCc3q1wTlJMYyxUEyIDQt5ZPFVQ3ZdRZkAYg=;
 b=76ova2mjUCfXV2DmLI+g/txlPa9qwJQ0G34fdNFqgkL9I2hI7qeGcqAtvblrXUQy+xV1Ggy+n
 RNf7neRMIr5ACX7WSxW+0WeBghjYEodAxHaOIa0ZxXUptU+8W/kIKZe
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add bindings for SAMA7D65's slow clock controller.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
index c2283cd07f05..d4cf8ae2961e 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
@@ -20,6 +20,7 @@ properties:
       - items:
           - enum:
               - microchip,sam9x7-sckc
+              - microchip,sama7d65-sckc
               - microchip,sama7g5-sckc
           - const: microchip,sam9x60-sckc
 

---
base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
change-id: 20240829-sama7d65-sck-aab8d133465b

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


