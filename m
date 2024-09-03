Return-Path: <linux-kernel+bounces-312242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F39693F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078511C22E45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCA41D6196;
	Tue,  3 Sep 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KD0b6VSS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC21D54DA;
	Tue,  3 Sep 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345800; cv=none; b=Tn/zrBwMyXzcBaCbaV6HqIzWe/ejnya7c/wl2QK/WnE7QoPR9m+J9cXFCDfX+bujlh2OPg7YRCA4if9eDoMB4iYDcVJG6yK+Yagsf1VqYF9C+M2d1ARWb05nUYFk0ZT2htVdBaLByh5y/AS0s6keMj61axObGZiCWcDXYnXIVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345800; c=relaxed/simple;
	bh=N6gPdKLgzt8G5cWCGX2YKZDyoklnH6qBOw/R1C7Gbb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTrChF+4eJPoHKmoKoCREnmprWZpdUifPNdxYz5OUyF5JSn8aPib5Lh4JhTcMDXH58dtnOILJ6jE/4cSuOQuxGzW7nuXy+FalLM3vmnFjY1HsGmJuNRX9sK+B4yHpWK9U5WHOS5FE30JVLm2vNd3/4D7Cs8WgaX24j7Lr6dpxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KD0b6VSS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345799; x=1756881799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N6gPdKLgzt8G5cWCGX2YKZDyoklnH6qBOw/R1C7Gbb8=;
  b=KD0b6VSSqbhYZLcSHu5LrTQMcCT/7YW2iFLkLcL+ujh6Upn1Npko1mrg
   idy3BmDHN4aa0M5RAY1QiBSHYdV00eucAfx7C0GiwtzIaIQosBx1YAYWG
   ws1AL+Di2iNfVBDM5Z0ym8YGvnnB5xdgSfIRSIeUWW2Up03RqnF3oYQPR
   6e3rq+wO+vaCfmcobd0/Do+mu1DvMCc8zoMsrCqB1gi/UdE0VJDhLuTuJ
   kLqShKwI0S6/CB2iGhKFWeAkyEutrNWbO9hR8F/BCYRKA3tIK8aQ2G7/d
   YK/FBhzr/yv864O+2vkmRC6tiHije2m5vnURMB1pI5LTaKowqIHIXKK6i
   g==;
X-CSE-ConnectionGUID: 02dNa+UiRmSH2VEpN09glQ==
X-CSE-MsgGUID: WP11WMHuTByh5ItSZkP0sg==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="262174364"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:43:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:42:48 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:42:45 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dharma.b@microchip.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v7 03/12] dt-bindings: interrupt-controller: Add support for sam9x7 aic
Date: Tue, 3 Sep 2024 12:12:40 +0530
Message-ID: <20240903064240.49415-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Document the support added for the Advanced interrupt controller(AIC)
chip in the sam9x7 SoC family. New compatible is introduced to capture
the differences like the number of interrupts supported in the
integration of the IP to that of the previous designs.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v7:

- Elaborated the commit message by explaining the difference in IP.
---
 .../devicetree/bindings/interrupt-controller/atmel,aic.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
index d4658fe3867c..d671ed884c9e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -23,6 +23,7 @@ properties:
       - atmel,sama5d3-aic
       - atmel,sama5d4-aic
       - microchip,sam9x60-aic
+      - microchip,sam9x7-aic
 
   reg:
     maxItems: 1
-- 
2.25.1


