Return-Path: <linux-kernel+bounces-313119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817B96A080
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F17C1F274A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83FC186E46;
	Tue,  3 Sep 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7DBTHRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD413E025;
	Tue,  3 Sep 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373606; cv=none; b=S6Ds2DBa190ItMekRd6JTTU6/05yg6OUu8SoMtqcBifyhVTpfmyzMTPlHwJIxa0bAhdtvLaZ37Agh6jbVDwKWfE85NXtkD4HcdQIzhxO6Su7aAJAc3TKZanvfh2/1mIdUGslPtdefPbmAV29RTbS4bOSuQlBVVUyOeRJBwZab0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373606; c=relaxed/simple;
	bh=hmFoSGTvmdZFU/qqfZd3fm3KxnXqO+nlF2DC3CWhBJ0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=obniWb49KS/P6U5JIivjMsgOG/N/u5PUe8DyZabjFx12yNamQqoDtm+XS1SkLTmFJGv+E6NP1BSKmXp1a/M7sS9GCcOKYoTQlRXHBkUDgyZYI2Bg/GqqmUEG0HQNt182zLJy3HB62VpjmAfsYVB8+J9Neddg+MQ1RL0Ksi8+Xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7DBTHRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966EFC4CEC7;
	Tue,  3 Sep 2024 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373605;
	bh=hmFoSGTvmdZFU/qqfZd3fm3KxnXqO+nlF2DC3CWhBJ0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=J7DBTHRE/sxChmS/y2I+pn79el/kL5ZxGR7BqdriNzqHutAlinRliHZjSrI2WMdaK
	 DPPbkMv+rlaCYttAAGuqGkBlvCat/OF1rCX29Lcp6LEHreZQwRlFJFt5oGgkpoMEvx
	 XR/UCOxNuHyQwLfBmwG8TWc9k8rX43xhWPyRrSziQXqpO+ILXAR/0n4ypgkwGdKvHF
	 YjfmpBt9fHpEot5H/cr4oZCJm2IYUZT3L+2yN43kz5qRprMin292AzIyIZC0E1yhPJ
	 5WbzHbRUEpgMXJvotdbuWsHobPwKX2ecYfeCkAY8Iuojyizzj1dkjtBSFM2b2l5s2K
	 Va0QO95Lt9HUw==
Date: Tue, 03 Sep 2024 09:26:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, shawnguo@kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
References: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
Message-Id: <172537334994.875077.18308965320836312656.robh@kernel.org>
Subject: Re: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support


On Tue, 03 Sep 2024 14:47:20 +0530, Tarang Raval wrote:
> Add following peripherals support for the Emtop i.MX8M Mini Baseboard
> 
>         * Wi-Fi
>         * Audio
>         * SD card
>         * RTC
>         * CAN bus
>         * USB OTG
> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
> ---
> 
> Changes in v2:
> 
> 1. Updated the node name and pinctrl name.
> 2. Removed the 'regulators' container.
> 3. Removed a stray blank line.
> 4. Removed non-existent properties.
> 5. Removed unused node and pinctrl:
>    -modem-reset
>    -pinctrl_uart1
> 6. Defined the CAN transceiver reset GPIO separately.
> 
> Change in v3:
> 
> 1. Removed 'can-connector'.
> 2. Use USB connector instead of extcon_usb.
> 3. Changed id-gpio to id-gpios.
> 4. Use Level trigger IRQ in the CAN node.
> 5. Corrected the compatible property of RTC.
> 6. Added blank lines to separate the pinctrl groups.
> 
> Changes in v4:
> 
> 1. Sorted I2C device nodes by slave address.
> 2. Moved properties above the "status" property in the Wi-Fi node.
> 
> Change in v5:
> 
> 1. I mistakenly removed <pinctrl-canbus>; it has now been re-added.
> 2. Added Author name
> ---
>  .../dts/freescale/imx8mm-emtop-baseboard.dts  | 335 ++++++++++++++++++
>  1 file changed, 335 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y freescale/imx8mm-emtop-baseboard.dtb' for 20240903091720.443091-1-tarang.raval@siliconsignals.io:

arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dtb: /soc@0/bus@30800000/spba-bus@30800000/spi@30830000/can@0: failed to match any schema with compatible: ['microchip,mcp2515']






