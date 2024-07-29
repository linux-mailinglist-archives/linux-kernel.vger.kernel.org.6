Return-Path: <linux-kernel+bounces-265203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B593EDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB97BB21F62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846C82D7F;
	Mon, 29 Jul 2024 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lk+TjvCz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCE43AAB;
	Mon, 29 Jul 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236797; cv=none; b=HN3itWeTwuClwo9fGdgspPlOlQboovLvnC7tQvwGR9XRPt7IxXQlfNcJ2nf1uz4zuuQs6Pr51kuDSBvZhk8/7bU8IsiF3RAVzZdHZxHKSo3gIQArKFAJKphY8HVM6yLKa4fEFQQK1pzu94RxTptSYXqot2MImPf72p8Lu5JpiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236797; c=relaxed/simple;
	bh=QRI0nR/CG7Adw5rChLp9HDCOcBuhHZs1uFOHuPs9fuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBTJLwvdyHfF3gagjhl00Q8/1VfncxmNHv/Ea/trkEjYCbyNP1HBPCETk7ZAyIw/rwR3OCMmpFIV1nXUJzYRWdZhM8vDO5B+3Z/aIShffE84hhYaFKhEnY0UDYdhMhcjYxrlBXHdpdNx1d4+HCUU1ZEpnJvnX7vg42CG9y4PgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lk+TjvCz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236795; x=1753772795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QRI0nR/CG7Adw5rChLp9HDCOcBuhHZs1uFOHuPs9fuE=;
  b=lk+TjvCzuEcDBaNWOUHYUaapUIFy52ATP08MkhOYtZ/fFQ1mOlf5PDXb
   P7i45mSfpvx/0ZBv1rgKDJYkFSML6/l/wko6/t3JpPLytpB2Uo9M+OKH/
   64IcBcKZ8bt+x79tfECMdknr0CxJ0XBD/MLz3cC28TXgUFt77TMGP9eSE
   Bpz/I9O5v2ulBhoXfsFTbt/5t13vkpqqTRYma+kui8Kv5vGEnAtNfRUCs
   qNzOznrxUdg8E6qcA+KLrBzUHRCyfIxfnOmgi0qzAIbFMQJgN9KpglJCD
   3BO3DnK+bJpbtxkH7eUjGk8Uo260svIvJbouDQa2isINO2iJfdaXf6CLd
   w==;
X-CSE-ConnectionGUID: dbvVkR59Tgaty9Rjj1qKOQ==
X-CSE-MsgGUID: DxV5YsByR/iwxA7iJAd0iw==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30453968"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:06:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:06:02 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:05:58 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<lee@kernel.org>, <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 01/27] dt-bindings: atmel-sysreg: add sam9x7
Date: Mon, 29 Jul 2024 12:35:43 +0530
Message-ID: <20240729070543.1990209-1-varshini.rajendran@microchip.com>
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

Add RAM controller & PIT64 DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v6:

 - Removed sfr compatible from the previous version patch as the syscon
   devices compatible are moved to a different file. Did not remove the
   Acked-by tag as there is no additional changes, only a change that is
   removed.
--
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 7374beb5a613..76e2b7978250 100644
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
-- 
2.25.1


