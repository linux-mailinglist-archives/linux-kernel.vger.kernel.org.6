Return-Path: <linux-kernel+bounces-211138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2E904D98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DBA2859AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8EA16DEB9;
	Wed, 12 Jun 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P9tFBfnz"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9D16D4E0;
	Wed, 12 Jun 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179559; cv=none; b=tde1LvOq1oGn5tsewJ0CcOIGm8BAFlzi6Qirqa904OeAToOiCrHLyL9dnnTdv/ei2KU42KzqkgIitLuWEs8NZW59ES2A0vlZunsPW085PGMpe8xNU/sxXCHtwv8wz3H32KvX/qSAW8EkL7MGVtY8pa2VcAM8SikT0NsVmkQCwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179559; c=relaxed/simple;
	bh=YBCJCug0PqpqgehXQQ8lDMJr5QCEyM6dQDI5d07jY+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kymt6ijbT/3nn8Fkg2wvO31DiBX4rebg/oIgtP+IAU2bJG348DQP8KNx+gGqWB2h0qO0hLxhDwkyAyE3PSmpi7gbFch/7r7/pohj9XASSNK5m5RIs8xCmzreGda/lITZmAwc6K/xZPmJt63HvQ9vZYOnYa5p/FyJwJrK4yUDY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P9tFBfnz; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B01AE1C0012;
	Wed, 12 Jun 2024 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718179555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qogXr6ddO0luZy08/pVi3ZqQWm4G2tT89hV2cFdiuz4=;
	b=P9tFBfnzjcd/yUAnh1Kg7TmT7TfTQJHL2DGw+MGqNWOxQHk5QVf6p3aG9Fhdtj2cUBdXsg
	GzO27Vbsg7QCxsFzx9YhkEUzyWXdNzYANE6hxlaGS8Fs+qTOlbwcek8YbB5vqSjJFKkFOh
	jp+yhpRjUfwt6hS0+Qiiynl99wqEAetVIPLFw96NnOq7XwQROx+Mu0jReqkPRKz5pPULqm
	2OKBBHQ0F9qwhholJnCuZDusdmwARq+liSmJfNYmHF91C68jbASSAp/fLNTSIrSt66p/P2
	qmpbrfm4A61evlbZxj789Sp0JRQfXohfGZEz1gIAQzul8N1k6DPKnFo0CfVFIQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 12 Jun 2024 10:02:34 +0200
Subject: [PATCH v2 4/6] dt-bindings: riscv: Add Sipeed LicheeRV Nano board
 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-sg2002-v2-4-19a585af6846@bootlin.com>
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

Document the compatible strings for the Sipeed LicheeRV Nano B board which
uses the SOPHGO SG2002 SoC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
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


