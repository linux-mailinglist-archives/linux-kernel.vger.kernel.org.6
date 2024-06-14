Return-Path: <linux-kernel+bounces-214886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAEE908B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5671C21249
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B121990AE;
	Fri, 14 Jun 2024 12:20:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224EC195F03;
	Fri, 14 Jun 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367643; cv=none; b=mfQgkeIi+JLzznoGjW8dnaKIt+BktUufIhRvDmp0vBgdFRhuLYoEYCtLQvU1Mbn9wNJyu0IrVzXa85GpaMjhgcBn3qKyVH6dFDHhWhL/QmiMzJiQ7G/lP64zLtjdAIUCkeNl7gG9eS208opMWKkwNBYtMd9stuts5sidv0DgKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367643; c=relaxed/simple;
	bh=AQjmUgnkIYBObU9R4yF5y+8pGugJxUIcztwj75zUnTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fp8DOsRPzG9AChtm86ae5iiGV1r9MzzrcQW1FDvGLvbhLJO5tC0pTw8z0bvra+Or1fhEE7XokgfgOT1vlhhJ8hg6XY1oxu89Du1Tsmj6iIDwfoWb9gU/l0Np69dajtrUMYbM0z7iF1pmPHp56indN1lXAba25KRrZA/XCvToeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 176E7FEC;
	Fri, 14 Jun 2024 05:21:06 -0700 (PDT)
Received: from [10.57.71.136] (unknown [10.57.71.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572BD3F64C;
	Fri, 14 Jun 2024 05:20:40 -0700 (PDT)
Message-ID: <f22db70d-01da-4b49-a13c-6c4639215468@arm.com>
Date: Fri, 14 Jun 2024 13:20:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240613-md-arm-drivers-iommu-v1-1-1fe0bd953119@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240613-md-arm-drivers-iommu-v1-1-1fe0bd953119@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-14 2:14 am, Jeff Johnson wrote:
> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/iommu/iova.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d59d0ea2fd21..16c6adff3eb7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -1000,4 +1000,5 @@ void iova_cache_put(void)
>   EXPORT_SYMBOL_GPL(iova_cache_put);
>   
>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
> +MODULE_DESCRIPTION("IOMMU I/O Virtual Address management");
>   MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240613-md-arm-drivers-iommu-f637be6ec5c8
> 

