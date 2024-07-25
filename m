Return-Path: <linux-kernel+bounces-262664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B893CA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2511C21FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F61422BD;
	Thu, 25 Jul 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NuImNiXe"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6F101F2;
	Thu, 25 Jul 2024 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943088; cv=none; b=fBiY4wOEFskG1H8VS79fLdJT3OIxjEMQ8xCFNJ10tV8mvjTV2KaBCmXnDmqFbu8ToDTtq/6XAacfPVj7twU3kVvNLGrsqaN2V5VFrqSsSVMnwwVp0NZnbajm1EVzpwhfQUrij2UVCj1NWL32uKNC+IzR8S8YXFd9pAid9GUs7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943088; c=relaxed/simple;
	bh=w1lbfo3Va5AWZ2hW/XGSHONgZEMwhfxCnYvF9DKJyRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNSp2QHi31Xxs4Nl+lV3pWm0q6Ozf8Zn4ETi86qNn5I/cr8NEgCqqw5eA9nFQ9suHjqWH130P49YXRdOOdwTtVsN2rBVf9VpfHLi8lyANp+fv6GXKm/mpGHemiIJjBr5prpu6lvEmEUz8Oygn2BB+z1SKtzZOUh4M9aecRyNPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NuImNiXe; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id X62Hs4pAoHEYLX62HsWoKU; Thu, 25 Jul 2024 23:30:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721943007;
	bh=Kgx1QNLMEsxTr+xL+tHBsE9DV94GgKFmh+JvzmoBtiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NuImNiXeFmlbW5MWCf2hdeT1xR6EFL3kzwiJEGpJwSBsyG9jc/wypHvsZP3NxGVW7
	 gkU1yUNqc9YGiQTy/kG1FSnRZgZXlbpllf4AIlYh7U6MflBosKg1iaRltw1m6pA6gD
	 qSvcjuS6hY4UIY9kNmDIc135hpH1nGITtZP9qM+hA76oHBKQ6z3rvFnw0orkAvDlff
	 PTZvUl5u97rLxUgFgi+gHQfwsyrVmSFTwlQb4yL/0tr1Oz/PAP6xcmb74ZQ4IqaCnv
	 ECbFa/cva4FRRLuEnZ4BgwJeNScBnBDIsC6hvbayAwo8u1AO5yxxXZQsHj1d2Z2QVc
	 EmWGstyrQYnbw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 25 Jul 2024 23:30:07 +0200
X-ME-IP: 90.11.132.44
Message-ID: <84808a6b-5a92-4679-833f-10e5a29f4cce@wanadoo.fr>
Date: Thu, 25 Jul 2024 23:30:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a double put in
 amd_pmf_remove()
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Patil Rajesh Reddy <Patil.Reddy@amd.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <72a97f7989f56c50e1ca417633fe703593d49189.1721941953.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <72a97f7989f56c50e1ca417633fe703593d49189.1721941953.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/07/2024 à 23:13, Christophe JAILLET a écrit :
> The 'input_dev' is a managed resource allocated with
> devm_input_allocate_device(), so there is no need to call
> input_unregister_device() explicitly. It will be called automatically
> when the driver is removed.
> 
> Fixes: 4c92d448e3e6 ("platform/x86/amd/pmf: Use existing input event codes to update system states")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only
> 
> I'm not 100% confident with this change. The error handling scheme is not
> a clear to me as what I usually see. For example, the last calls from
> amd_pmf_probe() don't handle error at all. So the probe just succeeds in
> these cases.
> 
> So, because of it, it is maybe fine to call input_unregister_device() in
> amd_pmf_deinit_smart_pc(), even if it looks strange to me.
> 
> Review with care!

NACK.

Things have been explained to me in another similar patch proposal.

Sorry for the noise.

CJ


> ---
>   drivers/platform/x86/amd/pmf/tee-if.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index e246367aacee..cc721fbc3e0b 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -515,9 +515,6 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>   
>   void amd_pmf_deinit_smart_pc(struct amd_pmf_dev *dev)
>   {
> -	if (dev->pmf_idev)
> -		input_unregister_device(dev->pmf_idev);
> -
>   	if (pb_side_load && dev->esbin)
>   		amd_pmf_remove_pb(dev);
>   


