Return-Path: <linux-kernel+bounces-265211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28693EE05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A856028278D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBAD84A31;
	Mon, 29 Jul 2024 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AQfe3hqZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69312C473;
	Mon, 29 Jul 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236855; cv=none; b=IgkeNGsiiJL7q9Sv2kn57x5hbiIulLTnPGbgHqeRCf433zI1fIkS5HUrY3fAxFHXngbOFdlQzgGlQy1lVp6rBNWsxYB0MEBtyTP1VYyJdEWR9cXSqcntXx2fB3gBZGxIEG3wKxmr7DJiMF39LKy5HLcSsVOlnl0Hp3PJ20fRKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236855; c=relaxed/simple;
	bh=MNyu+rKOG9IBkjo6Ew4FHJmJxmIaK4QmU4WgBoqiApY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3UZffI6l6pj8vJxfNpWnla1zrUvoGh2peyDG+WfFqdp4tn0TH94HGIcMl0btZIjZawthtqpq3ng4rlAodkoXr5KJNrKcsIcHBOX2gXDywKLdIEUvAkFJT6OwlDZAksL5oQfzIhkSzNseBDU6Iqx82tTrG3bQPE3dKT9pIt4uvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AQfe3hqZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236853; x=1753772853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNyu+rKOG9IBkjo6Ew4FHJmJxmIaK4QmU4WgBoqiApY=;
  b=AQfe3hqZlEoBT64kx8pBCt2blhZ6QT4dB4ZC91CYvYsQAiTIZzyTMynt
   FoIqdugtn1p6NLMFgHcTi09HU9IqxBMSwtxug1klsMq+MokYaQaE/2yeH
   GQJE8G3vh1AEj4d5Q8ztvVgxvkOALfXuE61i9lgR0WKge6AT+3y7yCy06
   mM7YGub81KnO6GlQUHtCl8NOBRTjwBrd6PCFs7XUOLhlrax0LfFxM+UR9
   yy53INPcOCMgYfjSMcqfXIetCzPyT9LBF9FrWaDuJrC/3QaBr8Wln1KMm
   mz704sJ79aXBqXwZMyUimhRuxTrYl1K+kWT++kcxomR1CZhuHnoEPsy5a
   A==;
X-CSE-ConnectionGUID: Trl5Yg7lR5GRkbAtH6EZiQ==
X-CSE-MsgGUID: 22ZYDZI7RGS7RMNUdYDxJw==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="29767661"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:07:25 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:07:20 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 09/27] dt-bindings: clocks: atmel,at91sam9x5-sckc: add sam9x7
Date: Mon, 29 Jul 2024 12:37:17 +0530
Message-ID: <20240729070717.1990654-1-varshini.rajendran@microchip.com>
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

Add bindings for SAM9X7's slow clock controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Corrected the subject line
 - Updated Reviewed-by tag
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


