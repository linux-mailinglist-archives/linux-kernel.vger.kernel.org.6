Return-Path: <linux-kernel+bounces-263604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2D93D831
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C183282C44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9B14A0AE;
	Fri, 26 Jul 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J4/6+VLe"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9038FAD;
	Fri, 26 Jul 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017885; cv=none; b=libSq3W/HW2bX+7FIY1fk/gtbzsb8nEWo7VOhPDTZi5u35n35WoNKSvAmWFSflJUZLa+AYv/M/gbG2t2ewnVoyYCYHpmqeNyOVe5P0p4yC/scM15nHxahO0RN6X/CbOCdUDei3n2ul2oYQwM/EFaLGKGYWRMXBRmVWnfqxC9kDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017885; c=relaxed/simple;
	bh=M8kT7XTM54d+VqSVtR7ra8gjgpddLbn1IZokTOD5/D4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ij39RbyV8gq6GTszmfnwqtIXqGegzcbu83rNoD804uQoYS1rIXBG2yZRAlz7PD64uApwBOLIAXDYOZiHDhForCWdqv8X5U/3L6KbDd9WClxvxQvf/6ubyAq6k9je0vWLNYE+D56AObvpqhRtchwo+//8PT7f1Abr6oGx796rNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J4/6+VLe; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02AC0C0003;
	Fri, 26 Jul 2024 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hlY/jskfFjLvf2CkYp2cXADUxnfZgmP+k1J65XVhjQ=;
	b=J4/6+VLeoBY7oJ1KT8elG55jruOUf7u4wlH+m+huKtpF7fvSHgd0BTXZsSU+xkK42AzJzE
	W4lARncevLveoRibHvSQxNz7HwccX9G9EaCAD/P3noX1SjjO36pDx53y7O3Ib2zeuv11HR
	l/zptPpvGHWmm7+9iQKYuTkTZqQwMd3RH1plH/t5n7q0J07dIGXU6QLcm9d/VFG4aSp0P7
	bHrhBHja9AQL7D7KlElfEaTQ2Q69SY31OuGX7qP01+4pvN/NT0z/c4uEuP+v3BK87e0By9
	SxpFy4Kt2GY8vBa5lfuaOCqp92i6J/36bDOWVp+3kNBimCJYLi5VUcdObrVjVQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:49 +0200
Subject: [PATCH v5 01/12] dt-bindings: usb: ti,j721e-usb: fix compatible
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-1-8664bfb032ac@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
In-Reply-To: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Kevin Hilman <khilman@kernel.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

Compatible can be A or B+A, not A or B or A+B. B got added afterwards,
we want B+A not A+B. A=ti,j721e-usb and B=ti,am64-usb.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 95ff9791baea..653a89586f4e 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -13,10 +13,9 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-usb
-      - const: ti,am64-usb
       - items:
-          - const: ti,j721e-usb
           - const: ti,am64-usb
+          - const: ti,j721e-usb
 
   reg:
     maxItems: 1

-- 
2.45.2


