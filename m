Return-Path: <linux-kernel+bounces-438000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414AD9E9B75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56CE166C0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA58148316;
	Mon,  9 Dec 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK+HxU+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F114AD24;
	Mon,  9 Dec 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761235; cv=none; b=YUCNEGLb/+3utIn7mBjr1tp5ogse96vRw/f6hPNs/Z/L+46PqbhCpH251fkhbyb+ESyz4rMeUxR9VXn2r81AXNGLU/ltYB5MDsXBEK2KrfDxm5UH8HQnSkMlfbfIqQdtfcBtFg5b9/qNCjtktErQEqSXC2aFotSdgeMf71Htrfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761235; c=relaxed/simple;
	bh=A0khTX962w4Lj2UZnP6iKvULYKO5dZNtoX7UeansjzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twpdzAU6KcleW6r1U8rAi5ZpFg/0qFXiAjyD2xtCVXUfvgKG0706WnQfD0/1ywpsD5pjrRlP3QjZ+Eb7LoWczszYNbhMBYnRbQXpjPxammDrVJobwulR6hfzz5HNy77vSgzWjGjd4JJjblD3NX98dmGaIQU6cHfEE+CL+uYLmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK+HxU+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C7FC4CEDE;
	Mon,  9 Dec 2024 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733761235;
	bh=A0khTX962w4Lj2UZnP6iKvULYKO5dZNtoX7UeansjzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uK+HxU+7UrafZWQAtX1yFKqLzr3GhtOoQ/I9qjhOXe6jTLtmtJJG3KeIfN+pCl52V
	 SuXy7P2d/WL1Ss8nzRAEHSimrk2PUmzwp7X26037XpdcMPYvmkYnE+sHgTIZsKrUK4
	 U9WyfTktZYBoew26+tTqWCm5l9AYXYCGHqzGRRGKntCtlMy3M+waCF9Y3y9LNbokf/
	 q6mQufLiMJrwhcZwa6S/tanQ6e/8jGJvZ54xMfKyei1YgNOLdvanuL4NyminJoySiF
	 InqCHHwsyavoTXPiTXjGvEClQPvgvlbr9uJ6SsQ+FWCXJ6saHAT+Aavv2twnJoGIbv
	 t9dq4WzA85JYg==
Date: Mon, 9 Dec 2024 16:20:29 +0000
From: Will Deacon <will@kernel.org>
To: Yabin Cui <yabinc@google.com>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
Message-ID: <20241209162028.GD12428@willie-the-truck>
References: <20241118222540.27495-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118222540.27495-1-yabinc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 18, 2024 at 02:25:40PM -0800, Yabin Cui wrote:
> Select ARCH_SUPPORTS_AUTOFDO_CLANG to allow AUTOFDO_CLANG to be
> selected.
> 
> On ARM64, ETM traces can be recorded and converted to AutoFDO profiles.
> Experiments on Android show 4% improvement in cold app startup time
> and 13% improvement in binder benchmarks.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> 
> Change-Logs in V2:
> 
> 1. Use "For ARM platforms with ETM trace" in autofdo.rst.
> 2. Create an issue and a change to use extbinary format in instructions:
>    https://github.com/Linaro/OpenCSD/issues/65
>    https://android-review.googlesource.com/c/platform/system/extras/+/3362107
> 
>  Documentation/dev-tools/autofdo.rst | 18 +++++++++++++++++-
>  arch/arm64/Kconfig                  |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tools/autofdo.rst
> index 1f0a451e9ccd..a890e84a2fdd 100644
> --- a/Documentation/dev-tools/autofdo.rst
> +++ b/Documentation/dev-tools/autofdo.rst
> @@ -55,7 +55,7 @@ process consists of the following steps:
>     workload to gather execution frequency data. This data is
>     collected using hardware sampling, via perf. AutoFDO is most
>     effective on platforms supporting advanced PMU features like
> -   LBR on Intel machines.
> +   LBR on Intel machines, ETM traces on ARM machines.
>  
>  #. AutoFDO profile generation: Perf output file is converted to
>     the AutoFDO profile via offline tools.
> @@ -141,6 +141,22 @@ Here is an example workflow for AutoFDO kernel:
>  
>        $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a -N -b -c <count> -o <perf_file> -- <loadtest>
>  
> +   - For ARM platforms with ETM trace:
> +
> +     Follow the instructions in the `Linaro OpenCSD document
> +     https://github.com/Linaro/OpenCSD/blob/master/decoder/tests/auto-fdo/autofdo.md`_
> +     to record ETM traces for AutoFDO::
> +
> +      $ perf record -e cs_etm/@tmc_etr0/k -a -o <etm_perf_file> -- <loadtest>
> +      $ perf inject -i <etm_perf_file> -o <perf_file> --itrace=i500009il
> +
> +     For ARM platforms running Android, follow the instructions in the
> +     `Android simpleperf document
> +     <https://android.googlesource.com/platform/system/extras/+/main/simpleperf/doc/collect_etm_data_for_autofdo.md>`_
> +     to record ETM traces for AutoFDO::
> +
> +      $ simpleperf record -e cs-etm:k -a -o <perf_file> -- <loadtest>
> +
>  4) (Optional) Download the raw perf file to the host machine.
>  
>  5) To generate an AutoFDO profile, two offline tools are available:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd9df6dcc593..c3814df5e391 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -103,6 +103,7 @@ config ARM64
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>  	select ARCH_SUPPORTS_RT
> +	select ARCH_SUPPORTS_AUTOFDO_CLANG
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>  	select ARCH_WANT_DEFAULT_BPF_JIT

After this change, both arm64 and x86 select this option unconditionally
and with no apparent support code being added. So what is actually
required in order to select ARCH_SUPPORTS_AUTOFDO_CLANG and why isn't
it just available for all architectures instead?

Will

