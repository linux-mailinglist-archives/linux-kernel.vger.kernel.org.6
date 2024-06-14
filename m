Return-Path: <linux-kernel+bounces-215466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA324909325
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C190B217E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51871A0AFD;
	Fri, 14 Jun 2024 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KpiM9gRA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB2383;
	Fri, 14 Jun 2024 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395596; cv=none; b=owqzscpybklsFeYLH+p+bc20wHyUX0A6qf/iCK6Ch7n7BBkzpohaxox0oTNegfAj+lGNKwrv00uFH26sOtqfMtkfL6z0njDrMGcD01e1HJrPmFjHyKvlZEzv84V7qQxd0MHbi3cmWDnappbJ7nsb5mowUiIOJd85gR7Mqoi317M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395596; c=relaxed/simple;
	bh=nHoaP/GaQSxefAsiXgLGzU/oYd+wmrJui6yiBp86/9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrjhsNy6DXHjGMAKVUJ1UsQh5M88+VwuHAqAU4kDkwup0SUiNzzahiBh8QEFNP7HVyjqNakmD7lvEXrS1BYTIRVFytb2mT9qlVY9f9EGKp1MtyWf9UhungmE/ltT/O4k4nIMV7EXz7HHyZrPbcsk4S95HIX5zItVzZ8SFlbN8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KpiM9gRA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/MLyFvtvPCSsCJBTNsNdmmW4gAACNBIixoKyIDtkgHA=; b=KpiM9gRAEtHBYCNqMqUcW9c7ux
	jMGg9HU8CYEa3JHzoo/j9bU08bl6Rin1+QVzkErrt/ABhDCTK5VQ1llpYaT5dckNVh6f6KGkB08Zs
	JksbBz+amTYE8agkI9ECjSLAwDQ0B03I+r+f4BoE5Q3n/ucoX+nnSDJKhRuFjAy4has40hSKEU1iJ
	XVMNBi6bVPNcsrrFOSaI+2J3RF69NvzBMGCq97bXZyi/bDLyidwF5/3M+3bsHdEzDG4EPM0iahHTM
	Usb4V2GISzumrK/uYmFTe9B1NbkAfa9zMWWnqyczfnvioUL/6SK5I3X5eiXXsdkjT7zKSTtbZ7UcT
	SOKf22Gw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIDBt-00000003wbD-12Dh;
	Fri, 14 Jun 2024 20:06:29 +0000
Message-ID: <65e8b991-84cb-4ff6-8daf-943ed0b5daa4@infradead.org>
Date: Fri, 14 Jun 2024 13:06:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Remove unused "spia_*" kernel parameters
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
 Alexander Shiyan <shc_work@mail.ru>, Olof Johansson <olof@lixom.net>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-mtd@lists.infradead.org
References: <20240614184041.601056-1-thuth@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240614184041.601056-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/24 11:40 AM, Thomas Huth wrote:
> The kernel module parameters "spia_io_base", "spia_fio_base",
> "spia_pedr" and "spia_peddr" have been removed via commit e377ca1e32f6
> ("ARM: clps711x: p720t: Special driver for handling NAND memory is removed").
> Time to remove them from the documentation now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ff02e1a02e12..dd8436c98735 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6273,11 +6273,6 @@
>  			Not specifying this option is equivalent to
>  			spec_store_bypass_disable=auto.
>  
> -	spia_io_base=	[HW,MTD]
> -	spia_fio_base=
> -	spia_pedr=
> -	spia_peddr=
> -
>  	split_lock_detect=
>  			[X86] Enable split lock detection or bus lock detection
>  

-- 
~Randy

