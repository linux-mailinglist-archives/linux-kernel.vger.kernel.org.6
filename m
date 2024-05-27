Return-Path: <linux-kernel+bounces-189908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D18CF6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AB71F21A14
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C502F2B;
	Mon, 27 May 2024 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OO0Xun4T"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5E4A1E;
	Mon, 27 May 2024 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716768512; cv=none; b=REf9WzenUuJl+SgBMIa91cluJiSqIv+vbBCq5WXnWmh5iVpeGzxIqoYze+ihNWUSbUrYQFn6wxNN4wmd8USpq/U7nKg6SeZgeiOxERKZx/eKbb8zXMXjkeJgsgKJn/q5ilBXnE2Tk/ivoNuRVQBZ+PuKhxi0KiSdmLdaxQNvM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716768512; c=relaxed/simple;
	bh=GnuAX0nDr0CKzPeHsMUQAbm8VYw3un4r2a9LUG+ssPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGISOBriU596KT2q/0+OA/guYnxGmLgE9zZuybOTHUOI6qGAEakOoEDB0gb8UF4FRUjrCybkkndVYfQHNybhzvbUEW6UPMnwjVISR+IIgJjRHu2izrks3WJtFyLbZth+KyfwutT95n4tnBP22hWTsCOzHgHgkUgzj37snJSj3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OO0Xun4T; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716768506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mGV1bJ7uirDC6E+UW16NvOjsfXec5LdTaeXF3VVLlOo=;
	b=OO0Xun4TpC1VlHyojkP/5DPL48+z7xVCiE1skzSjSH4K4zO2qqZJ1Me1rgCe6rgXaLThxb
	CvlKCqJpv6lFajh+ZqAtHnOCWIROHSMQEwRsVfKpYzGSvDwYYU1z5Yq2qzy8MpySqkLLGi
	znK+1/dJd5fSj8cisV/3mgTgkFKp2iYzeYwt6+2vRJkIq4Lx6z9Fg0B6KXDEgLM8fslMhN
	8yXvxVCHeimUQ8hPBIOv+Ifm+ftW1faqhT9y6tTCz6byQao1R2oCBoyKUACXPU1vDX3Kvx
	VTtidY6OPBVcRuIPkJ6gdLWNsDNL3inSr1whN+Wb1KDxVzzCR8L+aRu0OMp3pw==
To: linux-sunxi@lists.linux.dev
Cc: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	uwu@icenowy.me,
	andre.przywara@arm.com,
	didi.debian@cknow.org
Subject: [PATCH v2 0/2] Correct the model names and descriptions for Pine64 boards
Date: Mon, 27 May 2024 02:08:16 +0200
Message-Id: <cover.1716768092.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series corrects and, in a couple of cases, additionally simplifies
a bit the model names and the descriptions of a few Pine64 boards and
devices based on Allwinner SoCs, according to their official names used
in the Pine64 wiki and on the official Pine64 website. [1][2][3]

These corrections ensure consistency between the officially used Pine64
board names and the names and descriptions in the source code.  These
changes complete the correction of the model names and descriptions of
the Pine64 boards and devices, which was started earlier with the Pine64
boards and devices based on Rockchip SoCs. [4][5]

Changes to the model names may cause certain issues if some scripts misuse
/proc/device-tree/model to detect the board they're executed on.  Though,
the right way to detect a board is to use /proc/device-tree/compatible
instead, because its contents is part of the ABI.  Such scripts, if they
actually exist in the field, should be improved to use the right way to
detect the board model.

Link to v1: https://lore.kernel.org/linux-sunxi/d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org/T/#u

Changes in v2:
  - Introduced this cover letter, partially by absorbing the notes from
    the original versions of the individual patches
  - Collected a couple of tags, which should still apply after the v2
    changes described in the following bullet point
  - As pointed out by Icenowy [6] and Andre, [7] historical and factual
    accuracy trumps the naming consistency; after checking with Pine64,
    it was concluded not to perform any retroactive naming cleanups, but
    to preserve the history, so the v2 switches to the historically and
    factually accurate board names, and introduces a few additional naming
    corrections, for completeness
  - Adjusted the patch descriptions according to the v2 changes

[1] https://wiki.pine64.org/wiki/PINE_A64
[2] https://wiki.pine64.org/wiki/PINE_H64
[3] https://pine64.org/devices/
[4] https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org/
[5] https://lore.kernel.org/linux-rockchip/06ce014a1dedff11a785fe523056b3b8ffdf21ee.1713832790.git.dsimic@manjaro.org/
[6] https://lore.kernel.org/linux-sunxi/057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me/
[7] https://lore.kernel.org/linux-sunxi/20240522110507.51b12966@donnerap.manchester.arm.com/

Dragan Simic (2):
  dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
  arm64: dts: allwinner: Correct the model names for Pine64 boards

 Documentation/devicetree/bindings/arm/sunxi.yaml | 16 ++++++++--------
 .../boot/dts/allwinner/sun50i-a64-pine64-lts.dts |  2 +-
 .../dts/allwinner/sun50i-a64-pine64-plus.dts     |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pine64.dts     |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts   |  2 +-
 .../sun50i-a64-pinetab-early-adopter.dts         |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts    |  2 +-
 .../allwinner/sun50i-a64-sopine-baseboard.dts    |  2 +-
 .../dts/allwinner/sun50i-h6-pine-h64-model-b.dts |  2 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts    |  2 +-
 10 files changed, 17 insertions(+), 17 deletions(-)

Range-diff against v1:
1:  8deaf9d7d1b7 ! 1:  84cd1c708637 dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
    @@ Commit message
         dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
     
         Correct the descriptions of a few Pine64 boards and devices, according
    -    to their official names used on the Pine64 wiki.  This ensures consistency
    -    between the officially used names and the names in the source code.
    +    to their official names used in the Pine64 wiki and on the official Pine64
    +    website. [1][2][3]  This ensures consistency between the officially used
    +    names and the names in the source code.
     
    +    [1] https://wiki.pine64.org/wiki/PINE_A64
    +    [2] https://wiki.pine64.org/wiki/PINE_H64
    +    [3] https://pine64.org/devices/
    +
    +    Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
         Cc: Marek Kraus <gamiee@pine64.org>
         Signed-off-by: Dragan Simic <dsimic@manjaro.org>
     
    -
    - ## Notes ##
    -    This completes the correction of the descriptions of the Pine64 boards
    -    and devices, which was started with the Pine64 boards and devices based
    -    on Rockchip SoCs. [1]
    -
    -    [1] https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org/
    -
      ## Documentation/devicetree/bindings/arm/sunxi.yaml ##
     @@ Documentation/devicetree/bindings/arm/sunxi.yaml: properties:
    +           - const: olimex,a64-teres-i
    +           - const: allwinner,sun50i-a64
    + 
    +-      - description: Pine64
    ++      - description: Pine64 PINE A64
    +         items:
    +           - const: pine64,pine64
    +           - const: allwinner,sun50i-a64
    + 
    +-      - description: Pine64+
    ++      - description: Pine64 PINE A64+
    +         items:
    +           - const: pine64,pine64-plus
    +           - const: allwinner,sun50i-a64
    + 
    +       - description: Pine64 PineCube
    +         items:
    +           - const: pine64,pinecube
                - const: sochip,s3
                - const: allwinner,sun8i-v3
      
     -      - description: Pine64 PineH64 model A
    -+      - description: Pine64 H64 Model A
    ++      - description: Pine64 PINE H64 Model A
              items:
                - const: pine64,pine-h64
                - const: allwinner,sun50i-h6
      
     -      - description: Pine64 PineH64 model B
    -+      - description: Pine64 H64 Model B
    ++      - description: Pine64 PINE H64 Model B
              items:
                - const: pine64,pine-h64-model-b
                - const: allwinner,sun50i-h6
      
     -      - description: Pine64 LTS
    -+      - description: Pine64 A64 LTS
    ++      - description: Pine64 PINE A64 LTS
              items:
                - const: pine64,pine64-lts
                - const: allwinner,sun50i-r18
    @@ Documentation/devicetree/bindings/arm/sunxi.yaml: properties:
                - const: allwinner,sun50i-a64
      
     -      - description: Pine64 SoPine Baseboard
    -+      - description: Pine64 SOPine
    ++      - description: Pine64 SOPINE
              items:
                - const: pine64,sopine-baseboard
                - const: pine64,sopine
2:  fe5c35b78bef ! 2:  4a988518e0db arm64: dts: allwinner: Correct the model names for Pine64 boards
    @@ Commit message
         arm64: dts: allwinner: Correct the model names for Pine64 boards
     
         Correct the model names of a few Pine64 boards and devices, according
    -    to their official names used on the Pine64 wiki.  This ensures consistency
    -    between the officially used names and the names in the source code.
    +    to their official names used in the Pine64 wiki and on the official Pine64
    +    website. [1][2][3]  This ensures consistency between the officially used
    +    names and the names in the source code.
     
    +    [1] https://wiki.pine64.org/wiki/PINE_A64
    +    [2] https://wiki.pine64.org/wiki/PINE_H64
    +    [3] https://pine64.org/devices/
    +
    +    Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
         Cc: Marek Kraus <gamiee@pine64.org>
         Signed-off-by: Dragan Simic <dsimic@manjaro.org>
     
    -
    - ## Notes ##
    -    This completes the correction of the model names of the Pine64 boards
    -    and devices, which was started with the Pine64 boards and devices based
    -    on Rockchip SoCs. [1]
    -
    -    These improvements may cause certain issues if some scripts misuse
    -    /proc/device-tree/model to detect the board they're executed on.  Though,
    -    the right way to detect a board is to use /proc/device-tree/compatible
    -    instead, because its contents is part of the ABI.  Such scripts, if they
    -    actually exist in the field, should be improved to use the right way to
    -    detect the board model.
    -
    -    [1] https://lore.kernel.org/linux-rockchip/06ce014a1dedff11a785fe523056b3b8ffdf21ee.1713832790.git.dsimic@manjaro.org/
    -
      ## arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts ##
     @@
      #include "sun50i-a64-sopine-baseboard.dts"
      
      / {
     -	model = "Pine64 LTS";
    -+	model = "Pine64 A64 LTS";
    ++	model = "Pine64 PINE A64 LTS";
      	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
      		     "allwinner,sun50i-a64";
      
     
    + ## arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts ##
    +@@
    + #include "sun50i-a64-pine64.dts"
    + 
    + / {
    +-	model = "Pine64+";
    ++	model = "Pine64 PINE A64+";
    + 	compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
    + 
    + 	/* TODO: Camera, touchscreen, etc. */
    +
    + ## arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts ##
    +@@
    + #include <dt-bindings/gpio/gpio.h>
    + 
    + / {
    +-	model = "Pine64";
    ++	model = "Pine64 PINE A64";
    + 	compatible = "pine64,pine64", "allwinner,sun50i-a64";
    + 
    + 	aliases {
    +
      ## arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts ##
     @@
      #include <dt-bindings/pwm/pwm.h>
    @@ arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
      
      / {
     -	model = "SoPine with baseboard";
    -+	model = "Pine64 SOPine on Baseboard carrier board";
    ++	model = "Pine64 SOPINE on Baseboard carrier board";
      	compatible = "pine64,sopine-baseboard", "pine64,sopine",
      		     "allwinner,sun50i-a64";
      
     
      ## arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts ##
     @@
      /delete-node/ &reg_gmac_3v3;
      
      / {
     -	model = "Pine H64 model B";
    -+	model = "Pine64 H64 Model B";
    ++	model = "Pine64 PINE H64 Model B";
      	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
      
      	wifi_pwrseq: pwrseq {
     
      ## arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts ##
     @@
      #include <dt-bindings/gpio/gpio.h>
      
      / {
     -	model = "Pine H64 model A";
    -+	model = "Pine64 H64 Model A";
    ++	model = "Pine64 PINE H64 Model A";
      	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
      
      	aliases {

