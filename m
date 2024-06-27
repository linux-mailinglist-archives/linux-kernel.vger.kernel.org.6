Return-Path: <linux-kernel+bounces-232474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CDB91A94C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C656D1C210F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D6F19884B;
	Thu, 27 Jun 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYlPuCj0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E319882B;
	Thu, 27 Jun 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498871; cv=none; b=UlczgztPyZ2QCuKkvFFgJMIM6VMdfP2FsffgF/GrLy3NzgAKDBF0ycPhmGr+gSx3Z3V4WzSbNfuMl/L2XE9+FEQ+F+jKeBQbDkKVAw+8xKBVqllk2yQ+7x+XOc9zsBJqhA9MePgShW3ZIBV5JlUfhI3YCG4JCjrj3vxnc+CsFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498871; c=relaxed/simple;
	bh=gv4MXPYZvm3lNZmH4AUd269FhyNbFCqWRSyx8/WMyNg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZhMsv3R4w+CkhfI5LNGlKUzmssjN8a5l04RqA1s4H/NMWY7rFBQQb2tFwfQlGblUZQuCQWaKN0cvhp4c/P0oMKqIxm6ReCIyl9ZmW+k7WIKrmlV5GtaBoRoTbAfyp2bus1TW3tmOne1Zk+YuxhOiDgsb9HBewKKlqiuHyboTwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYlPuCj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C50BC2BBFC;
	Thu, 27 Jun 2024 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719498870;
	bh=gv4MXPYZvm3lNZmH4AUd269FhyNbFCqWRSyx8/WMyNg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qYlPuCj0oV8Jm9BP3YMEPpjI1Owzalvm09e89g6f/n5FCgTi97K/Yq+fjJowqXrP8
	 uIYh/tRKVbX0Bfcgm6354axi/B0ptRgdviyfaTjJ2fWgfp6w+B77vVJfNLa30E8lUF
	 jOg2tmfXhwOq96bNV073BUAn3PcgnRkGHbuZjR/QonTUBGWpSVYpyK77sjTSbPWeMq
	 BU41asrOKvaqNREPUT6F0eP9JIWoKw+VFXrTPH6xM2vLRyZK88yroP2EPrcB4mjfko
	 jQ61toqljbTP5BueUKCpqvp8ZRKZWMu9iigXTb6Ux0jk++xUhwU6B60fobefpO4FzL
	 9oPQ5b3CBOOHw==
Date: Thu, 27 Jun 2024 08:34:29 -0600
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
Cc: linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20240626230319.1425316-1-jonas@kwiboo.se>
References: <20240626230319.1425316-1-jonas@kwiboo.se>
Message-Id: <171949859482.3298953.17210742633761408276.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B


On Wed, 26 Jun 2024 23:03:10 +0000, Jonas Karlman wrote:
> This series adds initial support for the Xunlong Orange Pi 3B board.
> 
> The Xunlong Orange Pi 3B is a single-board computer based on the
> Rockchip RK3566 SoC.
> 
> Schematic for Orange Pi 3B can be downloaded from:
> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-3B.html
> 
> Changes in v2:
> - Add DT for v2.1 hw revision, rename initial DT to v1.1:
>   - Ethernet phy io voltage: 3v3 (v1.1) / 1v8 (v2.1)
>   - Etherent reset gpios: GPIO3_C2 (v1.1) / GPIO4_C4 (v2.1)
>   - WiFi/BT: CDW-20U5622 (v1.1) / AP6256 (v2.1)
> - Rename led node and move led pinctrl props
> - Use regulator-.* nodename for fixed regulators
> - Drop rockchip,mic-in-differential prop
> - Add cap-mmc-highspeed to sdhci node
> - Add no-mmc and no-sd to sdmmc1 node
> 
> Jonas Karlman (2):
>   dt-bindings: arm: rockchip: Add Xunlong Orange Pi 3B
>   arm64: dts: rockchip: Add Xunlong Orange Pi 3B
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   8 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../dts/rockchip/rk3566-orangepi-3b-v1.1.dts  |  29 +
>  .../dts/rockchip/rk3566-orangepi-3b-v2.1.dts  |  70 ++
>  .../boot/dts/rockchip/rk3566-orangepi-3b.dtsi | 678 ++++++++++++++++++
>  5 files changed, 787 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v2.1.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b.dtsi
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3566-orangepi-3b-v1.1.dtb rockchip/rk3566-orangepi-3b-v2.1.dtb' for 20240626230319.1425316-1-jonas@kwiboo.se:

arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v2.1.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#






