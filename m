Return-Path: <linux-kernel+bounces-577434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F70A71D04
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EB7189877B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA20202C2D;
	Wed, 26 Mar 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OWNm/UGP"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655620298A;
	Wed, 26 Mar 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009561; cv=none; b=K9IvrJqNFF2/eYs84eLM8AedJDXvK5IrzQxgSyaaUvPXUDLoPbvLszMoUSastjmZSHkZB7POvgwoxvbFnDH9fp54guxBMkwulADh4verV7+TBj0XevENDrnYsS0JhQtTe4Li4S+yti+NRYbXzn6hwV1QkkAoulaYk8OkkfGF4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009561; c=relaxed/simple;
	bh=Gj4nxgot6/aGs/lQlFZMZKLoOBQQONhPMDtSv/okADk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZYq4ry6Dgox0TUqdBV6En/iSFD3KiWyM4s0shOewNeESX77+lZAk+FA2SFPQTtSvilG0DtRvTeE+SVF22z9aoYqQWZChBpEm+SIX6QDDGkizkXz9eTKFrsmc5RbvYnUbTqTADKTaW/kTbZcg0UkfIVJW2JZyDVhz7Y9+TUMZFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OWNm/UGP; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2C0D101CA7F1;
	Wed, 26 Mar 2025 18:19:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743009557; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ifsa7+R78g8/kHGIkkfPyyGOifXMv1ZjJMomcIQic3A=;
	b=OWNm/UGPFpyFpLKoTsyoe9vN3D6kfvqB3hcPJlwVifWyfgjPnp7RMx/wGq9dt/pGhwY8t/
	ds0Apv8SkVacaXAmE0bRzcf3cttyR5EbBl7PiDYaPkMA5Mf8TF561e0/OGk0mVvfCm17am
	K4xHegWu2w85xaQZ7USohGRKFuOh6f6p5rqhq9Xmzrs3Bq+fUlYQbCXw/B0NXnnrIn1nte
	F80VzrsgON/9CPohCtEb0l6wrbF0A7u+r+gIilNRHpW5D1QapgaXRxYyj/Rwh/FD+TkZGB
	kbrWq7a1GZ2RlmbmL1dIYOZubvnET9uRAnDHUJ9qr49A1zkRGXcR2syxaAdRcA==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Michal Simek <michal.simek@amd.com>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] dt-bindings: trivial-devices: Document SPI measurement on LWE boards
Date: Wed, 26 Mar 2025 18:18:38 +0100
Message-Id: <20250326171838.2689448-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250326140930.2587775-1-lukma@denx.de>
References: <20250326140930.2587775-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The measurement device on Liebherr's (LWE) boards is used to monitor
the overall state of the device. It does have SPI interface to
communicate with Linux host via spidev driver. Document the SPI DT
binding as trivial SPI device.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Use already in-kernel available 'lwn' vendor prefix instead of introducing
  a new one
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8da408107e55..1e37144e7017 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -161,6 +161,8 @@ properties:
           - jedec,spd5118
             # Linear Technology LTC2488
           - lineartechnology,ltc2488
+            # Liebherr on-board measurement SPI device
+          - lwn,btt
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
             # 10 kOhm digital potentiometer with I2C interface
-- 
2.39.5


