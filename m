Return-Path: <linux-kernel+bounces-392171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257D9B908E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F651F228C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57D19B586;
	Fri,  1 Nov 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KJKFw353"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F9814A62B;
	Fri,  1 Nov 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461624; cv=none; b=H+MZUlrHAbeD3AoQqvtFk78SLQglnQfmdrqN0g9tFdFc6v8hLVugyUjWjIwB7cwKh9E95OHqb3GWfvc5SdM7nM6qZIEXNhalzHaw4RSJIFPwh464sZn/urX3ABVZgSsPAsY01JPg8mxJYUmXNA+3o8m/zR8qXPCsn1Kfwv795uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461624; c=relaxed/simple;
	bh=2FFDvupKdpH2nMa7kFYy8HYE5gnZkKHKaoyzng9SVMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1j9XYXlO6cA8s9PlTjZHoaF4UrvJwYW5VPiu3ucaZGyygZuB7d5sfaVYpqZY7h1dPORVLJ0kxoKFIXZpxIvIBthgdLTyQhMbhua8K+HdGsEncPva3MBNMyclXhLxeXFQHMaQw8Kzn0fq2vwSXrp8L1TSHaJ18zpOf6B7YlZRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KJKFw353; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=vBhhEiomKrzvqxGLGcDjM350Ad9Z2r+Ry5z4X3rrDy8=;
	b=KJKFw353fhDs710pbkq9vTdnMRsejfZ5iqwWlIWRjb1RcZwxk4IfCUPm3QLqFA
	752EO89ExgeAZ0rHV2XEe2vHdu5s414AXZpsn7MoRT+oXfuVomORhj5HijuR7GXq
	pj/6wl0Zs9EUHvikIXj9YKlsYf1DHuQUcihnccmjbyz3Q=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBX8YiMvyRnpAFrAQ--.14187S3;
	Fri, 01 Nov 2024 19:46:22 +0800 (CST)
Date: Fri, 1 Nov 2024 19:46:20 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mq-librem5: remove undocument
 property 'extcon' for usb-pd@3f
Message-ID: <ZyS/jGUf2C2VlJ4J@dragon>
References: <20241023220252.1392585-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023220252.1392585-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgBX8YiMvyRnpAFrAQ--.14187S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruryDuw43uFyfJrWkZr4rAFb_yoWkJFb_AF
	4xuw4rJrWrAFWIgas5tw4kZ3W2grWUC34ftr1rXr4kGryav398Ca97Wr4rGrn8GFWFkrZ8
	ArZxXF15AryYkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8voGJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhWKZWckdPvVbQAAsc

Copy Sebastian for comment if any.

Shawn

On Wed, Oct 23, 2024 at 06:02:52PM -0400, Frank Li wrote:
> Remove undocment property 'extcon' for usb-pd@3f to fix below CHECK_DTBS
> warnings:
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: usb-pd@3f: 'extcon' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/usb/ti,tps6598x.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index 1b39514d5c12a..61bdb43dec31d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -794,7 +794,6 @@ typec_pd: usb-pd@3f {
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
>  		interrupt-names = "irq";
> -		extcon = <&usb3_phy0>;
>  		wakeup-source;
>  
>  		connector {
> -- 
> 2.34.1
> 


