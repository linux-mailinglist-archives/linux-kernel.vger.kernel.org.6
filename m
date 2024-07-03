Return-Path: <linux-kernel+bounces-239259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889892589C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A76E289354
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C8174EFC;
	Wed,  3 Jul 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z+jLPCfU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E0143C6B;
	Wed,  3 Jul 2024 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002490; cv=none; b=BS4+RVtUxYM6UlfTq9b1BDKIoyuJezF5K+pNf/a4JgZYXgMrhIJPHmw1emMrJqBO55aei2wry7VWSZjG0SqRUf4aJB+7rwmofBrRWRuqb3cP7h6yMMH/ekqYItbxoNxH+QvgSDJsqVq+FWxdnglm7SY4Co1qlAUqQJ2+Gip2cxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002490; c=relaxed/simple;
	bh=d+NaFbiFI1ORWu1Rz4SBsOdh7lHDtqOtupPY4l7As28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrZNBjt8QEFXcpuI8GPnAhkXo1t5mCs9X7hibVGmZd0rJwHT3Vo2NEC/zcB0EttKFLiUQ+GAx7fwJFQgYPLTqMHOsChWzog+/jCntYZPX0NB2DEWYqL/DYGW0AA0u1ut2v20OqfLQYNAzDqaR4PaYfK2Cp+TeHh+bo/w9lEDjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z+jLPCfU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002489; x=1751538489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d+NaFbiFI1ORWu1Rz4SBsOdh7lHDtqOtupPY4l7As28=;
  b=Z+jLPCfUvSL0/kAR+CKGB+no0hlBjsP3P9ZxIdcUHSw1wTZw/EkRC3xe
   sRtAZkyZbeB8NOTLH9ihaMXMvqpI/gGdaAuTT0JqSWd2FCPNZl9VFAyJZ
   9yx3eQL58lXfuOQRNY3lyoxk2by/xZLRB1HuHrcZX/D3d1OkqhOk+aaHc
   Hd+qnidB7c+YPa8ML/F5r7tr2yBrmH6qTYQk96rO4iyoKDZBXiO/Vk2sM
   qnVpF/GRGj+TRhxblKeU6rdF61tbWaisk3WVGVLCMWpE/7c9Xr907adLp
   3QmO0PeMlydBLxU92WWcytdFQn/WZU5nclHBJHAr7rFWcLh1MnIyFYTae
   w==;
X-CSE-ConnectionGUID: C1sswkSrQy+pa1d+oVi69g==
X-CSE-MsgGUID: 7GR4o5dbRZOp2O0MfqxJVw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="29441491"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:28:00 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:27:55 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v5 12/27] dt-bindings: clock: at91: Allow PLLs to be exported and referenced in DT
Date: Wed, 3 Jul 2024 15:57:49 +0530
Message-ID: <20240703102749.195907-1-varshini.rajendran@microchip.com>
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

Allow PLLADIV2 and LVDSPLL to be referenced as a PMC_TYPE_CORE
clock from phandle in DT for sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
- Updated Acked-by tag.
---
 include/dt-bindings/clock/at91.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 3e3972a814c1..6ede88c3992d 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -38,6 +38,10 @@
 #define PMC_CPU			(PMC_MAIN + 9)
 #define PMC_MCK1		(PMC_MAIN + 10)
 
+/* SAM9X7 */
+#define PMC_PLLADIV2		(PMC_MAIN + 11)
+#define PMC_LVDSPLL		(PMC_MAIN + 12)
+
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
-- 
2.25.1


