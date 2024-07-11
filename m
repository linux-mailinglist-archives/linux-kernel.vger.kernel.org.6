Return-Path: <linux-kernel+bounces-248930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFDD92E3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DA21F22083
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C69158D74;
	Thu, 11 Jul 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DhW5kMsQ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF3157A61;
	Thu, 11 Jul 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692104; cv=none; b=JJvw228SFWxXIzH1ro6UlIslLQbyuHZ70ACY36CPcFh1xYeXuheIT7OveQZGFTzZozl4fZgeXgJAcgXOPrcchaDc+lCFaLu3u0El2EmNNNqbu+A2Kx4tBPVw/a0NKNbjOJTUCxJPRFGkhbvfH05RW2T13or7PngJGDszH+mTKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692104; c=relaxed/simple;
	bh=ICsuZZyph/qsEnfoSNGWrzYVLZXRVSY8ETWfLPWNqKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BdmzeE12p7UJP5W9tQJwck0PsB62lQICKdM/pwzaSVt6brGlH/moNxJZjnK9LMwp7NpOPimhnW2VXVRHYZEM4gAbkgGHVsWX2iPs3Lih5tHmKUnDZiRPkDc4opZfZ6ZlWGlctQ9LHxIvo8hLHFXw6BORBDbdWn7Up0QOO2/08nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DhW5kMsQ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6804B24000D;
	Thu, 11 Jul 2024 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720692095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwHOPxVN4WzseMpm8k0NEmyddjr++H2IEYNI4aIOG2w=;
	b=DhW5kMsQ5gn2k2AdT2xXDh9au2QB3+duzTCPwG6MqjA+hdRdO2GwEYQxJJJuffrgmPotH0
	L+Ya3FYdDCD8fiLFtj9JnR0uivlYMN7PPmJeJnEFWm4vpKFigWy7rDLYO6B8+gGNnozqN2
	qM9uL3G4BqoPjUybNkS7SSDmpGBf9em/qWn4zGW11JdEYGt7liy0CA1nJenCb1KXI5EaMM
	+kS+8U6rDlFvyYqCPqlrZVheLXnOVEURlooNIaLSvSyLEdrbIHk4IQDYFZU/QtAstQkPxX
	NwZOPMvjQ78oUUfVteK2y0x1vTkkXS25qv4KhUFScd36Vgpi+11VUvSF+7dJMQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 11 Jul 2024 12:01:29 +0200
Subject: [PATCH v4 2/4] dt-bindings: riscv: Add Sipeed LicheeRV Nano board
 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-sg2002-v4-2-d97ec2367095@bootlin.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
In-Reply-To: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
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


