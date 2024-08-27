Return-Path: <linux-kernel+bounces-303323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99675960AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557D828213E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37161BB6A9;
	Tue, 27 Aug 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXgCUuJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A71448C7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762623; cv=none; b=sJYqcReaRxizkUWHfCUNUa0X8eHH6RJXej1pm4ue0NAhI04lIADeSTm0F9/lrLi3cFPsj1dxzyB2+HnIFDptqPza2AqAL/0hIijSCD1A2WEpf6XoZktOOMIBvhObIdsTrnlCGP0viri8kX1hxALH8KPdjXKtXDnoLGM1mvQryDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762623; c=relaxed/simple;
	bh=2ZqQrzeYqI5Yy5NFyuU1piLbskRlrRRgZOLUi0g93X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVgj7EtxOS8k0HsEOvbEIMk6D39M+CAVPfZxcBab6ZwqXhJuK7AQfooT4TqQgOiTj51nknFizL4nYsTX90anDAitE4ha18E758xESi++6TxevfoF/2SFsmZKGYZuualh5lKA3efi1zLq4Sr4h6BaYfYz3jLL3DyNKSjIbbmoQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXgCUuJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD13C4FF55;
	Tue, 27 Aug 2024 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724762622;
	bh=2ZqQrzeYqI5Yy5NFyuU1piLbskRlrRRgZOLUi0g93X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXgCUuJcsBdTj5IJ/vDHleb8z/rFD2qJtc9Jvq2tjg3+1DRtGPKQynrgPRTGFuhsJ
	 girD6v73LAxlFv1iHdNWfBdczAwrz+L7ee8H6PtuUZVUJOGb4hG79AWgfp0jq9hXaA
	 b7nZjcm7R76qYsEkOvWEck1bSbDztIrygGGR1t1mt7yxnBFkVk36uxl+VCNVrkqYCK
	 uyVaAEEhzo4UNZeeN6IRUj04dy9J6ZkK4fWEfuSRp3EgnzBCfxxZEhR//vO0uMewmr
	 1AegJcJDe/+pBH9UYKi4dFD2goyATHbwYFNusn4ULw0F3f+d4jVspRJcSQHJwUo5I/
	 JOaHtx80SyU0Q==
Date: Tue, 27 Aug 2024 13:43:38 +0100
From: Will Deacon <will@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, eric.devolder@oracle.com,
	ebiederm@xmission.com
Subject: Re: [PATCH -next] arm64: enable ARCH_SUPPORTS_KEXEC_SIG_FORCE for
 arm64
Message-ID: <20240827124337.GA4772@willie-the-truck>
References: <20240824111234.2216355-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824111234.2216355-1-lizetao1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Aug 24, 2024 at 07:12:34PM +0800, Li Zetao wrote:
> When the CONFIG_KEXEC_SIG is enabled, an illegal image is loaded through
> kexec, and the illegal image is successfully loaded. The test example is
> as follows:
> 
>   # cat /sys/kernel/kexec_loaded
>   0
>   # kexec -s -l ./Image.illegal_signature
>   # echo $?
>   0
>   # dmesg | tail
>   PEFILE: Digest mismatch
>   # cat /sys/kernel/kexec_loaded
>   1
> 
> The root cause of this problem is that CONFIG_KEXEC_SIG_FORCE is not
> enabled. Solve this problem by enabling the ARCH_SUPPORTS_KEXEC_SIG_FORCE
> feature.

I'm not sure this is a problem as such -- it seems to be working as
intended if you look at the Kconfig help text:

  // Kconfig.kexec :: KEXEC_SIG
  | The image can still be loaded without a valid signature unless you
  | also enable KEXEC_SIG_FORCE, though if there's a signature that we
  | can check, then it must be valid.

> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  arch/arm64/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..9952c40a2bd8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1549,6 +1549,9 @@ config ARCH_SELECTS_KEXEC_FILE
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool y
>  
> +config ARCH_SUPPORTS_KEXEC_SIG_FORCE
> +	def_bool y

I think the real question is why on Earth does KEXEC_SIG_FORCE depend on
this arch option? Can't we just remove ARCH_SUPPORTS_KEXEC_SIG_FORCE,
seeing as it doesn't appear to do anything?

Will

