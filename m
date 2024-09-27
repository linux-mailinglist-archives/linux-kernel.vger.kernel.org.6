Return-Path: <linux-kernel+bounces-341309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E3987E14
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8611C1F22326
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BD15C133;
	Fri, 27 Sep 2024 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="R0HibH3f"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E831F94A;
	Fri, 27 Sep 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416840; cv=none; b=uJjyx2ELRNl7U15urGwflbqq+rJH4QLoD8TGGjwgsiZD8bF+HcncpvlRzZpyECabkhWW6qKAuuWa8WsxXYobV4+wci/bfsni1ObZ09QhvjIn9ZIo1THnJ6PB3mdhRzXN2Puqeyj8HAPJL/3U7ozREfQVq2N21waRWzp6hQdKvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416840; c=relaxed/simple;
	bh=nggBhNg9nszAJ/mkTPPZDmqlqFn8NkyEtH/hhPeczzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cn4Pckbcd7WKdhh4OGzHPmgZTaX+2UEr4d/efXk/xilcr4M4u+w04aGZcWuaXv/BFds61H5/zxHhQPTW8Frazw13UkeGvv1UMSAJcfwS0n1tSz48ngZrxCOmMJYMoKVpFnWv4x4Y0CB9PbS8RHxRJW5K8oGk2NW6BtERY1loBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=R0HibH3f; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727416836;
	bh=699NuMm8IMQ7ey19zdyLF9Pg8zDH6KqpN6yn26NXjVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R0HibH3fYTr/hp02LdHjsuH2UCxY/65xYzRsbx4lLJCw6saiMzkXpO6YO3/H+minT
	 HY4FxJUe8ZDChK1AvRYUz01YCJzLLB+BSXzWAXqq58p50R89L8FTXmtN0vIgCh85r2
	 7HWpjG1WMWD2XmE+5dD282jwGAsAS8W1X4V0bBIQQNifzp7WuqhVZXjpkOsFqSGBXJ
	 I1NAaplNiexstdikhJZNBaoAhMh42urYL4I69/YVvdHQyCws7gipCvsctEhLdVFVWE
	 DafIJBXj+t3cD9h6HeOJt6PKtamzNT/7YnwDq5+MvZjZBkZaFWF2tpVoJ9v/i7tzez
	 QICycZGmRIHqg==
Received: from [192.168.68.112] (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 13D0265029;
	Fri, 27 Sep 2024 14:00:36 +0800 (AWST)
Message-ID: <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 27 Sep 2024 15:30:34 +0930
In-Reply-To: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 09:34 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Remove the redundant space in the compatible string of adm1272.

In this case the space is not redundant, it's just incorrect, the
compatible string doesn't match any specified. Do you mind fixing the
wording?

>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Can you please add an appropriate Fixes: tag?

Thanks,

Andrew

> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..7ed76cd4fd2d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -284,12 +284,12 @@ &i2c10 {
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
> =20


