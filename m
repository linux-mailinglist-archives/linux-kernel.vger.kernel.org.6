Return-Path: <linux-kernel+bounces-516910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C567FA3798F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E7F3AA4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3242A81;
	Mon, 17 Feb 2025 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqktAj5o"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0508BE8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757761; cv=none; b=O3novJKFhkqKOw2gddklGnjbFdYsCXSz8V3YrH/Hpjsn/JkUdBJVI66XeARGF+Qvflw9gcRLEhSXFs9wFlHXz1uPwPkAkEwLDK1ipEMb2Ivoma66Jq4jXvKqX5t4jFCuhJLKQR+5y/1UEyn78mpfMY6SyAZxgt3kbqMVYPXGIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757761; c=relaxed/simple;
	bh=80IHJ4tqXjOk66XEpcwdR4td3Bevk8CSioYG+nODTiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJsT733rQiY/Fq1D0FtDjKB4SBhU1yxZNkNVo2qi1XAKJFJt/c6QYboO8wMSo+Dupzv3l3DjFejWcfPu4Rb2MvxrgOOmnHvkIlubcJLZKG8qJVgf/aqTrzK2E+v9M+6jQUocEpCfQuveCmdwr0iBJA6ap3qn0irQuXNPWjKUNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqktAj5o; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae9f3fe4-65e3-4e37-a480-70d7ceea2ec5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739757755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyawKvYJRUr2n2pt9f6L7mjmwNFrc2ialABTRZgBMJI=;
	b=NqktAj5ocZHCO4buGnhHEizZ6Eq8++z00JpJbk42Bfb8tfWojYOG460DglSHphRQIQk0H2
	Z29Xu56uqA6PTqmLRM6+9ww8DG6F0A6iBA44A7qCOvS5/Bm8bLqlm8gyJMCMNAB5r3xxK0
	0sLG0e0orf0ye7uOx/+Wvx06aDyRoTo=
Date: Mon, 17 Feb 2025 10:02:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: alexs@kernel.org, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250213054222.21776-1-alexs@kernel.org>
 <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev>
 <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/14/25 11:24 AM, Dongliang Mu 写道:
> On Thu, Feb 13, 2025 at 6:24 PM Yanteng Si <si.yanteng@linux.dev> wrote:
>>
>> 在 2/13/25 1:42 PM, alexs@kernel.org 写道:
>>> From: Alex Shi <alexs@kernel.org>
>>>
>>> A good checked summit could save much time for linux-doc maintainer.
>>>
>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>> Cc: Yanteng Si <siyanteng@loongson.cn>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
>>
>>
>>
>>> ---
>>>    Documentation/translations/zh_CN/index.rst | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
>>> index 7574e1673180..cc512ca54172 100644
>>> --- a/Documentation/translations/zh_CN/index.rst
>>> +++ b/Documentation/translations/zh_CN/index.rst
>>> @@ -26,7 +26,13 @@
>>>    顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
>>>    的字符标点占用两个英文字符宽度，所以，当英文要求不要超过每行100个字符时，
>>>    中文就不要超过50个字符。另外，也要注意'-'，'='等符号与相关标题的对齐。在将
>>> -补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试。
>>> +补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试，确保
>>> +在 ``make htmldocs/pdfdocs`` 中不增加新的告警，最后，安装检查你生成的
>>> +html/pdf 文件，确认它们看起来是正常的。
>>> +
>>> +提交之前请确认你的补丁可以正常提交到中文文档维护库:
>>> +https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git/
>>> +如果你的补丁依赖于其他人的补丁, 可以与其他人商量后由某一个人合并提交。
>> I think this requires a detailed tutorial. Otherwise, it
>>
>> will increase the difficulty for beginners to get started.
>>
>> How about removing it for now? I have a plan to write
>>
>> a translation guidebook. What's your opinion?
> Good idea. I can help contribute. Our Translation Team has a simple
> one to guide team members in kernel document translation.

Good jobs, This is very helpful to me.


In fact, I already had a draft before New Year's Day.

The reason I didn't submit it was because, in practice,

I found many deficiencies. I'll try to submit it later this week.


Thanks,

Yanteng


