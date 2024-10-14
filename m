Return-Path: <linux-kernel+bounces-363139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7B99BE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E985B212D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D560C824A0;
	Mon, 14 Oct 2024 03:44:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29FE231CA6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877449; cv=none; b=nOQx3nk/KJBTLlgQkPy5903vacQHh/I4MhH/A8KtiBAA6rY0sXYnyMVtzyKP3+XvRlWJBhEwjeXEJNdlQ3BfTdcIUwPuSD5xspMfvRbZgzjG4BpU59TtYEngjFzOWXbeaMjDkiwmyFYmaCvN/+JYm5mwcrG1hP23QtqKF2nfUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877449; c=relaxed/simple;
	bh=ippnO6VAw8Gofcxze/7kkaI9LzTMp92W65KvfiTWNYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nkmf5xaDnmMrva/P3MGTBnZJj7HsLKWgIg4FcB6Ec7YJ4G6QM23kKD5xviZ0CNdtRsDJGH3hZoMG40HChtPWgKS1lhqJAi5zkF283SsLBnSUwzOg1bLcjnn0faY1tFLijvf7b5SVauJkujg++xhZDDdDNuOfIVUjbHfgxg9NnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 501A7DA7;
	Sun, 13 Oct 2024 20:44:35 -0700 (PDT)
Received: from [10.163.38.184] (unknown [10.163.38.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7751D3F51B;
	Sun, 13 Oct 2024 20:44:03 -0700 (PDT)
Message-ID: <92337e78-2a6b-4f41-a3d6-3e07361eba21@arm.com>
Date: Mon, 14 Oct 2024 09:14:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: head: Drop SWAPPER_TABLE_SHIFT
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 ardb@kernel.org, shan.gavin@gmail.com
References: <20241014030341.995806-1-gshan@redhat.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241014030341.995806-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/24 08:33, Gavin Shan wrote:
> There is no users of SWAPPER_TABLE_SHIFT after commit 84b04d3e6bdb
> ("arm64: kernel: Create initial ID map from C code"). Just drop it.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/kernel-pgtable.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index bf05a77873a4..fd5a08450b12 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -26,7 +26,6 @@
>  #define SWAPPER_SKIP_LEVEL	0
>  #endif
>  #define SWAPPER_BLOCK_SIZE	(UL(1) << SWAPPER_BLOCK_SHIFT)
> -#define SWAPPER_TABLE_SHIFT	(SWAPPER_BLOCK_SHIFT + PAGE_SHIFT - 3)
>  
>  #define SWAPPER_PGTABLE_LEVELS		(CONFIG_PGTABLE_LEVELS - SWAPPER_SKIP_LEVEL)
>  #define INIT_IDMAP_PGTABLE_LEVELS	(IDMAP_LEVELS - SWAPPER_SKIP_LEVEL)

