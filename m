Return-Path: <linux-kernel+bounces-320935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801EA971237
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7A31F23017
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780AB1B251C;
	Mon,  9 Sep 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MtCKy3UH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD31B14F9;
	Mon,  9 Sep 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870969; cv=none; b=LnGzo3JifvSQSM8dsEOyWUu9KjjksUjhHq4RFL99K+Yt7qZCWbmzvrKG1xvwkWRLV/A6Ofdc/2htVvWIPyAaBiwPrB8huv63dHIUBmNkLh7JX+GryzcCEnA2IiJxaTh5cLZh6PEwTDUSJ19OGHQ5p6YknrXuLVYOWUzytgrkQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870969; c=relaxed/simple;
	bh=2lafLKjnorwqVWKIDeS2ovxiuaU21GohdSm/0wFNtvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEhwV141qCbgNbBLyZPxRPLs8B5im/AmqeQSpxp3yZZunHrlibZPlW2M3bcx0YpUYeYfPfXRDqycg17hw+Bs2vA/OZvDDpOjxu9vI+aljU46Ht7A+P3GlWNBykTObPp/uRze39OdXU2P+H8vOkYHAL7Sby9+wRm5kREwSggX6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MtCKy3UH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725870968; x=1757406968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2lafLKjnorwqVWKIDeS2ovxiuaU21GohdSm/0wFNtvY=;
  b=MtCKy3UHgrURz0UqcFnw89/sKLvdC7ws+RFrN/MbszlGjXpBVbH2Mt+k
   WHF/yciGvFR/i8FXsf9PzAu5JkIEqT6l9lhEd88rpj6s/gNzN6lE+3Ckn
   oiX6o0CkEkhaxHX5SlTxNxQphACnGfthC3ReQH8cmZEl/eVVtEIXPgMUF
   +8orCFnYR/euJcjVEUoYySTYfpbLMDk26EIyDBUSChzNsBwqNNFJcKw+P
   l5WT1A4ohof5fgMiEcV5bRB8nyaVrJtsXy5apqB13wphaDmbZ8xOfbgYd
   /7N6gHBo70hVzHZhcH38h57pDl4Z62ilDfjkDIYExINndzngqIQQ3vpTL
   g==;
X-CSE-ConnectionGUID: 3+qBZ8ypT7qJuXQunlVkIA==
X-CSE-MsgGUID: wyzCDRFkRbylqCWlGPF3Ow==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="198940351"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 01:36:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 01:35:48 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 01:35:45 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: microchip,sama7g5-i2smcc: Add 'sound-name-prefix' property
Date: Mon, 9 Sep 2024 11:35:30 +0300
Message-ID: <20240909083530.14695-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909083530.14695-1-andrei.simion@microchip.com>
References: <20240909083530.14695-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Add 'sound-name-prefix' property to differentiate between interfaces in
DPCM use-cases. Property is optional.

[andrei.simion@microchip.com: Adjust the commit title and message.
Reword the description for 'sound-name-prefix'.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 .../bindings/sound/microchip,sama7g5-i2smcc.yaml           | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
index fb630a184350..ad34df67c7c0 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
@@ -52,6 +52,13 @@ properties:
       - const: gclk
     minItems: 1
 
+  sound-name-prefix:
+    pattern: "^I2SMCC[0-9]$"
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Unique prefixes for the sink/source names of the component, ensuring
+      distinct identification among multiple instances.
+
   dmas:
     items:
       - description: TX DMA Channel
-- 
2.34.1


