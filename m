Return-Path: <linux-kernel+bounces-312239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347449693EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29E4288318
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0861D54D0;
	Tue,  3 Sep 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OgE2dq+7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B51CB527;
	Tue,  3 Sep 2024 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345768; cv=none; b=JuKa3KW6ZzXcMbsOL0ONtuf0f2I4JvebM9GNKt5DDX8tOMpVGShAK6UgL2llzh2dCPUkpFjV8fsK+tR4/SdBxzNZ329a/zg/Q0V44UvIQxwGdlUQlO1QaBFZJexbdoLXNaF1FUkhxh4X3RW5FrJyFzCqaP13/xbWHmbyXQ16jGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345768; c=relaxed/simple;
	bh=xw6HVneEx8JYTYqdGhN1CmrkEfyjnYCH2FyHmFQQEfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=layv4eeq0kILQb+oaoC58OnmZCfcKmVsFEq2qudO6X0YdTeuny40hFBMt0PhXZUUb4oKcXUZ7Zq6Qqzu3eT9nO96rUPsVWh/0dndVompBM8UFE0ka2ekZdw2yG2rtvAQIUZJNwEyso2pd4ttAvQExuoK9dvMfkA2Q5thQOJ6/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OgE2dq+7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345766; x=1756881766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xw6HVneEx8JYTYqdGhN1CmrkEfyjnYCH2FyHmFQQEfw=;
  b=OgE2dq+7/cflwCizlKj1X5W8IuJsmMQDogZkNBOSesARaAdbyKBz6oMH
   GNOUD+rBnoXRxXdw/5UtdE/4Tr0YX0PwH/hj2GU6A773gnfDMw/fBn8TI
   YJymCtXBLJmEVSD5c8Qmt1YfezqqTnVpCb8MGfbgDDx6QtS+FO9A5FCvb
   vourMu8f+gCLi2KnJWS3LuPrcmlEJFHdV1jNbGjcf4eARjQSCZDqYx6XZ
   eesnAXxcWsT6NtTdItHLvxPdqcO7NEb5oR7GK8HtGRCk+57lzjRYMoQ+p
   i1sSSbS0Kg1Kcx9YrG3S/kHuJMOCvl3vP4kAX+wRs9ZO+o9bJXbTQia0V
   g==;
X-CSE-ConnectionGUID: q+Zs7HZmS1O4vWTV7SMIVA==
X-CSE-MsgGUID: 7aGjnVWPRx+gMFhVe7bJTg==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31149999"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:42:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:42:29 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:42:25 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 01/12] dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
Date: Tue, 3 Sep 2024 12:12:25 +0530
Message-ID: <20240903064225.49313-1-varshini.rajendran@microchip.com>
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

Add microchip,sam9x7-ssc to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/misc/atmel-ssc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index f9fb412642fe..894875826de9 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: "atmel,at91rm9200-ssc" or "atmel,at91sam9g45-ssc"
+	       or "microchip,sam9x7-ssc", "atmel,at91sam9g45-ssc"
 	- atmel,at91rm9200-ssc: support pdc transfer
 	- atmel,at91sam9g45-ssc: support dma transfer
 - reg: Should contain SSC registers location and length
-- 
2.25.1


