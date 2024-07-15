Return-Path: <linux-kernel+bounces-252708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE58931723
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BF3B21975
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F818F2C9;
	Mon, 15 Jul 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sHFL7hFB"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89818EFE9;
	Mon, 15 Jul 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054765; cv=none; b=qYLQyqVPl2arzg39i1N7Gb/YeoOTi/1uerVZQxgddoLVDEcWmRKk3cYbAxEdeEs74EZBHLQGBFG315hshzfH3TfeiNidW3f1Jp+AeRToNGL4mgkq0Yojmn7Lxra+JFZxrdxFJ2I+Nyh6/XQZw4zdsrd2LKnyhmFNGN425HpA9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054765; c=relaxed/simple;
	bh=Luxwy5irdYgQUpZWRewadQ4SktmxJK8LzxEEBAj36cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke96P5WSmwmJ5wj3l/QVurn9vvXXmRREcR0Aex65/1kDpCIlard6htg5jdefZw+ombhQFi7Nt3mCtKkzJ7R1t87ssuHMaPYxGnK0NJnL227E53jBCkQ3RILTC6Ml3RRxxT26H6h+7aAv3eeg2JmIBA61OqXvm52qY8mekqu3YV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sHFL7hFB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KBMY6ImByh0nc1MFLk705Vqteq2mAvd0PlwRDlPJeHY=; b=sHFL7hFBYeFIyG7ArQgc7k42mz
	45fduOq8+alHbbYpPXET3Rcv8zVKQ1R9BCRgw9aAaXDC+hesqu/eqMF1H/WbvJfOtkikf8qiIoozr
	yrGG+k4g2TE+kDamzL3SuH3MkNy+89XfNb9OqFI6lshk/dZEoxUftTEmbwy7IE2xF8JmEZpQynSK+
	5ywyBy1DSJ1OgYGYGGCX3n68TzJXRuQscRgNux+vsXLdYKon525WrB+vD/fSIh9HaUFor57/xvyuB
	0hOfLgrzX7D9/BRtk+HVjsjefD7TQ5WRDhd4+uWBXtzJgtFffuToqYUR5qJe1TzyJyrfHytDKteuo
	LBXkvzLQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTMxh-00000007Qkf-3bKR;
	Mon, 15 Jul 2024 14:45:57 +0000
Message-ID: <2ee554e6-944f-4a2a-afb0-50fec5d37d26@infradead.org>
Date: Mon, 15 Jul 2024 07:45:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Docs/admin-guide: Remove pmf leftover reference from
 the index
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240715104102.4615-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240715104102.4615-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/15/24 3:41 AM, Ilpo Järvinen wrote:
> pmf.rst was removed by the commit 2fd66f7d3b0d ("platform/x86/amd/pmf:
> Remove update system state document") but the reference in the
> admin-guide index remained in place which triggers this warning:
> 
> Documentation/admin-guide/index.rst:75: WARNING: toctree contains
> reference to nonexisting document 'admin-guide/pmf'
> 
> Remove pmf also from the index to avoid the warning.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> I'll put this patch into pdx86/for-next that introduces the problem
> before making the PR to Linus.
> 
>  Documentation/admin-guide/index.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 32ea52f1d150..e85b1adf5908 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -121,7 +121,6 @@ configure specific aspects of kernel behavior to your liking.
>     parport
>     perf-security
>     pm/index
> -   pmf
>     pnp
>     rapidio
>     RAS/index

-- 
~Randy

