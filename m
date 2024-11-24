Return-Path: <linux-kernel+bounces-420308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3479D7898
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB5A16336E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4D118CBE1;
	Sun, 24 Nov 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZGG7rOo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BB17E00F;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487382; cv=none; b=eYKSJaqcnKs5TCJRHyQUQFzkA1bAaqIlIW0Ir1kUdEbmGLZq1TiKkmsqir5AXYkDd4RJQkDeiM3HznuNvl8R2KqixGXN2f6YWprPOGER5GMV6ZjPSk7QZsd6gt/C2BFzr6L9gbijM7DWXzMmb6eOFcdSh8DW5A7NGBKq3LwCeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487382; c=relaxed/simple;
	bh=8Hp9HnlSkudhEMoVTtPB8Mqq7buNaH8Vu6szhwn5uHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kPPaJNEeI6OOU7AvXaK3evhEVKFHx0M+Lzk3qVmdtJhcYlOAVRZTXgiXYKivXedRAjA9AxNXQtg/qKivEvx0y4+eZqkqhTySjpPlpbGMUt7J9u58PPkQS2cFOaPhUeqerG0VsQkB9uYxXD+MgCU+nbqIZZN5pibcXGQZNBZ5Qfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZGG7rOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68FCAC4CEDD;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732487381;
	bh=8Hp9HnlSkudhEMoVTtPB8Mqq7buNaH8Vu6szhwn5uHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UZGG7rOoUb2MQ5pq0RCgDVD0Uh4+J0lOKGx/2DGhvGu353804u3G9PeRttjYaaK1R
	 sIlF8MKTx4qiCvWgR36Y51xcGHiMhJa7JnXv67wWN4UqUAdkIPRYNn1gXuX0Lba+AN
	 MlPPclHkzD/1KRGxuZqeIy5rKh1m4xuYlUf6fnpXMfi+t4fV3nCen295fy9k3DVHKo
	 qQ3A4PUhAsU5tYBrM1hZHEvusSiMR/gUJOr+ynwe795p5grgl5bzNkDa8qYXGDYJyP
	 80SKszzwUJ6uNkIsTlDUeGscTpO79fnANpJsmGV1LCEpg6mSSDYQMDxaRiDXnZtagM
	 65DlIgKz062ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A195E6ADEC;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Sun, 24 Nov 2024 23:29:28 +0100
Subject: [PATCH 5/5] MAINTAINERS: Add entries for touchbar display driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-adpdrm-v1-5-3191d8e6e49a@gmail.com>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
In-Reply-To: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732487379; l=1179;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=Zo6z/5ObW5tpoXAd3EL3OeGr9DmJcirQwYT2c5Ljs0k=;
 b=6a+DIWi9GClhX0WByRx54Ur2Q/eMDyfO7632pcDcXF4uq+86V0QRMTAU2VoDMJFZXp6aXA2vH
 AXSUleowlhlDLrepwdiuHmpzTO0gZBEA6pKVWIu+/+sOFSB104Z0Kju
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7f0170977013889ca7c39b17727ba36d32e92dc..1964bb705cae0b0f12e2174fc96c5cd123d31520 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2164,6 +2164,7 @@ F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
+F:	Documentation/devicetree/bindings/display/apple,display-pipe.yaml
 F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
@@ -2183,6 +2184,7 @@ F:	drivers/bluetooth/hci_bcm4377.c
 F:	drivers/clk/clk-apple-nco.c
 F:	drivers/cpufreq/apple-soc-cpufreq.c
 F:	drivers/dma/apple-admac.c
+F:	drivers/gpu/drm/adp/
 F:	drivers/pmdomain/apple/
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c

-- 
2.47.0



