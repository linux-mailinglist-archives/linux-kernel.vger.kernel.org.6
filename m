Return-Path: <linux-kernel+bounces-310461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A55A967D63
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD91C213F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835118C0C;
	Mon,  2 Sep 2024 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hh1bdTrk"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7781946F;
	Mon,  2 Sep 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240745; cv=none; b=r41q679gITGsi341PBvKsdKrDv83aOrGAGjVX1t9zb1g/qMaGejAYi9zvKSRvQnd5/Sfdrqb257S2hKHYSQV0CTtfoHd4jZKxrStuBKVd2unjNN6eyMhqY+WCMYamX9aNynFm+SE2eaQjjIgC4B/bnnl5U/cxTeoqHwz+Y2NK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240745; c=relaxed/simple;
	bh=Gkw5/N0HtbyIWijLA7K4vIhfekiMhOEM/MlSdykpWU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sz1L3fb2kuEpt1a+a0RydgTZ9y8w/In4EAHFKIkHRwk3HXTWdnCihUQzL4+E3dGhPXD6iTW74TUcxGZTUq14DD3RQIEhLCMjlN87mVHEurKKae46fDtDce7ZAdYpzFPTJ02AD5Jx7qpP0iMJHFjn2H63YtVyGxIHL2DJJjd2jOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hh1bdTrk; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65f5467a-5c31-4d35-b0a4-e163429e98c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725240739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPqIE5RNTs1s0Odq078y70W4Md4LQBU8xZumnRmNTUY=;
	b=hh1bdTrkZl2TUGkHupsFWuKftY98ndV9gP4qsCpQ42AbdI60Sk8Lw4hZ9sdT9TeaIeN1as
	1lR9P+EXYQuqnB54jaoxjA/BRdMDGSepiVcIUhsB5la1XH0b8hY+8Z4+8Osh+e7EHlnNke
	6mn+FwYLLXux7Ya/tGn8Ak6RW9Ww5Ig=
Date: Mon, 2 Sep 2024 09:32:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
To: Akira Yokosawa <akiyks@gmail.com>, dzm91@hust.edu.cn, seakeel@gmail.com
Cc: corbet@lwn.net, hust-os-kernel-patches@googlegroups.com,
 justinstitt@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com,
 nathan@kernel.org, ndesaulniers@google.com, siyanteng@loongson.cn,
 alexs@kernel.org
References: <35904aa5-9851-4894-b953-689904bf33ca@hust.edu.cn>
 <58b7c7d2-f60c-4a2d-9cb5-d583182bfef4@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: YanTeng Si <si.yanteng@linux.dev>
In-Reply-To: <58b7c7d2-f60c-4a2d-9cb5-d583182bfef4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/9/1 14:03, Akira Yokosawa 写道:
> Hi,
>
> I'm not Alex, but let me chime in.
>
> On Sat, 31 Aug 2024 17:34:11 +0800, Dongliang Mu wrote:
>> On 2024/8/31 12:11, Alex Shi wrote:
>>> On 8/31/24 11:48 AM, Dongliang Mu wrote:
>>>> +目的
>>>> +=======
>>>> +
>>> there are still a lots of sign incorrect. Please be sure everything looks fine in a web browser after you 'make htmldocs'
>> What do you mean by "sign incorrect"? I check the html rendering in the
>> vscode. It seems fine to me.
> You are right.  There is nothing wrong as far as the reST specification
> is concerned.
>
> Quote from https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#sections
> (emphasis by me):
>
>      An underline/overline is a single repeated punctuation character that
>      begins in column 1 and forms a line extending *at least* as far as the
>      right edge of the title text.
Yes, I guess we should also think about the reading experience
of readers who use vim to read kernel documentation.

Because Chinese characters are already very neat, sentences
and paragraphs should also be neat, otherwise the reading
experience will be poor.

Let's take a look at some examples: (copy to vim)

整齐
====
整齐
====
整齐
====
Great!


And


不整齐
============
不整齐
=========
不整齐
================
I think this is a bit difficult to read. What do you think?



Thanks,
Yanteng
> HTH, Akira
>
>> Dongliang Mu
>


