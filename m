Return-Path: <linux-kernel+bounces-354897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDED99444F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB697B20FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ADB16DEB4;
	Tue,  8 Oct 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pDK/3D3+"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBC18308A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379663; cv=none; b=lBNLRQCDeWkFtc5VjmEID3PxcfbcmDEQqz5qy+j5EzQ3pt0QTN285rkzIZFHBZr3/RWR9orrmTsh9Bki4cxt/JPyukQpD3MRYDY0Vy2O5d7gizi68EZM66zh4FQ//ii7+SRLXFEmD5UlByS3p276lN7EnXRJXkozf7ncJ8Zh1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379663; c=relaxed/simple;
	bh=p10plJuEgBRn43/1IjluTWXxPZ06jKc1KbMaZObFujY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VifWNPlDtDBaRDYaKMI8RfF6U38aIBJRMfmvYAAmnIZL02VvTQE7tVyNnJRuZkYOzRpMljoWi53igFiGIUzJk5nov4Q/h2sIzsZngm+wDkE7BG+i1/chaCHw5dIOP/FiixI0L0oElyEf57/R2T1wg/mWGvkua2HjW6tcXaN+9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pDK/3D3+; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728379657; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/V1bqGfYBWKphm35NQNKbsjHmj8s5sbkZdapKnJs62g=;
	b=pDK/3D3+uzTQvzeX05zFAx8upItPUwMi2BC4l/H0G2BWn4TaemzpXcnNGd1GUWr7LuCcLKEHoMKCAx7fFwbdebBsZWsYzUpw6LhdGgMCnCAMVKysVWoI87zy4J8t1GbMw+b6abWRxsT2C/Onv8s6orFo+6d0FyIpVPk2fiiq8g0=
Received: from 30.74.144.159(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGd6wgf_1728379655)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 17:27:36 +0800
Message-ID: <e1ea6387-eb9e-46b4-a5a8-3f40ad63988e@linux.alibaba.com>
Date: Tue, 8 Oct 2024 17:27:35 +0800
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

Sure. I'm just back from vacation, and will find some time this week to 
test it.

