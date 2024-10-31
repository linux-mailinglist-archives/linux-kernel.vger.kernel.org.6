Return-Path: <linux-kernel+bounces-390050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004909B74F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5092866B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED51537B9;
	Thu, 31 Oct 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="GFS4Qz3u"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174991474BF;
	Thu, 31 Oct 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358213; cv=none; b=AYYQ+2HgGRng8fClB58osF9N72Y1pHCVhQj434zi1BN8GvONI2scPaZ6qAsdYo2sh7fEIsjObNKN/6V+829aZ/lbvXm09/o6ELBlZLTB90+C/dZJFF0IN6MfubiN9jyLknoi5X/R0xre9YhF16zpgLgaELRMYJ8FEL3IfunAitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358213; c=relaxed/simple;
	bh=gCXgoaBUYXSYReLJKteTd41Q6MEmZ2zAzNHvT0JUlFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/gPfTHeK5cs/Vq5V//Yq0mHeFa7DFqrG/g5YpBafUInp/G3SWX6nMmuT92nlCg89WJ9NERI1e1c+pr7yFsYItE6JB5cDVHyTFPkqN06nAKAmNouaYlvjs6f4QgeLU8uW5rJCDCLunymSrupnW+apjiGWeAVS4J1Ypx2VHJv8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=GFS4Qz3u; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358203;
	bh=gCXgoaBUYXSYReLJKteTd41Q6MEmZ2zAzNHvT0JUlFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFS4Qz3uSMolkFeoX0DkhKFzigFLUToTR8Nw0N7Sk1gGC/twb9fAKdkvXJJUmC7mM
	 piBHbbOs44+xzCPYk1lAPrArwuL6se5v9eooujbWQP0Q0wlEVeo6+Txc9j48dUpG8T
	 q1fWdAnRonwczDTkjF9JMD8mjljnormo2VMNt1cSyMavk6IbGAYxsIJTXBWJik2IoF
	 rsfJnrRzRTcC6oQH4OfuwRZTo2ozKQ6kGVDE+GdYPSpeGs5PIDZdX1ZBljyGihnrq3
	 oLLVD+Opy60v2BJ46FqiJgMIEtRZ1uGfLdITm6oJjAylh2vtywqVjArrfv0Dau9iTs
	 OshsieeaZ0T6A==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] dt-bindings: usb: Add A100 compatible string
Date: Thu, 31 Oct 2024 04:02:17 -0300
Message-ID: <20241031070232.1793078-5-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A100 contains two fully OHCI/EHCI compatible USB host
controllers. Add their compatible strings to the list of
generic OHCI/EHCI controllers.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in V2:
 - Fix ordering of compatibles

 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 2ed178f16a78..0d797e01fc0b 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -28,6 +28,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun4i-a10-ehci
+              - allwinner,sun50i-a100-ehci
               - allwinner,sun50i-a64-ehci
               - allwinner,sun50i-h6-ehci
               - allwinner,sun50i-h616-ehci
diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index b9576015736b..cf33764553fa 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun4i-a10-ohci
+              - allwinner,sun50i-a100-ohci
               - allwinner,sun50i-a64-ohci
               - allwinner,sun50i-h6-ohci
               - allwinner,sun50i-h616-ohci
-- 
2.47.0


