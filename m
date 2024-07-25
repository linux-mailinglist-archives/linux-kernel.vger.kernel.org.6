Return-Path: <linux-kernel+bounces-262610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0693C987
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86E21F21C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741C12FB1B;
	Thu, 25 Jul 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zHAl8Ars"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBB3CF5E;
	Thu, 25 Jul 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939296; cv=none; b=sco9qD4lk7rNTwTzBwY42HqVWBvMa9RciTn58vbWTp7gSPR58raBb/u2EHcP7lSmAD01vGPgePC//td7jwPAVsm9vy9WEwkCvdZVEjvaoXxsi8HYVqbI2a3TrdQ05I6i7o3bBVaMC+2filmjnUsH4ze7C988um1XlIJem8iHlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939296; c=relaxed/simple;
	bh=0s51NSbNHju9OKWShOXz0ndWhaBr6HUQ9uzd36ev4GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZMBby2HIjKXG6K4j4HKeS46Aw4uCcbuN0Q45Qt65b5qOhvb8ruyuDOZ2Qs91RokfcQH617f+7r3ja/xgjpPUC7hAr7DRKe+TRtLPxZLBQN96DXl822kyc6mMrR854426whe1qYqQYWKCkzqIR2i+ISZ8E0VagSzFctykXQO9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zHAl8Ars; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wg7yJREZnyNezMYRJuFSwN0D9BhYKJFLtV56cUGaQBs=; b=zHAl8Ars4XQ7iNwKmMRPswd8tt
	3WBH6IBJAN0Penrg7iXCeQTnp6bQBXroDvj88URtKl7Eg/blMfWQ0nOGgiPH0ouWrtgblaxxLQAPG
	gbcTWTGDuDdRMWcMzCkDcxJrPjRl0UbkY0kaTy3cX6TzWiplN3oyVIBk0zIMeW6jj/R069mr/Lww8
	ITuKQleJ18J2EM9+enjvtbbAoVb5K6Kzj1SvdOfZvCTiYVEP7sz5I757eI2c5gwdfkBzTSIcRej0C
	my3FHrJ3Zl+BcZ1ZVWC9LRQZ5WmviqB0qY9QKdSL7rUV+u+Trf8XrdMvtVUv/9/Cr66PBkPmkp0BB
	1Xro9l1g==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX54M-000000022A8-0uGU;
	Thu, 25 Jul 2024 20:28:10 +0000
Message-ID: <4226eb78-5078-44fd-bc05-f82d8d342c71@infradead.org>
Date: Thu, 25 Jul 2024 13:28:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: ioctl: document 0x07 ioctl code
To: Alyssa Ross <hi@alyssa.is>, Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240725171120.12226-2-hi@alyssa.is>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240725171120.12226-2-hi@alyssa.is>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/24 10:11 AM, Alyssa Ross wrote:
> It looks like this was supposed to be documented when VSOCK was
> added[1], but it got lost in later submissions.
> 
> Link: https://lore.kernel.org/20130109000024.3719.71468.stgit@promb-2n-dhcp175.eng.vmware.com/#Z31Documentation:ioctl:ioctl-number.txt [1]
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index e91c0376ee59..217bdc76fe56 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -78,6 +78,7 @@ Code  Seq#    Include File                                           Comments
>  0x03  all    linux/hdreg.h
>  0x04  D2-DC  linux/umsdos_fs.h                                       Dead since 2.6.11, but don't reuse these.
>  0x06  all    linux/lp.h
> +0x07  9F-D0  linux/vmw_vmci_defs.h, uapi/linux/vm_sockets.h
>  0x09  all    linux/raid/md_u.h
>  0x10  00-0F  drivers/char/s390/vmcp.h
>  0x10  10-1F  arch/s390/include/uapi/sclp_ctl.h
> 
> base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa

-- 
~Randy

