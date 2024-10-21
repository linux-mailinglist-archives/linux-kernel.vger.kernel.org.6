Return-Path: <linux-kernel+bounces-374893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875F9A719D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222EE1F23469
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22C11FA260;
	Mon, 21 Oct 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsFv8Tc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143061FA24B;
	Mon, 21 Oct 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533515; cv=none; b=r1FM+e/Zyk+UYBrTKoTuNxC45F+ZsUSk5ltN3Hw+qtzIfHO0le6tbHUCivDc9zo8+K7n6s4R4PVrdvdTVMGMMuRhCkaqSgMUrSJeCi6FFS2xUjj/1yixkDvFB/f0TwcwKnsMDyhS2uXVUiLGLZfAS6KV91wjfed+23CJykGd5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533515; c=relaxed/simple;
	bh=SeZBemYZZhTNxyr/LOMazMdpTm+fOGWkcQuVffgsxns=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=miKl63LZzmmqmyi4ccCSSPOPnM7gR+v+GQHKg94pYGNZsAB4CDaHc1HU8puMQD26leWX613Ml+YLK+Ke23HevYzuE9mA8UWtQwo5OUFrkRtTwoo7BmyFNPCKHubNpc6OGwXVyPgI7BEWPeo4AhwghVubTCeQYAYG5oVGNAq/QzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsFv8Tc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882ABC4CEC7;
	Mon, 21 Oct 2024 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533514;
	bh=SeZBemYZZhTNxyr/LOMazMdpTm+fOGWkcQuVffgsxns=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LsFv8Tc0W6xCIgK9qc6lV8cno1yELjGaJjVU6QiMnqWaCptVjXx1nnxoXY7vbRDnu
	 8I6CGKzQcoJi8qk/sFZiX3QImidaKk1NoZE/6yIZE9FTxahFI+U4qWtJcQbgrBHvqR
	 Q9wpr+KE4pT1BvWxMDWTVkqZ0gaTDaFZODP0tlYAKEtr/5mF0Jf9EuBux/7t3QZ/0b
	 SJjJdLTJhtARZ6nG1uB9zVKkr1+C3/XxLszb6HOf1MJhTy3zQ89uyPu6dP3CHqjmlo
	 ABMcbukv4EwUEB5J5S5WFy38mj7gm2CG95Tze39+MAJWpDLC290CFJaqSpTpIcCHpU
	 y75z9WVdyVeLQ==
Date: Mon, 21 Oct 2024 12:58:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com>
References: <20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com>
Message-Id: <172953337556.748331.14779753664880128918.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid clock-names from
 es8388 codec nodes


On Sat, 19 Oct 2024 03:38:10 +0300, Cristian Ciocaltea wrote:
> The binding for Everest ES8328/ES8388 audio CODEC doesn't support the
> 'clock-names' property:
> 
>   rk3588-orangepi-5-plus.dtb: audio-codec@11: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>     from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
> 
> Since the related audio driver is also not making use of it, drop the
> invalid property from all es8388 codec nodes.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Several DT fixes involving the usage of the Everest ES8328/ES8388 audio
> CODEC.
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts      | 1 -
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts  | 1 -
>  arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts      | 1 -
>  arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts | 1 -
>  4 files changed, 4 deletions(-)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3399-roc-pc-plus.dtb rockchip/rk3588-orangepi-5-plus.dtb rockchip/rk3588-quartzpro64.dtb rockchip/rk3588s-indiedroid-nova.dtb' for 20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com:

arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: audio-codec@11: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#






