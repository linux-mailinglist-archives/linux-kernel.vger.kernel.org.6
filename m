Return-Path: <linux-kernel+bounces-423547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6079DA988
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C05281A40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AC1FCFD0;
	Wed, 27 Nov 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lzYoEZgG"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBD3232
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716170; cv=none; b=DwcJP8ZxBBTWFfPR8eazWh5ceqFN7adRE+nXdUK3nNOvHMR81lZiFmRL0HxbOLWYHEJhyzgALgb68s2vjQ39/AkeZO0Y4T93xiNq+T3Um6Nkffq1T6tMvHEO92HVDjZ0TfEe48Lzp04P6sELFBvn4EN7sfbx2r47cxQvyfuiNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716170; c=relaxed/simple;
	bh=qb9TFOTX3syqD5AaXirIorMhGgw6vDS0CAsUGJCBPdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2gSgX6k8729oMXYWLSrR6shuwktvp4V1Glui2/u6x9r76FOJuguORBRhk2YHlPZQkpy2gLqCQo6Tb+fCa7hJhaGrk0V2aEQFU//ADTMQJi/O0qjmR55t2k+uF31f0FtW4MjCQXKpy85vJrXwO4dTcEnx/LT+crRFGWLuEzbPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lzYoEZgG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so26188605e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732716167; x=1733320967; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHoVh6bdQ+49A7HwWA2MZyeijxPsG/IR+pS2oskUYMg=;
        b=lzYoEZgGDBHqJu3AlUvpBQvxAVqHInKJB0N0ailkEKgYXgUHw5KJi4z3MV46GQG3/M
         CEZuAcZK933p2uB253LLUn85ZrPMQt10RlsyLtjB/WNn1QiVFDDrUwjmwGZbzOpV7Fmr
         wH7g31VGuI+49O3Ny/PpGRSjxsYSPvvHB78bkyezSPJrhmHJourL8quVmpv4e9KFBIcF
         EM258NE2JQqrs7xr3TonquiQPr4v4yC2jHY43yvNH+fIESNScSHG0Gs8t/BC9nPzCOM6
         usgCC2cjPHTivrYx8uAhD8A/MqxkV68+asyG8OnuvIzu/zuCt9WEFrG9D5WBrGK1w14H
         DhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716167; x=1733320967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHoVh6bdQ+49A7HwWA2MZyeijxPsG/IR+pS2oskUYMg=;
        b=UvaTY8Yx6Dcp3z9zjF70/aG8kum4QBwaz6z9WVTx5g2J780ZKrwslnIcIkqCM/DiFh
         xx5QqTmchonDeb8TSIrwZzb9cQZjE2Tn9zaJKE8/74EGxoauFGHY04UgteKEpLPuag+h
         vSnBk9qeL8SGdBzJqhJtsaeGP0+UVV0AEHqcrB7nQm0yztV/4PeH88nIYRLRfujXGam7
         TQS3e+ODwjuJ00cbbxSgVR4xEpz5zAOSnauQbRNpiwy1VoqLvz3xplXTyVQ/0dcwbrkM
         Hj6A1HNVAJFXyBZejDlCk7UYx0h3VVzJ6/i7OMJw+reNw4a67Qc7C0WB3EeCNdaVdRQz
         ZxdA==
X-Forwarded-Encrypted: i=1; AJvYcCW6++tTCCy5RNo0tskBA0TqsBbVaLdsKvzTjgJQWcsMCqIkwoBGMx+RTvWFiLMqzJ5e5PoPPErUB8gscVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwockENE3x//6spwgF05hFZM/uZ0z9HcxqmuwzxvKJjZsyIeOKS
	ICXVr3W6TT5uBH7WMQKwRdJ/H2/D+x4uHZIcQnQHKJBRGImtgkzyFQE/ws4c6wM=
X-Gm-Gg: ASbGncutVICOMF0NBHypXMWhwnGoGBvpDqmp3b/JYiZlYu7e7ON7cuOodiIO3yWsCN9
	xiQPw4Z2jDvJ9tXvDBLzfSo0Mt6xvBSDOY76bPsy63/iBOQhdJVhvhVat3NV2MalQsZVTOepVJ/
	gEa6szgRwzB+DQUwi75v6IyZZ8MAXCVp3RWUPUxhkbh+0aaUkU3b0XJlYSo6BxCDvBUOj3ZpJv4
	DISkedMcQwYGqIbVejbFVbblRY87d1qmNBbCgSbBFdfHdLyLK6eC8MxCdmTSGz2yFZLHdrBVK6X
	bdHW1SUbuPsIZuRwyX1uYJ6aesG4iN/M5Ek=
X-Google-Smtp-Source: AGHT+IFe1fSW20TaAbPYl6Y04HjqEdbDAiCLB5PflXpOVEcCMA7NIYGVv9p91IM/S4pid4RHtdLlvA==
X-Received: by 2002:a05:600c:3b24:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-434a9dbb06cmr33861275e9.3.1732716156911;
        Wed, 27 Nov 2024 06:02:36 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763a59sm22192305e9.11.2024.11.27.06.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:02:36 -0800 (PST)
Date: Wed, 27 Nov 2024 15:02:35 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Charlie Jenkins <charlie@rivosinc.com>, zhangkai@iscas.ac.cn
Subject: Re: [PATCH] riscv: module: use a plain variable for list_head
 instead of a pointer
Message-ID: <20241127-2c074e38cc599c7e2d0da505@orel>
References: <20241127103016.2699179-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127103016.2699179-1-cleger@rivosinc.com>

On Wed, Nov 27, 2024 at 11:30:14AM +0100, Clément Léger wrote:
> list_head does not need to be allocated, it can be a plain variable.

rel_head's list_head member, rel_entry, doesn't need to be allocated,
its storage can just be part of the allocated rel_head.

> Remove the pointer which allows to get rid of the allocation as well as
> an existing memory leak.

It'd be nice to add how the memory leak was found. Inspection or some
tool?

> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
>  arch/riscv/kernel/module.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 1cd461f3d872..47d0ebeec93c 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -23,7 +23,7 @@ struct used_bucket {
>  
>  struct relocation_head {
>  	struct hlist_node node;
> -	struct list_head *rel_entry;
> +	struct list_head rel_entry;
>  	void *location;
>  };
>  
> @@ -634,7 +634,7 @@ process_accumulated_relocations(struct module *me,
>  			location = rel_head_iter->location;
>  			list_for_each_entry_safe(rel_entry_iter,
>  						 rel_entry_iter_tmp,
> -						 rel_head_iter->rel_entry,
> +						 &rel_head_iter->rel_entry,
>  						 head) {
>  				curr_type = rel_entry_iter->type;
>  				reloc_handlers[curr_type].reloc_handler(
> @@ -704,16 +704,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>  			return -ENOMEM;
>  		}
>  
> -		rel_head->rel_entry =
> -			kmalloc(sizeof(struct list_head), GFP_KERNEL);
> -
> -		if (!rel_head->rel_entry) {
> -			kfree(entry);
> -			kfree(rel_head);
> -			return -ENOMEM;
> -		}
> -
> -		INIT_LIST_HEAD(rel_head->rel_entry);
> +		INIT_LIST_HEAD(&rel_head->rel_entry);
>  		rel_head->location = location;
>  		INIT_HLIST_NODE(&rel_head->node);
>  		if (!current_head->first) {
> @@ -722,7 +713,6 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>  
>  			if (!bucket) {
>  				kfree(entry);
> -				kfree(rel_head->rel_entry);
>  				kfree(rel_head);
>  				return -ENOMEM;
>  			}
> @@ -735,7 +725,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>  	}
>  
>  	/* Add relocation to head of discovered rel_head */
> -	list_add_tail(&entry->head, rel_head->rel_entry);
> +	list_add_tail(&entry->head, &rel_head->rel_entry);
>  
>  	return 0;
>  }
> -- 
> 2.45.2
> 
>

Other than the commit message change suggestions,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

