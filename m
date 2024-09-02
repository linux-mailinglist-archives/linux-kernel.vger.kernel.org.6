Return-Path: <linux-kernel+bounces-310617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55474967F24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B23C284590
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683C154C0B;
	Mon,  2 Sep 2024 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="riiPFqN0"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079814A4C5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257239; cv=none; b=jKpw6KlAr7uAkzgtrDTvM/LxpP5TMk9kvpNMO4Xqzr/gj3Sg48XsugKaWhnPzHB4shITAYHgKs445okcugkogHrUTGVD7FRnK/Omdg6KNWazjpr4rb/3boR4lSqYk/lrVrbz+W2BXmTzi5OaalKb45T0q7eM601TbQRfvL4TGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257239; c=relaxed/simple;
	bh=1SwXqyiCVRRoQN3UEPdxtZ2vW+ZevbVmTnYXJftwoiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7Crics037jSwwPC4A+Y0c0K9lLsmQKImuTUZwmfwWTpXEWjAbzj9zHCUh20THhbQNm1E5yCdV/Kofe0dIHrFgMZTjywJEFqtH+BTXsLsF5vHl3c6A2hkf3xZ4VueCf/SXnLOiuyWvZOOFOuRyM71X2YVQdbOl2x3k1Hc5Sa+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=riiPFqN0; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a474e6f-1731-482a-9399-07462ee6f1b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725257233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsSx3C7X9XYoiDqaXLDPgsJHFaoXA/O/tT3/TbjYLTw=;
	b=riiPFqN0qgN0BvMm0ieBWbS88HsU31Nthin/PejmnW1bLkxaIWalG1L5Uo5UU6SpQbNeqa
	ZkIrl0YqwbqZj4kPH0GCmJGyKCRHuhzRl9fcBErJ+bFp6nSGR0Sny3sQfrSdff/xNYj75h
	9yNjGeEXZIBvbWfu8xoQBSpycE8s6eg=
Date: Mon, 2 Sep 2024 14:07:00 +0800
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
 <65f5467a-5c31-4d35-b0a4-e163429e98c9@linux.dev>
 <129f741e-ab25-4954-8d30-39746dea2d3e@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: YanTeng Si <si.yanteng@linux.dev>
In-Reply-To: <129f741e-ab25-4954-8d30-39746dea2d3e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Akira,


在 2024/9/2 11:21, Akira Yokosawa 写道:
> On Mon, 2 Sep 2024 09:32:08 +0800, YanTeng Si wrote:
> ...
>> 在 2024/9/1 14:03, Akira Yokosawa 写道:
>>> Hi,
>>>
>>> I'm not Alex, but let me chime in.
>>>
>>> On Sat, 31 Aug 2024 17:34:11 +0800, Dongliang Mu wrote:
>>>> On 2024/8/31 12:11, Alex Shi wrote:
>>>>> On 8/31/24 11:48 AM, Dongliang Mu wrote:
>>>>>> +目的
>>>>>> +=======
>>>>>> +
>>>>> there are still a lots of sign incorrect. Please be sure everything looks fine in a web browser after you 'make htmldocs'
>>>> What do you mean by "sign incorrect"? I check the html rendering in the
>>>> vscode. It seems fine to me.
>>> You are right.  There is nothing wrong as far as the reST specification
>>> is concerned.
>>>
>>> Quote from https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#sections
>>> (emphasis by me):
>>>
>>>       An underline/overline is a single repeated punctuation character that
>>>       begins in column 1 and forms a line extending *at least* as far as the
>>>       right edge of the title text.
>> Yes, I guess we should also think about the reading experience
>> of readers who use vim to read kernel documentation.
>>
>> Because Chinese characters are already very neat, sentences
>> and paragraphs should also be neat, otherwise the reading
>> experience will be poor.
>>
>> Let's take a look at some examples: (copy to vim)
>>
>> 整齐
>> ====
>> 整齐
>> ====
>> 整齐
>> ====
>> Great!
>>
>>
>> And
>>
>>
>> 不整齐
>> ============
>> 不整齐
>> =========
>> 不整齐
>> ================
>> I think this is a bit difficult to read. What do you think?
>>
> So you are talking about your personal preference, not about what is
> technically correct or wrong.
In a sense, yes.
> And you are exaggerating by collecting them in one place.
>
> If they appeared springily as title adornments, they would not bother
> me at all.
Sorry, my example is not good enough.


>
> At times, especially with a very short title, I'd like to have a way
> longer adornment line to make it stand out such as:
>
>    整齐
>    ------------
Okay, I'm not a stubborn person, I just care about the feelings of most 
people.

If you open any document, you will find that the author is trying to keep
everything as neat as possible.

let's vim kbuild/gcc-plugins.rst

---

=========================
GCC plugin infrastructure
=========================


Introduction
============

GCC plugins are loadable modules that provide extra features to the
compiler [1]_. They are useful for runtime instrumentation and static 
analysis.
We can analyse, change and add further code during compilation via
callbacks [2]_, GIMPLE [3]_, IPA [4]_ and RTL passes [5]_.

...


Purpose
=======

GCC plugins are designed to provide a place to experiment with potential
compiler features that are neither in GCC nor Clang upstream. Once
their utility is proven, the goal is to upstream the feature into GCC
(and Clang), and then to finally remove them from the kernel once the
feature is available in all supported versions of GCC.

...

After a feature is available in upstream GCC, the plugin will be made
unbuildable for the corresponding GCC version (and later). Once all
kernel-supported versions of GCC provide the feature, the plugin will
be removed from the kernel.


Files
=====

**$(src)/scripts/gcc-plugins**

....
     These headers automatically generate the registration structures for
     GIMPLE, SIMPLE_IPA, IPA and RTL passes.
     They should be preferred to creating the structures by hand.


Usage
=====

You must install the gcc plugin headers for your gcc version,
e.g., on Ubuntu for gcc-10::

.....

or just run the kernel make and compile the whole kernel with
the cyclomatic complexity GCC plugin.


4. How to add a new GCC plugin
==============================

The GCC plugins are in scripts/gcc-plugins/. You need to put plugin 
source files
right under scripts/gcc-plugins/. Creating subdirectories is not supported.
It must be added to scripts/gcc-plugins/Makefile, 
scripts/Makefile.gcc-plugins
and a relevant Kconfig file.

---

We can see that all the underline are aligned with the title,  Even each 
row is
as long as possible. I think most readers are also accustomed to alignment.


In addition, we are only translating from English to Chinese, and the
translation should be as consistent as possible with the original
document to facilitate readers/developers to compare the original
document. Because our translations may not be accurate and updates
may not be timely, keeping them consistent with English will make
everything simpler.
>
> Of course I don't have a say on personal preferences and I think
> maybe I was stupid making a *technical* comment here in the first
> place. :-/
Don't say that, your comment makes this matter clearer and greatly
reduces the difficulty of discussion. I understand your feelings very
well, as I replied to your first comment by saying 'yes', and then I
elaborated on my point of view, although not entirely perfect.


Thanks,
Yanteng
>
>          Akira.
>
>>
>> Thanks,
>> Yanteng
>>> HTH, Akira
>>>
>>>> Dongliang Mu


