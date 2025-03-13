Return-Path: <linux-kernel+bounces-559511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A553DA5F4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5074619C16D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF32676CA;
	Thu, 13 Mar 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o/GrbqLC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF231FAC30
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869860; cv=none; b=BDevJ6/roA24YgcYtmRFy8Ml+z/xbaEMXzTDbmsFSFj+Isn9Wx3FlB1C5YSlIIay3mrApkYmKG8V1l09m/PB5hAPpTZej6oE6OU5VGa2VqwUrfwKtcEY0aRXGqogiI6P2JKFx0WODnwLb7vDX2EHET8jdkeLEdl8YiK3RqH8AM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869860; c=relaxed/simple;
	bh=EleUDN0p7TORHE0wSEwSE0kj+mfdR9PO/rSWsPpYYTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwWpqnh/8GMOXdSnRybiBllgR8Thk9oBoDKwYteqHFY6IkpMace6CXvG4mIT5gZT6c0Ll6gZU6Hg1BgootADFj3OvXvVBcvWCwzZioxlnQ408qiJVbdrElWwk0gfsIceck1aSURxDqkBFRsZjwiBfFZsMGd+hooaN1xxgy1T/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o/GrbqLC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so8044505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741869857; x=1742474657; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4eBilR3cQKKkUL6iTV1U2gPm+aqkc/I2/ErCrbp51A=;
        b=o/GrbqLCeyyu8Cw/4q1t9rjSCjvoqeKges7sjFAbL8xsEX4XHQpHVCLphDjin3B9OI
         bzH0u6lO2okzsgxF40lvXb5ECkMBJO6/cCjV6DKWv6Kglw7bDGRuvSQCrUntcbN9VjSS
         nQH0avWE+dP1UHHjTjRQ5e4RlCeU4leL0UL107u6LhJYTBUi7fey8r6o3xMEVgwBW+EB
         KFjWy39uxnnNuTrhFMFPiOvmuCqxhDcbXQ9U0Y1+4lHLBJ4+IX6f47JFGM0jPYQOYCiy
         0VBR2fo1zX4/RvWsoHbsxtYsWV8x+Ja7FTK46XSHdb4t66myUDN/WnJX6+2lVUWsnuei
         WYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741869857; x=1742474657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4eBilR3cQKKkUL6iTV1U2gPm+aqkc/I2/ErCrbp51A=;
        b=dJhB99GyoRXyrl1wBtr5LLNL8HVs+TuPbMG5CRLl5HwtJZjZFFF93zmJyiEHkvdhqC
         IOf+6mAZZUHPZfkdQWOPq590I1DT0IK7/yCdjoxehr9bDTKsTKQhOCgwEc5m9uyQq6hL
         vtAES1qy2noR2mNbk6yGfaso9/nE15umTivj2sF57KymTeOE54OsrKFkfICA55Ptbyx2
         bbgnOo20OniRoaDqXXSi2fHWvktNnQIegVC+E7Z+HrlNq4QkVPkfQqBiMe0/MmL7ncgY
         WyzuoVhuJs39cOIkS32Zz1c2qsA4THhcFWrstYWOz+ysJTBtqgXF2U+6XXbJiE+yCAcg
         cOow==
X-Forwarded-Encrypted: i=1; AJvYcCUHKP0VKp6P+ejQl34a+ZCH+szcytrmsnky9UZQOvQAxoPbn8u4ggYUUgI2/71J9eBKh38msOVghiuJAsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77+02b3d8mZUKyVdwCFkcH6cyau8TwPKN6O8DO7YeMo+XVbfA
	9CquL6Uxxr9coIKBA4Zt+SLyyI3Mvd1bOM/3RNaAaJey9XXeBvciEgO/SdM5/c4=
X-Gm-Gg: ASbGncvyQo98w51GNrLuC7nUoAkPXAhQN14++n5foN5dnwswwzU02YI6V7w2wmoTjeQ
	c4BuKCuDjXuq87xNI+bFQjRi3mtWl9fBKQhLUR9iCA0kacmMdI+TowO6giL4Yl8HNdLG5SboQJM
	FM4S8bjEOwNrE0SOv1GFaV43Ozeswapd7Sh2AHcMHNkwt6PuDwWW+fq8Ms8EhqTzKJE2l9YypIG
	rDko2tQSNd/6kWT8Ra5F2SwSp1SoaHDbIEpJCpUgfEcj70WvP1kx/Jf5JxahbKOd/UqbqkobWd3
	102T/27IPYsLEw0LnKC5lF756Mm8kraOSeQtPQCgzxE=
X-Google-Smtp-Source: AGHT+IEVKvciONpN7IaLFK/qsTCvmNWqORyhjjKaAjaSuACjOZk+fDyP3VpTM/ig5PwqolpsjOd7kg==
X-Received: by 2002:a05:6000:1a87:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39132dc4395mr17992640f8f.55.1741869857406;
        Thu, 13 Mar 2025 05:44:17 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e87sm2097439f8f.32.2025.03.13.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:44:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:44:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 03/17] riscv: sbi: add SBI FWFT extension calls
Message-ID: <20250313-ce439653d16b484dba6a8d3e@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-4-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-4-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:10PM +0100, Clément Léger wrote:
> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
> provided as a separate commit that can be left out if needed.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/sbi.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 256910db1307..af8e2199e32d 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -299,9 +299,19 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>  	return 0;
>  }
>  
> +static bool sbi_fwft_supported;
> +
>  int sbi_fwft_get(u32 feature, unsigned long *value)
>  {
> -	return -EOPNOTSUPP;
> +	struct sbiret ret;
> +
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_GET,
> +			feature, 0, 0, 0, 0, 0);
> +
> +	return sbi_err_map_linux_errno(ret.error);
>  }
>  
>  /**
> @@ -314,7 +324,15 @@ int sbi_fwft_get(u32 feature, unsigned long *value)
>   */
>  int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct sbiret ret;
> +
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
> +			feature, value, flags, 0, 0, 0);
> +
> +	return sbi_err_map_linux_errno(ret.error);

sbi_err_map_linux_errno() doesn't know about SBI_ERR_DENIED_LOCKED.

>  }
>  
>  struct fwft_set_req {
> @@ -389,6 +407,9 @@ static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
>  int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
>  			  bool revert_on_fail)
>  {
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
>  	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>  		return sbi_fwft_set(feature, value, flags);
>  
> @@ -719,6 +740,11 @@ void __init sbi_init(void)
>  			pr_info("SBI DBCN extension detected\n");
>  			sbi_debug_console_available = true;
>  		}
> +		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&

Should check sbi_mk_version(3, 0)

> +		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {
> +			pr_info("SBI FWFT extension detected\n");
> +			sbi_fwft_supported = true;
> +		}
>  	} else {
>  		__sbi_set_timer = __sbi_set_timer_v01;
>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
> -- 
> 2.47.2
>

Thanks,
drew

