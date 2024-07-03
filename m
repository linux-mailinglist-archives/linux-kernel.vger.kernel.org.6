Return-Path: <linux-kernel+bounces-239255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE58925885
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B651F277FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78415CD7A;
	Wed,  3 Jul 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VvMmnWfc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F8172773;
	Wed,  3 Jul 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002457; cv=none; b=R91ArcQK+/Jd71V788OT2qLmXiUMR4bKwo316fZGf94EZSisGLLfpYCfti404k4c/QmtWLH3a1VrPoo3KrO43RmX3ztt2Rc8UC5ZXAIWil94pzlTXn8GhZYgcbClOGIMKv1l8kU4Xjjfv6RgpCyukFlW5/vXX25bqzP7bb3RPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002457; c=relaxed/simple;
	bh=oXxCxXX+oZh8HsttkMvFbmyP3JdiAor+JVZTWRVjC28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAYGivqGpRvoiEuZjrIHI0w7kajBPpjnUYVp9jKtDU9PDTu1Im6kj37leIHb3IiXml5eXZB6NE8nR4CTlc2UsMwyzO4UAxSUn/LNAjyP9grGLJ/z2TZdhcxJj0se3eB9LcKcarDfQ/QE3BPgS5KUKfiYzpAKge5cWo2+6H9l1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VvMmnWfc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002455; x=1751538455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oXxCxXX+oZh8HsttkMvFbmyP3JdiAor+JVZTWRVjC28=;
  b=VvMmnWfc9AlC/HVwcFQ/t5jctJl//cBnq05TJxK/KWXtnVb9mJvwfGB9
   69Og4yLSrFAa86GYUr37Q5KjG6987YgPJ11N/iX91pvMJncu0jeWGO/nm
   0azDVXZsipdCK+r73oJax434bHTSVwpVBOtJ1yPMJpSb4RIFCeXZCXSz/
   hgqW0P9lBAQkjak4yZ4HxYlBdy1IHn2TPHBHFXV+5iJLg+e934QkINZNT
   2bMXsrGnJ9uG0AxwTyI1U844z5p0UvcJpaYpsSjlyfaplfLwn1nqs56SF
   3R62Moy79nimfgw8SOYeqQtTKXimuhoSyQDWuQtCs6fKhVaNeUQpbPfLM
   A==;
X-CSE-ConnectionGUID: 6if5lKZrRRahkqLSM+7f7Q==
X-CSE-MsgGUID: ufnVsza6TNa7T767oet9bw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="196197031"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:27:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:27:22 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:27:17 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 07/27] dt-bindings: clocks: atmel,at91sam9x5-sckc
Date: Wed, 3 Jul 2024 15:57:14 +0530
Message-ID: <20240703102714.195661-1-varshini.rajendran@microchip.com>
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

Add bindings for SAM9X7's slow clock controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v5:
- Changed subject according to suggestion.
- Alphanumerically sorted entries.
- Updated Acked-by tag.
---
 .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
index 7be29877e6d2..c2283cd07f05 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
@@ -18,7 +18,9 @@ properties:
           - atmel,sama5d4-sckc
           - microchip,sam9x60-sckc
       - items:
-          - const: microchip,sama7g5-sckc
+          - enum:
+              - microchip,sam9x7-sckc
+              - microchip,sama7g5-sckc
           - const: microchip,sam9x60-sckc
 
   reg:
-- 
2.25.1


