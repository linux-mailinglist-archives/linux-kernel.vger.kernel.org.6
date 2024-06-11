Return-Path: <linux-kernel+bounces-209962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9219903D63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FE31F25C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00BF17CA03;
	Tue, 11 Jun 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cycm0Ht6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D117C21D;
	Tue, 11 Jun 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112728; cv=none; b=qT5Proty5KfcEJi08LDBsxJMTsfANFpeaceJKsH3OvGtwbWiTgI3glc7CCapQG9J+7elV+CiuhNKlaGFYFKtmFoVFpRQ8lJMBG6QHkHeDlmYVDS0UPxmlnRJv/+aiEMNYxWYFvwwVDUENFMWgUTbIPw7eV/D5cFcUw2kZQR2Z30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112728; c=relaxed/simple;
	bh=jFnq2FBPHkfxPczuJQqEV38ac8nO/wqjWQJ0K6zPlFI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=rKmWcwpf4ngTAbnvVeR5BvXWZjjQLt5VJkAU+rLz5f2Ogbnk3XAqsqcMTYdvmGE09TW10rfPCL8Y0man1afC16PO1ZeWjW16wFfkSpT0D1f5sgEBSn25qDv1ixkuJBzZ2aSjJ3gXSYSi1K5udoQEhfqrWsxWndH1ly6l9Ql5jwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cycm0Ht6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DE7C2BD10;
	Tue, 11 Jun 2024 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112728;
	bh=jFnq2FBPHkfxPczuJQqEV38ac8nO/wqjWQJ0K6zPlFI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cycm0Ht6+j3y6WsTE+CTck5qn2Fg3n/vwCWelIGFAOD+PQLQsFXBIKXwUE63m/5UF
	 aVblHL0y/mQsGvoUgmtF6L7wJLkhxTJ7qLUMOIvX0/PZ/5zFUt1cOQtOTa68pFoW+m
	 OCgEmTXUqZTnEmdHrsmAFzfhveC4wH8Tczl/InNwvNOk4KIJWZibtMklUQ0Yvl3/Fp
	 U/J9roxqq1tcZvue0or59388QC/n2YL86XvB0X6Pm6x+SmrchqN3A39b8uPVZdhmBE
	 N0EPrbREnS2EUGv+5yLVyya1ZiTEy8EDbB+jrHWtqjAP2iL5vuysgYfHokRyhNlGHA
	 +J1fYMoexgU6A==
Date: Tue, 11 Jun 2024 07:32:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: vigneshr@ti.com, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 kristo@kernel.org, j-luthra@ti.com, linux-arm-kernel@lists.infradead.org, 
 u-kumar1@ti.com, devicetree@vger.kernel.org, krzk+dt@kernel.org, nm@ti.com
In-Reply-To: <20240611082820.17442-1-j-choudhary@ti.com>
References: <20240611082820.17442-1-j-choudhary@ti.com>
Message-Id: <171811267198.1781695.14762038214615295188.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable analog audio
 support


On Tue, 11 Jun 2024 13:58:19 +0530, Jayesh Choudhary wrote:
> The audio support on J722S-EVM is using TLV320AIC3106[0] codec
> connected to McASP1 serializers.
> 
> - Add the nodes for sound-card, audio codec and McASP1.
> - Add hog for TRC_MUX_SEL to select between McASP and TRACE signals
> - Add hogs for GPIO_AUD_RSTn and MCASP1_FET_SEL which is used to
>   switch between HDMI audio and codec audio.
> - Add pinmux for MCASP1 and AUDIO_EXT_REFCLK1.
> - Add syscon node for audio_refclk1 to set the enable bit in
>   CTRL_MMR reg and select the parent clock for the external clock.
> 
> [0]: <https://www.ti.com/lit/gpn/TLV320AIC3106>
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> 
> This patch depends upon the bcdma driver fix posted upstream:
> <https://lore.kernel.org/all/20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com/>
> 
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 121 ++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
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


New warnings running 'make CHECK_DTBS=y ti/k3-j722s-evm.dtb' for 20240611082820.17442-1-j-choudhary@ti.com:

arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: pinctrl@f4000: 'audi-ext-refclk1-pins-default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#






