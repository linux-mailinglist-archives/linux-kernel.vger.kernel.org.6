Return-Path: <linux-kernel+bounces-268756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECDB9428F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC887B2240A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0521A8BED;
	Wed, 31 Jul 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lpDmFJLZ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240501A8BE2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413555; cv=none; b=aHjeP0AA1iOPTaUDmmpZfEkVmS/qjD9AeVdlQMqnE6Rh5X932ntGeKWSeRDjrpCXFSRKeKNoeQFf9EBcJrKdbJ/KIQuBioyO5Kh7zdCq41ToM+K63r5n9QFZlZqEIGOCAmP6aaXjUs8cJtsc76bJl6Iq0AVPN+SvQOAgwzy3OhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413555; c=relaxed/simple;
	bh=b8hVmojrUfUxc5sorDFfUegqxUC1JzH5YJUFRcGslDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWJKkhXHBfXMOg/iUAvwG4uUEE5K0D5o8wKwqZWic+CUMm1oPhvSfyTqImJwY8YI0DPUPxrU8XSsldLKdv6UgbNqeaiQsS4tlF3ptO4ESDoxbV+rMbpmC3w1VzOTmVRlkIWFezOgUv1iD0SkmeFsFSqPrlyLQvlGtwfbHnu1jFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lpDmFJLZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso4739322a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722413552; x=1723018352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPhqvXPcxjB8hmfad49hCHGbmNQ9dpteVou05ijuxXo=;
        b=lpDmFJLZr27Wr7Ob/XOAj3qV8DXi6xKkdWDolIzXJUmYLItxuh5pErTv6fSa9Qmi53
         SIgrEiPpDTm5y9sYy3IYCsEVd1xwOH+p9TOTsxHox5Dv58VZYsOqYhm2YTC+ex+Qhv9j
         p/yi0OE4iJGBS9gvNbWCxsfX4TwfW13UifhQaZ1vwTYaR6lbK3oXSQiqW9+2/J/9kwEP
         LgbAJz3Q27FJGmPcWoDie0L6Dj/HXjysQ2fqpCAiyZeVKP7m/g/NhkY7HGyqaXFTmz1d
         Q/mxXkdtdsBzMMjQ2DaXM3RzXRJ7ykc8RRROqHM/YokCvTTezCw7dxBk9UKlhozgls52
         LaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722413552; x=1723018352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPhqvXPcxjB8hmfad49hCHGbmNQ9dpteVou05ijuxXo=;
        b=KTOePQwIJxru/u3NvaTVSVoM3rAcVHJwpYQoaCUTG8DujLWPzxvntjB8vdL15UXPsm
         r1Q6sO+LMZufTTOGbx9gsbJfRTrsY0UtYkHBNtC7Ca6an/+0AiOJlF8EpYkFKlFm+zV8
         jX9AMpIRh4J0jaL/GWkRalOP7ZUna+NRiQrdeBsFsyvgCeflgWzSsYMc+J9bu5FhIlte
         G3AwUWeOI4DKM72wLrJ0EVbRH+qxVJYZGVlDSOmyezuNpZQK7baazs/L1LH9rLuS5c7Q
         waUl1cKw0aIOuZtQ42LwgY55b8OyAvAjrEk1AqUqdGf7b10vCXBc5+K/8k35QPOGY9Lc
         AXgA==
X-Forwarded-Encrypted: i=1; AJvYcCVI1+oIPZzQIaGRUCYVjqcK4DHHEeil0TFHucbEGfRS4GACJJGsoEdk/lEQNK29+i1Ax9WmLu27iqfl77zbUaX1riE3xSthVT60mfuE
X-Gm-Message-State: AOJu0YyVvg5p3EqWO1kMVLvr1A3SgjpSGKRbguxtWfn6oi9bM7FNqCli
	uOIrVuwoITpuy/nBjiYSShj866DYW7uz3H8Ss8Iygg5N2rPWLt4VCEdLbtH0xYw=
X-Google-Smtp-Source: AGHT+IGxlRCnb+W6DiXG7nTnr6lyiGJnx0i1YWV+5ADomMCnBj37OyG82iPSl5g4jXJI8y3klQMjSg==
X-Received: by 2002:a50:d7c1:0:b0:57d:3df:f881 with SMTP id 4fb4d7f45d1cf-5b021190495mr11744615a12.3.1722413552263;
        Wed, 31 Jul 2024 01:12:32 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac60918cb4sm8394451a12.0.2024.07.31.01.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 01:12:31 -0700 (PDT)
Date: Wed, 31 Jul 2024 10:12:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v12 57/84] KVM: RISC-V: Mark "struct page" pfns accessed
 before dropping mmu_lock
Message-ID: <20240731-f034f3516f0fffede877c68d@orel>
References: <20240726235234.228822-1-seanjc@google.com>
 <20240726235234.228822-58-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726235234.228822-58-seanjc@google.com>

On Fri, Jul 26, 2024 at 04:52:06PM GMT, Sean Christopherson wrote:
> Mark pages accessed before dropping mmu_lock when faulting in guest memory
> so that RISC-V can convert to kvm_release_faultin_page() without tripping
> its lockdep assertion on mmu_lock being held.  Marking pages accessed
> outside of mmu_lock is ok (not great, but safe), but marking pages _dirty_
> outside of mmu_lock can make filesystems unhappy.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/riscv/kvm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 06aa5a0d056d..806f68e70642 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -683,10 +683,10 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  out_unlock:
>  	if ((!ret || ret == -EEXIST) && writable)
>  		kvm_set_pfn_dirty(hfn);
> +	else
> +		kvm_release_pfn_clean(hfn);
>  
>  	spin_unlock(&kvm->mmu_lock);
> -	kvm_set_pfn_accessed(hfn);
> -	kvm_release_pfn_clean(hfn);
>  	return ret;
>  }
>  
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

