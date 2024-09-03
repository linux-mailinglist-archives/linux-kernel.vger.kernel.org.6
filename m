Return-Path: <linux-kernel+bounces-313844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006696AAA7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36CE1C21280
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1533126C1C;
	Tue,  3 Sep 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj1e7KRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA241D5892;
	Tue,  3 Sep 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400347; cv=none; b=OB0UqAp1sRYgvPzcNomAgCEp2PDbqSfQal9A/DCnQGnSmzRGBJZzrTvlFyARVe+QI8zM7KHxcwLeMxv9zTnMS3dWuVXlXs3x6auHkCQfB6slpzjmywWrybHG19GqEQTE6QmG4std8Kyl6iYWwQ4plA9em4xaCF+LT8LrD4Ix8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400347; c=relaxed/simple;
	bh=8S4c4zt4ntdUgTcQmgkK5k7JKd8v/JUhdUYhKsJck9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdFDi4ioYK4SWeENyrA3WTpmh764rOAvrTSp9hJH5J+sIcnhwZ8lHLUZWw0XcOJysbPgN4FIy+VAxI7zmnwaaRgsG/LGIlBYj+MyHhFyh0N5OOgm+yDZGLxxJ0ZuCkw1OetXnqpsr1nt1jZeNnays54hZRqEzGngtXSsFZITxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj1e7KRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D14C4CEC8;
	Tue,  3 Sep 2024 21:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725400347;
	bh=8S4c4zt4ntdUgTcQmgkK5k7JKd8v/JUhdUYhKsJck9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cj1e7KRH4D2uh8TcUmSyyUznOMuZ29BUZiHwE5+lBhJi33nVHCAe/3khDox682yYD
	 iUuntTGcTOt881CfNF8ze73QUtFsrIJCRFkm/w6qwYSiFXYkkJvnQ+DWZb8QCMAFIJ
	 CETX+wj+cFKQq8XvUFRLzmL8ZRJAUcKbFp4Wos5zWj4DjgAsdfUrJytUOOGiejhnjf
	 V2F9jrNIOjikwBe1wwRwSlYW7Fq1WSgFEy2XxafHjg+oK8r5rRuYTuJTLfBSmj+fW0
	 5kyLgTCEUfFPveujcfAsuo2yxgMYcNu3zrWUnD1AM4tBkVNSSrfQ3oYp2hVfNDFeQQ
	 nFyCJ/qCH08tQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 03 Sep 2024 16:52:06 -0500
Subject: [PATCH 2/4] dt-bindings: trivial-devices: Deprecate "ad,ad7414"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-dt-trivial-devices-v1-2-ad684c754b9c@kernel.org>
References: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
In-Reply-To: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

The correct vendor prefix for Analog Devices is "adi", not "ad". Both
forms are in use. Add the "adi,ad7414" version and deprecate the
"ad,ad7414" version.

Keep them together even though it breaks strict alphabetical ordering.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 0cbbc4e0af9c..79c771a4cd9e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -33,7 +33,8 @@ properties:
             # Acbel fsg032 power supply
           - acbel,fsg032
             # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
-          - ad,ad7414
+          - ad,ad7414  # Deprecated, use adi,ad7414
+          - adi,ad7414
             # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
           - ad,adm9240
             # AD5110 - Nonvolatile Digital Potentiometer

-- 
2.45.2


