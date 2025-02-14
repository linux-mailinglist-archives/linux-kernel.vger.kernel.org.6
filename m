Return-Path: <linux-kernel+bounces-515429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C26A364B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932FE3B1B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0DA268687;
	Fri, 14 Feb 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="xnODtEQP"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA32686A1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554629; cv=none; b=rrbjeKff2pU0fAb9BzZIuHis8E1r07turqOc+yYdJuoo277E/2qaOJ0aS8ktSL3ZGsT6QdL7bOLbNGJxESn3Sk2JRJISHSIcFj9xT0QYVdZw38dDp1eBaWpRsxpPnIrKpp2iYHeUkSss8nD9hEqVGgztdFZ6dGLXfNjqWlvB1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554629; c=relaxed/simple;
	bh=OFAPAVOqVuoi9a1p+QX8ZWSN2oGBayyv39emGYuW7Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=STRv2vj6TIqYTuf+GbXiakKl5V1D/0Io7VFneC7it2z4vKnsBvwVCTa5lBzHXIRKf4F5XuPm0rPXMrKfpvSTRxddM3ExY59wbJRqyXr2WtOAQBR8EUWUUW7t9fKsEJ4cSKaNfLqPG5iw4qtwvmIg8elQSskBtqBdbOi2JFt39c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=xnODtEQP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=xnODtEQPIh/VEXOsU16HCVaa9NNEu1CsH4Jd3yTVsHaqS+hIB2UOU8xwUUTTaRLh18Hy/WeY+RyuGFSnI0RHV5GUPnFGL6daf6b4sWhF0jj0CEj6D8uEIJr+wllqG48MVilsxa/glMI9jLVKSCh3Cz7+bnCQSB3SAua59e61b2E0qAeo75pRO6d1Qq8rnD22VE0wkbYf/BGZxTCKlmLyV2TbP/YIyYFbPrBVAm+bgVgH8n8kn9ZcshBQ8hFBwrWYZgGYQJcjypjV4O458HIEko73UUmWc6OeyEZtYGmQYrejnfmdotHdwowqfS1gdElBuMVqsp+d+1McLRLIXBu8Jg==; s=purelymail3; d=purelymail.com; v=1; bh=OFAPAVOqVuoi9a1p+QX8ZWSN2oGBayyv39emGYuW7Sk=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 893203092;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 14 Feb 2025 17:36:56 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Fri, 14 Feb 2025 18:36:49 +0100
Subject: [PATCH] dt-bindings: usb: samsung,exynos-dwc3 Add exynos990
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-exynos990-bindings-usb3-v1-1-3e5d2721c98c@mentallysanemainliners.org>
X-B4-Tracking: v=1; b=H4sIADB/r2cC/x3MPQ6DMAxA4asgz7WUH1pIr4IYSONQLwbFAoEQd
 2/U8Rveu0CpMCm8mwsK7ay8SIV9NPD5TjITcqoGZ9zTONsiHacsGoLByJJYZsVNo8dX7k3ubGi
 t76DWa6HMx/88jPf9A7LqK+RpAAAA
X-Change-ID: 20250214-exynos990-bindings-usb3-6f80f7194137
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739554614; l=1615;
 i=igor.belwon@mentallysanemainliners.org; s=20241206;
 h=from:subject:message-id; bh=OFAPAVOqVuoi9a1p+QX8ZWSN2oGBayyv39emGYuW7Sk=;
 b=uTaLuSG+epbVxDmg8aBZu28KGGGb2BkzA1eUtYOg78i++a0yLgSiKU1KhRpWn5Xx7FQI4+tZY
 D9YY22xxBWcBIOPqsdbbsJRS79i5ifu17aOBbWCNqJbd7wfh3IhOykU
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=qKAuSTWKTaGQM0vwBxV0p6hPKMN4vh0CwZ+bozrG5lY=

Add a compatible for the exynos990-dwusb3 node. It's compatible with the
exynos850 variant when using the highspeed mode.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
The Exynos990 SoC embeds a DWC3 USB3 DRD controller.

The controller's design is compatible with the Exynos850 design
for high-speed mode.

This patchset adds in the new exynos990-dwusb3 compatible.
---
 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 2b3430cebe99106f3b6201ab31d4d9e3fcc55627..136b14eecfe951dbc20377bffba1039fb1429f16 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -17,6 +17,7 @@ properties:
       - samsung,exynos5433-dwusb3
       - samsung,exynos7-dwusb3
       - samsung,exynos850-dwusb3
+      - samsung,exynos990-dwusb3
 
   '#address-cells':
     const: 1
@@ -124,7 +125,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: samsung,exynos850-dwusb3
+            enum:
+              - samsung,exynos850-dwusb3
+              - samsung,exynos990-dwusb3
     then:
       properties:
         clocks:

---
base-commit: 5cbcf2652f4cd84eac21f5e88fe2a0baecc601fb
change-id: 20250214-exynos990-bindings-usb3-6f80f7194137

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>


