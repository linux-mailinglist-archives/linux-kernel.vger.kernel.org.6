Return-Path: <linux-kernel+bounces-510970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E95BA3243F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727483A8537
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2220A5C7;
	Wed, 12 Feb 2025 11:05:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8595209F58
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358319; cv=none; b=BHJGDSxAAb7rC5S+414aW2wx0QKorF9HZhX/t9cFLO3M6JA4O+l4HfE2BaWEPZ+AwtY3sNfFPhgNs9pHo93lHmYQppG2Pwlk/HT47uEksvrNDnzjeU881pYmfK1seE9B96EYwtsM+c08aqrpVBLrDd78Boi75vOlB/i6kDj4bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358319; c=relaxed/simple;
	bh=gWtL0LpKi6VE/r1z1i/28M1Br0IH1wKjkxZVCpn+ErY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/yI5G4R2ymPYMWto7W49ypjoxZfMqyBQLm2vQOiMWKyr5Ij2LZgVBnwCChOiKIveE/lK/gNBv6oy2H6f7sctr+BCO6WwT7Dbnzpc7Qhxq+TUuuI/tNf2u2LsRnGa6Su/vAFxkxJxr1kG7He0iNXKxWdWSIuA9K4wpRaUNiJZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3733F106F;
	Wed, 12 Feb 2025 03:05:38 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CD233F6A8;
	Wed, 12 Feb 2025 03:05:15 -0800 (PST)
Date: Wed, 12 Feb 2025 11:05:07 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Add missing registrations of hwcaps
Message-ID: <Z6yAY_8UcavXRzRZ@J2N7QTR9R3>
References: <20250212-arm64-fix-2024-dpisa-v2-1-67a1c11d6001@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-arm64-fix-2024-dpisa-v2-1-67a1c11d6001@kernel.org>

On Wed, Feb 12, 2025 at 12:30:42AM +0000, Mark Brown wrote:
> Commit 819935464cb2 ("arm64/hwcap: Describe 2024 dpISA extensions to
> userspace") added definitions for HWCAP_FPRCVT, HWCAP_F8MM8 and
> HWCAP_F8MM4 but did not include the crucial registration in
> arm64_elf_hwcaps.  Add it.
> 
> Fixes: 819935464cb2 ("arm64/hwcap: Describe 2024 dpISA extensions to userspace")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for the respin.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Changes in v2:
> - Add FPRCVT.
> - Link to v1: https://lore.kernel.org/r/20250210-arm64-fix-2024-dpisa-v1-1-d77f43c7b253@kernel.org
> ---
>  arch/arm64/kernel/cpufeature.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f0910f20fbf8c18fbeb63bcee18abf13371b1d5e..d561cf3b8ac7b11784282dc889852ef52a7b8f6e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3091,6 +3091,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  	HWCAP_CAP(ID_AA64ISAR0_EL1, TS, FLAGM, CAP_HWCAP, KERNEL_HWCAP_FLAGM),
>  	HWCAP_CAP(ID_AA64ISAR0_EL1, TS, FLAGM2, CAP_HWCAP, KERNEL_HWCAP_FLAGM2),
>  	HWCAP_CAP(ID_AA64ISAR0_EL1, RNDR, IMP, CAP_HWCAP, KERNEL_HWCAP_RNG),
> +	HWCAP_CAP(ID_AA64ISAR3_EL1, FPRCVT, IMP, CAP_HWCAP, KERNEL_HWCAP_FPRCVT),
>  	HWCAP_CAP(ID_AA64PFR0_EL1, FP, IMP, CAP_HWCAP, KERNEL_HWCAP_FP),
>  	HWCAP_CAP(ID_AA64PFR0_EL1, FP, FP16, CAP_HWCAP, KERNEL_HWCAP_FPHP),
>  	HWCAP_CAP(ID_AA64PFR0_EL1, AdvSIMD, IMP, CAP_HWCAP, KERNEL_HWCAP_ASIMD),
> @@ -3190,6 +3191,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP4),
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP2),
> +	HWCAP_CAP(ID_AA64FPFR0_EL1, F8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_F8MM8),
> +	HWCAP_CAP(ID_AA64FPFR0_EL1, F8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_F8MM4),
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E4M3, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E4M3),
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E5M2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E5M2),
>  #ifdef CONFIG_ARM64_POE
> 
> ---
> base-commit: 21fed7c223e20e694b91dbf25936d922a50c8b19
> change-id: 20250207-arm64-fix-2024-dpisa-635a5961609c
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

