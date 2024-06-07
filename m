Return-Path: <linux-kernel+bounces-205925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B290023C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7221F27B57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F524188CD5;
	Fri,  7 Jun 2024 11:34:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9F92837F;
	Fri,  7 Jun 2024 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760088; cv=none; b=rpXEHnzUopFQC/sNry+2Kxw3XBnOElBXtHPGvwrTz0Z3Z2Vdj7/rwTXvhrByRxK1+NmNIS0HM9muft/gSoHKgHVOBSnMBomcrRF4uENfmQEd3eQZjL/crIXMDKyByVz9cttKXE+lVFJ428BwuhvTzeF8edGLR+96KpdF6C+eztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760088; c=relaxed/simple;
	bh=mbG89FjHAxa1gznB6DfiZPNoSOm4l0OCZ9Vw9BRkHMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHXi6AZq35uO5zzNNYWawZi6nIqhgyET+JoKElEim0Dl076XrkQbM55DGw3gVBfBWh/Y6OWvaOZoFPl+MfE8ndoaU0tOLrLTqsvWhc4+KkMoJyZ4IM/hDkGC5Zfxx6tUsV3SqZ5UZ3RFSEbeJFkKUTFpK6ecrzpfLW0CxbntPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F2BB2F4;
	Fri,  7 Jun 2024 04:35:10 -0700 (PDT)
Received: from [10.57.70.246] (unknown [10.57.70.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587D53F762;
	Fri,  7 Jun 2024 04:34:44 -0700 (PDT)
Message-ID: <8c3db3d5-8ddc-427c-8db2-980b14afb258@arm.com>
Date: Fri, 7 Jun 2024 12:34:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Add ARM64 for reserving ZONE_MOVABLE
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 suzuki.poulose@arm.com, broonie@kernel.org, James.Morse@arm.com,
 Anshuman.Khandual@arm.com
References: <20240604052856.546183-1-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240604052856.546183-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2024 06:28, Dev Jain wrote:
> kernelcore and movablecore kernel command line works for ARM64. Update
> the Documentation to reflect the same.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b600df82669d..7282d6057e32 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2544,7 +2544,7 @@
>  
>  	keepinitrd	[HW,ARM] See retain_initrd.
>  
> -	kernelcore=	[KNL,X86,IA-64,PPC,EARLY]
> +	kernelcore=	[KNL,X86,IA-64,PPC,ARM64,EARLY]

Given these are both arch-agnostic parameters, wouldn't the correct change be to
remove all the arch-specific labels, i.e. [KNL,EARLY]? In fact, wasn't IA-64
removed from the kernel?

>  			Format: nn[KMGTPE] | nn% | "mirror"
>  			This parameter specifies the amount of memory usable by
>  			the kernel for non-movable allocations.  The requested
> @@ -3612,7 +3612,7 @@
>  	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
>  			reporting absolute coordinates, such as tablets
>  
> -	movablecore=	[KNL,X86,IA-64,PPC,EARLY]
> +	movablecore=	[KNL,X86,IA-64,PPC,ARM64,EARLY]
>  			Format: nn[KMGTPE] | nn%
>  			This parameter is the complement to kernelcore=, it
>  			specifies the amount of memory used for migratable


