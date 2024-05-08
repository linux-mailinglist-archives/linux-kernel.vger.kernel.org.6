Return-Path: <linux-kernel+bounces-173149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FB8BFC39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E733E1C21BC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879382492;
	Wed,  8 May 2024 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vp+oNFN9"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AC823DD;
	Wed,  8 May 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168222; cv=none; b=qrjvs207sTlcaWaitD3mtPja7HLzQLvv61Cdnz5RHFbOMs/Vxt11+++eAvQxSXGy3+LXwMzXl7XGIwYS1v3cutWsoHKDooyJnH3VJ74I4ArygTLAIIHObGqtxszIMedfdr0P3UUIwElKwU5y0qnzuECtZ4kmVVjVhcqbhGNI/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168222; c=relaxed/simple;
	bh=z/2a/nrs23WhS9VrtF5qiDn+DU+cNJvGsX0TMquMRxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8yO+xm1PrKXS+S6ahVwnvJKMh7R9TyyXfdvRp+4f/8D6VnaeYF8v1MHdcArHKj7mFPA2Bqeb57C2f+kTTRSv9i4sbfpCHUJxF1RAEPZdgfJ1MLQEClGUGjf+C7Nah33aGRvmf9TZdQsNywvm25SVLbWu4w1Fe6BPmYl6xwtulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vp+oNFN9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=lwuG52TUbyfVkNwqey1JXh7+1gTpfjwoDt9EJB504Lw=;
	t=1715168221; x=1715600221; b=vp+oNFN9YcexA9sn1rkTwGe+LIyAGFqDIo88U2/k8wGCO2N
	iFpjjIKKZYng4anMFaoT1phnQpJ0h6Oh0LEyNCazes+Fy/ZHLMKofC5SwiBxeyScIVD9qbWdH6hYS
	4+YOfGeETq2iXYFxA0HtPxYWo+in/7MugkhC6GquCR5Gfdg6vBgn/oXuJC/yrUiHsLxn6xFeEOKDC
	CgyQo2Xj2+ZF2KRI2ezAAZXFoOQftCdlLrrqcLSvopKaLEtmkVXtZTCL9vXdWB5Di7GeXK1fBFZ10
	Fs9oeCkT8wqXMFlBnPVr45J5SnG/3KA/TWVo5EjQrAssR84JJlga5Lk4NAy4sRvw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4fbX-00055h-2w; Wed, 08 May 2024 13:36:59 +0200
Message-ID: <252f883a-6bf1-4ef7-a5f9-d261a6cf725e@leemhuis.info>
Date: Wed, 8 May 2024 13:36:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] next boot regression caused by
 RIP:0010:acpi_find_gpio+0x4b/0x103 kernel panic
To: Laura Nao <laura.nao@collabora.com>, regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240426154208.81894-1-laura.nao@collabora.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240426154208.81894-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715168221;b694817c;
X-HE-SMSGID: 1s4fbX-00055h-2w

On 26.04.24 17:42, Laura Nao wrote:
> Hello,
> 
> KernelCI has identified a next boot regression on the following
> Chromebooks, between next-20240416 and next-20240418:
> - Lenovo ThinkPad C13 Yoga Chromebook (codename morphius) - kernel
>   configuration used [1]
> - ASUS Chromebook Flip C436FA (codename helios) - kernel configuration
>   used [2]
>
> [...]
> 
> The issue is still present on next-20240426.
>> #regzbot introduced: next-20240416..next-20240418

Hmmm, I noticed nothing has happened here.

Is this issue still happening? With a link to the particular test in the
CI I might have been able to answer that myself. ;)

If it's still broken I assume we need a bisection.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke


