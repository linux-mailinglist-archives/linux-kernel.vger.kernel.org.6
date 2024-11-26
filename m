Return-Path: <linux-kernel+bounces-421920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5D9D91F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47421B21F10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814E191F66;
	Tue, 26 Nov 2024 06:49:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50281917E4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603760; cv=none; b=X+gujvOGDs0KW5c2JhpBzCUrKFt0KPUxq7OGWwV+DuwFk1gjqEfIT+N4iztB8JfWL54XOnI4EjTDv7PpXYIRZXPyqiYwi/ksR8i3UzP3/RvM/upk78Kl5ZlWOd0shWVXAal2nSQhWD3/r8POjOb2C9N6wEwtnn3q34YwmS4N25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603760; c=relaxed/simple;
	bh=aPYtwxgZhw35UXv7IJQFDNx0YGXcgrG5lruABDTFbnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMI4pb6qcao0PXO3KD0VKrjcg7f+gsM7sonyaWb4cB1wllnBMfszIwapDmA3RLWHD4vUSIpFD7ON9opaoLHOTWxgIaaCPKas3Mz0EFw/HGR7gsbivYdtgNDlDJOqgF8Oeh8cNlgj/qowlNCACwbFXDas0DCkJguoftZW9KG2jUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tFpNh-0000ba-00; Tue, 26 Nov 2024 07:49:05 +0100
Message-ID: <f8d5e367-5648-4941-9d65-adfbe6d3c0dc@pengutronix.de>
Date: Tue, 26 Nov 2024 07:49:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: Add dsp rproc related mem regions
To: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 frank.li@nxp.com, aisheng.dong@nxp.com, daniel.baluta@gmail.com,
 laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com, iuliana.prodan@nxp.com
References: <20241125152427.136883-1-daniel.baluta@nxp.com>
 <20241125152427.136883-7-daniel.baluta@nxp.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241125152427.136883-7-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25.11.24 16:24, Daniel Baluta wrote:
> With imx8mp-evk board we are now configuring 'dsp' node for rproc usage,
> so add rproc specific memory regions.
> 
> Also, enable dsp node because it is ready to be used.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index d26930f1a9e9..c732ee79772d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -291,6 +291,16 @@ &aud2htx {
>  	status = "okay";
>  };
>  
> +&dsp_reserved {
> +	status = "okay";
> +};
> +
> +&dsp {
> +	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> +			<&dsp_vdev0vring1>, <&dsp_reserved>;
> +	status = "okay";
> +};
> +
>  &eqos {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_eqos>;


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

