Return-Path: <linux-kernel+bounces-232473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1F91A949
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8601C20A93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE43197A9B;
	Thu, 27 Jun 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGM0bmuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38912196446;
	Thu, 27 Jun 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498869; cv=none; b=pQy2h/gwsreZ+HyxrJWHRYx0qHCRIAIzyR0DmI0eCBSFgQjnuCjW2f7+71tCmkVR/E9b2FbRpo+eDMVK4/oeIoTF2K1Q6BZgJJUi4vtdqDPWT2k5/m7REn6Sar8z+CCRNSEgeyHf5rOivJeHH/HIbvWEXkSKHppp76nxB6Kjmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498869; c=relaxed/simple;
	bh=Fc0ykomioDc7Uypl1Uf66s988C/OLz9FiLzqmcO3ors=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NrInj2erH/+mfSEZwcaj3ARHLBSivjgldGvTORcq/VS0egdyH/cbjt3yunnHWO+p++gj9SH//xs7SACMdlh+FD3NVEQ6mt38JzkiuYEqTLIUv31p0Gb97TxF4Xk+OkASkJf2AMloVOM4vnZEkI4KvqBZmfvAYJaNByoj1HTMLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGM0bmuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AC0C2BBFC;
	Thu, 27 Jun 2024 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719498868;
	bh=Fc0ykomioDc7Uypl1Uf66s988C/OLz9FiLzqmcO3ors=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HGM0bmuNep0skTj+qhLyH1KhOTJQdcegXnLGbU6X8XLL6E1gt9wyZVRamODRthW6u
	 uetgWhuvW/YCjuL8zAg3wrQsqjgWCItYSM7nGI7mh9oLsio1p5A99rnm1kR7ODmVI9
	 IAs+UqzS1Ux4R/W+WE1YCLXOWPnQ3x1ZiNLVGO/rApQyJnpETKakhIdGSGr7nCamS/
	 RUxlWWXagpRCSDMcdIVEo3BKxFMu7s+FTJI8R/y+ysA6QOVoZS5n4bvcawiaSsIvbp
	 nAU8TvRR3jgXbQNKSsiUHsASHkuE1M83HC/ceyOh9AH7jFufiqyh+TtN1W65NP7u2k
	 Xks/h0wXtuflg==
Date: Thu, 27 Jun 2024 08:34:26 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: FUKAUMI Naoki <naoki@radxa.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240626201502.1384123-1-jonas@kwiboo.se>
References: <20240626201502.1384123-1-jonas@kwiboo.se>
Message-Id: <171949859356.3298890.9759631010670097235.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: Add Radxa ROCK 3B


On Wed, 26 Jun 2024 20:14:53 +0000, Jonas Karlman wrote:
> This series adds initial support for the Radxa ROCK 3B board.
> 
> The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
> factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
> version based on the RK3568 SoC and an industrial version based on the
> RK3568J SoC.
> 
> Schematic for ROCK 3B can be found at:
> https://dl.radxa.com/rock3/docs/hw/3b/Radxa_ROCK_3B_V1.51_SCH.pdf
> 
> Changes in v2:
> - Drop rk809 dt-bindings patches, replaced by series at [1]
> - Use regulator-.* nodename for fixed regulators
> - Drop rockchip,mic-in-differential prop
> - Shorten Ethernet phy reset-deassert-us to 50 ms
> - Fix pcie pinctrl
> - Add keep-power-in-suspend to sdmmc2
> - Collect a-b tag
> 
> [1] https://lore.kernel.org/all/20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com/
> 
> Jonas Karlman (2):
>   dt-bindings: arm: rockchip: Add Radxa ROCK 3B
>   arm64: dts: rockchip: Add Radxa ROCK 3B
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3568-rock-3b.dts      | 780 ++++++++++++++++++
>  3 files changed, 786 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> 
> --
> 2.45.2
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-rock-3b.dtb' for 20240626201502.1384123-1-jonas@kwiboo.se:

arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#






