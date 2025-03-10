Return-Path: <linux-kernel+bounces-554647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89942A59AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F5316D505
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DDE22FDF9;
	Mon, 10 Mar 2025 16:24:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF641D79BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623891; cv=none; b=mH62aDRdauZFNiAvuzD+72fa5upFtfDDxPo6UL58sTksxs+iu4YSAaaY8Bc7TySNGh4JsETaQWp2UlrDP/BkGjyNxQGYKeb4oML5orU6uKeVMDF1agFxmbDaKU7ffS+KxjvzmFmR/ybUcgriigApiBTQM56ejRwOQBOSC+5ecN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623891; c=relaxed/simple;
	bh=N7uxSTMMV0X8JjCCOcoELnB4MKWzT6xSv4Lh+AP9cGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI6Yv5U9KYcFUgr6cE56UcUeZ8WmtKb05noouJK5in2i0RfFukDq7NdNOM7P8n2gTN9rIw/YDgqw6LVBNAxX9t6tpWu51Ms66RgHmYE4pcQcfq8oRgshu+tGHxO7At8gIyDYsOT4TnD9Jl/Z7qZIdA0rOBSplDPFH7QjNpXV0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA7F31692;
	Mon, 10 Mar 2025 09:24:59 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798013F5A1;
	Mon, 10 Mar 2025 09:24:47 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:24:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64/fpsimd: Remove unused declaration
 fpsimd_kvm_prepare()
Message-ID: <Z88SSYFJo9R_YgO3@J2N7QTR9R3.cambridge.arm.com>
References: <20250309070723.1390958-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309070723.1390958-1-yuehaibing@huawei.com>

On Sun, Mar 09, 2025 at 03:07:23PM +0800, Yue Haibing wrote:
> Commit fbc7e61195e2 ("KVM: arm64: Unconditionally save+flush host
> FPSIMD/SVE/SME state") removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

My bad. Looks like a sensible cleanup.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/fpsimd.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index f2a84efc3618..564bc09b3e06 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -80,7 +80,6 @@ extern void fpsimd_signal_preserve_current_state(void);
>  extern void fpsimd_preserve_current_state(void);
>  extern void fpsimd_restore_current_state(void);
>  extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
> -extern void fpsimd_kvm_prepare(void);
>  
>  struct cpu_fp_state {
>  	struct user_fpsimd_state *st;
> -- 
> 2.34.1
> 
> 

