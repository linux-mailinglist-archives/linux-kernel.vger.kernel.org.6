Return-Path: <linux-kernel+bounces-448363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454BF9F3F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD58166EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6674040;
	Tue, 17 Dec 2024 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu2UGPka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89CEED8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396152; cv=none; b=b64W3OBk9q7w40Curg/FochArAa9nxT+dknFc/ONvLtY1nEoGc8IhzShFEp4F9a2fOJYrWp9+ORVvF4wmhswLxtGx+5Q8+Vf/JPRS+j/tH7Jko9cFg3cewBm0QmGiLzlnpKI45Vn1ICtaeDMiz7WH1dQCYYhv1/dFZ5DzVvbE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396152; c=relaxed/simple;
	bh=kAiHX095irOKqg2/zIy48DjsF9gMYEANVnrea2q89yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMmyBVtWB8Nrn1T6ttM4OCsx6fzIPR7yay2I5J/2/t3RHW/CHr7Kh0KHSl0sn3F7aMaCoeg/nNlK7Y9afOAahrfl6+xr+fYdb2/IAzGkLaphY2St1uDvJCD7NrN4kT6fP37KK4QbWWSxhWGS5SpkUE/ykC+L2at7WSI8+obP3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu2UGPka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDD6C4CED0;
	Tue, 17 Dec 2024 00:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734396152;
	bh=kAiHX095irOKqg2/zIy48DjsF9gMYEANVnrea2q89yY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pu2UGPkauX6ryKW63mZRrR2cHUBmhae8C6XRLKk9pYvwKmn70u67owsvG57oeGzGu
	 zM9HJPpHSkzoo1dyBR7ZKMBgTYpfHNm8Yvjo7NSX4CDj0LV2eDY2o5LkX7LurnHVUm
	 LH8qJNyCztf0zdI7M+zSYCAasoRt8NZu4G9gbCmpOH5pilYpz/nHbshFeLRmE4cCnH
	 mweI+G5zfOcJ2l6kpmwNMbFT5BgNJGTinfoBhpro7E0v7f06++Dx6OanEQd5Cf0oR1
	 ujYxDQnojR//HMUWZD7qnj88Ljo2vnwkfuyxYF1GzRMsmJgDAktOmtQx0mthPIBf9i
	 6rrsaMY2jr1Og==
Message-ID: <4b6088e7-88ec-4181-9f4a-f8411a11a4e7@kernel.org>
Date: Mon, 16 Dec 2024 18:42:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] nios2: Use str_yes_no() helper in show_cpuinfo()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
References: <20241209110640.39956-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20241209110640.39956-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 05:06, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/nios2/kernel/cpuinfo.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
> index 338849c430a5..7b1e8f9128e9 100644
> --- a/arch/nios2/kernel/cpuinfo.c
> +++ b/arch/nios2/kernel/cpuinfo.c
> @@ -143,11 +143,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   		   " DIV:\t\t%s\n"
>   		   " BMX:\t\t%s\n"
>   		   " CDX:\t\t%s\n",
> -		   cpuinfo.has_mul ? "yes" : "no",
> -		   cpuinfo.has_mulx ? "yes" : "no",
> -		   cpuinfo.has_div ? "yes" : "no",
> -		   cpuinfo.has_bmx ? "yes" : "no",
> -		   cpuinfo.has_cdx ? "yes" : "no");
> +		   str_yes_no(cpuinfo.has_mul),
> +		   str_yes_no(cpuinfo.has_mulx),
> +		   str_yes_no(cpuinfo.has_div),
> +		   str_yes_no(cpuinfo.has_bmx),
> +		   str_yes_no(cpuinfo.has_cdx));
>   
>   	seq_printf(m,
>   		   "Icache:\t\t%ukB, line length: %u\n",

Applied!

Thanks,
Dinh

