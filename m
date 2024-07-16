Return-Path: <linux-kernel+bounces-253333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E61E931FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558342825F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C0E125B9;
	Tue, 16 Jul 2024 04:19:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF437B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103567; cv=none; b=FLJlZb/BpxMWzkrDkx4EwUnBO+gaonsjZy6jTDbwCyzXfVgc25lOkpjdvnX4Yqes4l76Vn91ml/Qfb9l58E/RzHA+1oNw7AGfFWmSr42xHxFcZhDLuHLQ6q4H32UIX0od5OreYQf8WgyilTuKEWUSw0O9WCtj27SNxFXg5mf78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103567; c=relaxed/simple;
	bh=Z1jZw5U7703WvCAqDzyCnxNOMFkOImEOslelMxfq8Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClFZoj8CTAP224hQgQmRoFkvxHwp8gnsEP73ULJjev9WIbLlJkFCJwhb3Th58OqX0PeoZJl2LmLeFkcjTw/9sMakdnpMqzSoVL7OFIxMDYN/r6iqyOKwxwPfnHBhF0H+d2cxebslb8a8FBSXbbMdfx5VTFUgyl9H7roQDFYOB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6331C1063;
	Mon, 15 Jul 2024 21:19:43 -0700 (PDT)
Received: from [10.163.45.178] (unknown [10.163.45.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F00B3F762;
	Mon, 15 Jul 2024 21:19:15 -0700 (PDT)
Message-ID: <34b1f29a-675b-4b89-a398-7ed3b732d1ac@arm.com>
Date: Tue, 16 Jul 2024 09:49:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: remove redundant 'if HAVE_ARCH_KASAN' in
 Kconfig
To: Masahiro Yamada <masahiroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20240715192843.2201439-1-masahiroy@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240715192843.2201439-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/24 00:58, Masahiro Yamada wrote:
> Since commit 0383808e4d99 ("arm64: kasan: Reduce minimum shadow
> alignment and enable 5 level paging"), HAVE_ARCH_KASAN is always 'y'.
> 
> The condition 'if HAVE_ARCH_KASAN' is always met.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> 
> Changes in v2:
>  - update description
>  - add reviewed-by and acked-by
> 
>  arch/arm64/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c87d16b12e9b..d37cbfc3031e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -167,9 +167,9 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN
> -	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
> -	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> -	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
> +	select HAVE_ARCH_KASAN_VMALLOC
> +	select HAVE_ARCH_KASAN_SW_TAGS
> +	select HAVE_ARCH_KASAN_HW_TAGS if ARM64_MTE
>  	# Some instrumentation may be unsound, hence EXPERT
>  	select HAVE_ARCH_KCSAN if EXPERT
>  	select HAVE_ARCH_KFENCE

