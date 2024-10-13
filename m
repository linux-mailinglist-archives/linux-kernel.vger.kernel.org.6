Return-Path: <linux-kernel+bounces-362828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8399B9A8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEBB1C20D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE471448DF;
	Sun, 13 Oct 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KfMJqs3D"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9813D245
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728827207; cv=none; b=cl54+LTQOqqlsvxRm1dBBurj4xovoMNU2SdF+XNXti9Ml4e37Ukhe/NgU4olmoutFm6AwGie1d42s2iMKePtZB9Zo9nGPtCfKul+WyYLClORV8eVnODlsr5RVQ6XrfUMgsrMXtO7uz3MBJY3Y7+6oTXo96XAG0dn+j6o+NDE32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728827207; c=relaxed/simple;
	bh=eb4FTsFakVVt4QLIUU3vCpvkd45UVOJJrl5yD5w2EE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr48Aymx+/ibQ2+we1gOjGHWYEp+YYKaDsUxVaALk5W+QeTe6g5BcQmUWr3BvD1gl8HJ9ysbWgFp3SDQ7Wia+3F5hVHHk7DS6o+y/YadhaPoaYRVVdhy6W58scGj0+BPS1KAYWrbX0O2HnECyO7nPZlKa8kHiWO+SNfU9ND8/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KfMJqs3D; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=DG4VaxTxz6RJrJgJZkRSyVZtJZTlRJTMy8AojFB/k6E=; b=KfMJqs3Dox3zJa1N
	vvXZMPEA0cokfYfvkoOFXUfvEchzN9+dowKOS12GSX5o9rzTKGRl7xBXMZTomltX9YOb2jq94Qsl0
	zAYmLF7Gcz5nDFwyOsuQnf1W1qIK49YKwm8E2frwwS4H7wCMJnyumCdkJzN4Xcz70HAKD1rMkScGH
	etcIk2K44F4gIEHcyBJwg6/5mKHljQgdR1KCWIRZYP4njnN7LptRQP+qofCYETvczmoKAvhkQRWfD
	NLYAI4JBJjv6e31nImKyhAVKFuXJZNLD5XTs8Knnkx6zYBEtI/OfFT2mxDBukV0p69v5UC53Cjj4g
	G+D6QXmO0nM8ZQ1nFA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1szyvR-00AlgS-2R;
	Sun, 13 Oct 2024 13:46:25 +0000
Date: Sun, 13 Oct 2024 13:46:25 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Remove unused function 'atou'
Message-ID: <ZwvPMYWYfVFMonDL@gallifrey>
References: <20240913005753.1392431-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240913005753.1392431-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:46:09 up 158 days,  1:00,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> I can't find any sign of 'atou' having been used.
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping

Dave

> ---
>  arch/x86/boot/boot.h   | 1 -
>  arch/x86/boot/string.c | 8 --------
>  arch/x86/boot/string.h | 1 -
>  3 files changed, 10 deletions(-)
> 
> diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
> index 148ba5c5106e..0f24f7ebec9b 100644
> --- a/arch/x86/boot/boot.h
> +++ b/arch/x86/boot/boot.h
> @@ -305,7 +305,6 @@ void initregs(struct biosregs *regs);
>  int strcmp(const char *str1, const char *str2);
>  int strncmp(const char *cs, const char *ct, size_t count);
>  size_t strnlen(const char *s, size_t maxlen);
> -unsigned int atou(const char *s);
>  unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base);
>  size_t strlen(const char *s);
>  char *strchr(const char *s, int c);
> diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
> index c23f3b9c84fe..84f7a883ce1e 100644
> --- a/arch/x86/boot/string.c
> +++ b/arch/x86/boot/string.c
> @@ -88,14 +88,6 @@ size_t strnlen(const char *s, size_t maxlen)
>  	return (es - s);
>  }
>  
> -unsigned int atou(const char *s)
> -{
> -	unsigned int i = 0;
> -	while (isdigit(*s))
> -		i = i * 10 + (*s++ - '0');
> -	return i;
> -}
> -
>  /* Works only for digits and letters, but small and fast */
>  #define TOLOWER(x) ((x) | 0x20)
>  
> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
> index e5d2c6b8c2f1..a5b05ebc037d 100644
> --- a/arch/x86/boot/string.h
> +++ b/arch/x86/boot/string.h
> @@ -24,7 +24,6 @@ extern size_t strlen(const char *s);
>  extern char *strstr(const char *s1, const char *s2);
>  extern char *strchr(const char *s, int c);
>  extern size_t strnlen(const char *s, size_t maxlen);
> -extern unsigned int atou(const char *s);
>  extern unsigned long long simple_strtoull(const char *cp, char **endp,
>  					  unsigned int base);
>  long simple_strtol(const char *cp, char **endp, unsigned int base);
> -- 
> 2.46.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

