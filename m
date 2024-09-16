Return-Path: <linux-kernel+bounces-330453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D0979EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65985281E57
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2A153573;
	Mon, 16 Sep 2024 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TV9Rcxu9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB10152E0C;
	Mon, 16 Sep 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480238; cv=none; b=S1pfIZhmdqDseD5AIxcemuILz9+vP3grH5LDEcOkPRDydr+UKuymjZsoktKoz3R45nj/+lOWK0SYu/HZdYMLW/qD07VrGiaCEVCAmaBI6e/sFWF54ztFgcCc8MBWh8xzwbZQH5PP/bOSDu5sIJw3v/slu4+9RokL5dY3ISx0EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480238; c=relaxed/simple;
	bh=7bl2ZEDuC0zZI5FlRxCu17AXg0qnwONuc0subfjdRWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=apMrwY3x7D2geM5ApBYMiZZ9wMrj+qrWbbKwd0vfdEOCZd3+VJmXXimlhffF2dF59BCgtfFu385+QYCz36HV1kNXnzd5iy6hGqM+/R03CaR46R44XocB/ztezWK0ZxiDMGpt1mhZK+yc6W/WAQnWgKtG4Cp+Kr1UtPOCQv6FE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TV9Rcxu9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726480236; x=1758016236;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7bl2ZEDuC0zZI5FlRxCu17AXg0qnwONuc0subfjdRWI=;
  b=TV9Rcxu9ajbB49QC7jp0UjGa2PrusVVQeGANR8HyVUX7dvT9KSELZ5i+
   yYtpQkx5F+wychjL5922h5QKhmog8m88aFYi5d9vtz4EkCqFG8jKlItJ/
   zwjJAoqWlsGSUiLcxTHzcfucsool9dpocfaw9RzXRqWHc7/haANHNYals
   Wfh1oPPPyxmjK73t6XfgdE1wFwyxhm/fAU9eb/aXKG5e+fw5mzX4slpoP
   GNT5cj0UOLp08+cUr25+aib/SIVYuldskAv2Mz0RlQTSsGBEwaOIoyNCp
   0kh9GSsttJeQFon91U4H0A8lWvCQwQhTCTpwuo++r2CpkYN3Q7X83Z14o
   Q==;
X-CSE-ConnectionGUID: FMt8JCZwTJSUmtKKgkwdXA==
X-CSE-MsgGUID: 1t0XNRlTShmtFNu1yaLadg==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="199259963"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:50:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:50:16 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:50:14 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 16 Sep 2024 11:49:19 +0200
Subject: [PATCH 1/4] dt-bindings: clock: add support for lan969x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240916-lan969x-clock-v1-1-0e150336074d@microchip.com>
References: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
In-Reply-To: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Lan969x is going to reuse the existing lan966x clock driver - document
that by adding compatible strings for the different SKU's that we
support.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../devicetree/bindings/clock/microchip,lan966x-gck.yaml    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
index df2bec188706..16106e8b637f 100644
--- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -16,7 +16,18 @@ description: |
 
 properties:
   compatible:
-    const: microchip,lan966x-gck
+    oneOf:
+      - enum:
+          - microchip,lan966x-gck
+          - microchip,lan9691-gck
+      - items:
+          - enum:
+              - microchip,lan9698-gck
+              - microchip,lan9696-gck
+              - microchip,lan9694-gck
+              - microchip,lan9693-gck
+              - microchip,lan9692-gck
+          - const: microchip,lan9691-gck
 
   reg:
     minItems: 1

-- 
2.34.1


