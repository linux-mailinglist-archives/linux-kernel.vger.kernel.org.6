Return-Path: <linux-kernel+bounces-521126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E838A3B4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642EC1899E10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8231CBA18;
	Wed, 19 Feb 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f9TezJNt"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC721DFE23
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954171; cv=none; b=PJy6OzsWp2cX0lXKWJMN3ZazrzB9UDWSkqWsFO8psYa6WsIOWAk8lxCBJZpCFgHcPj5XNAI2fB+NLtJd8A+ugtH/X45PID8pExacUVOCcErDrjlqjUUo6Dn2HoNh3vo8qKF8prOBZipzM9QCnbN+obmU3/Jw9AIcJMzGWNrqlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954171; c=relaxed/simple;
	bh=ZFR9Bssmw+rkM4kJMxjoQ8QQzST30QWN969X923UvhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb9jgiJ4ryN6rXtxae8TFccwxv3UdAmaP/uk8NsoKxyVoQud389OInYC+2E+a6PGkljIRB+U4D2PmVbT0PuPxOLoptbmjyk6g129/uGBVZrda+uSr9rllLrGj9Ivn01PrU7ahbjDMQ5UkWpDQA3ksl2/5XfUZOh4jaeXvlSEEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=f9TezJNt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2f748128so2379202f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739954167; x=1740558967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hX5Pqy74HJXGhYd3EYVGCK1e+ORfs5MU+F8H+njiblE=;
        b=f9TezJNtOmcpId/TimX969aOFeVzhNFlS5Vj5mWnfZpPO5aZA7TQL/E2N3xS8xMjOG
         ajG15sM0KVqP5PEqhH8T1J1XZ5C/b7/cBeIJGsKjyltUzbkeMV5TbsBXJH4R6XTXTxp5
         eWMEuLThjiPYV035NMBvS/yftrUExnfC77/thRBLyBDc5mI/AEfg5VhWUZ9fkc0CK//b
         6EPo9xz8spSLRe10b8ch2/dC/WauC9u+mh2/wGN/7A8+WHrLjbSJf2mX4UVXa7uqRokZ
         FCnyVuZKV6k7vVhNA4jiwz6dOE8GGNZfqFo/dAquuhfD20ocixgLKI87+UCLFVUDRNNd
         q6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954167; x=1740558967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX5Pqy74HJXGhYd3EYVGCK1e+ORfs5MU+F8H+njiblE=;
        b=d+Ibhwl5VEWQNiC3il2cqWXqjBEvyCUShbu/3CbTRMvWx4o1f37JtfIJuB/Uh+m+/l
         TG5P1/zNYpaT7gVdiKonk8/M3C5vS2baE4o3/26yejuq1TftC09XaIYuOXvgpazvU0/o
         XE+NBcBBL1/4I0ZCBp3o34vJzL5/ouQ61LZNaLhDrDLQbSaL2Vq7TnziKhgkhUGAdOs2
         mgpKDwbzWhwslNYUiLVH4dBvT892aEHG76i+WrIYZjyXcZ0BMKjzUzQA2cSL0hkstAXi
         N3XW6SaEN5JQakvrZykc4qQP16S1/tysUjNpjUoxoBJ424eEg5/Xu3SUV13c9Ca739Vl
         SCGg==
X-Forwarded-Encrypted: i=1; AJvYcCVRLl6zApo3dQ+cBSWoHtWns4lk9x2W7QNGQwK9JYqF4B3OtyuJ5wQpdLRPXW1PmRRMFGBSXt3qs6z5MkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvMD5ztBNwXiuHszvy0hac7fNoi9kdHYvjih/Ft0WfliKWQ+c
	0q1p+Ee25lezBBn6ALzGkAupFgPgRvRljfVgtjivXSPF3iTCOwTZ6ksVVlK7PA4=
X-Gm-Gg: ASbGnctHf4LcpAUWjBVqH/v4Z+JYrIpVwTfYvoSdGfgizfiOLoBXPRDoYFf8RbOOLP/
	31Z7rS8d9fS1Kg7JEWdbTI5XKg3ixvN6WuhsfF+DyTKi5U4lF4wCNx3zB8iBzYS9hax/Cm0GOVs
	rVLbbJo7a4l8fT4HDrAFbZ9hmCubZQsBmN/nB6vZr3YbMVYc+weGbutEnnqLoibsTaq0wEwISnO
	4MAPKwwdrlUXILYnheAooJUiDzewbMv6CiLhIO7K5E78B9AJbsY8eCLoQ1waGIEdMMwZKbEqZ4J
	Gww=
X-Google-Smtp-Source: AGHT+IHs4kVPkFYUzWm7KaTrDUxtzlrgRhTgXt+SxWy9TWu9laptUSWnP8MSP8v1LxvgTwxXTCCeSQ==
X-Received: by 2002:a5d:6484:0:b0:38f:4c30:7cdd with SMTP id ffacd0b85a97d-38f4c307ec0mr7919846f8f.37.1739954167212;
        Wed, 19 Feb 2025 00:36:07 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm17085819f8f.73.2025.02.19.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:36:06 -0800 (PST)
Date: Wed, 19 Feb 2025 09:36:05 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: anup@brainfault.org, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Subject: Re: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
Message-ID: <20250219-badec60b9b12834cf534dcbf@orel>
References: <20250219015426.1939-1-xiangwencheng@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219015426.1939-1-xiangwencheng@lanxincomputing.com>

On Wed, Feb 19, 2025 at 09:54:26AM +0800, BillXiang wrote:
> Thank you Andrew Jones, forgive my errors in the last email.

From here down is all exactly the same as your first email, which I
already completely replied to.

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
> 
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  arch/riscv/kvm/aia_imsic.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index a8085cd8215e..29ef9c2133a9 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -974,7 +974,6 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
>  
>  	if (imsic->vsfile_cpu >= 0) {
>  		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
> -		kvm_vcpu_kick(vcpu);
>  	} else {
>  		eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
>  		set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
> -- 
> 2.46.2

