Return-Path: <linux-kernel+bounces-265231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B993EE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E60EB2208A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6787E139CE9;
	Mon, 29 Jul 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tevPlzXI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDB6E619;
	Mon, 29 Jul 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237026; cv=none; b=TObBtYMYEZ3ihSmbLhWVN2LQH3zdnXw+cvwkMTH4SWVT4iRzErNhr5Vgck+nn+9STpEsCNyS+Nd3wR3fRxQ9eqhXrHQM+/NczBebSou9uNN6kf2VE0Ai6fa6nKElqALKHZt37DHMXGeuhad20d8P/J2jEeoURtcGVJpjKt3xleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237026; c=relaxed/simple;
	bh=dFJfVyEFvG4m3o+zB9WNck43vC6nwJonGUyBaWISAEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtQJmYXxesTY0AsUQaqtb2DCZ3O5KxeW1TaKJyJAmJZAW4186lZBAXZ4NDS4mSs4xFpa5e+dbh9GKbqYprg/7VAu2MJVSRvaaTzf5+2xg093niUNOGVz0r4m+8Hux6YQrfhNdnYSggQuylmf/Yb/ExrL6iwhfckJxPlYPTPKhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tevPlzXI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722237024; x=1753773024;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dFJfVyEFvG4m3o+zB9WNck43vC6nwJonGUyBaWISAEo=;
  b=tevPlzXIRECzRuC5MFyUMUKmjuc+xBqDJtvo+/L7RfyOQ8ibvJIzkgYX
   LMux50b6x6n//OT7kVPLIVRiEFaWv0+oCUpPGErAj1dR8sxgaABKGcn9o
   UTAlO9Bip3Ny1Urqbjr/z/bbgrrrpbDc7XQ6Mv7Jr34Wa5ayL7uMf5fXm
   d5+uuieaoJguxG+CzSWHkmTpuqS74iIcfaZWarzWjILyMG7V/NxloeA16
   D02bRv4MGObPWKRxCiJIOOy1cSQrH53QXpBC9rVSNqwahhj4EgjZYaP+8
   QkcuvAXVOuAuOhcjS1uW3dAnejcxnKKTXDhiYmdiNH0M5oGFMM464HbOu
   g==;
X-CSE-ConnectionGUID: nya7fybtRtOcSI+sfk742g==
X-CSE-MsgGUID: Kmp4xWkbSFK2Nn8vP5h0mA==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="32597004"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:10:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:09:59 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:09:55 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mihai.sain@microchip.com>,
	<varshini.rajendran@microchip.com>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 26/27] dt-bindings: arm: add sam9x75 curiosity board
Date: Mon, 29 Jul 2024 12:39:41 +0530
Message-ID: <20240729070941.1991515-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add documentation for SAM9X75 Curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Updated Reviewed-by tag
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 82f37328cc69..7160ec80ac1b 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -106,6 +106,12 @@ properties:
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
+      - description: Microchip SAM9X7 Evaluation Boards
+        items:
+          - const: microchip,sam9x75-curiosity
+          - const: microchip,sam9x7
+          - const: atmel,at91sam9
+
       - description: Nattis v2 board with Natte v2 power board
         items:
           - const: axentia,nattis-2
-- 
2.25.1


