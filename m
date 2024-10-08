Return-Path: <linux-kernel+bounces-355233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042AC994D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C4A1F22019
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730A1DED43;
	Tue,  8 Oct 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="aPDWWmu0"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD81DFD1;
	Tue,  8 Oct 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392511; cv=none; b=g/8BgyKOsuLKrYl6gKWQJXQFd21ZFVZoZ588NjQLWLtZ/7leOpQ+ftI9+GbdcYrZ3v3Q+XTXti8rMUdHVsfVLO0KHCDgmZ7a9s5E8rwahfwmdawuGyNfv6bEUGrTUIwRHS/NaS8ErgBvawShg2N7UALN6QFaykC1hL/tPX6k6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392511; c=relaxed/simple;
	bh=PjYUW86T74UXwM2Ugm9utYyrO2lI7z5siDAlwllsukI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3yekXogDIhT/vALhvz/yVfEF3AE53L1NfCdDPiyF+rob9YtiCX6sd54c3xKS10Kgb79IDMaFr6Lp6yBhCRy6yLwXsBCnrFf2unmkxFin489CxX1rbxOQbUqRnSFs15kBg4BBfx9+aySmjsNA6h03zOn1k366xHse+XuB8PZl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=aPDWWmu0; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=z/wk1Uvs/XAIDFdJXIhXEljo1iiUXtvIJAYJotUPatU=;
	b=aPDWWmu0SDTLkn6GRQBPuxBihtWmoNiSMiipCpRcZOQZAxCVxtkefUTRuP+mrv
	IU+O1Dgz0qE0MDyUdcOB6aI4LDD8erniMjMXiVYPI1Epk0dllJBmMnW921SjhDCP
	w+xW5/PEmUq5BFrKy3esCgEsRvK/o+CcHp7kYY+Tosyds=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgA3zvQVLQVnr4zVAQ--.29073S3;
	Tue, 08 Oct 2024 21:01:10 +0800 (CST)
Date: Tue, 8 Oct 2024 21:01:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: freescale: imx95-19x19-evk: add
 nxp,ctrl-ids property
Message-ID: <ZwUtFKhB3R2geN1D@dragon>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
 <20240903-imx95-dts-new-v2-6-8ed795d61358@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-imx95-dts-new-v2-6-8ed795d61358@nxp.com>
X-CM-TRANSID:M88vCgA3zvQVLQVnr4zVAQ--.29073S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW5uF1fKw17tryxtFyDtrb_yoW8WFyfpF
	15CFWDGw48WF4fGr9Iga4rtwn3Aw4ruF48ur1UZanrtr4jvw1xJr40gFn3Wr4UXw4kCa1r
	uFnFyr18WFy2y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYnQUUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxhyZWcFFVE1PAAAsr

On Tue, Sep 03, 2024 at 03:17:51PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add 'nxp,ctrl-ids' for SCMI firmware to confirm the board ctrls as

s/confirm/configure?

> wakeup sources.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 37a1d4ca1b20..5101cd171e09 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -8,6 +8,15 @@
>  #include <dt-bindings/pwm/pwm.h>
>  #include "imx95.dtsi"
>  
> +#define FALLING_EDGE			1
> +#define RISING_EDGE			2
> +
> +#define BRD_SM_CTRL_SD3_WAKE		0x8000	/* PCAL6408A-0 */
> +#define BRD_SM_CTRL_PCIE1_WAKE		0x8001	/* PCAL6408A-4 */
> +#define BRD_SM_CTRL_BT_WAKE		0x8002	/* PCAL6408A-5 */
> +#define BRD_SM_CTRL_PCIE2_WAKE		0x8003	/* PCAL6408A-6 */
> +#define BRD_SM_CTRL_BUTTON		0x8004	/* PCAL6408A-7 */

Are these defines board specific?

Shawn

> +
>  / {
>  	model = "NXP i.MX95 19X19 board";
>  	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
> @@ -357,6 +366,14 @@ &usdhc2 {
>  	status = "okay";
>  };
>  
> +&scmi_misc {
> +	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE	FALLING_EDGE
> +			BRD_SM_CTRL_PCIE1_WAKE	FALLING_EDGE
> +			BRD_SM_CTRL_BT_WAKE	FALLING_EDGE
> +			BRD_SM_CTRL_PCIE2_WAKE	FALLING_EDGE
> +			BRD_SM_CTRL_BUTTON	FALLING_EDGE>;
> +};
> +
>  &wdog3 {
>  	fsl,ext-reset-output;
>  	status = "okay";
> 
> -- 
> 2.37.1
> 


