Return-Path: <linux-kernel+bounces-239256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843592588C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039D4B27B85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A630171095;
	Wed,  3 Jul 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ARZw2sJx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914015B54B;
	Wed,  3 Jul 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002487; cv=none; b=sMUKWIDl2LNG9LH3p3LCg8Gzx/K+B48kVQizhajyOcMg3hXzg/aCsZe/Dwm6Ds5veStHBsDbwSU48P7W4fhoXVE4MyVlvrWkV8ljXwE+aA/MiZ9FtziXozA6GcauOtOvtRYg65wjUQBIwObR3CTI3oTsDz9FTZEsXfSp1aXtKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002487; c=relaxed/simple;
	bh=h2IyvQyiSXx4uAiLjaRknaqtBfAOw8HI2r50csPsnJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWIO28OP7xjpk8Cnsgozzptbd5yQ/JzLvB9d5mZUgv0+yZ73bNL9tAz59ky1newfVLu9Py8YXNtnLJC2F1+1p91qp4BWQCp7wvKRRPIAVcfW+AhHk6lH8ijVvGLphvgKSjZ/41PBFYPXyXfuAEAqy2ZXFd2uux/3apo64lTXixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ARZw2sJx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002486; x=1751538486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2IyvQyiSXx4uAiLjaRknaqtBfAOw8HI2r50csPsnJE=;
  b=ARZw2sJxdi4/dP9vyFD50DhQG6o2uBtFwmaqFqbaFfikoajzH1PiFnZ8
   2m5Gvk+PdXYt+0VCdPDCrfrecLM4B8/Gacd8i4StMdXL50/i38VeASikA
   azc8omj2V2k36rVWHj9kZGi208OVUuSRREYzCRp+mZKBKwGqtHv7GKIjA
   wMGWIuU4LTWjARqW2EZo5159T7T8l2FS1OOoEulU/iYnp0MhOXYZO7dRW
   /h1U3TF0Ijtf9DHymKIFOxfXBXdSxtQzvFzjxDWjngpC8EtANJ2x7bDy/
   zc/UaDkra0mb4PoWDyIctpTVKtKHV3ApzKQjGtY+lp2GvFjAuxBl5DWOd
   g==;
X-CSE-ConnectionGUID: C1sswkSrQy+pa1d+oVi69g==
X-CSE-MsgGUID: cyF5/onQSqOBeMdYZP9aHw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="29441486"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:27:29 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:27:24 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 08/27] dt-bindings: clocks: atmel,at91rm9200-pmc
Date: Wed, 3 Jul 2024 15:57:22 +0530
Message-ID: <20240703102722.195709-1-varshini.rajendran@microchip.com>
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

Add bindings for SAM9X7's pmc.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v5:
- Changed subject according to suggestion.
- Alphanumerically sorted entries.
- Updated Acked-by tag.
---
 .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
index c1bdcd9058ed..c9eb60776b4d 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
@@ -42,6 +42,7 @@ properties:
               - atmel,sama5d3-pmc
               - atmel,sama5d4-pmc
               - microchip,sam9x60-pmc
+              - microchip,sam9x7-pmc
               - microchip,sama7g5-pmc
           - const: syscon
 
@@ -88,6 +89,7 @@ allOf:
           contains:
             enum:
               - microchip,sam9x60-pmc
+              - microchip,sam9x7-pmc
               - microchip,sama7g5-pmc
     then:
       properties:
-- 
2.25.1


