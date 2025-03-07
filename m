Return-Path: <linux-kernel+bounces-551594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF0BA56E54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1325A1898A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC0523F40E;
	Fri,  7 Mar 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dSwAmMPX"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0A23F296;
	Fri,  7 Mar 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366211; cv=none; b=EYT1jyG/Up8PrSQkEIBPw0IRZqBnAXh4Ws/qjyaa6f/ASbMSJcMwJi587+iiNpWz6FUbTomIz7m4bajHog0pxHSlgEIgpYRrx62cjWM/5TNyt8qQuD+IRZZlDAvMdTSKDGSm/dG2WPj7m8NxAeM/7lpQGpKLsTneUFVlMuCFW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366211; c=relaxed/simple;
	bh=kh4EMQTN3dA5uP/tWptGhinVjmpozCvlQpRfPlWoHvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P15saYsQuJwIMlLkcqsPTCo7kLeOZkqYciBCFqLl2kvJTRbMP61+KiO7hIY08ikKfTQ4mLr/ze/9YRqrlP3DEeOWsCj1ite4w0eGtWz+Pui5IyihnD7NjR0mRwSRHG5bdi4Df2vXQBu5lg6El3uV42zdiBB17YBwWva5CcN6eiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dSwAmMPX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF12C20457;
	Fri,  7 Mar 2025 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741366207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=er5swXWpkzKiG2YOJuYh+0MhuxsAcETMofMo3e4cVbc=;
	b=dSwAmMPX0XxGWc1amRFX5TEIMwxJBnC+Zlvg7U17tdj1DhqUqHw1uVmcHajy0fKle53yxk
	JEtSK5sYffqXMsd17h04cOr182u508EAApybN30hr6zInkYSqeJq4yj1CoKByEBfRM5EIg
	3dQSo6tVeKc/6IbgL1eAw721D11B2L/uUsgTvofB34pMzqQCb9qTk7CWUV+KUbSkuE9VaV
	YCUT5yFhMg8mQujISMgZj8fPCDfjQPNZNnVocreg7qqQP63efWF52iA8g5yCoGTfdwLgQN
	hwzPs8tdkMDxBRdP4CSBxtD8AFp+JIbMgSl6YeEnzCuUEcHFSr13SkNQtQp1dA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: marvell: kirkwood-openrd: Align GPIO hog
 name with bindings
In-Reply-To: <20250115211727.194142-2-krzysztof.kozlowski@linaro.org>
References: <20250115211727.194142-1-krzysztof.kozlowski@linaro.org>
 <20250115211727.194142-2-krzysztof.kozlowski@linaro.org>
Date: Fri, 07 Mar 2025 17:50:06 +0100
Message-ID: <87seno23b5.fsf@BLaptop.bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgfgsehtqhertddttdejnecuhfhrohhmpefirhgvghhorhihucevnffgoffgpffvuceoghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgffhgedvhefgtdejvdethfdvieekgfetuefhueekteetgfdvueeutedttdekgeevnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemledtrggumedvvggutdemlegstgdtmeeivdgstdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemledtrggumedvvggutdemlegstgdtmeeivdgstddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehsvggsrghsthhir
 ghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: gregory.clement@bootlin.com

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warning:
>
>   kirkwood-openrd-ultimate.dtb: p28: $nodename:0: 'p28' does not match '^=
.+-hog(-[0-9]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/marvell/kirkwood-openrd.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/marvell/kirkwood-openrd.dtsi b/arch/arm/bo=
ot/dts/marvell/kirkwood-openrd.dtsi
> index 47f03c69c55a..9d7cff4feada 100644
> --- a/arch/arm/boot/dts/marvell/kirkwood-openrd.dtsi
> +++ b/arch/arm/boot/dts/marvell/kirkwood-openrd.dtsi
> @@ -53,7 +53,7 @@ mvsdio@90000 {
>  			cd-gpios =3D <&gpio0 29 9>;
>  		};
>  		gpio@10100 {
> -			p28 {
> +			p28-hog {
>  				gpio-hog;
>  				gpios =3D <28 GPIO_ACTIVE_HIGH>;
>  				/*
> @@ -71,7 +71,7 @@ p28 {
>  			};
>  		};
>  		gpio@10140 {
> -			p2 {
> +			p2-hog {
>  				gpio-hog;
>  				gpios =3D <2 GPIO_ACTIVE_HIGH>;
>  				/*
> --=20
> 2.43.0
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

