Return-Path: <linux-kernel+bounces-284056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10B94FC79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D441C223B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9081CAA6;
	Tue, 13 Aug 2024 03:57:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E91BF53
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521435; cv=none; b=G/usNhhWMdKA8iiBQ7tqlpILQmyD6Ej0VFIC/jgnk6UVGJZzKeIyKGGQ4Sb4yknvj42Dw9puhaPAbw+cKbcHYbVUZAq4a7o3xDqJTsN7MY1vhZst7Vhsr4WCKc7iNglKC8msVZuXrYE2A/t8jl9kHlXDH9itdw5TS7e577KbbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521435; c=relaxed/simple;
	bh=m9yr3vMYcKNI0QHQ+34ZEEOrBVkZH5WYJR4T/gXM0UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stWIyoDE3ZMGUqpyhGjqU/8lRTKLySs1tq3FI8vbHUIvMf7BECid1qGtmhlv9EwEVL0DFe5sYt1O3qnUx8RilyTs+DI3H4PVIL7O0WCo87Vl8Ju44oF9zPniC1WVGszqMmvOyZVEbo+3kQuvQ6cQPsfvJK8kARNv/chZWk/7bEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2753FEC;
	Mon, 12 Aug 2024 20:57:37 -0700 (PDT)
Received: from [10.163.57.95] (unknown [10.163.57.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CE583F73B;
	Mon, 12 Aug 2024 20:57:09 -0700 (PDT)
Message-ID: <0f4b602d-90d3-4035-a0e1-0fb061868764@arm.com>
Date: Tue, 13 Aug 2024 09:27:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] arm64/sve: Remove unused declaration
 read_smcr_features()
To: Yue Haibing <yuehaibing@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, broonie@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240810093944.2587809-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240810093944.2587809-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/10/24 15:09, Yue Haibing wrote:
> Commit 391208485c3a ("arm64/sve: Remove SMCR pseudo register from cpufeature code")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  arch/arm64/include/asm/fpsimd.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index bc69ac368d73..f2a84efc3618 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -155,8 +155,6 @@ extern void cpu_enable_sme2(const struct arm64_cpu_capabilities *__unused);
>  extern void cpu_enable_fa64(const struct arm64_cpu_capabilities *__unused);
>  extern void cpu_enable_fpmr(const struct arm64_cpu_capabilities *__unused);
>  
> -extern u64 read_smcr_features(void);
> -
>  /*
>   * Helpers to translate bit indices in sve_vq_map to VQ values (and
>   * vice versa).  This allows find_next_bit() to be used to find the

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

