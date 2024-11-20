Return-Path: <linux-kernel+bounces-416017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96449D3F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B561F24CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893313B7A1;
	Wed, 20 Nov 2024 15:36:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51DD12A177
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117007; cv=none; b=QF6gkJEqty+wzA5i2rgL1HmhaCXRs0Mi/s9Tr53GjDHqnrAUyyOgUvsYFOxpdEkisKTEuHwaXS4d51a0NSe3ssFH2LcX2dwMue54UoHWg8LugQo/dgz21+ICq4uyxTJlmbjwPTxMaH0s3A2e2x6xx9JO8PsNhvBt35u0+OqhzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117007; c=relaxed/simple;
	bh=L2DkyljbYpDbQrOOJD3UjrFLxUtyxx4J/tFlahc+ZyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHcS2azkQzz2BU5SFCcsyrQ4IK66d2k6STtGvIi8j8niTNyKR557++Dtf7QHmPI4toYjISALK3OD3OFeyIzLE7BYsbXXjjZV7UlIIFr8M+8qMEZQknQj7Lw8brRpszt45xOAHjGQL5mO2QOcXUPdfQVzBuyW3GiXKzAngL0W28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tDmkn-0008HL-Rc; Wed, 20 Nov 2024 16:36:29 +0100
Message-ID: <11dd729c-df29-4d10-bf47-73e1fa01322f@pengutronix.de>
Date: Wed, 20 Nov 2024 16:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: Add dsp rproc related mem regions
To: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de
Cc: aisheng.dong@nxp.com, imx@lists.linux.dev, conor+dt@kernel.org,
 robh@kernel.org, iuliana.prodan@nxp.com, shengjiu.wang@nxp.com,
 frank.li@nxp.com, linux-kernel@vger.kernel.org, laurentiu.mihalcea@nxp.com,
 devicetree@vger.kernel.org, daniel.baluta@gmail.com, krzk+dt@kernel.org,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
 <20241120135859.3133984-6-daniel.baluta@nxp.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241120135859.3133984-6-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Daniel,

On 20.11.24 14:58, Daniel Baluta wrote:
> With imx8mp-evk board we are now configuring 'dsp' node for rproc usage,
> so add rproc specific memory regions.
> 
> Also, enable dsp node because it is ready to be used.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

>  &eqos {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_eqos>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index fa4ff75af12d..e6f3ac02689c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -282,7 +282,6 @@ reserved-memory {
>  		dsp_reserved: dsp@92400000 {
>  			reg = <0 0x92400000 0 0x1000000>;
>  			no-map;
> -			status = "disabled";

This reverts commit 010dc015b811 ("arm64: dts: imx8mp: Disable dsp
reserved memory by default").

Please enable the reserved memory node in your board DTS instead.

Thanks,
Ahmad

>  		};
>  	};
>  


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

