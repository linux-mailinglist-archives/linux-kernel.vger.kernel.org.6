Return-Path: <linux-kernel+bounces-573365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31406A6D65B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5976188E3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158E25D528;
	Mon, 24 Mar 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Q5V9fS3h"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2452D7BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805514; cv=none; b=AzTu88UN9HhRc/qyE+R+E+1501hSSktin1NWljJD5lKTv8bGlYKmdQXnKphBooK5wLiazzeLrObbA45eh6rEXrM/tBDg1L4tSmT5i62pJT10LzvCiRKyutzX0of5DUyFuJxDpxhZ0VOl4XB5xbU4A8JLejfLE1suEpLSLO2fQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805514; c=relaxed/simple;
	bh=ZYP5ZE2sYmVE0GKwUpi6BvG/et9x6PsV3/5+gVDqQGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX9f8nXYaHbL7yL+frQqD0qRCitYcE1j0eXbzCHf9EmpMuyDgUwkDJtPw1vVp+FStrjHtKijvm+59pEDgdcgaaCga3Q2sbNt8GH6V6Mul4gHe+PmTVF2TInprpZqwdwSIBuvh9/BbI4koq57kN/RYop9EGahOC2khgvmgtIb+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Q5V9fS3h; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so37713705e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742805510; x=1743410310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZduTWk6Q/NfGLId+77FETKnLFu0VMYUFIa4ad6z5VWI=;
        b=Q5V9fS3hzrYm3NDncPBw08yRKmc681iE0M3nIzJb+0dBP61jsm18ef61GBC5jnd5ks
         4rBfkMGUrLEEfam72Q6FOBFabXK8tLWHiwiHgR0+/DnKDhB5iZWuMVn00uFla0tpMJM/
         hxFvSzUux5k+y9UT1iB8nEyTYCEdK+j8OYCXjatlgrJM2ALm1L9hBfi60KwEeR5FNQT2
         pMgwVwH2pbq0MQJzR2n1gUnUiKoHS4j9xIcI0giEE+CgLyFERvGtky+/ysY6mI3ZpnhQ
         FdveRkWVf4nLKCr1Iv07yqWRcDfBhNO1Wu2RLVKiM4FgZjjvr/TrE/5V8dicEtC/LSgH
         9Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805510; x=1743410310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZduTWk6Q/NfGLId+77FETKnLFu0VMYUFIa4ad6z5VWI=;
        b=oR+lHWfdIchHuKP13Jvt7l6MdONpMRTOKIDoSXpChGUYWPYwLkwP62IQQ5vt5UJJvV
         oDWIspVayolE92NbzL5ZgWg1QqQoCf5wLP2hoFSC9ERi0mfvDnZk1UjIeC1gc10cjBGc
         3ZgK7VJ2iHVNCnRE2jiaaWjLTGXKoIvgEQ9xZqYUT/SnqDTT6rNdwt3TDaZO2avawwKV
         b8OHNUsWyl4YnQDS0QVf67otsrOva7hvv8MbFDbE1+5pvWJC6z/Dy/wT3NyIBI0TIWUk
         P6dA//kkfZPZ6VTvMTE6IIAPWcblpYJqbIKG21FueUVNJ46Kqfd0HEk85qDembSS8N8I
         zdaA==
X-Forwarded-Encrypted: i=1; AJvYcCXcmGqmLtsWpxtjZTjYp4HVkgVuo5/5ldVBuW/5XMmfOQ1IDB/PAAdzxavMmD8EoLyL+/l4lm5UU2Xidn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6NQMq/SqJX2NQJEtmj+Cvj2ay8fj+Y9NHyZMFmD5iNULBL1c
	p45CqewANdsnapXt5P2VYg0niRAbzZkq4FVbNs3NTizlXyMtGwcH9Mz1Br0TsKY=
X-Gm-Gg: ASbGncstY9OyuC1vTmmfgjVFfalPtLgm1QChpsXSZ6S2DWD0NZ9B16WXEzi2sshcJlg
	i39Zq+dofyggZRWbEFVsjYZkbAEMsdQpmoPnmsScT/+W9zwHOIkJssXAP15SKGwpvlBb5kIMLsP
	MqHIei+R2ZJJoR3RdztQXrmRwn09geiu6tr5cFcaGBdftMJr2pWjZ60S92LnVw7kgD0VR8a6BIt
	jHJRK9BZHUceRDN18wgVe5iYsOaJvwdVwPA4xeMq2yrBlfgeuGREtZwJOAx/UMBFh3eLGxuwTdC
	rbVcF1mfrB7U7hvbYXDyvhSs8lJecFKmxuSCT/tf+w4k4cEDVMA=
X-Google-Smtp-Source: AGHT+IFfByT9kX5BtGIwa/tzkqtkM/NyfD6bNVjUzK/mR93IFLpzCJaTWVkJNz1ak36WHMSNC7s0NA==
X-Received: by 2002:a05:600c:3d8c:b0:43c:f3e4:d6f7 with SMTP id 5b1f17b1804b1-43d50a58731mr108138165e9.31.1742805510206;
        Mon, 24 Mar 2025 01:38:30 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c7e:e8c0:8299:1c31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm114934995e9.25.2025.03.24.01.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:38:29 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:38:29 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 02/18] riscv: sbi: add new SBI error mappings
Message-ID: <20250324-5d1d09fc9e50d2276ba56b6f@orel>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-3-cleger@rivosinc.com>
 <20250322-cce038c88db88dd119a49846@orel>
 <779c137d-5030-4212-b957-3d2620448ea9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779c137d-5030-4212-b957-3d2620448ea9@rivosinc.com>

On Mon, Mar 24, 2025 at 09:29:33AM +0100, Clément Léger wrote:
> 
> 
> On 22/03/2025 13:06, Andrew Jones wrote:
> > On Mon, Mar 17, 2025 at 06:06:08PM +0100, Clément Léger wrote:
> >> A few new errors have been added with SBI V3.0, maps them as close as
> >> possible to errno values.
> >>
> >> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> >> ---
> >>  arch/riscv/include/asm/sbi.h | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> >> index bb077d0c912f..d11d22717b49 100644
> >> --- a/arch/riscv/include/asm/sbi.h
> >> +++ b/arch/riscv/include/asm/sbi.h
> >> @@ -536,11 +536,20 @@ static inline int sbi_err_map_linux_errno(int err)
> >>  	case SBI_SUCCESS:
> >>  		return 0;
> >>  	case SBI_ERR_DENIED:
> >> +	case SBI_ERR_DENIED_LOCKED:
> >>  		return -EPERM;
> >>  	case SBI_ERR_INVALID_PARAM:
> >> +	case SBI_ERR_INVALID_STATE:
> >> +	case SBI_ERR_BAD_RANGE:
> >>  		return -EINVAL;
> >>  	case SBI_ERR_INVALID_ADDRESS:
> >>  		return -EFAULT;
> >> +	case SBI_ERR_NO_SHMEM:
> >> +		return -ENOMEM;
> >> +	case SBI_ERR_TIMEOUT:
> >> +		return -ETIME;
> >> +	case SBI_ERR_IO:
> >> +		return -EIO;
> >>  	case SBI_ERR_NOT_SUPPORTED:
> >>  	case SBI_ERR_FAILURE:
> >>  	default:
> >> -- 
> >> 2.47.2
> >>
> > 
> > I'm not a huge fan sbi_err_map_linux_errno() since the mappings seem a bit
> > arbitrary, but if we're going to do it, then these look pretty good to me.
> > Only other thought I had was E2BIG for bad-range, but nah...

Actually, I just recalled that there is an ERANGE, which would probably be
a better match for bad-range than EINVAL, but I'm not sure it matters much
anyway since this function doesn't promise 1-to-1 mappings.

Thanks,
drew

> 
> Yeah I also think some mappings are a bit odd even though I skimmed
> through the whole errno list to find the best possible mappings. I'd be
> happy to find something better though.
> 
> Thanks,
> 
> Clément
> 
> > 
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > 
> > Thanks,
> > drew
> 

