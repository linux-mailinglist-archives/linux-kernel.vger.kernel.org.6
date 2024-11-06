Return-Path: <linux-kernel+bounces-397423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3489BDBF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC8E1C22EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D81190472;
	Wed,  6 Nov 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ywwtr1Yr"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE019006F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858968; cv=none; b=VwTs2UZuLP7SMWfQTSvkroj+IN2q6Y2UHiXexY8YzCXVZn1E9y+ylvBoSQPkWvjwHMVJeRqQ+01W+vDXSTvZnGbbG/wNTFrUBPa/ENa9n5J3JBNElaGQ6CbdCunYqvR9dLQaUZZfU8xihlg0O9mCet89GDy9tCBfCP1MP4mfFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858968; c=relaxed/simple;
	bh=qoICrbOY2eN8WqKvK8iQFEjhTz0vF/bERGMi3ZJ3ZBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiTFO4NPrM8/qZLZEJfJSxsnpneTClxqDWYfmoK2GakMDVbm6jyAOPd8ptvVwVa+IUgToUkEAX9jeevFZZgBYT3+BJuuyim5RgIq//IZSi/ATBwHlpRQJeIBP3qznCdMgHN8xaSVcYySsR+eymZ2FATd7BLH47uFMNfjE5S1vYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ywwtr1Yr; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9209f37c-e3e8-4390-9630-0157ed8eb690@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730858964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fk3QSDOqZOzm7LJ9rcdSnlstSgCPdypDTHx34fMzi18=;
	b=Ywwtr1Yr84/JkqcZ67GQ7Zo4xcXVaHPruO6DQ4Q7d4Qic967DC4RMbrejhdGoBATi7dVT7
	U2pCeJBst191n+1KkZ17RxTSPgkuIRumIGfHswIOQmv5Ni66u5iGKwmKkJwcLuDud9Rvn/
	3e1RFm95tWcpSKt7veiKKDHlu3PqU7A=
Date: Wed, 6 Nov 2024 10:09:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH linux-next v8 RESEND] Docs/zh_CN: Translate
 physical_memory.rst to Simplified Chinese
To: Jonathan Corbet <corbet@lwn.net>, xu.xin16@zte.com.cn, alexs@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, he.peilin@zte.com.cn,
 tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn
References: <20241028135321916ZWK032bHhlbncjvmzDkZs@zte.com.cn>
 <87ikt294v6.fsf@trenco.lwn.net>
 <641acef2-70f4-4172-9fa9-da0f5203a78e@linux.dev>
 <871pzp7n5e.fsf@trenco.lwn.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <871pzp7n5e.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/11/5 22:47, Jonathan Corbet 写道:
> Yanteng Si <si.yanteng@linux.dev> writes:
>
>> 在 2024/11/5 03:27, Jonathan Corbet 写道:
>>> OK, I have applied this patch.  A couple of comments for future reference:
>>>
>>> <xu.xin16@zte.com.cn> writes:
>>>
>>>> Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
>>> ...and this I don't understand at all; why do you need to reference that
>>> patch here?
>> We use it to mark the progress of the translation against
>> the original document. If we don't put this tag on at the
>> very beginning, when the translation falls behind the original
>> document for a while, we'll have to go through the whole
>> original document log from the very top downwards, which
>> is an enormous amount of work. On the other hand, the
>> checktransupdate.py also works based on this tag.
>>
>> Yeah, this tag might seem a bit ambiguous. I think maybe
>> we could improve it? For example:
>>
>> Trans_mark commit 7332f9e45d2e ("docs/mm: Physical Memory: Fix grammar")
> "Update to commit xxx" suggests that the current patch is somehow
> changing that commit.  "Update the translation through commit xxxx"
> would be a bit clearer in that regard.  I think it's better to stay with
> something resembling plain language rather than adding a new pseudo-tag
> that outsiders won't understand.
Approve!

Thanks,
Yanteng
>
> Thanks,
>
> jon
>
>


