Return-Path: <linux-kernel+bounces-263601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A70893D824
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2707B283BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7156B7C;
	Fri, 26 Jul 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JGmQ6y8i"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3238FA8;
	Fri, 26 Jul 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017884; cv=none; b=VdMKCY1c62kG90WJO7sNz2fRkdK/bfaPeBPq6XxQGbB48RXA2M6SNErREMSIXIzvpZT9QdNospGTpSHoibTTGVUZE/4UGzTswlUMP/8ItnoaQ8kxqFV4FBfDODiW3fpXG2Qyx/zWn0BjXIqkuIJzxz9qLVEM2egZQWtrZNZsJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017884; c=relaxed/simple;
	bh=LMjr38px/uwtqVLxo9LnKsWDTKiWBJ+juaV59U63100=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiijJWZiv7GMJGSv/qmJVxei8eyibTrpv0XGB9/TA2OnWWK6XytDqwi1KN2V+dOWHZUgsA0y6StRAv+I6jOyFy9Lv5Kc2CsqhKKD327aiYJgqxBdzY9g8KDLYCSdZQOiP6upRPYjiMiPE/d3jEvTbVv4xkvaCszpXg3Og9HQOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JGmQ6y8i; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCB57C0005;
	Fri, 26 Jul 2024 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUvbczHasNSXYbLrtASntXaaRYM876jaQmbG3YSsJHs=;
	b=JGmQ6y8iMVspfKfeIgjSAH4IQ9SYmrlcCs4vVSk/ja0JTxjpsrDPd8cGRslr7gZ9/mWLMU
	0wAow8JJj9jEiGSfQ9iaPNrGR5JOrXXE5XeQM433RAkDyoS1WqWiz/ASEaUvoS72CZr7ou
	HMdVE2t9jnQxDN4vt6lUClUh7LK/q/A0hddvZ3NfgVTjxXoLhUPxdO+KxDbZjmDf9NPG5F
	66/SYgrLhx0I9LFTdl/SN5PmCwNrNSnYCu77naOMLaLiQ1dqf+F7RoN8Yb6J8Wjo/ZJbOF
	PMDvbC4vmZPMGDi1bIygRWjP1PGydtMUt4ol3IGMALu6pg7RsHEIO9X3OkMmjQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:50 +0200
Subject: [PATCH v5 02/12] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-2-8664bfb032ac@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

On J7200, the controller & its wrapper are reset on resume. It has the
same behavior as ti,j721e-usb with a different SoC integration.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 653a89586f4e..038fdf173841 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -14,7 +14,9 @@ properties:
     oneOf:
       - const: ti,j721e-usb
       - items:
-          - const: ti,am64-usb
+          - enum:
+              - const: ti,am64-usb
+              - const: ti,j7200-usb
           - const: ti,j721e-usb
 
   reg:

-- 
2.45.2


