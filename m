Return-Path: <linux-kernel+bounces-190427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2304F8CFE19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E5228386F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EAA13BC02;
	Mon, 27 May 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QbO9iXsj"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4581327E5;
	Mon, 27 May 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805715; cv=none; b=tacgtBVZI2tyH1kpabMf5l5b2heJqzp+IaWgRqGLwxiX4Qe/nNSJ36kx5Br/uqzV8GD6Z2lK0BwOV0S4sS1IRTU34jSTmptLQr9qSLD7oOuiSbM5CHAI9ORK8g9VvUVsgnQjveBpI6BN/lDuF2JdoUQKMvZFFYzoJGFPs29qp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805715; c=relaxed/simple;
	bh=vvw3fEFm/MIzHbbIvboYwwd/M6wZeRTLrFARmDAtiho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxCPTC6hUU1SKYMwpbn1HxX0GIsv/cL0qqMDDHIUVJB6nIMrLuqx3RmPPXbHQIFjkbkgigrbokKYEw83vLnIs+xPgMs3f19EAN3g3hssVxKfgfv+62jsECpsNCLoR/Q4aIvrQ36TVZs+OW13mFQwsQOyxipG/SXZq92aEkdBUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QbO9iXsj; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C71A2000A;
	Mon, 27 May 2024 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716805705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkDr/uTE+SSoGhb8+yyec0XwQuw7fpgZQvCgauJl+yw=;
	b=QbO9iXsjbbJFFYLKpoNqnQNi4vhO+TOVHjmxpIt7pyL4x8fhpsc8DbvpAfBP2vDcGJ8dIX
	9f9kUD+elT1qUytp8yzoI+Y7UgoExX9E9nHneyiG8RliuNra1qOtI/oFyWv3HNSUrFZV8h
	wVUdUwymxt45ndDI79hl7pxDhiaDYe3j8QCbjnaF4c3B3JmYSYepfw+lbMUFfR3s4APlfI
	pG5DYzDrNJJvo/DKkuNIpOzaazoVgH90ClAk6fC1+n3AQU/tUVSYC70Ttu1fWFDYEQ0EsC
	WlKdegmGmtj+TzeT6qzTg0mu1PG4PHeudaQyMJ4Mc4cXzzneT78KGXIGKOrcCA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 27 May 2024 12:28:18 +0200
Subject: [PATCH 2/5] dt-bindings: timer: Add SOPHGO SG2002 clint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sg2002-v1-2-1b6cb38ce8f4@bootlin.com>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
In-Reply-To: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
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

Add compatible string for SOPHGO SG2002 Core-Local Interrupt Controller.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecb..b42d43d2de48 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -40,6 +40,7 @@ properties:
               - allwinner,sun20i-d1-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint
+              - sophgo,sg2002-clint
               - thead,th1520-clint
           - const: thead,c900-clint
       - items:

-- 
2.45.1


