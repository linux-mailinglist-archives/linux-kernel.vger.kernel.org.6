Return-Path: <linux-kernel+bounces-245594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D011392B4BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DC1C21E28
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3764156C68;
	Tue,  9 Jul 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oe/k0raP"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39752155C80;
	Tue,  9 Jul 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519648; cv=none; b=tpd6NXK6Tz2HaIYbM18ir+8pSJYHnSntx6EkhwXU3r6ldpxZCo0NiLfkZVpzStxMEaQSuJpa+q2AvT68UioqQ6tbpwTHEtmpySYPjvHf9obhrYaylbPPmpEbYhaSfEOHoeEHPGD3lpXZU9gCQRLjvLb0aTfmO7Du+IOgNDvddUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519648; c=relaxed/simple;
	bh=ICsuZZyph/qsEnfoSNGWrzYVLZXRVSY8ETWfLPWNqKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKWhaLSO6oZ+sHHAaFVo4Z1q846KPZgNb+fTxtTBQ85yMDnKtVCbhsLSuSiA9yvruhc9jbjlAXJJhy+B7k8JXN+IBivzvA5NrrhiZxXd+3EvwYYKLmuqOWV6DuB2wU+8eGODX+/OKwdFHy8l8DTDP5mHYizsh/D4GPavHYclncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oe/k0raP; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCF1C40006;
	Tue,  9 Jul 2024 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720519644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwHOPxVN4WzseMpm8k0NEmyddjr++H2IEYNI4aIOG2w=;
	b=oe/k0raPnNXaUjvo1qgcMND8z4lYzFd77vEx22BFr4I+SfCOCKnFSNcHBsgXEGaLjPa0BX
	f276Q+22/Q1eHMvACRuBT1Eu/oreIJRF2DXWTMTTKKYvx8e9z+vRYVF76JT5btkfXIRjbO
	y/dxwe5dO9+VoSIiHBDd82PCW2bx8MOOeaa3ZcJw+M5JEGVO4gZvYkjW7ToF6tIVwz3H0h
	Ih5bxYpwUeoZ48bw0mcQBD7o8PKGVR1JX6irNBBD22tk3zGsz55UJoUnuq7JbGeijZauph
	vBT+98dYAk4Ha0uvtRtCLZ+LoUpYP0vdi8dPmGyTNDF6HCmIsTISGuXHpDHLHA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 09 Jul 2024 12:07:18 +0200
Subject: [PATCH v3 3/5] dt-bindings: riscv: Add Sipeed LicheeRV Nano board
 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-sg2002-v3-3-af779c3d139d@bootlin.com>
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

Document the compatible strings for the Sipeed LicheeRV Nano B board which
uses the SOPHGO SG2002 SoC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 9bc813dad098..a14cb10ff3f0 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -26,6 +26,11 @@ properties:
           - enum:
               - sophgo,huashan-pi
           - const: sophgo,cv1812h
+      - items:
+          - enum:
+              - sipeed,licheerv-nano-b
+          - const: sipeed,licheerv-nano
+          - const: sophgo,sg2002
       - items:
           - enum:
               - milkv,pioneer

-- 
2.45.2


