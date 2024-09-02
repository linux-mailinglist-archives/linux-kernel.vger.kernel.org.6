Return-Path: <linux-kernel+bounces-310491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B576967DB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F6A280FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F62C182;
	Mon,  2 Sep 2024 02:10:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8C8F6C;
	Mon,  2 Sep 2024 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243040; cv=none; b=L7KizZUqEQx1vlHBql4aE0vcuhhrPIsRqRrLzyGfxB/O0dhFBrix3Bt9mqOzOWjaE8kkEiockKPCxC5hnOqOd18eEj2QjCm9+hcqHCn1SeEQYOz1QcFh7fr0THmtLJvZLeTtngEj0MhWkDKZcIA/D3ffozpHqu4vn/zV12vUlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243040; c=relaxed/simple;
	bh=NywgQX5uVanACwXn0eOYKwiWw3QHEo8iwJBzG8PXgfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDv8SQsWbUHvf0raV9trcaVtXT7fUBDpM2RH0RgudpndfFNW35W3fTF8faNP6sf90prLqU0dtPFlPTJeRnz991/mDrNC4l6RMWigFM5Dwwy4X5PiFLnt0w2MEp2uJVxBhXxOPm4Ydp664anUeAd+WeGbI+IqG1Cgpr5iHQ1dSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B817C4CEC3;
	Mon,  2 Sep 2024 02:10:38 +0000 (UTC)
Message-ID: <9bc18998-821b-42d1-8c6b-abc528be33f2@linux-m68k.org>
Date: Mon, 2 Sep 2024 12:10:35 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] m68k: remove trailing space after \n newline
To: Colin Ian King <colin.i.king@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240901155846.142816-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20240901155846.142816-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Colin,

On 2/9/24 01:58, Colin Ian King wrote:
> There is a extraneous space after a newline in a pr_debug message.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, looks good.
I have applied to for-next branch of m68knommu git tree.

Regards
Greg


> ---
>   arch/m68k/kernel/setup_no.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> index 37fb663559b4..c926da9d5ec2 100644
> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -138,7 +138,7 @@ void __init setup_arch(char **cmdline_p)
>   
>   	pr_debug("KERNEL -> TEXT=0x%p-0x%p DATA=0x%p-0x%p BSS=0x%p-0x%p\n",
>   		 _stext, _etext, _sdata, _edata, __bss_start, __bss_stop);
> -	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
> +	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n",
>   		 __bss_stop, memory_start, memory_start, memory_end);
>   
>   	memblock_add(_rambase, memory_end - _rambase);

