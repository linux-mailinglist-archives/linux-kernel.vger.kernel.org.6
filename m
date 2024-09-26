Return-Path: <linux-kernel+bounces-340808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CC298781A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3C1B27B54
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B58158205;
	Thu, 26 Sep 2024 17:04:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8E535D8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370254; cv=none; b=kDPQVEG65RxBjbAreWCHEytWsa1lGCAllGCnhHMSiHzLL+hBM/2dThnBMXJKYjBGe7iSE1slzXxZ4UuAqez9nesiNicqFWXXw9zfWJCq2ZwNNNvsYmj0JIUkKn0iP9eSZl7O741+JoodE1G5wGS2LRbR3csFnHgqgWSdgrguUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370254; c=relaxed/simple;
	bh=NvzDRi77jz03pJp8uAdOr2y1QrWgk6fgbHIsdwNHYh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzwix01veEB9IpUz81ZpMsWIaCI637QkCKLfDFgdwciDixks2BN73/+CKfAiGRULoLVfsbe2E4dfgEYuD7q9Bf9CekjcUp0+EQSJMnnMgsHzNwL0rFvSpfLbvRMN5eMV4xa3WSzLVXgqZKPVKjrJo9mehe0CRZqo24qQJqWzGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EFFC4CEC5;
	Thu, 26 Sep 2024 17:04:13 +0000 (UTC)
Date: Thu, 26 Sep 2024 18:04:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: defconfig: Enable CONFIG_EXPERT
Message-ID: <ZvWUCtkOXKfnIr-m@arm.com>
References: <20240926145817.1124-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240926145817.1124-1-linux.amoon@gmail.com>

On Thu, Sep 26, 2024 at 08:28:16PM +0530, Anand Moon wrote:
> Enable CONFIG_EXPERT to allow the configuration of PREEMPT_RT.
> 
> PREEMPT_RT depends on the following configuration:
> 
> CONFIG_PREEMPT_RT
> 	bool “Fully Preemptible Kernel (Real-Time)”
> 	depends on CONFIG_EXPERT && ARCH_SUPPORTS_RT
> 	select PREEMPTION
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5fdbfea7a5b2..3d9d29eb0c13 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -28,6 +28,7 @@ CONFIG_CGROUP_BPF=y
>  CONFIG_USER_NS=y
>  CONFIG_SCHED_AUTOGROUP=y
>  CONFIG_BLK_DEV_INITRD=y
> +CONFIG_EXPERT=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_PROFILING=y
>  CONFIG_KEXEC=y

EXPERT is not really for defconfig (at least not for the arm64 one).
Distros can (and do) enable it if they want. Also PREEMPT_RT is default
off, so you'd have to enable it in your config anyway, not sure what
this patch helps with.

-- 
Catalin

