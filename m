Return-Path: <linux-kernel+bounces-256615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5B935117
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92461F2216E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BF14534A;
	Thu, 18 Jul 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="b8DnsO6s"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732A144D10
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322598; cv=none; b=eJKvPCV6TG6rx97f5XYPH/RPOWfZuQQNsig6nVgMZzXIj1QNRZK/aN/DqtH06vp06N5X48pa9gUWpmqOtlISNzheYDK3fBUAzV60kgyO03q9XiTmgQ7QAF1cujTPm6c3geIGpClQd/ZnRWkJnfwOkP+oukdfTtAR62iGBgKArgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322598; c=relaxed/simple;
	bh=xL3m9hbmkMooZERsOAU/7eovW/Lp3XPyHCnVNSGGhiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL6baA4pqpD9vPJx2Z5boPY184Q+YFHCSGiDf9Bz4ZJRvKwMmNweVpSdlWj7fJ5xJFy6dI4ucpTpKutRjYjxYxvaBsKKE3y+tRd8Eb5axgZYgOBJvMubg8iKVDAJXpzf4+ijEdJT+vcCwjhfbn9hhREhhJ03nfB2iCCSzDyn/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=b8DnsO6s; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447e57103d5so2747351cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721322595; x=1721927395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oZIFGo3b+JV9w2PKJcAfLvpOGjnV19xdselgMBeOOw=;
        b=b8DnsO6s7Xwknj2xSx+IT8/Q9ORRWX6ha7xcIvBYCDUo640EY019VWFzh+177NINLb
         eBZqV4sBt8NKqg28Y9fLmHE1KYTudSmNk1sHHd3qZn1NeCFgXzarGeEh3vr+QgUMT7Fl
         TlMmRT7/qzKuNPqp3b4LWa5DopTYXZ7FxWmUcf+u4NhVWkSjl2W7tKCNyosfDmEysfHW
         70wEyKoGgONqj1nfJZbOROkZBe5/6pcOGQiiCPnU0Y9cOSANuOTE3R0VjYD4VGAKdQ1a
         v1i0L+suiBHsU+WflGgoY5BSfZ+onMOJ8r4aBbb01JJbddjpsaJ6nTbGBBbuJfadDKPh
         vy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322595; x=1721927395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oZIFGo3b+JV9w2PKJcAfLvpOGjnV19xdselgMBeOOw=;
        b=tVkqGAH5hIVK+yunrFiVmWcXM+fMYoeyXN8+vYZXqTHdFwOETdKJh1+QDvnlx2+kMU
         4ny6RPQRXWv7o5ScEko6egXN+56Od2rpNMOsCRrLQoPSQm8aY3dydC9iw9YWZrN49bAc
         pl6QDmtwBVbBx/i8ND2amYTk2JFobxfQlNi7cw02xWYhB85RDldC2zEzK0JVy2dreFtv
         D6gUr1SGpOCMruKsMTd4aLjH6dt4QniAiPi1Vr0AsLeCuoxdxhFGA8eHUD7W2oLKVbSz
         5vIwGAvTyttYFehamBYuPhQu6Fq4uFcMJOvg21jEsdqbyxU1xp5KU0SA6gyuG1TmvvjZ
         OxrA==
X-Gm-Message-State: AOJu0YxWU/d1sVJN0W5y/Z02QGJzQh+TyTsM/5WJ9gwvtAmAvy4rea4c
	CAfzx46Th0n0gcWZvoUDe+K8bXTQeUb1J18GDkVB/aImhXERdCzwbY1erq5I88k=
X-Google-Smtp-Source: AGHT+IHrzZA/m6pVbTgjevfoe8nzNI8qw8J1MyZZNmpIu3/V95B0K8fx3QqerirmL3TlDD78U4x6Ww==
X-Received: by 2002:a05:622a:103:b0:447:e692:8b31 with SMTP id d75a77b69052e-44f969b9a3emr16945791cf.37.1721322595207;
        Thu, 18 Jul 2024 10:09:55 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f96a02d2csm4369571cf.43.2024.07.18.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 10:09:54 -0700 (PDT)
Date: Thu, 18 Jul 2024 12:09:53 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org
Subject: Re: [PATCH 2/2] riscv: KVM: add basic support for host vs guest
 profiling
Message-ID: <20240718-f39bdec648fc285ffe46cc3e@orel>
References: <cover.1721271251.git.zhouquan@iscas.ac.cn>
 <fbf8a9fcca05a1b554ac0d01b0c46fbb6263c435.1721271251.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf8a9fcca05a1b554ac0d01b0c46fbb6263c435.1721271251.git.zhouquan@iscas.ac.cn>

On Thu, Jul 18, 2024 at 07:23:51PM GMT, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> For the information collected on the host side, we need to
> identify which data originates from the guest and record
> these events separately. This can be achieved by having
> KVM register perf callbacks.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/kvm_host.h |  6 ++++++
>  arch/riscv/kvm/Kconfig            |  1 +
>  arch/riscv/kvm/main.c             | 12 ++++++++++--
>  arch/riscv/kvm/vcpu.c             |  7 +++++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index d96281278586..b7bbe1c0c5dd 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -285,6 +285,12 @@ struct kvm_vcpu_arch {
>  	} sta;
>  };
>  
> +/* TODO: A more explicit approach might be needed here than this simple one */

Can you elaborate on this concern?

> +static inline bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu)
> +{
> +	return IS_ENABLED(CONFIG_GUEST_PERF_EVENTS) && !!vcpu;
> +}
> +
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>  
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index 26d1727f0550..0c3cbb0915ff 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -32,6 +32,7 @@ config KVM
>  	select KVM_XFER_TO_GUEST_WORK
>  	select KVM_GENERIC_MMU_NOTIFIER
>  	select SCHED_INFO
> +	select GUEST_PERF_EVENTS if PERF_EVENTS
>  	help
>  	  Support hosting virtualized guest machines.
>  
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index bab2ec34cd87..734b48d8f6dd 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -51,6 +51,12 @@ void kvm_arch_hardware_disable(void)
>  	csr_write(CSR_HIDELEG, 0);
>  }
>  
> +static void kvm_riscv_teardown(void)
> +{
> +	kvm_riscv_aia_exit();
> +	kvm_unregister_perf_callbacks();
> +}
> +
>  static int __init riscv_kvm_init(void)
>  {
>  	int rc;
> @@ -105,9 +111,11 @@ static int __init riscv_kvm_init(void)
>  		kvm_info("AIA available with %d guest external interrupts\n",
>  			 kvm_riscv_aia_nr_hgei);
>  
> +	kvm_register_perf_callbacks(NULL);
> +
>  	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>  	if (rc) {
> -		kvm_riscv_aia_exit();
> +		kvm_riscv_teardown();
>  		return rc;
>  	}
>  
> @@ -117,7 +125,7 @@ module_init(riscv_kvm_init);
>  
>  static void __exit riscv_kvm_exit(void)
>  {
> -	kvm_riscv_aia_exit();
> +	kvm_riscv_teardown();
>  
>  	kvm_exit();
>  }
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 17e21df36cc1..c9d291865141 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -222,6 +222,13 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
>  	return (vcpu->arch.guest_context.sstatus & SR_SPP) ? true : false;
>  }
>  
> +#ifdef CONFIG_GUEST_PERF_EVENTS
> +unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.guest_context.sepc;
> +}
> +#endif
> +
>  vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
>  {
>  	return VM_FAULT_SIGBUS;
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

