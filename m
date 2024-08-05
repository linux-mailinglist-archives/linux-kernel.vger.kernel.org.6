Return-Path: <linux-kernel+bounces-274844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52D947D77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0CEB233AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C36154C07;
	Mon,  5 Aug 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgtOWvXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF93F9D5;
	Mon,  5 Aug 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870014; cv=none; b=m2uw1f7qrEqbE73vcuEP2tO0TzLM9b5o9TOc2dltcq1Hk6C1MRaRoaOiNvGxFyDhCXoQoSRjAk1vVPaqZxarGclpOPq9M7MdpReCqzTwGPAjilp2/8o4PyMC/S6SezUSdCeLHJESeBD4cSaIp4qoN8k2+fN7wKhvHr11QzYKXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870014; c=relaxed/simple;
	bh=BvrkceB7VckQ65t9UIejN1/seIpoW+gmGHw6Bpfa1KI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tXIEvw1WiKolzoba/g7Qgz8GZZaMFThL16kxohgQIiWrYMX/C1lQN2MQRcdtuST9IRZsg7Fws+mRwpbiuRsFvdS1GdavxiLdlpA8hDZYBQTZaUk1RpvAmzbsGXcanTPX3WxcLi4lTpCFBxFfsYuuaFDziSC0JF9k83NhmfIXxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgtOWvXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690BC32782;
	Mon,  5 Aug 2024 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722870014;
	bh=BvrkceB7VckQ65t9UIejN1/seIpoW+gmGHw6Bpfa1KI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RgtOWvXIe5UibJyNzAZ9c81c0XVk+dYUbypvfMiCLu2/CUOtXzp4ElCbp1eBqdScs
	 uEqs+7rh1jh6yZ5pNZvL0QsAFXom71FJX4NR/FeRQrwmcLUkWaGaAwrfk7/w4IhnxP
	 NfDHwDJbxDUJ7fQBdtsZPPWNZBP2ASER6HtQGMnRPvIjZQA33aAbD1AMYwMCD6vk8m
	 yk/G7fWZIt9Q7gNmul801q9CMnxxMJQelHMDHzK9Gd7NV2TwPgUbYwXl27++m+ruTI
	 oKciF7qSJbyqrRvurkAP++QjNYKZRcDc3HwvfMcJuL37P1BIPtmSMgds+t5kJP2Tcm
	 eCITua3KKiKoQ==
Date: Mon, 05 Aug 2024 09:00:12 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sergey Bostandzhyan <jin@mediatomb.cc>
Cc: linux-arm-kernel@lists.infradead.org, heiko@sntech.de, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20240801175736.16591-1-jin@mediatomb.cc>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <20240801175736.16591-1-jin@mediatomb.cc>
Message-Id: <172286966609.2708545.4957056858125634326.robh@kernel.org>
Subject: Re: [PATCH V2 0/2 RESEND] Add DTS for NanoPi R2S Plus


On Thu, 01 Aug 2024 17:57:34 +0000, Sergey Bostandzhyan wrote:
> Hi,
> 
> as requested, I am resending the patch series, now with hopefully all
> relevant addresses on To/Cc.
> 
> I noticed, that a DTS for the R2S Plus is not yet available, while the
> R2S is already there. The only difference is, that the Plus version has an
> eMMC, so we can reuse the R2S definitions and only add an eMMC block, which
> I copied from the DTS in the friendlyarm/uboot-rockchip repo.
> 
> I applied the same DTS changes to u-boot and tested u-boot 2024.04 with
> kernel 6.6.35 on an R2S Plus which I have here and the eMMC became visible
> and usable.
> 
> Kind regards,
> Sergey
> 
> 
> Sergey Bostandzhyan (2):
>   arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus
>   dt-bindings: arm: rockchip: Add NanoPi R2S Plus
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |  1 +
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 31 +++++++++++++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> 
> --
> 2.20.1
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3328-nanopi-r2s-plus.dtb' for 20240801175736.16591-1-jin@mediatomb.cc:

arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: mmc@ff520000: Unevaluated properties are not allowed ('num-slots', 'supports-emmc' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/rockchip-dw-mshc.yaml#






