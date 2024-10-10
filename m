Return-Path: <linux-kernel+bounces-358582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD7299811B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41F3284D30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B451BF336;
	Thu, 10 Oct 2024 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c52M554W"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BB19D8BB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550445; cv=none; b=B/JnwC7nWP39mATRbdcrX9Hll5/6z9xjwtoQiH7EcXUa9NiHe/a3ydxMifezY/iYi4GZN7D8hXeIwBVbMsdcvbSe0kMOsrZ2ARi2rTLFGvfUgZWAZ0vLOWNn+MMCSAa5BbBqqwLH/65rOHSAhzH5FAYI5qXNlIUr6EZcHwolVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550445; c=relaxed/simple;
	bh=t/nYnsopstvIy22BbL/ndmU8/Va7L7PXQblhnksgHfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzeoVA+OmfZcR/xoS0YUoeeUn8vxYU+7s4Yf5kT3ThJf6bimZVm4wzcNSQHqE8D93c3lND7hjtHtERt10prC9sUQCvogUh3nsY4kvfMw5xbmUEsg3HhU/jnodtoBwtxXZXWNW3x/DjVZVeeknVvvc/lHr2AY94fHQW4x0dSt1fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c52M554W; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728550440; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ca62slCO8FsSYSilwJ414+sJXuEBrQt2YouWTe1gVSg=;
	b=c52M554W4IPu5hdxhUkavN1E5kivU2zlnKG0E6MCNBBQjDjxHjF5PmufX5wG7Yi6nFvTVMVkUOh3VfcE8wgjBfkeV5NAucmmNHBRVA5eYraXhSQta7GNGjpzyDsTm4QRqiJaK2auTrN1B9Iz5QZzIPL4Z6VnTpRKpjvt0oxbaXs=
Received: from 30.74.144.160(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGlqylg_1728550437 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 16:53:58 +0800
Message-ID: <c5a86a1f-5486-45d9-944f-28c4f9daab93@linux.alibaba.com>
Date: Thu, 10 Oct 2024 16:53:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, hughd@google.com,
 shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 chrisl@kernel.org, david@redhat.com, kasong@tencent.com,
 willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org,
 chengming.zhou@linux.dev, v-songbaohua@oppo.com, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20241002012042.2753174-1-nphamcs@gmail.com>
 <CAKEwX=Of2U7x+KHikU5p94=qL5VeO_JfysEWKz+=VR3jyq0B5Q@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAKEwX=Of2U7x+KHikU5p94=qL5VeO_JfysEWKz+=VR3jyq0B5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/2 09:22, Nhat Pham wrote:
> On Tue, Oct 1, 2024 at 6:20 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> Changelog:
>> v2:
>>          * Fix a WARN in the shmem THP swap path. Thanks Baolin, Yosry, and Barry
>>          for the report and the discussion on how to solve it.
> 
> Hi Baolin, could you run your stress program again on this version?
> FWIW, I was able to trigger 64kb mTHP swap in shmem + no-fallback
> swapout, so I think the issue is fixed.

I tested it on my platform, and no issues were found. So

Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

