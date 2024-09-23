Return-Path: <linux-kernel+bounces-335349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3492497E477
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AB128130B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7B372;
	Mon, 23 Sep 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RhVlsKpt"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF80184;
	Mon, 23 Sep 2024 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727053312; cv=none; b=mem2DV3gQ9c7dApWnVpwdbwBmF4GTZE9iQEVvaLXnHTWMlFQXk6iiHtr9+qFF2sQ7SBiNngMe8PL7TvmuDDM86h5/8qR2N+k1yk6gJGL++nvMe0yv7zEozYOI/b76xvzxdAg4Onx2/Wx0r/HrM99nN8rAZGsuvWNHscO3wj5rtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727053312; c=relaxed/simple;
	bh=ozSzYmjcPxsWN4q/ELigqRLFp9XVWfBdPdR26ic71B8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3F0wkxhCfBNE4mO3qgEa60XjLF2YysuQK/kS55J8sz8H0LP9cZEx7uUfKJnH/3fgtcp+cCDsKGEnrgugtxwZT2HOeMTg6abGESlSS5gJshSQrm+AF1i4vcuj/W7CJv0X4/QprZI73+ZGKx+472fKqHkHodadAOzZWUCc96TKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RhVlsKpt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727053309;
	bh=rEz5q50Q88VwaKB4RIe1Y0Mq0OGB9yE2/0HHGblYAQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RhVlsKptaqDaqD49XfvrnNKT4IGbhX3ygGKBW1df8GlyNiM+scf6o2qMlJSdwDl0+
	 J/N/6KVkxNlV25Ap+oMrDDpi6vk7KcSLzRAdfV1s3IvqVgycoLUK0nMZ6UAi/gF3X1
	 +Pvxa7x8V6wOr86F27rNobBbvg1q6iZOR8XQZ9Iy7DUOVXpiVKNQxAZhGDprawRPKp
	 sbY+M0paacteznirwn8F/Q8MV+dvFFCmnheEfiTipP4L1rmAwuAmooSDQzx9SaWpls
	 onC2QNC/CaOOxN8WeqPrJNUMiVv/whbR/5cv2tvt4BGcNBnTTg+y6UIk1m667Ig2SX
	 buWVmzzhTJWDQ==
Received: from [192.168.68.112] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 60638640E8;
	Mon, 23 Sep 2024 09:01:48 +0800 (AWST)
Message-ID: <59baad7d486637f7f82f2730181734eca047efd7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v19 1/2] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 23 Sep 2024 10:31:47 +0930
In-Reply-To: <20240920070449.3871705-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240920070449.3871705-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 15:04 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Revise Yosemite 4 devicetree for devices behind i2c-mux
> - Add gpio and eeprom behind i2c-mux
> - Remove redundant idle-state setting for i2c-mux
> - Revise address of max31790 devices after i2c-mux.
> - Fix warnings reporting by dts checking tool.

Can you be more specific here? If you've had to fix existing warnings
that the devicetree produces you should split those out into commits
separate from adding further nodes. Instead, if you're just fixing
warnings that this patch itself introduced then you should drop this
comment as it's just a process issue. Process issues are better
described in the patch notes or series cover letter, not in the commit
message.

Generally if you feel you have to list the changes you're making in the
commit message for a single patch, it's a sign that you patch should be
split into multiple commits anyway.

> - Remove led_gpio pca9552 since there is no binding document.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 539 +++++++++++++++---
>  1 file changed, 466 insertions(+), 73 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..6b4efb5fbd83 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
>=20

...

> =20
>  &i2c11 {
>  	status =3D "okay";
>  	power-sensor@10 {
> -		compatible =3D "adi, adm1272";
> +		compatible =3D "adi,adm1272";
>  		reg =3D <0x10>;
>  	};
> =20
>  	power-sensor@12 {
> -		compatible =3D "adi, adm1272";
> +		compatible =3D "adi,adm1272";
>  		reg =3D <0x12>;
>  	};

Can you please split the adm1272 compatible changes out to a separate
patch and include an appropriate Fixes: tag?

Andrew

