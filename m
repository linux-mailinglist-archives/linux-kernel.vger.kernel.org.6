Return-Path: <linux-kernel+bounces-376110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C951B9AA030
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FA11C2168E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2BA199FDE;
	Tue, 22 Oct 2024 10:38:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D273C15574F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593538; cv=none; b=a9F3Ps0fUSrdq40HJAb/8fCGgLViBn3SBJeMXAZutVo/2pI091SL3mV3Gn+YwMBFbfyclOpn14Ln1topyTh9wk5/bma7mDM+c13ZyAc3qHvK5ya37SC4RKASP0O6NmE5Ih2gxgUMJlYRHT+Bq562LxY3++0jab4XqOa3KTh3rR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593538; c=relaxed/simple;
	bh=F83EyKFMQOyvBEdzWoHL44fvx1r2PCtrUVdBNSUwcO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns4/3+iVSjMdoRe//fj1+CbnZahz16LUs/l2G005NqbTrzZIL0oLbwQbU/V7WvR32BtQHbqQ8V7ZF6YagzaHkuZa53rZwfhkjhC4ScLmMpHi8LIJCbn+YvkAQ5N3LNe/lFH4rQpVArGjh4kvVjKmSmL3/slwsVtNZCvsnNNwZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2CBA1042;
	Tue, 22 Oct 2024 03:39:25 -0700 (PDT)
Received: from [10.57.65.71] (unknown [10.57.65.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25E0D3F71E;
	Tue, 22 Oct 2024 03:38:51 -0700 (PDT)
Message-ID: <fca25741-c89f-43ea-95af-5e3232d513fc@arm.com>
Date: Tue, 22 Oct 2024 11:38:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM/nommu: Fix typo "absense"
To: WangYuli <wangyuli@uniontech.com>, linux@armlinux.org.uk, jgg@ziepe.ca,
 jroedel@suse.de, robh@kernel.org, catalin.marinas@arm.com,
 jsnitsel@redhat.com, robin.murphy@arm.com, baolu.lu@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@st.com, sza@esh.hu, benjamin.gaignard@linaro.org,
 arnd@arndb.de, rmk+kernel@armlinux.org.uk, hch@lst.de,
 guanwentao@uniontech.com
References: <104F90E5B8D0EC97+20241017032929.105068-1-wangyuli@uniontech.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <104F90E5B8D0EC97+20241017032929.105068-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 04:29, WangYuli wrote:
> There is a spelling mistake of 'absense' in comments which
> should be 'absence'.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/mm/dma-mapping-nommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index 97db5397c320..fecac107fd0d 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -39,7 +39,7 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
>  		/*
>  		 * Cache support for v7m is optional, so can be treated as
>  		 * coherent if no cache has been detected. Note that it is not
> -		 * enough to check if MPU is in use or not since in absense of
> +		 * enough to check if MPU is in use or not since in absence of
>  		 * MPU system memory map is used.
>  		 */
>  		dev->dma_coherent = cacheid ? coherent : true;
> -- 2.45.2
> 


Unless it is already taken by someone, please, upload the patch in
RMK's patch system [1]

[1] https://www.arm.linux.org.uk/developer/patches/


Vladimir

