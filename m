Return-Path: <linux-kernel+bounces-239263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E292589E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CA128F4AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A2173339;
	Wed,  3 Jul 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GMuuaTYQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793B16F0DD;
	Wed,  3 Jul 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002527; cv=none; b=J/xqD/4cixTheV+Ex16uP8/joMYVk/qyLZ9v1NoyXsPnF/2YYbsP4UYzZKn0iUu2zAyhcmCFLCP4CzuZr6kDZ0Awa0b6HXRsCfOTMtvUqXV9xe2ZamEG0/IjtSKUbA7z85RE805aLt2//wt+ls6hRjMBncp+kqg8Aui7bq+E55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002527; c=relaxed/simple;
	bh=YbocINexu7W/LW3dxzi0XE7KHqeUdFUgZnMRwDmW0kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8Mkmp3fwUrwI6U/YKBnvUIZ+ien5GdfwBy0cMWad54HQO5peSADXTBckRdlDDTYBFxxmdoqWnqbi410WJ/hz0ZBE0eEFaO5gzxQMwAEkHF9V8oS79nqICaS72ewZsFAG4vD5FOOyrDocU7P06rZ6dnyoEFPD1523zJOV169XNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GMuuaTYQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002527; x=1751538527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YbocINexu7W/LW3dxzi0XE7KHqeUdFUgZnMRwDmW0kE=;
  b=GMuuaTYQ/a0IaK4HgSl+QfxtPWJlKLnDZmQjIRcTruPG5kK2OoRCJ4In
   fjWWPBuA2gioGxgeMBNWbH3I82xHg0iYPiuOQn8eUiniVyj8mCD10N87w
   05yLJNkii7Qtmek4qXMWasuUC75SXw/IldHvpBjNapL8CH2KWMdC2RARD
   14+pF8ZgfHiuilLGPBB/Ty9Cyl0hrdQQ/Bf2jo33Ji/oDiUo7zJWEzCVe
   EZvN8/tJBqGPpZGitXDWwWh4rmcyztLElXDqoImpDscHWCL0RXMjvk8A4
   yYfXY/B/T4S9T/5tqv9I9gmXvpN1/yWQ+4F/+EEeNNCjY1ZhjjMeaB4S+
   w==;
X-CSE-ConnectionGUID: ywlN1IFORca1IOesWlMguw==
X-CSE-MsgGUID: V6OkUdLkTRSruK8jHMM+cw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28804766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:28:21 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:28:17 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dharma.b@microchip.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the property microchip,nr-irqs
Date: Wed, 3 Jul 2024 15:58:14 +0530
Message-ID: <20240703102814.196063-1-varshini.rajendran@microchip.com>
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

Add the description and conditions to the device tree documentation
for the property microchip,nr-irqs.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../bindings/interrupt-controller/atmel,aic.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
index 9c5af9dbcb6e..06e5f92e7d53 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -54,6 +54,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: u32 array of external irqs.
 
+  microchip,nr-irqs:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: u32 array of nr_irqs.
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
   - if:
@@ -71,6 +75,14 @@ allOf:
         atmel,external-irqs:
           minItems: 1
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,sam9x7-aic
+    then:
+      required:
+        - microchip,nr-irqs
 
 required:
   - compatible
-- 
2.25.1


