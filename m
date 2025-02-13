Return-Path: <linux-kernel+bounces-512798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589ACA33DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B200B188CB24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2C1227E8A;
	Thu, 13 Feb 2025 11:23:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B7227E82
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445792; cv=none; b=Bzj35O1ZUPbiS4lhlcUS2XsispZ5LYQTmxv6Dn3pTbp3vQxmY1MvW40lQEY/8ezqhEHjlc8TpkQHhzpyR29EY6K1h5JLNgxmuxz8qOQWaQp+aXcghqr8DKokAVOCWXFGT2KU6notDazCEuiaTuLEwsj/wQkx42F8J3yAKG79IAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445792; c=relaxed/simple;
	bh=ESAc682XjkWhqlUhJxEDwDEPqrj9GTkKQGu6d2NKAi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAvudaY2on4Pkjk4i9iAnWKf7XEWN6GTcNvcYRaq/+Gs9afpzxahCUSRifK63mGoVQ3duoeOy+Vdd+pS8N2K8RrRk2Ker3b77I/zVt205mV2pf5KG8iPehc++K06YUMzwYQDkBSH0ONq+Jvkt03yAVAcchnzBEYU49H5M0W56t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E9B1756;
	Thu, 13 Feb 2025 03:23:30 -0800 (PST)
Received: from [10.1.32.44] (e122027.cambridge.arm.com [10.1.32.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3B0F3F6A8;
	Thu, 13 Feb 2025 03:23:08 -0800 (PST)
Message-ID: <cdb9e8e2-9033-470d-ae84-7085f2fc0561@arm.com>
Date: Thu, 13 Feb 2025 11:23:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] configs: Drop GENERIC_PTDUMP from debug.config
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: christophe.leroy@csgroup.eu, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-2-anshuman.khandual@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250213040934.3245750-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 04:09, Anshuman Khandual wrote:
> The platforms that support GENERIC_PTDUMP select the config explicitly. But
> enabling this feature on platforms that don't really support - does nothing
> or might cause a build failure. Hence just drop GENERIC_PTDUMP from generic
> debug.config
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  kernel/configs/debug.config | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 20552f163930..8aafd050b754 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -73,7 +73,6 @@ CONFIG_DEBUG_VM=y
>  CONFIG_DEBUG_VM_PGFLAGS=y
>  CONFIG_DEBUG_VM_RB=y
>  CONFIG_DEBUG_VM_VMACACHE=y
> -CONFIG_GENERIC_PTDUMP=y
>  CONFIG_KASAN=y
>  CONFIG_KASAN_GENERIC=y
>  CONFIG_KASAN_INLINE=y


