Return-Path: <linux-kernel+bounces-199038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72DB8D810E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76362285F85
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB24184E02;
	Mon,  3 Jun 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHaUDtyi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07482887;
	Mon,  3 Jun 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413716; cv=none; b=crOBK4PSBWdAuM5hn5coVim24OXIn0ts59irzTSNgJlU5ONo/L++V0sNfyRek1HzoiAqVGyGM8GiB1ihTyUf6AMX7jUk4luw0OmD3EYtDUJtsyNp/cRnwr28+yTkPo93xZL/DqEIIfvRqigrTrY9PJxVnCTb0NNr52USAfMpCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413716; c=relaxed/simple;
	bh=gNH7o0uB5n2M8ruKL+VTu1X79iL62sffpOhlGco74wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLxwjqLhI06LHdo91zpcN5RsSMjTxmSIVDq0VwkyeIkYRJ1yC2GmpmdB9c6rLT+rQ6PS/etgFwD4Soo/RtyjbtveeOH72yZsl4dxLcxDrJjgvplW1B0eVJwiOYGTIv1vbRgP8fUoSzZR+IDlX0ZpK/v5ZgqeXubhza1L+P8HTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHaUDtyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F137C32789;
	Mon,  3 Jun 2024 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717413715;
	bh=gNH7o0uB5n2M8ruKL+VTu1X79iL62sffpOhlGco74wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HHaUDtyizsjTRoCz/94lHKMhepKrfZzT4eyuBt7y3PA4Hm/RLqotW9BQ7lfQrlViH
	 EAGuTdjHCVBv2dvYXs+jxMd5ZsqPADjzDYI1QbaoSNidIHfsyd2qOtB4iUvvjhgvpV
	 8EL8TNXmHBDdQvpDsNQvAKpInuktTcjMewmoZYu0t80SF+6Pi/242KM07OS/EzlgPq
	 y/MvzGJ0lyk2WR2fhRFiid3YUYcV2KZuQnMzz/Obd6bF9qAA4lYV/vBnzJm38h2GBt
	 q2r6qY/whvxlXUZ0ifJQGpFauI49trgwLBOb+wwmyxLJJdFStRnMcabY2hpXdY0JTp
	 UmBJu59Yg8LPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78170C25B75;
	Mon,  3 Jun 2024 11:21:55 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Mon, 03 Jun 2024 13:21:32 +0200
Subject: [PATCH v3 1/5] dt-bindings: display: panel: mipi-dbi-spi: Add a
 pixel format property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240603-panel-mipi-dbi-rgb666-v3-1-59ed53ca73da@tronnes.org>
References: <20240603-panel-mipi-dbi-rgb666-v3-0-59ed53ca73da@tronnes.org>
In-Reply-To: <20240603-panel-mipi-dbi-rgb666-v3-0-59ed53ca73da@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717413714; l=4065;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=rqNvjdSCUsjKcYeeCETT/jnXy2Sa85ePgrIqrhCdz9A=;
 b=KfEmNiuP8/F5Bf1ISjNKur1+rckhTra3cwSqtCnHVF15L0X0pppQLet79ChGwcmiHEBMPLSeq
 rzza6UFJCICAaJlxw9tGvv8HUciLjAHzl30hpr3qpTyK3LMZzaGaLdO
X-Developer-Key: i=noralf@tronnes.org; a=ed25519;
 pk=0o9is4iddvvlrY3yON5SVtAbgPnVs0LfQsjfqR2Hvz8=
X-Endpoint-Received: by B4 Relay for noralf@tronnes.org/20221122 with
 auth_id=8
X-Original-From: =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Reply-To: noralf@tronnes.org

From: Noralf Trønnes <noralf@tronnes.org>

The MIPI DBI 2.0 specification (2005) lists only two pixel formats for
the Type C Interface (SPI) and that is 3-bits/pixel RGB111 with
2 options for bit layout.

For Type A and B (parallel) the following formats are listed: RGB332,
RGB444, RGB565, RGB666 and RGB888 (some have 2 options for the bit layout).

Many MIPI DBI compatible controllers support all interface types on the
same chip and often the manufacturers have chosen to provide support for
the Type A/B interface pixel formats also on the Type C interface.

Some chips provide many pixel formats with optional bit layouts over SPI,
but the most common by far are RGB565 and RGB666. So even if the
specification doesn't list these formats for the Type C interface, the
industry has chosen to include them.

The MIPI DCS specification lists the standard commands that can be sent
over the MIPI DBI interface. The set_address_mode (36h) command has one
bit in the parameter that controls RGB/BGR order:
    This bit controls the RGB data latching order transferred from the
    peripheral’s frame memory to the display device.
This means that each supported RGB format also has a BGR variant.

Based on this rationale document the following pixel formats describing
the bit layout going over the wire:
- RGB111 (option 1): x2r1g1b1r1g1b1 (2 pixels per byte)
- BGR111 (option 1): x2b1g1r1b1g1r1 (2 pixels per byte)
- RGB111 (option 2): x1r1g1b1x1r1g1b1 (2 pixels per byte)
- BGR111 (option 2): x1b1g1r1x1b1g1r1 (2 pixels per byte)
- RGB565: r5g6b5 (2 bytes)
- BGR565: b5g6r5 (2 bytes)
- RGB666: r6x2g6x2b6x2 (3 bytes)
- BGR666: b6x2g6x2r6x2 (3 bytes)
(x: don't care)

v2:
- Use 'default: r5g6b5' (Rob)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 .../bindings/display/panel/panel-mipi-dbi-spi.yaml | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index e808215cb39e..8994549b4bff 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -50,6 +50,12 @@ description: |
       |        Command or data         |
       |<D7><D6><D5><D4><D3><D2><D1><D0>|
 
+  The standard defines one pixel format for type C: RGB111. The industry
+  however has decided to provide the type A/B interface pixel formats also on
+  the Type C interface and most common among these are RGB565 and RGB666.
+  The MIPI DCS command set_address_mode (36h) has one bit that controls RGB/BGR
+  order. This gives each supported RGB format a BGR variant.
+
   The panel resolution is specified using the panel-timing node properties
   hactive (width) and vactive (height). The other mandatory panel-timing
   properties should be set to zero except clock-frequency which can be
@@ -90,6 +96,28 @@ properties:
 
   spi-3wire: true
 
+  format:
+    description: >
+      Pixel format in bit order as going on the wire:
+        * `x2r1g1b1r1g1b1` - RGB111, 2 pixels per byte
+        * `x2b1g1r1b1g1r1` - BGR111, 2 pixels per byte
+        * `x1r1g1b1x1r1g1b1` - RGB111, 2 pixels per byte
+        * `x1b1g1r1x1b1g1r1` - BGR111, 2 pixels per byte
+        * `r5g6b5` - RGB565, 2 bytes
+        * `b5g6r5` - BGR565, 2 bytes
+        * `r6x2g6x2b6x2` - RGB666, 3 bytes
+        * `b6x2g6x2r6x2` - BGR666, 3 bytes
+    enum:
+      - x2r1g1b1r1g1b1
+      - x2b1g1r1b1g1r1
+      - x1r1g1b1x1r1g1b1
+      - x1b1g1r1x1b1g1r1
+      - r5g6b5
+      - b5g6r5
+      - r6x2g6x2b6x2
+      - b6x2g6x2r6x2
+    default: r5g6b5
+
 required:
   - compatible
   - reg
@@ -116,6 +144,8 @@ examples:
             reset-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
             write-only;
 
+            format = "r5g6b5";
+
             backlight = <&backlight>;
 
             width-mm = <35>;

-- 
2.45.1



