Return-Path: <linux-kernel+bounces-374892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47FD9A719B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250221F23415
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577AF1F9EB0;
	Mon, 21 Oct 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCBZtJIw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE01F4FD8;
	Mon, 21 Oct 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533513; cv=none; b=bIO55sx6GnMB7m9oYFtaYIWaIKYlSvTTG/xuFDaEapY3ltB+Lshgij/VEQIn4DdolKc7IpJmNd8IpAHOaaZ/kRjVbNseoh5jQKLlzlAaMn1DY9itYG1qRt39UOOFJvoM5WCLSaTpB1t2n+QRnPdZrqplhdX19nr6hRc2YUX/h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533513; c=relaxed/simple;
	bh=AU1fwaTTVLa71D02ZQ1USonnY5Leg+lK4dyzvIoJ5E0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kFTYri3Xv1G/hC1kLdLwlolN6+F1034iCdIt1ymprAiuFiS8rVbFxGMhHWqaKnY/PWMkpXV1IusTclZ7JLj3MJ66H0HRCgHdTeNh4um0cGhyyh6Kxhb+uXMs2AWIEiMIWUX70EdqnJJZEy0SOhos/a5EejELA7BuDfw3Ys8wUow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCBZtJIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAE0C4CEE7;
	Mon, 21 Oct 2024 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533513;
	bh=AU1fwaTTVLa71D02ZQ1USonnY5Leg+lK4dyzvIoJ5E0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eCBZtJIwgOpyPDEDW5qODnrdHLLYivBHiSizWtHyk300oIZpHtjmqcIzn0kfn+S45
	 uEnFMnpENMH2DYIBVuyCFpOVxnT2M80UJwJJhGSt+0O5gg7hrgq4q4HoLPGIAyav06
	 2Bwj5VA1RwaDg0q67tizNTEO72FXwMJIjiqiMjBRs3cIG+SI11HasazBpkHjKm5HAq
	 ijQMTI+VJpWkQtKbp/EfiIN2vCAyvwauoTiobeLtynhbFgoM1CqXGCtskv+xeNGkpW
	 kVoQUGrlYhgOwz8vCeXCt8ORh7IIBgzoqfsuI2pBUFlgzSSp7vhUfwd6lXFwJEC7VO
	 WvwsUDapCv2DQ==
Date: Mon, 21 Oct 2024 12:58:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Benjamin Tissoires <bentiss@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>, 
 devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
References: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
Message-Id: <172953337296.748240.4918539108990404546.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Using i2c-hid-of-elan driver instead of
 i2c-hid-of driver


On Fri, 18 Oct 2024 13:13:40 +0000, Hsin-Te Yuan wrote:
> After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
> i2c-hid-of"), i2c-hid-of driver resets the touchscreen without having
> proper post-reset delay on OF platform.  From the commit message of that
> commit, not to decribe poset-reset delay in device tree is intended.
> Instead, describing the delay in platform data and changing to use
> specialized driver is more preferable solution.
> 
> Also workaround the race condition of pinctrl used by touchscreen and
> trackpad in this series to avoid merge conflict.
> 
> Adding other second source touchscreen used by some mt8183 devices in
> this series since this should be based on the workaround of pinctrl
> issue.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v2:
> - Add second source touchscreen patches since they should based on the
>   first patch of this series.
> - Link to v1: https://lore.kernel.org/r/20241018-post-reset-v1-0-5aadb7550037@chromium.org
> 
> ---
> Hsin-Te Yuan (4):
>       arm64: dts: mediatek: mt8183: Fix race condition of pinctrl
>       arm64: dts: mediatek: mt8183: Switch to Elan touchscreen driver
>       arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
>       arm64: dts: mediatek: mt8183: willow: Support second source touchscreen
> 
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts |  2 --
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts  |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts   | 12 +++---------
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts   | 11 ++---------
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts   | 11 ++---------
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts   | 11 ++---------
>  .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  3 ---
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi      |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts   |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts  |  3 ---
>  .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi       | 10 +++-------
>  12 files changed, 12 insertions(+), 63 deletions(-)
> ---
> base-commit: eca631b8fe808748d7585059c4307005ca5c5820
> change-id: 20241018-post-reset-ac66b0351613
> 
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
> 
> 
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8183-kukui-jacuzzi-burnet.dtb mediatek/mt8183-kukui-jacuzzi-cozmo.dtb mediatek/mt8183-kukui-jacuzzi-damu.dtb mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb mediatek/mt8183-kukui-jacuzzi-kenzo.dtb mediatek/mt8183-kukui-jacuzzi-pico.dtb mediatek/mt8183-kukui-jacuzzi-pico6.dtb' for 20241018-post-reset-v2-0-28d539d79e18@chromium.org:

arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb: pinctrl@10005000: mmc0-pins-default:pins-clk:mediatek,pull-down-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb: dpi@14015000: power-domains: False schema does not allow [[92, 7]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb: dpi@14015000: power-domains: False schema does not allow [[92, 7]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: dpi@14015000: power-domains: False schema does not allow [[94, 7]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dtb: dpi@14015000: power-domains: False schema does not allow [[92, 7]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dtb: vcodec@17020000: 'assigned-clocks' is a required property
	from schema $id: http://devicetree.org/schemas/media/mediatek,vcodec-encoder.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb: dpi@14015000: power-domains: False schema does not allow [[92, 7]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dtb: dsi@14014000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dsi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dtb: dpi@14015000: power-domains: False schema does not allow [[90, 7]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#






