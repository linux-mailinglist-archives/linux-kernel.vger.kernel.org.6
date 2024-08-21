Return-Path: <linux-kernel+bounces-295316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A60F95999B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8061F2219E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12751CF29A;
	Wed, 21 Aug 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qYyl0iJ7"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52141B2EC8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234969; cv=none; b=Hk00hP8sLWZr3qc9372zAIz7+8CspoJQqxV8syowdD3++ve+9MA09bAnURobIlFyaEt0jJz3s1t81B6sCaa5OR7nPV3NPeEtwQHcl9/nz6LtB9d0PkIpFN5V9YbwidHHZ+5PI5OrqD4oa5slbx2XJs/nOZOyML81NbcKcum7Obo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234969; c=relaxed/simple;
	bh=s7+jho+CREfQFPM0TTipEiHTFn41NdXXOtzVkH2yPIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZddCL+f3qfhZnB+1Qoia6zgDh0B7JsXJWs65Ebyqe8DyVsvp27aYEGO3wp8DHGaN1SePjN7K5WJLSdpgUXQzqxcS1OD3bRlNBJqmeLocgOHEnqdjjTK7xihqxhisZEpT8TbFj59ZyFQSReXcq2p90H8rSAMSqu805WcU5e+C7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qYyl0iJ7; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id giHJseKCWS3tRgiHJsKjup; Wed, 21 Aug 2024 12:09:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724234965;
	bh=zfrpLHC5O0ar80k3u2i0ovH9Bw792zRYPSpC/5PntTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qYyl0iJ7aDFoErA7BsUr1IG8H2Map4hxyG8di9IrEvOOUcwXMSF8g5nsAQmqoHzti
	 TxqpLzmGWhWZ8HfY3eFtNwraSuVBczFc+elL+ro1pXj0qSPlnt2BccHsPp5OnuefPy
	 NoPsn30ZQST7ZhsIDvHKniN1hIJUEt/P8D3RPgaUuIiyWNV48cfRjIDpnjIYPRUgJ3
	 1jMi0WaPpQICac/3zjtCQKIeplv1CQjeNhqe4pzYvfGcCbPvUGaiSExFBIzv4TBPiv
	 EmdKi0M6Gxnjd2x21lJV7qlP2oV+wrPlxHnswcHxl4ge/Owj7W+uMz8XlHQjnhCE8Y
	 Md0T2wgHpfp3w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 12:09:25 +0200
X-ME-IP: 90.11.132.44
Message-ID: <75478278-1f18-4865-9dbf-c929417e1637@wanadoo.fr>
Date: Wed, 21 Aug 2024 12:09:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: sprd: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240821013901.787555-1-link@vivo.com>
 <8f577565-69b7-4da0-a7fe-2e94bf37948c@wanadoo.fr>
 <b8e9e59c-6486-478a-bd25-ee13cbcc46cc@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b8e9e59c-6486-478a-bd25-ee13cbcc46cc@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 09:08, Huan Yang a écrit :
> 
> 在 2024/8/21 15:00, Christophe JAILLET 写道:
>> Le 21/08/2024 à 03:39, Huan Yang a écrit :
>>> The devm_clk_get_enabled() helpers:
>>>       - call devm_clk_get()
>>>       - call clk_prepare_enable() and register what is needed in 
>>> order to
>>>        call clk_disable_unprepare() when needed, as a managed resource.
>>>
>>> This simplifies the code and avoids the calls to 
>>> clk_disable_unprepare().
>>>
>>> Due to clk only used in probe, not in suspend\resume, this pointer can
>>> remove from sprd_mbox_priv to save a little memory.
>>>
>>> Signed-off-by: Huan Yang <link@vivo.com>
>>> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>>
>> Nitpick: no need to add this S-b. I just made a comment when looking 
>> at your patch in order to improve it. I'm not the one that suggested 
>> the initial change. All merit is yours.
> Your suggestion is helpfull, help this patch be better.
>>
>> Also, I think that, if used, it should be above your Signed-off.
> Hmmm, it's neccessary? If so, I'd like to update it.

I don't think it is useful and personally I would remove it, but you can 
keep it if it makes sense to you.

CJ


