Return-Path: <linux-kernel+bounces-395355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A759BBCC2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD61AB22304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628351C9ED1;
	Mon,  4 Nov 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="i8Zom4zp"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD991BFE06;
	Mon,  4 Nov 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743350; cv=none; b=MaawaJxY54Ba+rgp9e59i5PvZhsPe9KgcOlznyHC+WQr97bPSBCDVnOit9Gpq9wyiNE2GOxYSkdtvgiTnAxUai14XiZfuhureEKDaJIMXZXjfPYauUkNjQ9MeNXZAJbdqNph+CZ8aJJ77s8FxdWv3ETfX7G36EDXVOFkyZI2yz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743350; c=relaxed/simple;
	bh=58l9uQUc8et8TAqnTa2SbuAJRgLBacV8FDAdaRmp10E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rz7BhtZg9KJdhUI65Qbs85JHcAvJTYFDb0pIG7Yby5xKSDXqRlTzAUd/DB5+6QzPefN1k/31/xjJ27oy/S58/eWttUMxgu1+7Lx/HxovOXBo4uXBM9mRpCrkiV6edp70ShZ9yiNXDpuEJbx1UEMK/TuTe8AKWGyPhONejjbGf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=i8Zom4zp; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 81G3txN94lUew81G3tdlTw; Mon, 04 Nov 2024 18:52:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730742778;
	bh=7a6wZTAgFjyZIQRwbpzpwrJO+mZ8x5NXtG/M2aOltuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=i8Zom4zprEcgc7rXp/7A+2Gyn0tqLqyGKXS2VlQR3kkBazvYzhkgZ8pu3Fni5G0RI
	 8cPWJtRZFZdloyd3LwvCMg0vXOtGmHwRuRLsYPuJb9iYFAMq9B1ypnMpTLnQkSpzT0
	 pUTCfTkMTlSEsxkKh0/RUh3Xacer1Ma+VIP575EDx9MIJkPZ52CSsKYyZClZro+CUE
	 3H9QEybVWX5QU6FmRYi8AXnfr5AXYl4LpZBDNjZy7MNaaOTA8alh972b8qoYKFcO7S
	 FRjGI3A+kbMgZWlOcxdwqgFvrm8zPm/T1FyIumv9pJAJ6Ro/K0sgFFyLOBUk8Lvmro
	 wytD53pp5YHrg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 04 Nov 2024 18:52:58 +0100
X-ME-IP: 90.11.132.44
Message-ID: <32c796a7-7598-46d4-af78-00fcb47990f6@wanadoo.fr>
Date: Mon, 4 Nov 2024 18:52:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/fpsimd: Fix a typo
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <2cbcb42615e9265bccc9b746465d7998382e605d.1730539907.git.christophe.jaillet@wanadoo.fr>
 <173074012615.2444105.10660252555826650982.b4-ty@arm.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <173074012615.2444105.10660252555826650982.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/11/2024 à 18:10, Catalin Marinas a écrit :
> On Sat, 02 Nov 2024 10:31:54 +0100, Christophe JAILLET wrote:
>> s/FPSMID/FPSIMD/
>> M and I inversted. Fix it
>>
>>
> 
> Applied to arm64 (for-next/misc), thanks! I also fixed the typo in the
> commit log.
> 
> [1/1] arm64/fpsimd: Fix a typo
>        https://git.kernel.org/arm64/c/525fd6a1b34e
> 

Strange, checkpatch does not complain. I was sure it was running a spell 
checker.

After checking, it is run, but does not spot it :(.


Thanks for fixing.

CJ

