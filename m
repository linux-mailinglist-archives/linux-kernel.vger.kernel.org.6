Return-Path: <linux-kernel+bounces-172576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B94B8BF3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826CAB20E50
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0A65C;
	Wed,  8 May 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BFGjaM/D"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979F399;
	Wed,  8 May 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715130043; cv=none; b=oFkHcZqu6LUkPHxoPu2PgoDM7Q2dUNov0+GrHlKB1Zh9N4lAAFdKsJ+HSNgdpFSJY2zzxZ1ymm5oSg/o5Hf218bOz89DTbSgDG3obzuYe0c6G81/BR/5S3Z3C5ILbXZwli5Tn8fddZYvmlvZmAbqlEtOEJt8W2yM12WVs6JFSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715130043; c=relaxed/simple;
	bh=/8Bq7FXsUxoAh3ffhhufUURn58m0DQuS71n5CXE7GAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duzC6+PxC/TtuRVaPg8p6ebMT2ApaqIaSadn9op8LLdmmRY5CAmxD7XE+GTmYjpZwMKnPLFO2dSibV9ZOZ5DEJlejTIgqO8ZGralAwEgazEaMdEnjETk/hOAg32RiFk/epJ46lCNZZOk3agODNEVtdwfVHGGF67OxBg+gGIDaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BFGjaM/D; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-82-209.adl-apt-pir-bras31.tpg.internode.on.net [14.2.82.209])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CC19A20016;
	Wed,  8 May 2024 09:00:30 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1715130033;
	bh=kMjFTG/O0qrpfW1eF1AuxbXY76Q+hOssQVvDEfpATf4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BFGjaM/DkrZvajCW6PMQ18HRX7vtyY7LVGbeDxBsQQcUCM0C3AtkktGVqvLIwxoLS
	 cVE0p/hjrNyGMSgR8TThdds+fLF8whBw4153a6VXRLArCIJj5dNAZIeqa1QgYx0s0s
	 P0su5qGrayeU6BCvf41pGwDnau0r3tl9qO16melnWDK6WjF0LoTs05ib6+pHcDBAHA
	 J++C3ZfBln93RL/Yp2QAB8w40vMPaeJ80gaKoYPfV/IPX1NTLrgpSd8dLRKl8ArAjr
	 2vX0QvWNdR9sRl3uS9064m2PEaSTysxSJ8ixQD8npnROaMI/on6jWvJO8MJh1Pd/Cj
	 Qdio8kWqNb+ag==
Message-ID: <db966c501288c73ac50a86aa2e5884e6cfc28715.camel@codeconstruct.com.au>
Subject: Re: [PATCH v8 0/2] Change email sender
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kelly Hung <KellyHung@asus.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com
Date: Wed, 08 May 2024 10:30:28 +0930
In-Reply-To: <20240507092109.6018-1-KellyHung@asus.com>
References: <20240507092109.6018-1-KellyHung@asus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kelly,

On Tue, 2024-05-07 at 17:21 +0800, Kelly Hung wrote:
> Requesting assistance from ASUS IT, I obtained a new smtp account.
> So send the patch again using new smtp account.

Ah, thanks, however Joel's already sent a PR to the ARM SoC maintainers
with your patches. Sorry that we didn't communicate that too well.
Here's the PR:

https://lore.kernel.org/lkml/CACPK8Xd2Qc9MQUJ-8GuRjmyU50oMHpmmHPHLqAh9W_1Gy=
qi2ug@mail.gmail.com/

>=20
> Kelly Hung (2):
>   dt-bindings: arm: aspeed: add ASUS X4TF board
>   ARM: dts: aspeed: x4tf: Add dts for asus x4tf project
>=20
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
>  3 files changed, 583 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
>=20
> --
> 2.25.1
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> This email and any attachments to it contain confidential information and=
 are intended solely for the use of the individual to whom it is addressed.=
 If you are not the intended recipient or receive it accidentally, please i=
mmediately notify the sender by e-mail and delete the message and any attac=
hments from your computer system, and destroy all hard copies. Please be ad=
vised that any unauthorized disclosure, copying, distribution or any action=
 taken or omitted in reliance on this, is illegal and prohibited. Any views=
 or opinions expressed are solely those of the author and do not represent =
those of ASUSTeK.
>=20
> For pricing information, ASUS is only entitled to set a recommendation re=
sale price. All customers are free to set their own price as they wish.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Unfortunately these footers aren't helpful. The kernel's mailing list
etiquette documentation has more info:

https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-d=
isclaimers

Andrew

