Return-Path: <linux-kernel+bounces-322670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0D972C12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A01283894
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D943C17E010;
	Tue, 10 Sep 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X4DHuP09"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDC14A4C3;
	Tue, 10 Sep 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956647; cv=none; b=OpCArBzOHhwSHUBAXSbMakAHG2JKtZAwntFq9y7hnDX22t6IdGDs8PlhD62k4Su7hEswPiEdo/UDXy/7WEE46HW6tV5l3uo6ZM5BAfnZMtAOpLN95KA1TnaId4RcFtbcb0Prpj0i6UIO0wkoE2Z5GLMyruFuRdYWKgN0089eNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956647; c=relaxed/simple;
	bh=MjTDozSO25dJqutHnvvKIt+CxnDOzKA6MZ7DnQLbgE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVQplvDmKuv7p1kiebxfOeT0sSc7AmWPmeCVsI9WXHHXRIldUBGUnj3je5CpG243n9lDJEIoIP/0rnsdPK0f6mv1YFby1qcZ7xG5i+7YqaAR3cRazPJOUjFXK20eaAoO48vdvo2DmOJ5Si+Z4FpkyDZV8nHppEmVBFRDKkw7xc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X4DHuP09; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725956645; x=1757492645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MjTDozSO25dJqutHnvvKIt+CxnDOzKA6MZ7DnQLbgE4=;
  b=X4DHuP09fUCXl2Xb+AKPhsfIptL2cyzF3wKi77Oc3Z8mE9ffQjSx1dCm
   4OLq6ur0OsDl0VfOPOoT/x7LLycLcaUnrDiQeOw6Re+JrHX5aP8U35xZa
   5da/9Ha56IZYzQmQWVOg3+24C8/D5xg1kn9fHXwewOFFY8FqgtadnQhLD
   ZceUZRVEEL6184FNdbVdgR9KDI2scAOp2oS6newLfy8nWwsn2YtAb6yLr
   NS6qNgy5+0d6QA7a+ZcbralP2k9v/pvYihAs8qqw5OHH/Ek8/fzwG8q1i
   E899eUHmHHkW2ueJPb/dS4D7rj8ONa9/2i8esBvQBArZKVvaqDT/jRyUu
   g==;
X-CSE-ConnectionGUID: iHNlYK4jRDu9l7omWRWKHQ==
X-CSE-MsgGUID: TlHYxewcTX+SMSNajrhm9w==
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="32196567"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2024 01:24:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 10 Sep 2024 01:23:49 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 10 Sep 2024 01:23:45 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <codrin.ciubotariu@microchip.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH] ASoC: dt-bindings: microchip,sama7g5-spdifrx: Add common DAI reference
Date: Tue, 10 Sep 2024 11:22:03 +0300
Message-ID: <20240910082202.45972-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the spdifrx yaml file to reference the dai-common.yaml schema,
enabling the use of the 'sound-name-prefix' property

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 .../devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
index 2f43c684ab88..7fbab5871be4 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
@@ -13,6 +13,9 @@ description:
   The Microchip Sony/Philips Digital Interface Receiver is a serial port
   compliant with the IEC-60958 standard.
 
+allOf:
+  - $ref: dai-common.yaml#
+
 properties:
   "#sound-dai-cells":
     const: 0
@@ -53,7 +56,7 @@ required:
   - dmas
   - dma-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
-- 
2.34.1


