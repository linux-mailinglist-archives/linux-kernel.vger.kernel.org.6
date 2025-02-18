Return-Path: <linux-kernel+bounces-520005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9309A3A4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF013188B7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F99270EC2;
	Tue, 18 Feb 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oCX4y4n/"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B826B975
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900927; cv=none; b=WJLJhX8E7KVXdd3gX/oozjlYgkaK+JmuowcWvn7PYNdmyULmeOvY3OveYceJgwLipVGPn1rZZud2Ou13QqxY+NvbdwjQG97R4ZA6huv6istNKkmdnHjrAHUdcFwVyHciCG/ETX8r4FrPP3siwaVxs5zIlVsLoe1W6pfwJxc6zlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900927; c=relaxed/simple;
	bh=iauYa14SsO/lsoYscvnp8YszrySxWKqagso3jWg5CLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw+3S2loSXRTX3rpNohT21+V+6cCiMUjCV8PjK+12bH0CBUNwimxgj6eLCmnGdu7euFnAwsg2Pk4DTaO0YRmbPxNCxHfx29hf2g4l8zoDqLCPSCHAkgMzGxdUix3Q+qX2DRE8gErOpg54OKLNEc46MKf9AuEos4eusYhBNDOzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oCX4y4n/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso3776252f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739900922; x=1740505722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/9F2KANNnqRPhOVip+6sGGo7ED+K7ta4GpssYl+9ok=;
        b=oCX4y4n/UKpgMVUsJdVILw92Q0kzKN5V1cKjYbkWlhFiiTLyWsVKtH4mqwqXsayqjD
         7aYSDmoQt/kAkIjNU52KNUkJ0X91mSNZ6bCuqLBud630s8X6Tx8SKAC5YGJ0v1tt0GJN
         XewWExI+EOrmPU0nXKTgPRrKXjVkAMDnX/yfC/T5TzHj2KozMABwSunFgEX0l2Bu/lV9
         Mh/NR0mR4PQfRD3X6ok7GhdE/HGliEdAdGanMYZ3dZpzQ+2shOMHdrekX9pCmT5CYE3i
         nGAzEGakxh4xptatgM8p2+JbyggYkjvZ2NyFgs8qL8EAaNHkCYziIGJp6/yj4s3YGO76
         RdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739900922; x=1740505722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/9F2KANNnqRPhOVip+6sGGo7ED+K7ta4GpssYl+9ok=;
        b=bB3P4raeLVh9ZGsgT7EMgY8iiyAepVno8p+yS4OIZnLVCTL39vF76u1raWQ1xkeiKz
         nsA1IjNpLjt6Uf8Bw6EdHvw9xEZvvf5HefEHu5lWD5NPtIty7eTRUjsa0c387EADg11n
         3q4FYjnY6hsWFfDHBZinhuXPAAItHNx14gigmiyVxBuSZ7+f5tOQ2u0q32UKvfqVyJX0
         zMziwirsd/w54sX2AYjZbPQW5NLHj7329ZQaSQFfA+jLv1Z7ghEz2FwmLfY4/dMUvT12
         2NohFIDuzFHsYdlZjlgW32uUDdOGdpZ7M/s2OcKWbgX/NddpbECS+2J/yQiAoqmfTFXi
         aXpw==
X-Forwarded-Encrypted: i=1; AJvYcCWahFtpPTz2+Ck0E4p/g3MF9mdkfyUtNd+Q/O2ty3T0jG15kmotwJJd6ixXcp2Qrh8urwkSch2V7WpYxXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOuPpRKN2ikzhydC7sAwQAmuTcYnSF24Hq8XMuMyqugB0H3CcY
	mBmL6IgqjxUuVfUYhYu4iECE0QKwtP1Ga08izCwWMptzPGWXjocjoi4BYeQxHZY=
X-Gm-Gg: ASbGncvc+4JWNdVyyOyFXaFg2DFzRms34T0WfZiSm4DWUmkGfgri94+cmJbzf2qoZ1u
	ApB2TmkAsfL4R0XctMH2boTi3XWom3gtM09E7ha2teB8ah7rppocddLXZrzVN3RqINc7/aUj6W1
	qYj7QkqliI6OB5OguRs5jR2JUeMC3yBoRnEzjX10thxN8xabf1/cZHx13OBOpEEs5Rk73wlYSgU
	wRFbNo4LrZ/RItXQmrtlP7jz4DA+FWrXtgfmWA/UVxPPrpJyvWwt7c5mYTZHtnb+I99u58zsWLR
	2SM=
X-Google-Smtp-Source: AGHT+IGDVdEGfqSSRSuokSOsRD/Nb4bUupeEDDpkXhWkKSM85eFfn/T5hKxjkCf6oi4D/15usSNtVA==
X-Received: by 2002:a5d:6c68:0:b0:38f:4acd:975c with SMTP id ffacd0b85a97d-38f58795a45mr438523f8f.27.1739900922377;
        Tue, 18 Feb 2025 09:48:42 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc45sm15720336f8f.33.2025.02.18.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:48:41 -0800 (PST)
Date: Tue, 18 Feb 2025 18:48:41 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?6aG55paH5oiQ?= <xiangwencheng@lanxincomputing.com>
Cc: "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, 
	"anup@brainfault.org" <anup@brainfault.org>, "atishp@atishpatra.org" <atishp@atishpatra.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
Message-ID: <20250218-57a3a16e477f83a8c267d120@orel>
References: <38cc241c40a8ef2775e304d366bcd07df733ecf0.1d66512d.85e4.41a5.8cf7.4c1fdb05d775@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38cc241c40a8ef2775e304d366bcd07df733ecf0.1d66512d.85e4.41a5.8cf7.4c1fdb05d775@feishu.cn>

On Tue, Feb 18, 2025 at 04:00:24PM +0800, 项文成 wrote:
> From 30dd00f6886119ecc5c39b6b88f8617a57e598fc Mon Sep 17 00:00:00 2001
> From: BillXiang <xiangwencheng@lanxincomputing.com>
> Date: Tue, 18 Feb 2025 15:45:52 +0800
> Subject: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
> 
> Hello everyone,
> I'm wondering whether it's necessary to kick the virtual hart
> after writing to the vsfile of IMSIC.
> From my understanding, writing to the vsfile should directly
> forward the interrupt as MSI to the virtual hart. This means that
> an additional kick should not be necessary, as it would cause the
> vCPU to exit unnecessarily and potentially degrade performance.
> I've tested this behavior in QEMU, and it seems to work perfectly
> fine without the extra kick.
> Would appreciate any insights or confirmation on this!
> Best regards.

The above should be in a cover letter so the commit message can
be written following the guidelines of [1]

[1] Documentation/process/submitting-patches.rst

> 
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  arch/riscv/kvm/aia_imsic.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index a8085cd8215e..29ef9c2133a9 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -974,7 +974,6 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
> 
>         if (imsic->vsfile_cpu >= 0) {
>                 writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
> -               kvm_vcpu_kick(vcpu);

We can't completely remove the kick, but we could replace it with a
kvm_vcpu_wake_up().

There's also a kick in kvm_riscv_vcpu_vstimer_expired() which could be a
kvm_vcpu_wake_up() when hideleg has IRQ_VS_TIMER set (which it currently
always does).

Thanks,
drew

>         } else {
>                 eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
>                 set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
> --
> 2.46.2
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

