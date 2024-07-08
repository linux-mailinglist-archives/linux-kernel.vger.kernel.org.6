Return-Path: <linux-kernel+bounces-244052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4E929E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3F1F235A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75B7406F;
	Mon,  8 Jul 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="gRy4PEcO"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAA50276;
	Mon,  8 Jul 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428098; cv=none; b=TCsLRETAGKh6BEtgsPMKqYGWfcRgDYJQiZneQl8IlfTqHS7U5eqzuNcsbU+dXwKoYGfy7llyepTUM7HZJTPEkxrm38I/8FTkFax3NvSdGJM2iFOHyghnLZeJURQ9EpFlY0Z04LsRW9JMRXtnYscEg4T3uQ7qusy09xirgClS1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428098; c=relaxed/simple;
	bh=VDC1D0H6FRPHVF2lVtnTQz7uJqjeGfJhvGsyEQA9a+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf6zF5zTlNI58OQMq1eaSqX/f3paXBsWkIFSZQVlAIqSg9r1E1TK6G1Qr1puvole/Hl8nRZykI6C5SL3tpPIym9yZ9TiBR8l70jwbsU7Vq5GVbktbmI8oV2kx4S9Ouh3bnngLIK76Kdb6ZDFFTPvfqMxvruLPZiY1SLsQd6ztUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=gRy4PEcO; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 715A6BFBAB;
	Mon,  8 Jul 2024 10:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1720428088; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=YMcfbKShlC6yhIcdj/UB0uMGVB2w1gBHYsj3ySGDcHY=;
	b=gRy4PEcOremjDqhdsoBCrKVn9Uc6OnDETntMVeRK4k9Xse7D3Y6JNjW2qLzmWsj1hDU20F
	0fV/ycC8DILLp8GzyJn11hABwPGHsaIMwcjBuFEymeAKEf3hhfx/s7+5x+8lMCjSuPrnMd
	jwpjjz6BVhGjK6YRwMW121cPCgA1Ws2KfPFXsPHv3YUYirQGJEPIWxFpHWhAIVU7M7UBfD
	j9TDnaMK4PYP5XQCVwnSgveLooNsm4NjX2Y6dc1xjgscMe2OqQNOrNFxyehJ4h3FLa5N9K
	SvWW265CmoFo5glgHuJC4lxc12OtfLKjw7/1Mbx8AS8Ao9zhAK+XSYav0nuGNQ==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 3/5] dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
Date: Mon,  8 Jul 2024 10:40:33 +0200
Message-ID: <20240708084107.38986-4-frieder@fris.de>
In-Reply-To: <20240708084107.38986-1-frieder@fris.de>
References: <20240708084107.38986-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add the bindings for the Kontron i.MX93 OSM-S SoM and BL carrier
board.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v2:
* add tag from Krzysztof (thanks!)
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6ae..5fa1494435011 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1318,6 +1318,12 @@ properties:
           - const: variscite,var-som-mx93
           - const: fsl,imx93
 
+      - description: Kontron OSM-S i.MX93 SoM based boards
+        items:
+          - const: kontron,imx93-bl-osm-s # Kontron BL i.MX93 OSM-S board
+          - const: kontron,imx93-osm-s    # Kontron OSM-S i.MX93 SoM
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.45.2


