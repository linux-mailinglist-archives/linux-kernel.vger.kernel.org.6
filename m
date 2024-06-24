Return-Path: <linux-kernel+bounces-227736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6C915604
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790931C22305
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD491A071F;
	Mon, 24 Jun 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QLbUgLBZ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677913BC1E;
	Mon, 24 Jun 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251737; cv=none; b=mcqEPaj1wtXmoEspxrmBsUAfBrcSBF/PXJwiSggJgFvvt3HzweRjYybbnW2EV+8fZEAvW/eM79TQdNi7cGp9O0EbLqe+A+dgI63WLM65Y+CczKPtHtgBgF3r8Xcc/WxXYk7L62uJHlvnfjBeGHzE883ciJC3Oiav3gWANdXyqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251737; c=relaxed/simple;
	bh=+Np1PfYtDOV+sfjb7kGbjp3FuCMuZlNsdpaOoDnTykU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ln7gCtcfAQalCZg9nyI7fpalWP15fwjbovfhOrlg0Bbtq72Wx3x0nyADBTIWkXYH5RMWaBJGbGpFDgIAEhyVWF/GN1q92HfLv8DaB4BgYy2N1EF8Xeb/2BZXQE6gmzJYJ5Zie3YgxeysI4G67J1R6uKUGAVnqgevn0boWmv2UOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QLbUgLBZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719251732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMIDSnjT3PD/47d4+6ZJlG0hXn2fIBhyGjnU5O7IR3g=;
	b=QLbUgLBZVcgVcpGaFpVUnU1mgrT8Tese8mogm39YN+x1kdgHCUBByBafzW3dJGeJkPcGhl
	0DAvtJZXHlZgDSxRQHZj7Mon8lcOEMCmavE6odP2Bzbyk/GNYpMp9oavCNDecuBDlcDF00
	YduP8cZGcBKVaymsZi848oV9hWvNScRqQIN5njrEQI2LM0WzEOLUdhs7xLW+t3eVGnecF8
	WZvAjir1LCMTSWLCjlcsNAMxsE/N3+ESFdmCegfNR7bq7lKlLEinN0+4HjW6SArSetT/RP
	oxbPjAQCnqF2nsPMjvU8DlKmuk1UWisuvxd2hOMfFbG1pAn0SCNInm6yzQHJBw==
Date: Mon, 24 Jun 2024 19:55:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, alchark@gmail.com
Subject: Re: [PATCH] arm64: dts: rockchip: Delete the SoC variant dtsi for
 RK3399Pro
In-Reply-To: <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
References: <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
Message-ID: <ba9d41461f5d56947d7851473637722b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

Just checking, are there any comments on this patch?  Is there something
more I can do to have it accepted?


On 2024-06-02 08:25, Dragan Simic wrote:
> The commit 587b4ee24fc7 ("arm64: dts: rockchip: add core dtsi file for
> RK3399Pro SoCs") describes the RK3399Pro's PCI Express interface as the 
> way
> built-in NPU communicates with the rest of the SoC.  All available 
> evidence
> shows this not to be accurate, as described in detail below.  Moreover, 
> the
> rk3399pro.dtsi isn't used anywhere, so let's delete it.
> 
> The publicly available schematics of the Radxa Rock Pi N10 carrier 
> board [1]
> and the Vamrs VMARC RK3399Pro SoM, [2] which put together form the 
> currently
> single supported RK3399Pro-based board, clearly show that the PCI 
> Express x4
> interface of this SoC is fully functional and actually not used by the 
> SoC
> to communicate with the built-in NPU.  In more detail, the VMARC SoM 
> exports
> the SoC's PCI Express interface at its board-to-board connector, and 
> the Rock
> Pi N10 routes it to an M.2 M-key slot with four PCI Express lanes.
> 
> Both the Rockchip RK3399Pro datasheet, version 1.1, [3] and the 
> Rockchip
> RK3399Pro technical reference manual (TRM), first part of the version 
> 1.0, [4]
> don't describe that the SoC's PCI Express interface is reserved for the 
> NPU.
> Instead, the RK3399Pro TRM describes that the NPU uses AHB and AXI 
> interfaces
> as the host interface (HIF).  The RK3399Pro datasheet clearly describes 
> that
> the PCI Express x4 interface is available for general-purpose use, just 
> like
> it's the case with the standard Rockchip RK3399 SoC, [5] albeit with a 
> bit
> shorter feature list provided in the RK3399Pro datasheet.
> 
> Even the publicly available reference RK3399Pro schematic from Rockchip 
> [6]
> shows the availability of a standard PCI Express slot with four lanes, 
> which
> would be pretty much impossible if the PCI Express interface was 
> reserved
> for the communication with the built-in NPU.
> 
> Based on the RK3399Pro datasheet [3] and the board schematics, [2][6] 
> the
> built-in NPU actually exports NPU_PCIE as a separate PCI Express x2 
> interface
> that's partially pinmuxed with the NPU's separate USB 3.0 interface, 
> which is
> described further in the next paragraph.  However, the NPU's separate 
> PCI
> Express x2 interface is left undocumented in the publicly available 
> RK3399Pro
> documentation, in which it's clearly described as reserved for internal 
> use
> and not intended for the communication with the NPU.  Finally, the 
> evidently
> independent nature of the separate NPU_PCIE x2 interface makes ignoring 
> it
> safe when it comes to determining the nature and the availability of 
> the
> RK3399Pro's main PCI Express x4 interface.
> 
> The actual application-level communication with the built-in NPU, 
> including
> powering it up and down and uploading the NPU firmware, is performed 
> through
> the separate USB 2.0 and USB 3.0 interfaces exported by the NPU, [7] 
> which
> the VMARC SoM [2] and the reference board design from Rockchip [6] 
> route to
> the SoC's standard USB 2.0 and USB 3.0 interfaces, to make the NPU 
> accessible
> to software running on the SoC's ARM cores.
> 
> [1] 
> https://dl.radxa.com/rockpin10/docs/hw/rockpi_n10_sch_v1.1_20190909.pdf
> [2] 
> https://dl.radxa.com/rockpin10/docs/hw/VMARC_RK3399Pro_sch_V1.1_20190619.pdf
> [3] https://www.rockchip.fr/RK3399Pro%20datasheet%20V1.1.pdf
> [4] 
> https://www.rockchip.fr/Rockchip%20RK3399Pro%20TRM%20V1.0%20Part1.pdf
> [5] https://www.rockchip.fr/RK3399%20datasheet%20V1.8.pdf
> [6] 
> https://opensource.rock-chips.com/images/e/e4/RK_EVB_RK3399PRO_LP3S178P332SD8_V11_20181113_RZF.pdf
> [7] https://wiki.radxa.com/RockpiN10/dev/NPU-booting
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399pro.dtsi | 22 ---------------------
>  1 file changed, 22 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
> deleted file mode 100644
> index bb5ebf6608b9..000000000000
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -// Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
> -
> -#include "rk3399.dtsi"
> -
> -/ {
> -	compatible = "rockchip,rk3399pro";
> -};
> -
> -/* Default to enabled since AP talk to NPU part over pcie */
> -&pcie_phy {
> -	status = "okay";
> -};
> -
> -/* Default to enabled since AP talk to NPU part over pcie */
> -&pcie0 {
> -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> -	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> -	status = "okay";
> -};
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

