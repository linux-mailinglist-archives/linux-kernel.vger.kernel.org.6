Return-Path: <linux-kernel+bounces-367135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A090599FEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6A81F22032
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65C161326;
	Wed, 16 Oct 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C4cMOhWo"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D01531CC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046613; cv=none; b=roDM+jqymNSPblhMBwPzs1eGTcALI7AsTqgo73LBgbNo8QGv1/opiKg/O+sFWU5ASI6B0uSYsWL8PNtyNfRfbstWjFG7x12MLHpoUJWHapm3zLE+wKgDpWwfIZYG0Ic2XmEdXbvKVHpZM1o08lzx7HUzbCdO3cqBcHHtM4WrzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046613; c=relaxed/simple;
	bh=5quQ9Z0Z7oHrCaae6DYZXYqEEC6z7KWjNFlHX9O+WfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otD8xYnb5sC3TTfFW3qCXXz2xG+RMMHqB8LKjdcAEj6uZIGXvPdV4eKhkyiXErcJQ10QZTwctH3uAvildkDnekc5SQOs5fxjHcOnZezQHPkPY+Ovb+BYcgiC//0Mp/yBMmvJY+OdmXblYzKrkZMKljVIJJWS0vs1C8vFPt541kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C4cMOhWo; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5f64d14a-4de3-4abe-a0be-9288c2594cdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729046608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSaXD5yyprV6bSzARBG4h8KizvJMBQBv9KzMrwwDgvs=;
	b=C4cMOhWoqx+tyJFg5CUAMnEbOvgh3AuGWQIgG/g34fXpfURtu5nB9aiav7goxR4KT6nEEz
	n37G6spoazyKYON98bIYAtrf+gvABTzWldLm8gViQUv0KZkrXynZHbhPef6VnJ0FachHNN
	swnN7gmeRfw6445WEVYZGRJ7rVcmorY=
Date: Wed, 16 Oct 2024 10:43:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/3] Docs/zh_CN: Translate page_tables.rst to
 Simplified Chinese
To: Pengyu Zhang <zpenya1314@gmail.com>, alexs@kernel.org,
 siyanteng@loongson.cn, corbet@lwn.net, seakeel@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yaxin_wang_uestc@163.com, zenghui.yu@linux.dev
References: <20241015154301.4736-1-zpenya1314@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20241015154301.4736-1-zpenya1314@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/15 23:43, Pengyu Zhang 写道:
> Hi Yanteng
>
>>> +随着内存容量的增加，久而久之层级结构逐渐加深。Linux 最初使用 4KB 页面和一个名为
>>> +`swapper_pg_dir` 的页表，该页表拥有 1024 个条目(entries)，覆盖 4MB 的内存，
>>> +事实上Torvald 的第一台计算机正好就有 4MB 物理内存。条目在这张表中被称为 *PTE*:s
>>> +- 页表条目(page table entries)。
>> page table entries -> 页表项。 So:
>> 每一个页表项在这张表中被称为 *PTE*:s
>>
>>> +
>>> +软件页表层级结构反映了页表硬件已经变得分层化的事实，而这种分层化的目的是为了节省
>>> +页表内存并加快地址映射速度。
>>> +
>>> +当然，人们可以想象一张拥有大量条目的单一线性的页表将整个内存分为一个个页。而且，
>> Hmm， let's exec %s/条目/页表项 in vim.
> This translation is indeed the most confusing part for me. When 'entry' appears
> on its own, I previously tended to translate it as '表项'.  However, I noticed
> that other Chinese documents have used '条目', so I reused their translation.
> In our context, though, I believe 'page table entries' and 'entry' are better
> translated as'页表项' and '表项' respectively.
Many things are chaotic in their early stages, and Chinese translations 
are no exception. However,
we are working to change this situation, for example:
Documentation/translations/zh_CN/glossary.rst
> How about exec s/页表条目/页表项 and s/条目/表项.
I think that's OK; if you don't mind, you can go ahead and add it to the 
glossary.

Thank，
Yanteng

>
> Thanks,
> Pengyu


