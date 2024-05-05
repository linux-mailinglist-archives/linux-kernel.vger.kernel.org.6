Return-Path: <linux-kernel+bounces-169035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B708BC1B7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 18:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E628189F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C8C37707;
	Sun,  5 May 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R51Znnja"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2429413;
	Sun,  5 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714925192; cv=none; b=rs65s6Sa1TKRDy7Zy8P9F2SRo0VyuIVqB2rROleiqIsmdrHcsfyDqPnqjbZcxHMc9m9IGfk+m6Z8nso/ghp4iSrnyJvjKMepWvHoIXcDlWPbNuDODDNPBvHXbtWnwt6mtddym0NcuscPwXYqxtM0MBmKyKzvvpwy3dogqRd0Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714925192; c=relaxed/simple;
	bh=0yAFzB+mDN9kykEk2+ZvpPNjE7XW966iy2RCCM+5wjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLJtmx2QTn/Ckl4FaeAmJcJN70ygZ5XkdOzmMVHlWkgddbTZjfSdzxmKLsXP9DVlOpdqvnUDxMnvW4uj6GpMjGtfrVXUFUNanPDS13ojo9UMoLXxIHkWw7LrHTzyUqV2gtmLO6zCQe31ycxIXTB4IHIL2EDRe8cRwlPNZQoSHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R51Znnja; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05FA6E0005;
	Sun,  5 May 2024 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714925181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y2Dlrk8mQoUShSZHFcLrq5tD8NECZae46r8UdVAZck=;
	b=R51ZnnjaaUQtNtnB//lP3+4HnLZ3dm/rW+SoZLCNSzvDv8JuCTZbwhb3LIlYP5l43OaFK1
	X7LOn8rHY+s8Mdb9UdNi3KHkR2+KhekJUrcBrxF6OMUawxOz51duUf0fp8jDU1UizI39BZ
	mdDGUIk3Ra4CPQO5K/KgSSxfWavTJ0+X9cAXpH1vH3tudGI+Wc3I2djfCLPHTzkrM3dSrJ
	1f3DgNbcedpA7Pp3VgWZX7pG6gnLrxjhoitzz/d8pZluBNzoDzWq+96eSuo+7i6ftLK4Py
	HQ41m3ucMvUM/xvG3soq4sSz4Cmgbi3xtbf+lzf4Dx3rnODZ7irOEe3v+bsGcQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Robert Marko
 <robert.marko@sartura.hr>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: marvell: eDPU: drop redundant
 address/size-cells
In-Reply-To: <20240402183240.49193-1-krzk@kernel.org>
References: <20240402183240.49193-1-krzk@kernel.org>
Date: Sun, 05 May 2024 18:06:12 +0200
Message-ID: <871q6gp7kb.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Krzysztof Kozlowski <krzk@kernel.org> writes:

> The ethernet-switch node does not have children with unit addresses, so
> address/size-cells are not really correct, as reported by dtc W=1
> warning:
>
>   armada-3720-eDPU.dts:26.19-60.4: Warning (avoid_unnecessary_addr_size): /soc/internal-regs@d0000000/mdio@32004/switch@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> This probably also fixes dtbs_check warning, but I could not find it, so
> not sure about that.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied on mvebu/dt64 as well as the 2 other pacthes.

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> index d6d37a1f6f38..91c2f8b4edfa 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> @@ -25,8 +25,6 @@ &mdio {
>  	/* Actual device is MV88E6361 */
>  	switch: switch@0 {
>  		compatible = "marvell,mv88e6190";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		reg = <0>;
>  		status = "disabled";
>  
> -- 
> 2.34.1

