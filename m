Return-Path: <linux-kernel+bounces-169610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E98BCB30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2612F282DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776A145338;
	Mon,  6 May 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBhdQxei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99C144D03;
	Mon,  6 May 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988990; cv=none; b=VCDFLdZV07oucZvKCYepd2nwIck1k/3Cp4opyO98p+mrOE+p7hDPpamQSdXDZqXEAx/AWwaIr84kilv2xtEmWxhZUdOxS9YX7YK3EoDgZyEIQwv1xP8cPMFxRi6cGCb0LuioHVc82oSGkLfWjSOcZBvBznhYVEqMogOlCl0kmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988990; c=relaxed/simple;
	bh=LZLJVc9pYCHgTinDxt8jQL+ros/h+Mn8XlRPuxpUeDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IntabqgXk2CvamKFP0AEZwbDeWb2AjAH21jIGy1GgZDDwKVkYIcUw49K2QsDutBu/yg6vqh+W+LuCVkKJb3y8XvSTcDkMaMm2x223ojzD6OnMkrDOaln8EBupDfgzdc2PEIkzfklKEW2txbicmponNY41wCvhuyk99rOQ9T1FnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBhdQxei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 874B4C116B1;
	Mon,  6 May 2024 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714988989;
	bh=LZLJVc9pYCHgTinDxt8jQL+ros/h+Mn8XlRPuxpUeDk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LBhdQxeiNhcMwOF3GRwD+JJF+iJe6uII8wrTniw7U1OHKzKw5latzw2RdpfSp3ysn
	 Z37NGA82w0LhYn4WN0n1FnSK7SHbHYZIWSvSnNa2q7yqNte1VjirD84hgbQgeloALD
	 zmXoAqU2G14fq8mVy7FcsjvNAR/AnOBWJskoZ6WZCIjr9+ILbeaZLY31rmiGtnvcHc
	 RBp7Bdcziz+hNR6d7x2ixU6L1LjWOJ9zLqcYqnrbkbr9WMGysnV2S56w8LKdwhXLjg
	 NrTV9vSIsE72oS+QyUr2cXKB9RY2OdRtCN9wN0rGIMKFJEg4XptVOHLQbfGIYR+dZ0
	 eTnkkhBGMznWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF76C10F16;
	Mon,  6 May 2024 09:49:49 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH RESEND v2 0/4] DONOTMERGE: ep93xx-clk from ep93xx device
 tree conversion
Date: Mon, 06 May 2024 12:49:47 +0300
Message-Id: <20240408-ep93xx-clk-v2-0-adcd68c13753@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988988; l=2237;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=LZLJVc9pYCHgTinDxt8jQL+ros/h+Mn8XlRPuxpUeDk=;
 b=9/KPOFB2kj4JSUtGN0bBC7dHnMlQlJqzK/pDgy7CTZDdR9V+cRVzCJkONlJD5eMoVdbmyTREbuZ5
 hV34J+NzD4cLl+KcCoX+Qx5xMqmQxA3uexviasO3qQ1DhWvc8BmM
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

The goal is to recieve ACKs.

This is a fraction of v9 "ep93xx device tree conversion" series:

https://lore.kernel.org/all/20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me/

The clk driver for ep93xx was converted to AUX device, as suggested
originally by Stephen Boyd.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v2:
- soc: Add SoC driver for Cirrus ep93xx:
  - added __init for ep93xx_adev_alloc(), ep93xx_controller_register()
  - added static, __initconst for pinctrl_names[]
  - clk revision for SPI is now resolved here through differently named
    clk device
  - more verbose Kconfig description

  NOTE: "of" includes are required unfortunately.

- clk: ep93xx: add DT support for Cirrus EP93xx:
  - dropped includes
  - dropped ep93xx_soc_table[]
  - add different named clk and dropped involved includes
  - moved pll's and fclk, hclk, pclk init to separate function
  - fixed ep93xx_clk_ids[] explicit lines

  NOTE: clk_hw_register_div() is clk-ep9xx internal function which uses
  devm.

---
Nikita Shubin (4):
      ARM: ep93xx: add regmap aux_dev
      clk: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: soc: Add Cirrus EP93xx
      soc: Add SoC driver for Cirrus ep93xx

 .../bindings/arm/cirrus/cirrus,ep9301.yaml         |  38 +
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |  94 +++
 drivers/clk/Kconfig                                |   8 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ep93xx.c                           | 834 +++++++++++++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/cirrus/Kconfig                         |  17 +
 drivers/soc/cirrus/Makefile                        |   2 +
 drivers/soc/cirrus/soc-ep93xx.c                    | 252 +++++++
 include/dt-bindings/clock/cirrus,ep9301-syscon.h   |  46 ++
 include/linux/soc/cirrus/ep93xx.h                  |  26 +
 12 files changed, 1320 insertions(+)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240408-ep93xx-clk-657a1357de67

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>



