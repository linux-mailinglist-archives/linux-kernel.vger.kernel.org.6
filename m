Return-Path: <linux-kernel+bounces-410590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA89CDDA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC4AB24FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CF31B6D15;
	Fri, 15 Nov 2024 11:42:56 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BD52F9E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670976; cv=none; b=Z211lBtfQ3UGIRqrf1AkRMgE/Dw7tcAPygWNuwBFBaKJum+I3lzCUXXT9103BxiFQBALkv9OAGAr5uGDXuIKICqleIm9B9/9LAonc6HJ3oIx24g5BtaBvUyt9bPlO67gczy3SEJxQYtrxiLw59rNOOHSqmPsbF9iiXvlal0spzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670976; c=relaxed/simple;
	bh=dqUHp0K8+Qu//0hhMfdsiLORn6fHR8S3gPMKkfAbYUc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=WWsP7g05Vkm0TTr6UVWlMeQoAYYAgMmkGPdljhwI2TpW4WiS2mlt+vyhlkDxG9y0kd+iBq2rF9NC8e84P4D35dsLdjPeHY+srn8H4fnp8PPtcxKdZOJU4yOfQHiqNhKJkpuCX+kOae8Rv1/x2WSpVCqjW4mARA0yeVfd6IxpHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 300383B8;
	Fri, 15 Nov 2024 12:33:02 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Nov 2024 12:32:53 +0100
Message-Id: <D5MPWZF8NUW9.1VVRAD59LVVV2@kernel.org>
Subject: Re: [PATCH v3] mtd: spi-nor: atmel: add at25sf321 entry
Cc: <linux-mtd@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Marcus Folkesson" <marcus.folkesson@gmail.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>
X-Mailer: aerc 0.16.0
References: <20241115-spi-nor-v3-1-93ec584177cb@gmail.com>
In-Reply-To: <20241115-spi-nor-v3-1-93ec584177cb@gmail.com>

Hi Marcus,

On Fri Nov 15, 2024 at 12:21 PM CET, Marcus Folkesson wrote:
> Add entry for the at25sf321 32Mbit SPI flash.
>
> This flash is populated on a custom board and was tested at
> 10MHz frequency using the "ti,da830-spi" SPI controller.
>
> Link:
> https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=3D1608801
>

Please put the URL into the same line as the link and no empty line
between your SoB and the link.

> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

..

> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 45d1153a04a07b7c61f46b117311b24ab695038f..ff9462d9b8ed83f44ee99a7f3=
b70b99b4d455e9b 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -238,6 +238,11 @@ static const struct flash_info atmel_nor_parts[] =3D=
 {
>  		.flags =3D SPI_NOR_HAS_LOCK,
>  		.no_sfdp_flags =3D SECT_4K,
>  		.fixups =3D &at25fs_nor_fixups
> +	}, {
> +		.id =3D SNOR_ID(0x1f, 0x87, 0x01),
> +		.name =3D "at25sf321",

No name please. As you've already found out the ID will be reused
and the name is just misleading.

> +		.size =3D SZ_4M,
> +		.no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	},
>  };

Otherwise looks good and with that above fixed:

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

