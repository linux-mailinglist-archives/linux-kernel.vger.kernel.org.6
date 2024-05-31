Return-Path: <linux-kernel+bounces-196349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26308D5A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B261C21625
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5937FBC5;
	Fri, 31 May 2024 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XDd2q9fC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lw3/VR9P"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D14CDF9;
	Fri, 31 May 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137175; cv=none; b=UedOgbINu2a2XtKNKY+V2bz23z0aaql4fLhHGo1AOxRC/BQnKHYkEdxFR6ghlayolEOO10UDROFedL/9r2GDX5YvSgXPEPB7YMEo5wiC/n+pD9/umaRQ0PHqFzRbP7IpMSlrTmSL0gAQkbGmgpKuaGQ3/1SvUalz4dFTCgAXRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137175; c=relaxed/simple;
	bh=zYiX0AjhLTjP2O/Ol190QQL9U/qbjcmRbGaR0I9IbLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLli6fvINXWjrUc2AwpN2cTs0MX0Oa8U3m05qjvqGSO5Maoimshriy7dVB9hfOATOGUXV2I2PZJmIPrcqs5rutDWskZEg6U1uQW+7xXe8VAd3CNBf/3nP6p03A7LdBD3a21BGoMLOeI5lQzWAZkEUb1SJ3XvTYwj7BJJJyQfyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XDd2q9fC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lw3/VR9P reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717137171; x=1748673171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yxhy+lgIkgKBNI7vIDVh7UOrpF+bSmn9/vQclJLbSlU=;
  b=XDd2q9fCCr+h3yqke1vmBgzXtlG4Vo1LdPe6OjVaop4HG+2gGfR0/Jhs
   l2leLCMkQ7RWV2nnFLuIaTUkERzyzI+aO6iPiEjVeHt8RfLLf7k8oY/LF
   a1y+9mVLj4whrM+QAAYNsUpUVxVPLYCpz/iSKtMdo0BlavOmW4LmwJbjL
   db2ig0tbcPuc7CZj7u7VgiSbyn4JS5w//N/AoYI441FBb4je6stI+xqPk
   PkQoEKovXM0DmvWqKfWfN+BGSDSIBcxn9v4g1YO9CyzyGqMkpR1dUMyrh
   XX+FUFJTVNw0U3nmfbFjJnstlT5f+JYE5ibJBiXgXC4zw/3t5Lm/OHbTB
   w==;
X-CSE-ConnectionGUID: p1+aEhYhRJKk6H/MobMNLA==
X-CSE-MsgGUID: 333r38qDTS201iM4aUMemQ==
X-IronPort-AV: E=Sophos;i="6.08,203,1712613600"; 
   d="scan'208";a="37152648"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 May 2024 08:32:49 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94B7E165F00;
	Fri, 31 May 2024 08:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717137165;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Yxhy+lgIkgKBNI7vIDVh7UOrpF+bSmn9/vQclJLbSlU=;
	b=lw3/VR9PiO5roQceuizF5xXrSm48jTqU9oAnsOSp97GJS+o6w2dYuQYhkp6NvysJF5XElL
	XFqS4ZwpnB9GiA2OHKKT8XvFCX45mL9ok547OVLdhjz6C6P3Sbtq+fz+mnzAuLwDK+6A03
	lH0PyH4mYJ7X2NdYVeq4Nds20BIrJ9O5dHaTdf4K4uO7uSZk/eI61CCB9z5tgG7GRNoVKU
	ZCN26HbpEvjnE1RwUanzgfuiDrD7JnI/ZgpQW3yYT8PbHIhqRnA+QVLhu4TuRvpoRIOpmE
	6Cyc6tiR0oy4WXpc4/yC3WEnbcNXpToVQ9FWIC5iaAgcRuYoX2KfKWuAVt49Tw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH] ARM: dts: ls1021a: add QUICC Engine node
Date: Fri, 31 May 2024 08:32:44 +0200
Message-ID: <3380831.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240530-arm-ls1021a-qe-dts-v1-1-2eda23bdf8c5@geanix.com>
References: <20240530-arm-ls1021a-qe-dts-v1-1-2eda23bdf8c5@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Esben,

thanks for the patch.

Would you consider current converting into YAML format?

Am Donnerstag, 30. Mai 2024, 16:22:54 CEST schrieb Esben Haabendal:
> The LS1021A contains a QUICC Engine Block, so add a node to device
> tree describing that.
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 51 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nx=
p/ls/ls1021a.dtsi
> index e86998ca77d6..ff7be69acdd5 100644
> --- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
> @@ -460,6 +460,57 @@ gpio3: gpio@2330000 {
>  			#interrupt-cells =3D <2>;
>  		};
> =20
> +		uqe: uqe@2400000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			device_type =3D "qe";
> +			compatible =3D "fsl,qe", "simple-bus";
> +			ranges =3D <0x0 0x0 0x2400000 0x40000>;
> +			reg =3D <0x0 0x2400000 0x0 0x480>;

Properties please in this order:
* compatible
* reg
* #address-cells
* #size-cells
* ranges
* device_type

> +			brg-frequency =3D <150000000>;
> +			bus-frequency =3D <300000000>;

Mh, aren't these values depending on your actual RCW configuration?

> +			fsl,qe-num-riscs =3D <1>;
> +			fsl,qe-num-snums =3D <28>;

Current bindings defines:
> fsl,qe-snums: This property has to be specified as '/bits/ 8' value,
>   defining the array of serial number (SNUM) values for the virtual
>   threads.

So '/bits/ 8' is missing.

> +			qeic: qeic@80 {
> +				compatible =3D "fsl,qe-ic";
> +				reg =3D <0x80 0x80>;
> +				#address-cells =3D <0>;
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +				interrupts =3D <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
> +					      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			ucc@2000 {
> +				cell-index =3D <1>;
> +				reg =3D <0x2000 0x200>;
> +				interrupts =3D <32>;
> +				interrupt-parent =3D <&qeic>;

Move cell-index to last position.

> +			};
> +
> +			ucc@2200 {
> +				cell-index =3D <3>;
> +				reg =3D <0x2200 0x200>;
> +				interrupts =3D <34>;
> +				interrupt-parent =3D <&qeic>;

Same here.

> +			};
> +
> +			muram@10000 {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				compatible =3D "fsl,qe-muram", "fsl,cpm-muram";
> +				ranges =3D <0x0 0x10000 0x6000>;

Node address but no 'reg' property? I have no idea if this is okay.
Also compatible (and possibly reg) first.

Thanks and best regards.
Alexander

> +				data-only@0 {
> +					compatible =3D "fsl,qe-muram-data",
> +					"fsl,cpm-muram-data";
> +					reg =3D <0x0 0x6000>;
> +				};
> +			};
> +		};
> +
>  		lpuart0: serial@2950000 {
>  			compatible =3D "fsl,ls1021a-lpuart";
>  			reg =3D <0x0 0x2950000 0x0 0x1000>;
>=20
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240530-arm-ls1021a-qe-dts-093381110793
>=20
> Best regards,
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



