Return-Path: <linux-kernel+bounces-262680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1508B93CABF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B347B1F21F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1915143C4B;
	Thu, 25 Jul 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfHpOY0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EF1EB27;
	Thu, 25 Jul 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946019; cv=none; b=rWuQM2+JdhRBo2IIJO2cCtIA4XSa8ebWT0p8fF/5XXQA9aJuEIAIb/lUleASpRsbcdWi0V01GQIK4uaQ1J6wecA5H8wa0ev/tdLvPQyJnyKjneTEFnJoGy2aH3CVhfgMG3hxIfRZo+j7LS6zY+OffvNvii/QonzNgJgHiyzWcwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946019; c=relaxed/simple;
	bh=LgSSN2lcE5Drpeys6UvvHn55TA9dDi8sJM4cgdioywM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=DxUi6oLyH0ZwBXmC1N1EYd05YPRoOcLdRoQivCgoE/Q2pL/v/B0tba5G9lk3qzxYKW47IM7BwTW3zShhCi/F+AP7GEaWw3vw75aPMHEvMebRkiw/NqgPuHKo/gQaTBCnYVOvjOoFG4U1/772KgkosxNfKiJRd9xQ4aHochZzEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfHpOY0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F03C4AF0A;
	Thu, 25 Jul 2024 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946018;
	bh=LgSSN2lcE5Drpeys6UvvHn55TA9dDi8sJM4cgdioywM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RfHpOY0N4O8aZwzlQ9tZZHXXiqoB25L+603N8EyyDgsufgycOI/Ozurm1GW1nZ/lg
	 Lt5FFY7GvO1OFsMrds6baGHYdw/35jRAE0T9wwg6M2DKzr3jsETxrfgbxTIW0hp3aF
	 RmmLYePPzh8Q1xMEI78o4U6IcREYKK2Jmj2BYCjsSfwEa7C7Bd8S0oZMz/3tWH+Ky6
	 KM6bMkdjyMeaBlV1EYhx7Q3NugsHXdNEKMLhtS32J3hX/4k8qM4O1jS/4Z6JOI4aaH
	 pOuTpjgRsM7kRQK3PjswN56etE+2Kc8IH2zArn16pLphv2TaCmNnRdm2ngrvhQgoFw
	 vxuhTIJ8cQ4DQ==
Date: Thu, 25 Jul 2024 17:20:17 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh+dt@kernel.org, s.hauer@pengutronix.de, 
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, 
 shawnguo@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org, festevam@gmail.com, 
 linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
References: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
Message-Id: <172194566256.4000899.15176243632706048606.robh@kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: imx93-11x11-evk: Add several sound
 cards


On Thu, 25 Jul 2024 16:59:05 +0800, Shengjiu Wang wrote:
> Add bt-sco, PDM microphone, XCVR sound card support.
> 
> Shengjiu Wang (3):
>   arm64: dts: imx93-11x11-evk: add bt-sco sound card support
>   arm64: dts: imx93-11x11-evk: Add PDM microphone sound card support
>   arm64: dts: imx93-11x11-evk: Add audio XCVR sound card
> 
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y freescale/imx93-11x11-evk.dtb' for 1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com:

arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: pinctrl@443c0000: 'pdmgrpsleep', 'sai1grpsleep', 'spdifgrpsleep' do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/fsl,imx9-pinctrl.yaml#






