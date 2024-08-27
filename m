Return-Path: <linux-kernel+bounces-303303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D536B960A70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144D41C22CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9049A1BFDE0;
	Tue, 27 Aug 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7KBBR3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0CB1BF7E1;
	Tue, 27 Aug 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761901; cv=none; b=eqHNADVgnylQLOLJEohCxhlpy5Ok4kKTblXtrmubwuVfZzFQTGjPajL3a/I56J0zmaqdROk3ZHcvnMSIQrlrUGa7RAxzU0EEI84QxK5Um9GVfJGool67n1x2yHoSaxw8XGENkRr/aPNcDlf/a2OWH0uTJmZaz4DJgv/CvCX9D1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761901; c=relaxed/simple;
	bh=j0hRm/gJPQ7F3cgnMEppt5zV1tBSEPSVWQy7ZCwmuUg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=p5UF9GIKXwyafyCXkMs8GhRPNs9LwZUOPK3C+RzgeI9Jns4S/zYsULkpuwfLvTPtbbozjxbLMhQJiB+c4NTW6gI/42uJ60bBVpDVnsQBR1eDzkuS+meiC15auhwdYpmjMlrj+En1FoPjIsCa98hGbLN3vtOGPvlpB2B4EIPdWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7KBBR3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A916C61049;
	Tue, 27 Aug 2024 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724761901;
	bh=j0hRm/gJPQ7F3cgnMEppt5zV1tBSEPSVWQy7ZCwmuUg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=H7KBBR3uIDi3SAjo8FLifPkHuvIpyMWU1/k6O6t/fQVF/Q3hqO9+0bT9phS2Xed+N
	 JB2BbhBXXIlibRuB6WP+jOO/xp1EcDLN6smCPbRD5VVOxQtdCE2KyxQau2+NbbFv4R
	 raOnTL36JHZDDno04zIJess+KDInyebKT32+PkvvJ3wpc/R3cU4AiRA7b14NHLSC8S
	 sZMeYq8LOT78PuEOypSG+H2jdhKIE27CtqrRQSM7lJLqNaB910F1e8in5gMXGd/xvP
	 bxMvDBqibYSMipDC30C/UruHd4A/Q5b3NvvEf4CjrIzKUWr0ffI22IfVP18YwYPsaU
	 3wm1psz7WQugg==
Date: Tue, 27 Aug 2024 07:31:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 imx@lists.linux.dev, Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20240826205334.975272-1-Frank.Li@nxp.com>
References: <20240826205334.975272-1-Frank.Li@nxp.com>
Message-Id: <172476183829.3553281.6314012832354346473.robh@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: imx93-11x11-evk: add io-expander
 adi,adp5585-00


On Mon, 26 Aug 2024 16:53:32 -0400, Frank Li wrote:
> Add io-expander adi,adp5585 under lpi2c2 and lpi2c3.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx93-11x11-evk.dtb' for 20240826205334.975272-1-Frank.Li@nxp.com:

arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: pinctrl@443c0000: 'sai3grpsleep' does not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/fsl,imx9-pinctrl.yaml#






