Return-Path: <linux-kernel+bounces-319685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B71970088
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDE3B22846
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDF131BAF;
	Sat,  7 Sep 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ph9P0haq"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364FEEAE
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725692698; cv=none; b=a4gfiMwocYcFiODyHorwpVhCFx1Q+GJUqvz1HwVvl3iaYht4Wl0NHNroNbtO7XS+WwBU82Uf9c8ZxIhzGQKSA5e043ntw8cekgKziKXg7zVn0W0R0ZcPyxNJGmIXInhMhoaitoOXu5Z9Zc9O9NSfOGUlvZY5khJU6t3AsdKuwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725692698; c=relaxed/simple;
	bh=ZLHMe9jy8+HsVZINDX06hNiggV9hjGuZ8jU3JjSoxqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0hjuO7MQ/yNJNt8tVsnOvRuBBPiAbJ+6vCEc8kkmLwMskLCrRONs4xLNQzkydRlLS0oEabcTPDy0Qnj52o2nQQCIZuewWD3jCsAK0ppmoevnZXBhN0ep7f3l/JZ7dFeh51eH8Dc6zVRM4I5g27+VxoVAaR//12ySSgTco/Re/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ph9P0haq; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id mpV5s8vX641DAmpV5s0s85; Sat, 07 Sep 2024 09:04:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725692693;
	bh=ws6woaw3V59PogyDNQ6FMv2g3JohNKI2FGtYQY5L58I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ph9P0haqZtBjA0qJLG0dPNjjC55IG/FYry9togkk2reDnvuHXC686t6x0u7Tq1hNW
	 Kj8Ss4m63CGDlmqvO7YbCNZ+PJYDnN8bVLHaQiV4RTDkcCmIv2BwPXSOT10fUkPM+C
	 im84USas1ww6OEHJcM0gdrrp1ke81vLVCvx54jL9LSdlWJv1CDB2pNy8hkVRC9PK9I
	 3Eo0ww9gDgjSdmOdoNAcKYpGDJaiFTw2bXwBciqvLHfek5DJxYsf1WHVjcOeXKjduO
	 H4Smx1nSl2QuUq9UkJVdsb+CADj7cJVJNe2Hth54rKtoWEFX6Wh4nTOmUQgsTxe5ro
	 zevYN9RzzEyrQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 07 Sep 2024 09:04:53 +0200
X-ME-IP: 90.11.132.44
Message-ID: <47e0745c-e7a4-4201-b1bf-bb8e44e5911d@wanadoo.fr>
Date: Sat, 7 Sep 2024 09:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add support for gd25 and gd55 series chips.
To: Renjun Wang <renjunw0@foxmail.com>, tudor.ambarus@linaro.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_983A0FB4662661C03E98E1AC214E32179F0A@qq.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <tencent_983A0FB4662661C03E98E1AC214E32179F0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/09/2024 à 08:32, Renjun Wang a écrit :
> Add support for gd25lq255, gd25lb256, gd25lb512m, gd25b512m, gd55b01ge
> and gd55lb01ge. All these chips are tested on Rockchip boards[1].
> 
> [1]https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/mtd/spi-nor/gigadevice.c
> 
> Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
> ---
>   drivers/mtd/spi-nor/gigadevice.c | 43 ++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
> index ef1edd0add70..f0069a4adbbf 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -61,6 +61,7 @@ static const struct flash_info gigadevice_nor_parts[] = {
>   	}, {
>   		.id = SNOR_ID(0xc8, 0x40, 0x19),
>   		.name = "gd25q256",
> +		.size = SZ_32M,

Hi, just for my understanding, why this change?

If it is a fix, should it be done a separate patch?
Or should it be mentioned in the commit description?

CJ

>   		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
>   		.fixups = &gd25q256_fixups,
>   		.fixup_flags = SPI_NOR_4B_OPCODES,
> @@ -82,6 +83,48 @@ static const struct flash_info gigadevice_nor_parts[] = {
>   		.size = SZ_16M,
>   		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>   		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id = SNOR_ID(0xc8, 0x60, 0x19),
> +		.name = "gd25lq255",
> +		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixup_flags = SPI_NOR_4B_OPCODES,
> +	}, {
> +		.id = SNOR_ID(0xc8, 0x67, 0x19),
> +		.name = "gd25lb256",
> +		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixup_flags = SPI_NOR_4B_OPCODES,
> +	}, {
> +		.id = SNOR_ID(0xc8, 0x67, 0x1a),
> +		.name = "gd25lb512m",
> +		.size = SZ_64M,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixup_flags = SPI_NOR_4B_OPCODES,
> +	}, {
> +		.id = SNOR_ID(0xc8, 0x47, 0x1a),
> +		.name = "gd25b512m",
> +		.size = SZ_64M,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixup_flags = SPI_NOR_4B_OPCODES,
> +	}, {
> +		.id = SNOR_ID(0xc8, 0x47, 0x1b),
> +		.name = "gd55b01ge",
> +		.size = SZ_128M,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixup_flags = SPI_NOR_4B_OPCODES,
> +	}, {
> +		.id = SNOR_ID(0xc8, 0x67, 0x1b),
> +		.name = "gd55lb01ge",
> +		.size = SZ_128M,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixup_flags = SPI_NOR_4B_OPCODES,
>   	},
>   };
>   


