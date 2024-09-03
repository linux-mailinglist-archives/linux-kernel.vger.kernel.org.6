Return-Path: <linux-kernel+bounces-313843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C096AAA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9701F21895
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F25F1D460A;
	Tue,  3 Sep 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0kNoqLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AF1CF7CF;
	Tue,  3 Sep 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400345; cv=none; b=F169UBi0+PBofwHLLhmTVySc8WLsjvwe3jGmiRb5lE4GCb3iHqySS3Ritp1481vmZ3Aj9KcgenD1heL0XobVMcHOH0vznyXC9I4Uf1Q2UzXktNZATqMQdAYgheviam15QW9fd+A6fwbgN6LozB8B4BECYwsi0tgIlRTGwWi6YNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400345; c=relaxed/simple;
	bh=oeEqTWA9UzdfLhBymYvMHY+ymYpMcEoH48Z3ze7qIQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KY+09UzlZmKta3m6YLrtRV+B1Qk9O7wKJQv5xMW1JgGVcwwuLC7RRNuzTZV6eQdew4gIcLNHnhKSFX66njqoOAcBTCGyOO12bMjD9EVC8q4DfnXrmRKcl8AlEUf3UbeRLYh5P17Wjt+eWX6I/FfQFVR1aHc3oxaXcKZfValj0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0kNoqLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F13AC4CECC;
	Tue,  3 Sep 2024 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725400345;
	bh=oeEqTWA9UzdfLhBymYvMHY+ymYpMcEoH48Z3ze7qIQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T0kNoqLT2nzOjyM8bz+Oy90NiZwsUBcMwegWa6btmOSLYLy+rkbvDzB2ShzEY3N4S
	 ofSMN0uUUNZFU8lIchfBmp9kmrlyVujzyJt5Pr+SgTNVb3DlHnpDcgNwueRZZTO/0S
	 A2Fd9SbCDunwmdVjWGvZPbtBO+XxqnpRT8tyKs0zYeX9ysbTkMXSuOHhqHPlGycbMa
	 aeHBA1fbbs5ozul61QKSWCKoHAHj8QB+p6yhaPSOcMMd+RaxQ0mnZdA0q0ghwMifwL
	 hRt0quMwMfKjGYebvC49yNY8O49VP0OAqCXhgyhkvKd8yt7hLSGD37V/LsQnFpFXeY
	 irrtqn2ztysdw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 03 Sep 2024 16:52:05 -0500
Subject: [PATCH 1/4] dt-bindings: trivial-devices: Drop incorrect and
 duplicate at24 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-dt-trivial-devices-v1-1-ad684c754b9c@kernel.org>
References: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
In-Reply-To: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

"at,24c08" does not have a correct vendor prefix. The correct compatible
string would be "atmel,24c08" which is already documented in at24.yaml.
It is also unused anywhere, so just drop it.

"st,24c256" is already documented in at24.yaml, so drop it as well.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7913ca9b6b54..0cbbc4e0af9c 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -50,8 +50,6 @@ properties:
           - ams,iaq-core
             # Temperature monitoring of Astera Labs PT5161L PCIe retimer
           - asteralabs,pt5161l
-            # i2c serial eeprom (24cxx)
-          - at,24c08
             # i2c h/w elliptic curve crypto module
           - atmel,atecc508a
             # ATSHA204 - i2c h/w symmetric crypto module
@@ -364,8 +362,6 @@ properties:
           - skyworks,sky81452
             # SparkFun Qwiic Joystick (COM-15168) with i2c interface
           - sparkfun,qwiic-joystick
-            # i2c serial eeprom (24cxx)
-          - st,24c256
             # Sierra Wireless mangOH Green SPI IoT interface
           - swir,mangoh-iotport-spi
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface

-- 
2.45.2


