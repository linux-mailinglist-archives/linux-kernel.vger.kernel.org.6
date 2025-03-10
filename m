Return-Path: <linux-kernel+bounces-554674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F0A59B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D34F16E922
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFD230D3A;
	Mon, 10 Mar 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VlT4BOzS"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA5230BE3;
	Mon, 10 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624810; cv=none; b=tlez6jaEKqULCumv59UUmaPMlUpH7QH/4U2SnMXfJhBFKLjeITN4crY85VrG7qRh8eD70unjfLWg4hkn7qceJKnG1pvMPyCGlQrU+Ke54Lp4hHTsD0Zw3mgyfuSbzBkUIILPnw20zzKaOTQi71LPrFvRrePJO7jdBKC7xGQSeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624810; c=relaxed/simple;
	bh=FJ/g4p5K4DhZe5aNgiyBGgNgUhTwe26PsEdnxAtkehY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0QB1LXEnnTI+iYNCi5dTBK8J08UIgTOtjOHxpMK9Asm/okUijbax3e/RnrjwFw619YXdI3qwqwvq6Ati0ppSVEmfBUMpfRDxgmD5YrtgEaeZ+Nf/5JouZ7zMlR2VCPlLBpXOTDZ7Ebe8UpgFmjcLcF9WpRS4+sSIOdiH5k591c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VlT4BOzS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 520E041DF6;
	Mon, 10 Mar 2025 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741624806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFmJVkvgEr7zPfQ20jjW3wMDTUUTOBdrrvb2AdJk2z4=;
	b=VlT4BOzSDzwOKvMH3AFVaudzLMasQEOtRQivw/fPBOo3sQGLitdcE5pPg/HakDLuu5fodv
	RBnilJbL8SejASp4E6onzGzyL5P0ZrZtvqtvUOjEt/LcDLTvzcvjaK5lH/dox0xZPHs44U
	VRDUtxdVXa+JV9YBIgj7SDBYhk4YewRDkKCwhYrNlBtYwX4wq4AB7hXyGwL41bHGVD4Cyd
	xjpJeOCJIDyhgPWU/1xQlqql5tWD2vIOkwxEOATAVscV9S5k8LeLoX4hSSy+KYMTJ/ZSrp
	f7h/BxTgSl33OAFqDbN/ceOSm/6Qc07DjNE2osEQLYxRV+uxPp6cP5xm9U+gVQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 10 Mar 2025 17:39:48 +0100
Subject: [PATCH v4 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and
 Concerto board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-varsom6ul-concerto-dts-v4-1-6034fda6ec64@bootlin.com>
References: <20250310-varsom6ul-concerto-dts-v4-0-6034fda6ec64@bootlin.com>
In-Reply-To: <20250310-varsom6ul-concerto-dts-v4-0-6034fda6ec64@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=FJ/g4p5K4DhZe5aNgiyBGgNgUhTwe26PsEdnxAtkehY=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnzxXlMg/BcfWlXJmfaq+uYf55WPEuRwC7kJQiR
 hH6/2m2X+qJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ88V5QAKCRDRgEFAKaOo
 Nh3vEACk/cWrSLz7Db6mxHyQBfgW2xa23PjCQYpq28VNPJd6JgrYhReZSWBv+GjtlOexgtdKqI/
 QbQ7/BrKtROsHrWWBCR+VRY6Wv0+pYxdM9UrfGSyT1dPCZelAxr+u2tZS+H4cNTO3LGiPqvrfb6
 3Vn50hPc7Bh823P9ClbLaJCjFN1c79nnBwijQo9lTqQzRsWDqBDm0g4bMilk/N0QprwR3wdPhX7
 93C0I6R9+GGvWwDPuER1B/QFfz7wUnN+GdusqpjiPQdViNgw/qEA3Z+f2iFOXE3gYV1Z/7hkTtb
 Fc+dRTNhZ60b/6B5q8raXi9zo5lbBS4FAaTiNlL4kau4V0p4x4MFSQicCdW6jwgEhLrCWGuYfVQ
 V3LpRLx5y40mwMdmliL7ICTCvDKUQ5+07dSgsKEl6nlIqTjbHdkyZp7S2OLDEFHtv0MvlT94PEB
 Tc8PvvB7pqlTLxaW0Npj0rSmnxMWy8nvymkZDbE1wdwKJVM8I2v3OUjXuij5kQGG0SdjBRCz+Ji
 7MRnPMcCbeCx5V0Ke2WLvI8gUYSNK+vC+I62eH7TxvzvByJLni8Gm8FBFJvgtqy0PHOvlklPIXI
 tY7ncDpAifzo5G5b6a7gZgtqo+5FTLT8RW9IjuTO9l5Dtsgx0/cNcQUUq9eNWXYPD02b4mlv4/p
 VJGvvfXlUPLwOmg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhgvshhtvghvrghmsehgm
 hgrihhlrdgtohhmpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghonhhorhdrughoohhlvgihsehmihgtrhhotghhihhprdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com

Add support for the Variscite i.MX6UL VAR-SOM-MX6UL and the Variscite
Concerto carrier board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


