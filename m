Return-Path: <linux-kernel+bounces-365049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7EA99DCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BE51F23D26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9C170828;
	Tue, 15 Oct 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TE8e37kB"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132B4D8AD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962969; cv=none; b=TuVoUyTJ5Ghlh4eWuo0Fp4wU0Lcdkw9FqIwF3XAGEAijno+653yT+9EnT34yLPKAhFzkzsCFTzRkr4yrRRnw2DlxuopAE5Rc8ut+AaV4K9CGkABHcLA8jJm6znvMdgSUijm/x2Mh7vr1IF84HLzvHbNYW6GeJCAxEmyjXR0/kBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962969; c=relaxed/simple;
	bh=VJC4VzBx1aILUuz/lqnmlJkmGMl6HwJ2I5ieCb1Ii7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RylcZxQAG+Xaf8I8HLZ8wlfy1vksJR7d8RxaNo227Ofn7+cHcCwl/C68ZbVh50mXztz8UCNlbK8UIQbjaL1qaTDYaaoDss37Rn80PiMJ2+hUkOFf6Prh/XGUi30ogio3bCMMoYSv9qZcp45CXz7RCz4VczZNTmSFwYO1Dliy5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TE8e37kB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22fde7ff-457b-4b69-b548-69cff915569d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728962964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxbHd8WjPhjH1XD16k4hT12HJ0eL0UwvEDh9WdChaEg=;
	b=TE8e37kBjTdN0tNaBOSXvGqs1qP82Vt3586AfdNr2xECshRxDVWWMMww5coxhDcVWe+Pnu
	6tud6WhxVZV/whxypBakVPekvVlXY1D+v73lihgufQqrNCRGwGJSWAL86DP+yDhCWbcr0j
	I5GsnYjSWbD+/f97zNty54fT7pShvB0=
Date: Tue, 15 Oct 2024 11:29:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <seakeel@gmail.com>,
 jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
References: <20241012171357153parWX6Has5WheQyGlP0kP@zte.com.cn>
 <ecdc7672-965a-4bc5-8e0a-a407de82407f@gmail.com>
 <87ed4isd7b.fsf@trenco.lwn.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <87ed4isd7b.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/15 03:21, Jonathan Corbet 写道:
> Alex Shi <seakeel@gmail.com> writes:
>
>> Hi Jiang,
>>
>> Your patch format is still odd in 'Subject':
>> Subject: =?UTF-8?B?wqBbUEFUQ0ggdjVdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBwaHlzaWNhbF9tZW1vcnkucnN0IHRvIFNpbXBsaWZpZWTCoENoaW5lc2U=?=
>> Content-Type: text/plain;
>>          charset="UTF-8"
>> X-MAIL:mse-fl2.zte.com.cn 49C9DsLB077233
>> X-Fangmail-Anti-Spam-Filtered: true
>> X-Fangmail-MID-QID: 670A3DD9.001/4XQd8n4BCPz5B1DK
>>
>> It should a English word.
>> You need to send patch to yourself and apply it to check if
>> everything all right.
> I think the formatting is OK - the patch applies fine here.  I would
> appreciate a review of the actual content, though...:)
<https://lore.kernel.org/linux-doc/1add7be9-0da0-4463-a3ea-80e2fd99bd19@gmail.com/>
 From the very beginning, we have reviewed the content. Moving forward,
we will continue with the review process, but we would really appreciate
receiving feedback from the translator, even if it's just a simple "OK".

Alex, I believe we need to draft a Chinese translation guide, in order to
minimize the review work that is unrelated to the content itself.

Thanks,
Yanteng

>
> Thanks,
>
> jon
>


