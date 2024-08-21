Return-Path: <linux-kernel+bounces-295667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F4959FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EBC1C21655
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152001B5307;
	Wed, 21 Aug 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Q260JJbb"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8871AF4E3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250379; cv=none; b=GBs34tX937KXVensuEe7iKInnTWbkPqqEgOdy+/YmYln/9xsXrZm6SUYFJEQ1w1m89SzXjkwMtuleRhBQzbqoJPPOgReQgEzpurndW35PRAe5Xixkxrg8x5n5L2bzOws6Lo6Fqn7AD8yEC5bb5HgU5djDJZ1d9CAuN7nokQRLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250379; c=relaxed/simple;
	bh=e/p1wvN0rr+uwVTWTY5B1uoCkpF4QMNW+Ie2vp4O0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+r6RRhUDmYjX2hJ4zmvlU4iIEfh/pP1OYXdCFecKdnPhfOVpogO1pdYt/ODrcI0vKvNimvJek2W6fGiBus/12ZyefpxOFhdrdCHruwC4a7D+zCAY0tUecMCMvGblKRQg4k2XQuc7WBCAsbB2GLf8B4Jnta0LWtHAVaRtHBW7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Q260JJbb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3718706cf8aso4120583f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724250376; x=1724855176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrIMYX5Iitm0qRfXTFPY5P6XAicIDodU2yRwqwdOg/Y=;
        b=Q260JJbb3t1OMLulVqKJvob61fTJkAnU3QGlC3nXlf9HK9s7PS8mVIzofrCSjKrTd/
         QUZo+4aWF/mI+fx4avrfNyplOkqr4ft6FTb5BY8n+Wzy8ezsofxCKwD7ofGo99x3LN72
         DJwjsaP6tXOL/FxBr7HzEAl9ONJsbRQjfDnSoDwLs5k2/dQbq8YSDIsk8Hk/NRcMs6Yp
         uBpVA49cdJip939sI6RBdShnzz3PibKFcrsTVoShPDD/p/MsQM6KF/Tf113FWSjJxWD1
         ELyiMM+mdyo+PNgicESLBmDV881FsymnxkjDMVPBp+JnSavGIAchyUY4LEA2HOUqKA0y
         2soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250376; x=1724855176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrIMYX5Iitm0qRfXTFPY5P6XAicIDodU2yRwqwdOg/Y=;
        b=fNd9uzu5XMBzpfvvOUGh/4FzMgrtRGcXgPWFfNOymIIN5NTRiTV57/VCUpOdHEjvop
         /HvVrwJ/3fj+xpZFD62ZU1+UD0RZYG0DjTA57Gv8FSncxJ7Tpg5dQ2QSu6vl/Ink9xMy
         WRAzmRWkTiyw307NC4KMZeYclZ7nQW6iPn/Z3g2+IYhUxonh8LilMVHf2TBqlrBotoKp
         C+OcSp6MxQ+kSJwkVvTBur5yXn0xNguHBG+sciPOzeAWkjMqET+KXZPF5AMhjKjyhzXe
         NwyWO8jxwh2mGa4Tys7gEyvHzqMdKJVjjrDexBmwAQvM66JI9XCXKR7OSsg7UUFXIoqJ
         sUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaY3cAVsUIlc22MKL3O8LonJt7vlYNKidLkoMWCJLRRt0Mnql9UzNKtD9E4uX2Ft+eujCs5cyJk4vNC28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQwUQfV1Mnw3vpO1tue5yPKcjHiHAgqYui4boFRR+C6PuxJs6
	srBp/FZo6WWHQOBrycCkwcpYglht6BVsEgLBndYi2Zerr4fY3VG2BwGU1KPG/nM=
X-Google-Smtp-Source: AGHT+IFBp+F6BpmW+3C9l9vVnrfI4oNMEkRJT5vJDxgLRdcLaekCgZetIKmjR+7etclQht7wUwu4kQ==
X-Received: by 2002:a05:6000:196b:b0:371:87d4:8f1d with SMTP id ffacd0b85a97d-372fd6da3ebmr1649160f8f.28.1724250375016;
        Wed, 21 Aug 2024 07:26:15 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189857069sm15832388f8f.47.2024.08.21.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:26:14 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:26:13 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, Andrea Parri <andrea@rivosinc.com>
Subject: Re: [PATCH v5 06/13] riscv: Improve zacas fully-ordered cmpxchg()
Message-ID: <20240821-810273dbc0f3fc92a67d395f@orel>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
 <20240818063538.6651-7-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818063538.6651-7-alexghiti@rivosinc.com>

On Sun, Aug 18, 2024 at 08:35:31AM GMT, Alexandre Ghiti wrote:
> The current fully-ordered cmpxchgXX() implementation results in:
> 
>   amocas.X.rl     a5,a4,(s1)
>   fence           rw,rw
> 
> This provides enough sync but we can actually use the following better
> mapping instead:
> 
>   amocas.X.aqrl   a5,a4,(s1)
> 
> Suggested-by: Andrea Parri <andrea@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 92 ++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 1f4cd12e4664..5b2f95f7f310 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -107,8 +107,10 @@
>   * store NEW in MEM.  Return the initial value in MEM.  Success is
>   * indicated by comparing RETURN with OLD.
>   */
> -
> -#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx,					\
> +			      sc_prepend, sc_append,				\
> +			      cas_prepend, cas_append,				\
> +			      r, p, o, n)					\
>  ({										\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
>  	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&				\
> @@ -117,9 +119,9 @@
>  		r = o;								\
>  										\
>  		__asm__ __volatile__ (						\
> -			prepend							\
> +			cas_prepend							\
>  			"	amocas" cas_sfx " %0, %z2, %1\n"		\
> -			append							\
> +			cas_append							\
>  			: "+&r" (r), "+A" (*(p))				\
>  			: "rJ" (n)						\
>  			: "memory");						\
> @@ -134,7 +136,7 @@
>  		ulong __rc;							\
>  										\
>  		__asm__ __volatile__ (						\
> -			prepend							\
> +			sc_prepend							\
>  			"0:	lr.w %0, %2\n"					\
>  			"	and  %1, %0, %z5\n"				\
>  			"	bne  %1, %z3, 1f\n"				\
> @@ -142,7 +144,7 @@
>  			"	or   %1, %1, %z4\n"				\
>  			"	sc.w" sc_sfx " %1, %1, %2\n"			\
>  			"	bnez %1, 0b\n"					\
> -			append							\
> +			sc_append							\
>  			"1:\n"							\
>  			: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
>  			: "rJ" ((long)__oldx), "rJ" (__newx),			\
> @@ -153,16 +155,19 @@
>  	}									\
>  })
>  
> -#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
> +#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,				\
> +		       sc_prepend, sc_append,				\
> +		       cas_prepend, cas_append,				\
> +		       r, p, co, o, n)					\
>  ({									\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&			\
>  	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)) {	\
>  		r = o;							\
>  									\
>  		__asm__ __volatile__ (					\
> -			prepend						\
> -			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
> -			append						\
> +			cas_prepend					\
> +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> +			cas_append					\
>  			: "+&r" (r), "+A" (*(p))			\
>  			: "rJ" (n)					\
>  			: "memory");					\
> @@ -170,12 +175,12 @@
>  		register unsigned int __rc;				\
>  									\
>  		__asm__ __volatile__ (					\
> -			prepend						\
> +			sc_prepend					\
>  			"0:	lr" lr_sfx " %0, %2\n"			\
>  			"	bne  %0, %z3, 1f\n"			\
> -			"	sc" sc_cas_sfx " %1, %z4, %2\n"		\
> +			"	sc" sc_sfx " %1, %z4, %2\n"		\
>  			"	bnez %1, 0b\n"				\
> -			append						\
> +			sc_append					\
>  			"1:\n"						\
>  			: "=&r" (r), "=&r" (__rc), "+A" (*(p))		\
>  			: "rJ" (co o), "rJ" (n)				\
> @@ -183,7 +188,9 @@
>  	}								\
>  })
>  
> -#define _arch_cmpxchg(ptr, old, new, sc_cas_sfx, prepend, append)	\
> +#define _arch_cmpxchg(ptr, old, new, sc_sfx, cas_sfx,			\
> +		      sc_prepend, sc_append,				\
> +		      cas_prepend, cas_append)				\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(*(__ptr)) __old = (old);				\
> @@ -192,22 +199,28 @@
>  									\
>  	switch (sizeof(*__ptr)) {					\
>  	case 1:								\
> -		__arch_cmpxchg_masked(sc_cas_sfx, ".b" sc_cas_sfx,	\
> -					prepend, append,		\
> -					__ret, __ptr, __old, __new);    \
> +		__arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,		\
> +				      sc_prepend, sc_append,		\
> +				      cas_prepend, cas_append,		\
> +				      __ret, __ptr, __old, __new);	\
>  		break;							\
>  	case 2:								\
> -		__arch_cmpxchg_masked(sc_cas_sfx, ".h" sc_cas_sfx,	\
> -					prepend, append,		\
> -					__ret, __ptr, __old, __new);	\
> +		__arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,		\
> +				      sc_prepend, sc_append,		\
> +				      cas_prepend, cas_append,		\
> +				      __ret, __ptr, __old, __new);	\
>  		break;							\
>  	case 4:								\
> -		__arch_cmpxchg(".w", ".w" sc_cas_sfx, prepend, append,	\
> -				__ret, __ptr, (long), __old, __new);	\
> +		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
> +			       sc_prepend, sc_append,			\
> +			       cas_prepend, cas_append,			\
> +			       __ret, __ptr, (long), __old, __new);	\
>  		break;							\
>  	case 8:								\
> -		__arch_cmpxchg(".d", ".d" sc_cas_sfx, prepend, append,	\
> -				__ret, __ptr, /**/, __old, __new);	\
> +		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\
> +			       sc_prepend, sc_append,			\
> +			       cas_prepend, cas_append,			\
> +			       __ret, __ptr, /**/, __old, __new);	\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
> @@ -215,17 +228,40 @@
>  	(__typeof__(*(__ptr)))__ret;					\
>  })
>  
> +/*
> + * Those macros are there only to make the arch_cmpxchg_XXX() macros

These macros are here to improve the readability of the arch_cmpxchg_XXX()
macros.

> + * more readable.
> + */
> +#define SC_SFX(x)	x
> +#define CAS_SFX(x)	x
> +#define SC_PREPEND(x)	x
> +#define SC_APPEND(x)	x
> +#define CAS_PREPEND(x)	x
> +#define CAS_APPEND(x)	x
> +
>  #define arch_cmpxchg_relaxed(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", "", "")
> +	_arch_cmpxchg((ptr), (o), (n),					\

nit: no need for the () around the macro args when the arg is not used
in an expression.

> +		      SC_SFX(""), CAS_SFX(""),				\
> +		      SC_PREPEND(""), SC_APPEND(""),			\
> +		      CAS_PREPEND(""), CAS_APPEND(""))
>  
>  #define arch_cmpxchg_acquire(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
> +	_arch_cmpxchg((ptr), (o), (n),					\
> +		      SC_SFX(""), CAS_SFX(""),				\
> +		      SC_PREPEND(""), SC_APPEND(RISCV_ACQUIRE_BARRIER),	\
> +		      CAS_PREPEND(""), CAS_APPEND(RISCV_ACQUIRE_BARRIER))
>  
>  #define arch_cmpxchg_release(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
> +	_arch_cmpxchg((ptr), (o), (n),					\
> +		      SC_SFX(""), CAS_SFX(""),				\
> +		      SC_PREPEND(RISCV_RELEASE_BARRIER), SC_APPEND(""),	\
> +		      CAS_PREPEND(RISCV_RELEASE_BARRIER), CAS_APPEND(""))
>  
>  #define arch_cmpxchg(ptr, o, n)						\
> -	_arch_cmpxchg((ptr), (o), (n), ".rl", "", "	fence rw, rw\n")
> +	_arch_cmpxchg((ptr), (o), (n),					\
> +		      SC_SFX(".rl"), CAS_SFX(".aqrl"),			\
> +		      SC_PREPEND(""), SC_APPEND(RISCV_FULL_BARRIER),	\
> +		      CAS_PREPEND(""), CAS_APPEND(""))
>  
>  #define arch_cmpxchg_local(ptr, o, n)					\
>  	arch_cmpxchg_relaxed((ptr), (o), (n))
> -- 
> 2.39.2
>

Besides the comment wording and the nit about macro args,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

