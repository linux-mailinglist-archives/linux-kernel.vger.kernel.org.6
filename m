Return-Path: <linux-kernel+bounces-239248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D592587B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7327EB20FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731215D5B3;
	Wed,  3 Jul 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z7WlH21t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED411143744;
	Wed,  3 Jul 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002406; cv=none; b=Tolw7GdsZhA5doVyPVenI7g0vVU34X+Kk8z0xdbuYfKY+XC1qn0UI3Qh+ZDcejooK4QA4CJ/zkbtSSHNLJj2Pz9ghWG8j/Alc7u8z16xsGXq71MA5zBsAZsX1qZ5AtEG+Y8y5ModjVrfIPhNzYnAZ5kX/VTubZunMiOlqb21Huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002406; c=relaxed/simple;
	bh=OZONZC0L9/k87HW5rUnW1mTWkoq/e2Ggm9W9MinqYHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6J1iMFgvtucXFebDbZzDxfsE3bv44QavH5iEVAwAosbFLC770fKXtH6fl6TLFzocpa3uuxR/eCdmNI3RTXLbxtUNwABNVCKt7BfOcnJr8641ZQZZn93+f5wf2eA66LKkh3b75DOArHnnGFUFUkQbiniOFV0QlpIhGhnQD/F7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z7WlH21t; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002404; x=1751538404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OZONZC0L9/k87HW5rUnW1mTWkoq/e2Ggm9W9MinqYHw=;
  b=z7WlH21tUt2SfUpQcvO7Q7/l3PoLJuno4QXrn2MGP/lA3yRIvZPGs0yQ
   UcZpoDwM8bkYhW2K8K+eQfXWbVFbbh5ZwrarXCVuPwL7fOYqOu/o5O79B
   THcrhX8Q+MD6tKNHPTxtlxUxmE12Wahs3Ocd9nBoJOoMJFeN/mocXxFsC
   2+iZytJj7fMu0oEFtoE+YYGOksUJkIZ2ZMMauGWH1ZGtzoN+NNzFRkgQj
   B8DJuEbN7K7IZK+tMF2muicXwmGKA4+Os4CIPaqytd1rE+TFkuKG7o58p
   uwIFZS2IaUIbpWR+dx154aEplCBYUfmfrot51c3owdCylS58fvdfN0tgl
   Q==;
X-CSE-ConnectionGUID: Pkzf6S+tQ2Ka0F87qiXpUQ==
X-CSE-MsgGUID: tETn17lJQ2yW9FQYd1PnBQ==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="31414851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:26:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:26:30 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:26:26 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 01/27] dt-bindings: atmel-sysreg: add sam9x7
Date: Wed, 3 Jul 2024 15:56:21 +0530
Message-ID: <20240703102621.195333-1-varshini.rajendran@microchip.com>
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

Add RAM controller & SFR DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 67a66bf74895..1339298203c6 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -11,7 +11,8 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 PIT64B Timer required properties:
-- compatible: Should be "microchip,sam9x60-pit64b"
+- compatible: Should be "microchip,sam9x60-pit64b" or
+			"microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for PIT64B timer
 - clocks: Should contain the available clock sources for PIT64B timer.
@@ -31,7 +32,8 @@ RAMC SDRAM/DDR Controller required properties:
 			"atmel,at91sam9g45-ddramc",
 			"atmel,sama5d3-ddramc",
 			"microchip,sam9x60-ddramc",
-			"microchip,sama7g5-uddrc"
+			"microchip,sama7g5-uddrc",
+			"microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc".
 - reg: Should contain registers location and length
 
 Examples:
@@ -63,6 +65,7 @@ required properties:
 	"atmel,<chip>-sfrbu", "syscon"
   <chip> can be "sama5d3", "sama5d4" or "sama5d2".
   It also can be "microchip,sam9x60-sfr", "syscon".
+  It also can be "microchip,sam9x7-sfr", "microchip,sam9x60-sfr", "syscon".
 - reg: Should contain registers location and length
 
 	sfr@f0038000 {
-- 
2.25.1


