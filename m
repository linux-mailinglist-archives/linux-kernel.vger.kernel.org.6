Return-Path: <linux-kernel+bounces-551593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92AA56E51
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45888168EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B685B23ED63;
	Fri,  7 Mar 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mi68Tnua"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635F23CEF9;
	Fri,  7 Mar 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366201; cv=none; b=Q5ckSpqsTs8kMm++EynWFfTERjg3+67T5hfwyt+qqHtTFQSEgPJSAcocEdNZlmDbTp1HzONqqNfTw421O7MZoyR7/ge0WfKdM/AYKOxOgjRL+Pc15OZ7VIFtn8YFX+ln0aXODXuPuiiAEYdqEEdmpDDUyaQXRBYjGZih/IgZDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366201; c=relaxed/simple;
	bh=BkdzNg21dY4wGEzq0NCMQlpFDcyv1zsRYtIT0j3L5Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YuaGmFtM5XJhi0w/DSBqBBQQ6NnjBj+yFulMbtLt3sgZ0yH+KKqmUNkvk2Rex47bNRWfVg6EJkLbbsm3vfn2n9pzyX3Mnufa8esLop8NRDoMEhzwo9JfJBEAndmmIGwMHn5x42u7hffJt2nOCkdIJAW3Vmjdr5eoRJx2ZvjwVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mi68Tnua; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A31744326;
	Fri,  7 Mar 2025 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741366196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BplyvVDozmPKMflokHePn2tVjQH8dGQbXJDI5IAAd7M=;
	b=mi68TnuaVw8Kt0xQOuiK29+qCxeKmfezbkHt/2Ynt1WpV5oaPbJ5YP82QQZr524HHcGhOl
	bj7Q2qUHj8Wlc26xQwE7YarfG5h15cWTYJydyrik8m0OAHYVhrl9q6paB06Kzao9N2IVeJ
	ncibjlYXfyFoWDb13pCnuOPFSGpiVisHgxqMQ91nFqFQv9E6vTX2Csgk4a9ZPbt/D1GoD4
	Ecb2a0zmjyVWw6thbtxrRUe1a2lbk54nffUXmpRmze50Z4E+Np35q0f6VNbPaRsWCv39oZ
	bqrcD6ZCIl7o3qZdAFmma4oWM18q9lyd16njXdeZDMniuS8Nv0xbfrERMwQi0g==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: ***SPAM*** [PATCH 1/2] arm64: dts: marvell: armada-8040: Align
 GPIO hog name with bindings
In-Reply-To: <20250115211727.194142-1-krzysztof.kozlowski@linaro.org>
References: <20250115211727.194142-1-krzysztof.kozlowski@linaro.org>
Date: Fri, 07 Mar 2025 17:49:55 +0100
Message-ID: <87v7sk23bg.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgfgsehtqhertddttdejnecuhfhrohhmpefirhgvghhorhihucevnffgoffgpffvuceoghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgffhgedvhefgtdejvdethfdvieekgfetuefhueekteetgfdvueeutedttdekgeevnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemledtrggumedvvggutdemlegstgdtmeeivdgstdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemledtrggumedvvggutdemlegstgdtmeeivdgstddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehsvggsrghsthhir
 ghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: gregory.clement@bootlin.com

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warning:
>
>   armada-8040-clearfog-gt-8k.dtb: sata_reset: $nodename:0: 'sata_reset' d=
oes not match '^.+-hog(-[0-9]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  .../arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b=
/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index 225a54ab688d..90ae93274a16 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -371,25 +371,25 @@ &cp0_pcie0 {
>  };
>=20=20
>  &cp0_gpio2 {
> -	sata_reset {
> +	sata-reset-hog {
>  		gpio-hog;
>  		gpios =3D <1 GPIO_ACTIVE_HIGH>;
>  		output-high;
>  	};
>=20=20
> -	lte_reset {
> +	lte-reset-hog {
>  		gpio-hog;
>  		gpios =3D <2 GPIO_ACTIVE_LOW>;
>  		output-low;
>  	};
>=20=20
> -	wlan_disable {
> +	wlan_disable-hog {
>  		gpio-hog;
>  		gpios =3D <19 GPIO_ACTIVE_LOW>;
>  		output-low;
>  	};
>=20=20
> -	lte_disable {
> +	lte-disable-hog {
>  		gpio-hog;
>  		gpios =3D <21 GPIO_ACTIVE_LOW>;
>  		output-low;
> --=20
> 2.43.0
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

