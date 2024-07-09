Return-Path: <linux-kernel+bounces-245592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF292B4BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B961C21A17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC3156653;
	Tue,  9 Jul 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DIO2NmNq"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2912CDB6;
	Tue,  9 Jul 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519646; cv=none; b=jTNo45dffDFKUvlCDEQ5ToFrewMeJtpV5yPWbvIgHcN3ztdzw2hrNqRD8s5ahH5yKUrB24VN43iiL3NLq+HeA4h8U6nBlYKFz8gXQbtJ0k/5xXBng6GjtYDwX9VlmMW9ATVoqCj+hsVtq5gYR+7uDYM3LNt8FSGV87ZbYCOfdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519646; c=relaxed/simple;
	bh=gNdzO19tkqtEXbL7/XaqfYl1O6LdfiExoOmgGOhmUEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1hd2fWw25q9XZQhgK8H+5+hrmSlLfO8qj1uiLLDzBxiMJfA7qy7WoXxsrBOnqTYk+DcJvLBuIeUlJRRWsOue/UcSwzXaa2KivT1s2nxDc+tlZBRpYwZsMJz40RaDYaIR8g3s0CAVo0mnaVmVsqTZrsRdJ1juzlrxX/w6ORSAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DIO2NmNq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29F0040003;
	Tue,  9 Jul 2024 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720519642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhYN2esY9mLXkTt3QVpkwWv6jX6N62gsaZnkqzr2dx0=;
	b=DIO2NmNqAVuxnpus8tNQc77xzz27cN2SMn5PlXAT405CzUDkSK8vRy/RxMN6jfjGywyams
	qtC+ht/x+TsMflZFq2lCPmwpewo1KbP165tAwnYxjLRhVh7yo5yfBil6imRYXVnAsIy3ab
	alKlJOR+7AvkvyEW6/6Pd/ATYMx0sdzJeYhLkcffkZu3pfGaPjdD0hJh3qwpzbBSCVS7Oc
	MDYaTBjkSvNGbq2cBO3uZf4MUtDegrwzRZcE4TIRL6YNzF5s4ZJ/7iI4zpnMKe/XdEcQVp
	gFmGfiGhoZ6EkAbZ1m+L1tRmkvi7c1SrVh2sOyYi+A48XDOtb9JMIrvWY7fsNw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 09 Jul 2024 12:07:16 +0200
Subject: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add SOPHGO
 SG2002 plic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-sg2002-v3-1-af779c3d139d@bootlin.com>
References: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
In-Reply-To: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
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
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

Add compatible string for SOPHGO SG2002 Platform-Level Interruter
Controller.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


