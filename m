Return-Path: <linux-kernel+bounces-282178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCE94E07F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162B31C20A7E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7C12206E;
	Sun, 11 Aug 2024 08:27:34 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BB200A3
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364853; cv=none; b=eH5EazlnZ77kn4DK3L4B6xUUxBOQwVocEYw8vgFDJD5+M8PVjDR71CFVnTdepe6sSw8a7BU5IfYvyYuNxc+3wWMJDkAC7jpbyqArYUBg2iQ9fdhDLG993tmc4ueXJHKiQClFTvUpbgV9sh2Zn55W6cZRuJAs0bgygjs87qMuuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364853; c=relaxed/simple;
	bh=y0guvFZ8p5lFnkpPgfWzA+FUF0sAYJKOFfIGKGqpiDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMGjzT9/wbKzUcHKlCnUnM6HdDhr/Yrqh40WCPsisRCfu6NiSphBOxsKkiXoA5s06dtDI9FIHibFVANG0skia7RR+OOYBqxBdq2+QHAL3qgK85+YDX/qKkqKP+C+qrqld8DtNvp0KgVgvW1gI0wkIsPgXuI/fT/FU1LeYm5YV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B8B37C6238
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:21:51 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B3CCC0003;
	Sun, 11 Aug 2024 08:21:41 +0000 (UTC)
Message-ID: <2171ee94-ec78-4146-b6fa-9aecbb99efd8@ghiti.fr>
Date: Sun, 11 Aug 2024 10:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Make riscv_isa_vendor_ext_andes array static
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240807-make_andes_static-v1-1-b64bf4c3d941@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240807-make_andes_static-v1-1-b64bf4c3d941@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 08/08/2024 02:27, Charlie Jenkins wrote:
> Since this array is only used in this file, it should be static.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407241530.ej5SVgX1-lkp@intel.com/
> ---
>   arch/riscv/kernel/vendor_extensions/andes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vendor_extensions/andes.c b/arch/riscv/kernel/vendor_extensions/andes.c
> index ec688c88456a..51f302b6d503 100644
> --- a/arch/riscv/kernel/vendor_extensions/andes.c
> +++ b/arch/riscv/kernel/vendor_extensions/andes.c
> @@ -8,7 +8,7 @@
>   #include <linux/types.h>
>   
>   /* All Andes vendor extensions supported in Linux */
> -const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
> +static const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
>   	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
>   };
>   
>
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240807-make_andes_static-ec524bae21f2


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


