Return-Path: <linux-kernel+bounces-391914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C15D9B8D46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138861F212A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5715747A;
	Fri,  1 Nov 2024 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="aPmnC14z"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152125757;
	Fri,  1 Nov 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450883; cv=none; b=c/splmBhUArkSbs9JDaIGDSMUIGPLizBTDb0tvKxH7BNHANR5qNjz2CoyWM0qVNGlIiCLgSlG1JCN+XGCw3xCdG89wIOpcnAdSQfohioxmF5H8ttoBYZdBW321fnNtJKi6YT77NVzvBUI6YWyjD6zo0YWKjI1LG/stI1620+ujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450883; c=relaxed/simple;
	bh=T0Hx7Xag3FRTXmP6XGYR2vtat49C3n0alPW8ATG7aUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih4TbF1yH4VswdcOZPxlFMO64eb+stEkGC2uvo+9J79U/ehA0kt7YZgPCGWPH4JLWMxnBEzo7wqNh738sIsUetmMlNcgifyTWpFgWCmUWrNfDcnnKTia+csyd6J98vCpeOgOHBzKlprLqXYw2KKQRtfx+CvEWJu8v2w2UnMvsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=aPmnC14z; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=IeaVJHhC0vZY63A4QtQYExEgCz/IQApw8RhqgXRhQ5A=;
	b=aPmnC14zcu7eUaNpshEHexKf8C8or9kGiWOh6N82pnkymJELLGh+LVNYWq+P0x
	lOcTL39BG6IH9r2tVtoOZ3kXhnxe19/KuaKkg9ITumylG7q0vcyhGiqAiQy1PNTF
	sulrv32U3bIpJ79x58DqJ9jtHBMRwXzIpWpHSMTYQl8/g=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgC3P0uVlSRn0vRiAQ--.13641S3;
	Fri, 01 Nov 2024 16:47:19 +0800 (CST)
Date: Fri, 1 Nov 2024 16:47:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mq-zii-ultra: remove #address-cells
 of eeprom@a4
Message-ID: <ZySVlU2gPSN3KKSl@dragon>
References: <20241018183117.740439-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018183117.740439-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgC3P0uVlSRn0vRiAQ--.13641S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWfXFy3tw13Ar47JrWrKrg_yoWftrXEyw
	1fuw4UG395ArW7C3s8Zw40qwnFk34UA34fJw1fXr4DKayav3y3K397J3yrJr9xGF43Krs5
	AFn8tF1kJ345KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8qYLPUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxyKZWckPo77kgABsj

On Fri, Oct 18, 2024 at 02:31:16PM -0400, Frank Li wrote:
> Remove #address-cells and #size-cells of eeprom@a4 because no children
> nodes under eeprom@a4.

Hmm, bindings/nvmem/zii,rave-sp-eeprom.txt suggests there could be child
nodes?

Shawn

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> index 0c960efd9b3d5..c7bbba45f3685 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> @@ -517,8 +517,6 @@ eeprom@a3 {
>  		eeprom@a4 {
>  			compatible = "zii,rave-sp-eeprom";
>  			reg = <0xa4 0x4000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
>  			zii,eeprom-name = "main-eeprom";
>  		};
>  	};
> -- 
> 2.34.1
> 


