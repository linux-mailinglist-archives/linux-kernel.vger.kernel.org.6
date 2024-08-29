Return-Path: <linux-kernel+bounces-306383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F2963E39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B48285A35
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663518C028;
	Thu, 29 Aug 2024 08:21:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B88189BAF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919668; cv=none; b=H8wmDtF4Imx+0YD3+bpwwTa5NrtTPci/daMZLegHPyzYK7wopWQohItCPzDHoe5tzyVJndcshhirkU2LzfV788RIa/YZiy6XLaJ6eTOJn0i3nclwt391FRFTm/o2wuwFC62JBr24YdDaKNekOO2/8Ed5oPaNVTFeVA0ew1EK9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919668; c=relaxed/simple;
	bh=wQpaqsmGCnU/TFoZpBi5VCR+n1hl3U0nPDby7/smhoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e4Lm9WXrNdVpaEPp+rKc9bUYnwDygptITwOTE/p85eiHV03TU1fBh+WNk7VqSyBG5pQaq/agn0prgK+Xp2OndXZv3tNgYXVJhOl7LyrJzmqYXMbOak4v0+x3mRBmWSwKWt6tW5XytNzs7xA2bhWHlae1HJSkVNSmEMNBbW3Uans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvYyH3cdxz20n0B;
	Thu, 29 Aug 2024 16:16:07 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id D6C571A016C;
	Thu, 29 Aug 2024 16:20:57 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 16:20:57 +0800
Message-ID: <dfeb5f5f-2b21-4b8f-bb8b-7170ef001773@huawei.com>
Date: Thu, 29 Aug 2024 16:20:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] f1295af16a: ltp.madvise11.fail
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	<linux-kernel@vger.kernel.org>, <ltp@lists.linux.it>
References: <202408291314.bdbfa468-oliver.sang@intel.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202408291314.bdbfa468-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/8/29 16:13, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.madvise11.fail" on:
> 
> commit: f1295af16abee075de68400c58550cffacc29eb1 ("mm: migrate: add isolate_folio_to_list()")


f1295af16abee075de68400c58550cffacc29eb1 tags/next-20240828~164^2~86

on next-20240828, it was fixed in the next patch,

f1295af16abe mm: migrate: add isolate_folio_to_list()
4e3a04695e25 mm-migrate-add-isolate_folio_to_list-fix // this should fix 
the issue.

or please test next-20240829

Thanks.

> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240824
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: btrfs
> 	test: syscalls-01/madvise11
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408291314.bdbfa468-oliver.sang@intel.com
> 

