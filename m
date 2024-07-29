Return-Path: <linux-kernel+bounces-265163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0C93ED75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1DA1C21C10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128084A36;
	Mon, 29 Jul 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cjfHh76B"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966C8287E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234505; cv=none; b=s8z7TIxQ3qEpxGp9g5XpjBw7BuHDcRidN405d86xjX8sM0ep882pWKuwHlDxE13H/KnEpEoG1hlFMTeyMce6IOuZK4SjT6XHCng5GGkO8xE3OUbxQLmKJsxYlsU5Z813tTNlNysiF+X/3ZYKEN9K6t7TeYtZtgx9THulzdiaP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234505; c=relaxed/simple;
	bh=nHiEo1ErGhfWHnITXXyXVIz+TpkqlULio0NdjcvTGxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv0+wN2OCK4VpkvlvwRjonOjH8e4ncJdBEY/zNQ7lGnRIiEsfpHBWmiRUQPuPTPKrBAaZ0hZjLLohdb93pb50Cs/OeaZrs9v63IgKYrdQJMWhYkdaDoF4yppxk5SufDGINZ3Yc0hjGy7cFY1sFS9T23i1ify5+CxbM0YXOtNpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cjfHh76B; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d28023accso1943417b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722234503; x=1722839303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LhZsel+ZXOFBLouKmnPn+e0gC2RjgaR8JO/hzKLRAg=;
        b=cjfHh76BjPOLV13RfB/kPgZkdjxTGgdLy8kbnka4Rr+6sswIFcPqm9Lrzo9YXsibHD
         MBwjXSaCJgXp4ry+syXpSBT6+31jlWvLKoWbmNQhZ0+DPjOiDYJ+cA92CptVxjhZK10j
         L1KI5OtUV8b8rV1L3uznFRcO7cejTq4Ja34uoJLRfEpLXbA1PfiwKax/bKRdIkbTR3OF
         qEsboOn6QVvWnQdWKlQoZ+MeaWNOag7M29znUz7P8a1ZSoBy+Fhrv57WhPttKgo7M691
         JRXI60WfsuLKBTqmyB67fBYDFHDJgg26Bui624siTg/qupNPqjpIWetmaOMDQl/MISDa
         dpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722234503; x=1722839303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LhZsel+ZXOFBLouKmnPn+e0gC2RjgaR8JO/hzKLRAg=;
        b=FHuSFEyjnQZRt+QxmwafgQLkSdlmL/VcNDKIDHDNCsvCCbi1+vkDA31NNEvSTmDq5c
         JiK8/6TWgj0UJrt3xGiA1duL0I3+nVvJZ77rIjAiRuu0vkgzE6uaaytMkYJXzUipCbW7
         4Ccv1VHQXdXO6Huqrq2Y0EEsq9IL1K18uqW8q8Pq5RiqQm9JS5hnNNNht4ZgvuH11UhN
         57C3YkH5iwR+saP+FBZg+/2ig+UQ8cYNpBU/ShBgyYxmsd7yvRYLnaGY+PzR2Dn9J6dy
         ksKIWu3eyjMkPHkN08Z1TuSGDHOGYpkp08jBAwBIsEMqGlm8QRaVykS+YiiBTRKYEk1h
         3A3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXM5z0bg7Anq8J4u2VTteqofLE/f9w8Slp13faVKMBuxMszA009KS+cG/2hmIP5M2nzD5T45rboKybLU2+F8fwwg+UFVyijMWHB3nT8
X-Gm-Message-State: AOJu0YzqnmTgOlJgT/FYPjs2UZEdqFyp1apjla+XxpftK+bpQXabDLUa
	gdN0RBY0xm00rBimD+4gRm05tAjtiS/HLrwNYvIv4gLtcyaJBhy0oPxOSJugjAw=
X-Google-Smtp-Source: AGHT+IFxLwq27q0Hdj/w8FwvESdnHQBwsPuqDTmOipebs/uzejoVKO14hWPOPPbb4dFbQ7eyO/Gv0w==
X-Received: by 2002:a05:6a00:6f64:b0:706:6bdc:4de5 with SMTP id d2e1a72fcca58-70ecea1dd24mr4120390b3a.7.1722234502813;
        Sun, 28 Jul 2024 23:28:22 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead715540sm6132019b3a.45.2024.07.28.23.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:28:22 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:58:13 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] ACPI: NUMA: initialize all values of acpi_early_node_map
 to NUMA_NO_NODE
Message-ID: <Zqc2fQr4KJrJW9IB@sunil-laptop>
References: <20240729035958.1957185-1-haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729035958.1957185-1-haibo1.xu@intel.com>

On Mon, Jul 29, 2024 at 11:59:55AM +0800, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/arm64/kernel/acpi_numa.c | 2 +-
>  arch/riscv/kernel/acpi_numa.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 0c036a9a3c33..2465f291c7e1 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -27,7 +27,7 @@
>  
>  #include <asm/numa.h>
>  
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
>  
>  int __init acpi_numa_get_nid(unsigned int cpu)
>  {
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> index 0231482d6946..ff95aeebee3e 100644
> --- a/arch/riscv/kernel/acpi_numa.c
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -28,7 +28,7 @@
>  
>  #include <asm/numa.h>
>  
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
>  
The change looks good to me. However, I was wondering whether it needs
"Fixes" tag in which case I think you will have to split this patch into
two.

Otherwise,
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil
>  int __init acpi_numa_get_nid(unsigned int cpu)
>  {
> -- 
> 2.34.1
> 

