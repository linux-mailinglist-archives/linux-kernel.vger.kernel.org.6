Return-Path: <linux-kernel+bounces-211136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D117904D93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE05B262F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FD816D4FF;
	Wed, 12 Jun 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fX4zOSoH"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6316C6B7;
	Wed, 12 Jun 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179557; cv=none; b=PI1pBjAIUz/haO4GbQBwrX/G8WfPMnGg+qvNdzNC6drf/QF8NLSYwuppMuBO5TOS75A0sprYDzck6DNBKnimiqAHkECZZgfSb3IEzd7F3qt+EJtk5BdrEexBDcmgX73Po2tuwl9pT248qrn+Ra4nhZp5mDsVlt/z/22EMOvz6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179557; c=relaxed/simple;
	bh=Im8ghuseOTJoJEaNxYsrQz2yqU/F6Hgaz6qtpvWf0NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emtXxXRyHLXKyjHyBviC1GEefGhvjRlMhPjzmQ14R1n9pSIdpTxbmutFp3JDPyolJRyAe02ID5nDJuSA7cl6x+/Ktu2MllXt64Jh1fa3sD1mPRV+/FAg9cPaQsdtY+kTWFKNK6bDV4J0Zv4aZG0ibGK/qqNIirudXeBtg/ZUoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fX4zOSoH; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C31C71C000A;
	Wed, 12 Jun 2024 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718179553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fie/5opLxx7Vo9z7CQ4tW6ySP0dMVwgo4tZMrJ7+8Hw=;
	b=fX4zOSoHT01iVPcv6evonc/as95kPfsOfRzlDVCaxx5RQ+HFYFX8CYPDBG7hxYb53Hv7n1
	RPyiJmRSxTLj0IaDSA4S0SQDS0PPoaxaoUeMC12voacrcVhqx1RmQbO3vD+4wJ8Oz74tnr
	vmaMm2Szini4O5OaCwndVB3GvXGR2pPxitsDZ+ReSuOJaIPwzkbshuaIjo1tgFK2J0CHSW
	NhdBDI1pYjJ/3N5mmbrytqT/LGFcvJwNUEV3v4RKjEIQlOAlIHzQOU6A0VVYuS1vwe2B/V
	yUwgmermU1rs6dtaEd+Zh5Dsja24u+G/tpKRvQKUmerUkh4aXutSkMBvIbPidQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 12 Jun 2024 10:02:32 +0200
Subject: [PATCH v2 2/6] dt-bindings: interrupt-controller: Add SOPHGO
 SG2002 plic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-sg2002-v2-2-19a585af6846@bootlin.com>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
In-Reply-To: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

Add compatible string for SOPHGO SG2002 Platform-Level Interruter
Controller.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276b..7e1451f9786a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -67,6 +67,7 @@ properties:
               - allwinner,sun20i-d1-plic
               - sophgo,cv1800b-plic
               - sophgo,cv1812h-plic
+              - sophgo,sg2002-plic
               - sophgo,sg2042-plic
               - thead,th1520-plic
           - const: thead,c900-plic

-- 
2.45.2


