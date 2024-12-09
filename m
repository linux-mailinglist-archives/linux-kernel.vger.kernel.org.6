Return-Path: <linux-kernel+bounces-438008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2258E9E9B90
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709712818FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25D143890;
	Mon,  9 Dec 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bVkN6oLN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC314883C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761533; cv=none; b=bGHvRUFUAsWUEfFdiZy+NKOADeKF/8nR//ijBEPwljeNFCK992sTLu/FUOUOrLudmLMVUuU0w95xmtj8icqwgNkdRlLkoByYaV8mpQjMYJ7yt/EloygKyyGPdNoBZMJND+t75zEI29ylcsLC5bez9IJcpjgTMd3rCAFmmqbvxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761533; c=relaxed/simple;
	bh=fM5PGHA8vi65zWnX1BTN1MEY/EibjwplQVAS2tIjGfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIx3fpOr7E42ujchDIFB5IvanqWhk3qcQonRDhLXUgQTxvFDCmpSmK2cFeu0I8vnjn1f3ppP+1fl2dOyMz4k/8jQVwA1b91l/LJM9SH5V9ZCvsvOZZsxHB8cXUe8b7Ey+sX1hlx0IfWPx71DQ3ES2urmc/MWkGQKXZe8z43XSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bVkN6oLN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-386329da1d9so1332765f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733761530; x=1734366330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2pxOWI3xrkwAHNRcOrURto35zEibdpN2tF3/Hg076U=;
        b=bVkN6oLNjP2L8gqd88coYfxJ4zP7c0V/XoyyCqllo/Sf4TT/A/XjSXg+Bkj5tv0pDT
         A5YowKjBWmEpJAVaNi+H/NlV/rUCKfwTcg7fKk4zbA+a1UCNeia8VUwu9bljsYJlpI0O
         +qZOY7OLZrJ/5w8ANygij3LrV/Q22Oz2SderFXCgXChoGTTEPcgXHe6T8NifTD5xj+Ws
         b0h/Ekj6wBjscI03icY/qhqiEe6Q5dER3OU5ETmKAxC6BGmjEB+62sODaXEEx55jNWRO
         ZS/sbaAH+f3QfivLHshNNNDj/YAZh46rCk7p6xQn2qpYxGyyIoxbxeUa5XGfOcxz1UmO
         V9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761530; x=1734366330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2pxOWI3xrkwAHNRcOrURto35zEibdpN2tF3/Hg076U=;
        b=EAySTzVs3gtMFN8DB8EHoxVq4rlfTtT8FVgkRHZd3raPtwSOnO37z1aYLuG1tViYYH
         lbced+P8zZNZIxme7XPIx8MhJorMidiWj6biXTU1qUH3BQyyAZJXTPnuxB8NTATpgcjG
         gEbOhvR381EoqzIEIovqDU15VDMM5Axxk61r/+IAuDyq8R94HI8G/ezzawtM76fZLh5e
         /2I/XyhamNDdXcTaEc6yTDUKj0ulUquL+UdlDoESCuz1aUFWlqAZQkHOygGnxX1DCCQF
         aONqQ0zTegCrDiFNVzQrcz2Is6B19p1ceyke4be44uOxaHOAXU84hEgpEaWyO8Q7zih4
         8Lhg==
X-Forwarded-Encrypted: i=1; AJvYcCWR5Ab3JFRuyjnhSNsWslxzpU0eurEdkoPR2dzGf8s6HVKfo750WEy5acLza2oU/yb+kzSrGtWORczzoWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFjus+r8hJRUJjIe/wyKcao1Y4ZIAGXGyddsqZX5tlC1unKUI
	gwzWh44I+0iZuJn16XE4bAGoEUipbM2RLGnNchHT/RcANaLSEOoPr+qYU4uUers=
X-Gm-Gg: ASbGncuCjylPzyWEUl0nQjyP42PHvjJXx8BGu979NVSYTMLCBas31b2fZcE/9crF5Tr
	cu1A1FTSp9S9Vt2wfX6vpWfIkIgUdqRqsAQM4g6XmGk9JdtV4LC4uAcPkD/fgb4qVk6sS2CxgUv
	N7hxL4Dy2N5CQ/ksRqB1l9U7yOZYkkJtiSIsVg5deM/VTGsKGzeWVEhIbpQM6YS5B8dHFoOAdd9
	grYsN1+1+RLP2ddLOIJiwNFBg8pGxi7UmjsdB0Mlly6N3px2eaz6niPhkcQ+QUoOEomNEOc69qm
	+SjyKw55hVw/
X-Google-Smtp-Source: AGHT+IG0YRY/AI+hYtU/jY/moJvUMH8alDa4Bfs7WysfLm7PTeWvvswR1hSEHB/r4Jz0ywy3oKLk4w==
X-Received: by 2002:a5d:64e6:0:b0:385:f220:f798 with SMTP id ffacd0b85a97d-386453d269dmr814304f8f.6.1733761529729;
        Mon, 09 Dec 2024 08:25:29 -0800 (PST)
Received: from localhost (dialin-242125.rol.raiffeisen.net. [195.254.242.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219096d8sm13826119f8f.78.2024.12.09.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:25:29 -0800 (PST)
Date: Mon, 9 Dec 2024 17:25:28 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v5] riscv: selftests: Fix warnings pointer masking test
Message-ID: <20241209-393e756fd92bdfe890b1d4ae@orel>
References: <20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com>

On Fri, Dec 06, 2024 at 09:52:11AM -0800, Charlie Jenkins wrote:
> When compiling the pointer masking tests with -Wall this warning
> is present:
> 
> pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   203 |         pwrite(fd, &value, 1, 0); |
>       ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> ignoring return value of ‘pwrite’ declared with attribute
> ‘warn_unused_result’ [-Wunused-result]
>   208 |         pwrite(fd, &value, 1, 0);
> 
> I came across this on riscv64-linux-gnu-gcc (Ubuntu
> 11.4.0-1ubuntu1~22.04).
> 
> Fix this by checking that the number of bytes written equal the expected
> number of bytes written.
> 
> Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v5:
> - No longer skip second pwrite if first one fails
> - Use wrapper function instead of goto (Drew)
> - Link to v4: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com
> 
> Changes in v4:
> - Skip sysctl_enabled test if first pwrite failed
> - Link to v3: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com
> 
> Changes in v3:
> - Fix sysctl enabled test case (Drew/Alex)
> - Move pwrite err condition into goto (Drew)
> - Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com
> 
> Changes in v2:
> - I had ret != 2 for testing, I changed it to be ret != 1.
> - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> ---
>  .../testing/selftests/riscv/abi/pointer_masking.c  | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> index dee41b7ee3e3..50c4d1bc7570 100644
> --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> @@ -185,8 +185,20 @@ static void test_fork_exec(void)
>  	}
>  }
>  
> +static bool pwrite_wrapper(int fd, void *buf, size_t count, const char *msg)
> +{
> +	int ret = pwrite(fd, buf, count, 0);
> +
> +	if (ret != count) {
> +		ksft_perror(msg);
> +		return false;
> +	}
> +	return true;
> +}
> +
>  static void test_tagged_addr_abi_sysctl(void)
>  {
> +	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
>  	char value;
>  	int fd;
>  
> @@ -200,14 +212,12 @@ static void test_tagged_addr_abi_sysctl(void)
>  	}
>  
>  	value = '1';
> -	pwrite(fd, &value, 1, 0);
> -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> -			 "sysctl disabled\n");
> +	if (!pwrite_wrapper(fd, &value, 1, "write '1'"))
> +		ksft_test_result_fail(err_pwrite_msg);
>  
>  	value = '0';
> -	pwrite(fd, &value, 1, 0);
> -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> -			 "sysctl enabled\n");
> +	if (!pwrite_wrapper(fd, &value, 1, "write '0'"))
> +		ksft_test_result_fail(err_pwrite_msg);
>  
>  	set_tagged_addr_ctrl(0, false);
>  
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> -- 
> - Charlie
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

