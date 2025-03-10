Return-Path: <linux-kernel+bounces-554613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB1A59A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738D93A2A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960422F15F;
	Mon, 10 Mar 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ngbR+vkB"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF922DFB6;
	Mon, 10 Mar 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622231; cv=none; b=An65FVJmnz0bUesMRJHJXt1f6C8I54ZDDRBsXNMGPhUs/F4cjow5Njfdb52ZVgksQfvIx+HbssF4tnRkHZEMcbIevf1rRHjrB5TW+tyIs15UiuvAjOqZ5XgyPbGRBjNGnM/ETwvL0hBhXL/vsLPrejChIqfzHUvoKl3WESfvIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622231; c=relaxed/simple;
	bh=TMVSI2zGfqwniwiuhzluD6wQ3DWKu2knPI+0dq4y2jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWD/9wfCS83T8Qu7NEjjVh8G8rnQlQOIA9HI33geWh7WNLEGivqyZ8PL2fE0YmrTtTqm6syJrjq15MXqC8x6PR2wLhDEwYG+IJNhQfWshleutlbuKQtxCULzwZCbCIuUjlvax0eOX95ZWi3UeiNXRQoXWf/l7ea3Iwt4sQWa3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ngbR+vkB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D44544199;
	Mon, 10 Mar 2025 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741622227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBLy6wqoJxrI6Sq3aEgj7fgqeaYRLpYnXmNTnu+lE3c=;
	b=ngbR+vkBc9xzIp6DGmi2QfjL1d5SAO0Xse+YW10wkME9OSgksZMofslMUhRPAQ0jvi9wAR
	xPe/Zgp6aajwlTARRWxqK4PTZ8QSaiFfqGKi04mhnWxlAVArtShUPtIg/GekJa/v5EF+5D
	5dLqWiGtqH1CRFPgcJbL2aTm7LWHhiQzqEimFffoWXeqQz4LgjcIvEGIzCFYJl6wCqnyan
	ytGyUZfOT1h5MTgIIlLU5OVysGTQqHD5cxExmXjI5RgxOu4urIv98hV0kRA0TqneMEio5R
	rxyC24nPF8i8033WyD1dRmF526YVzTxI+Xhvv0wwuH4WtkIjtxdnO2ZqI27uzQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 10 Mar 2025 16:56:07 +0100
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and
 Concerto board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-varsom6ul-concerto-dts-v3-1-551e60713523@bootlin.com>
References: <20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com>
In-Reply-To: <20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=TMVSI2zGfqwniwiuhzluD6wQ3DWKu2knPI+0dq4y2jo=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnzwvRKAtb9RX0+IISECyeAyAc+PzHjC4KgCpRL
 M1VuemYnbuJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ88L0QAKCRDRgEFAKaOo
 NmuGD/wJGaqSrv7s/cs4ENQzEcKbTBf1mrVlSz8AIbtBRQUki2H/rO7VInhseA4z1n3EDJwTixp
 ZU0YeVURTIECM7HE+HH5QaNvGMBrsYwcdgnRUzYzxSAD1vTRtYo18+KGnkc5bfacBH+zx8MBILI
 jAv+I6ftaiRvQJFn99j1DXh1Yp4umV09+tfr8eOsWry+fFxHRw5TSL33AwgBt/bP+RZP1J7Ri7k
 oHQHkWth92CyTLHZFiHGf5YfSMI76EOB787BaRIKgPGTjvUVMYSEkqT1YKkhUGYb0Nscv3o+y/F
 333YMY3kwxG++4bWOBex3D2iXk51ZO2NDOM2TFNEh7kufO/X7Pm2hVbhiPVwqrtuJ5WAbzVPzyR
 NP9vtBX588GgZRSS0+t07x3OnJbkXsmzxRBxzm50n7n//JDu7tYJV1gklf9LoRTn2tmAwVTw1IA
 hFNRrD+PALQErnnyjqsvLUqLaYVE1ysk4IvbkzGKCqPW3SZxWxDQLlQmKlMUA/rlP3chaISIjJV
 ug7utTMqrGaleQry+cDI4foIc8VtyawRlI9CS6wWyfasu8GNT2mLC4zOFawMQ659hGYc09ID0yp
 H/H0NV04HJtI9V4PxK7gZQx5fYYdJMyfwooo+/OfXOhi8Ll87BPKK404SNx9IRNQyxS50SqQPAm
 +jIxPYDMrwIEFtg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrt
 ghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsrdhhrghuvghrsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com

Add support for the Variscite i.MX6UL VAR-SOM-MX6UL and the Variscite
Concerto carrier board.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0db2cbd7891ffb361e0ac60fe6be66e381b2a8f4..a8f8cb845a2085eb13594adacf33f372185e8b0b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -688,6 +688,12 @@ properties:
           - const: phytec,imx6ul-pcl063   # PHYTEC phyCORE-i.MX 6UL
           - const: fsl,imx6ul
 
+      - description: i.MX6UL Variscite VAR-SOM-MX6 Boards
+        items:
+          - const: variscite,mx6ulconcerto
+          - const: variscite,var-som-imx6ul
+          - const: fsl,imx6ul
+
       - description: Kontron BL i.MX6UL (N631X S) Board
         items:
           - const: kontron,bl-imx6ul       # Kontron BL i.MX6UL Carrier Board

-- 
2.47.0


