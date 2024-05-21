Return-Path: <linux-kernel+bounces-185181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF68CB1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577441C21D25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D927C085;
	Tue, 21 May 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b="gCjKyA6y";
	dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b="l20fF07k"
Received: from mx.bitactive.com (mx.bitactive.com [178.32.63.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE81C6AE
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.63.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306466; cv=none; b=IHCEFVONZMJUhe0B3eHN3lwLOqH0kS8kk87ANJJL8y+qkSxdxXL0vM18fGol/dDhekw1nGNvHh+op6DhfpqV6LPuXnlQFa6fxGmMxkp0zDkUdSgo9X/ANv3YudU/RXHoX0i1TQG5nqumNwEOACAhbvP5ViHDIALk8YYbK01SNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306466; c=relaxed/simple;
	bh=ET6AvymuhslWwRcEmBvCeaxWjr2PKY2wEpGzhu+nO7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type; b=Se/50GyASpSuqLK654YnxR9rc9HswhiBzpZZBtldHWyy0F4mQBXwJ8GgDlVyYzUewjc0q3sNhs3m+SsKbj4EzCL2lE5TSmBGSMDOKKYxP3yyTo07CfVP2M44SwfHSjXdlBSlI/0PrnpTtX3U76cmNnl77T5EC5tednh4taCObGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcinwanat.pl; spf=pass smtp.mailfrom=marcinwanat.pl; dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b=gCjKyA6y; dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b=l20fF07k; arc=none smtp.client-ip=178.32.63.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcinwanat.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcinwanat.pl
Received: by mx.bitactive.com (Postfix, from userid 1044)
	id 4VkJjT6mWnz7mgb; Tue, 21 May 2024 17:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcinwanat.pl;
	s=s2048; t=1716306461;
	bh=8Q3D0/0B+f2wkHTGW5lf37HesfsMZnmiKoIexwp+hH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gCjKyA6yjEmDhohhSoM00rWoeb9zDFhO/q2BHhr+Dr9vau6Ql2INVw58h69IQnM3p
	 9Lz+c2eYVyAJFTZvUgEy63ukm84zZ9SuJ7Xfn0wxWq7bx3ZdwjWMEpWRqpF06yEbCm
	 GxYUHlux5GsN9xGx5LuxJ3UrbSn08+F/yqSspUTnpbmxEMtWFcdBvchH7KgUF6flXd
	 Qoqn6tzP5gvw+9vVk+vcXnMEns+K1c+QMgJW++n2GRyOzYMsg7spqoP0b9IlUJB4sN
	 3jK0UZqM70y6yqwUGmTq0NKU6g9d754ZflQZYC+zfdhfnDTCYimLHdiTHo0EkLXfIP
	 CADLeAcLkpzzA==
X-Spam-Level: 
X-Spam-Virus: No
Message-ID: <2652f0c1-acc9-4288-8bca-c95ee49aa562@marcinwanat.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcinwanat.pl;
	s=s2048; t=1716306455;
	bh=8Q3D0/0B+f2wkHTGW5lf37HesfsMZnmiKoIexwp+hH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l20fF07kmDb0ltVgOtfjcITz64kxoWyDCfhDGPMug9nL7z0FPzwR8x9y1K3VckuMO
	 iDpQoDQf5HN0te1Cz0v4o+Z9JWM4146d5AUhBm+BIgkZAlowDAbYBFSoht4u4QFIHJ
	 at2tJITyPEmGiGIwxcsapy4j5RYg0EIxlehgqZZAqrbuzZ6erjgUNBdXh9w3N6Q+I5
	 1QOTDpnyRVq4r9grXdpNH2rCIRmiYP8T/TRyTwXhju/MKyUDWV/zgPaz0+V+7ykegE
	 BHTIhkhQ+0+/OmlkYiNbQvxXH9vmUu0rTbmlUVsrYQAUSCBziWrKvs6cTQ1npgnQEk
	 dgIFPUsUHJKVg==
Date: Tue, 21 May 2024 17:47:33 +0200
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alex Shi <alexs@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, steve.kang@unisoc.com
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
 <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
 <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>
 <ZhxwIh2M8jr6IZaF@dread.disaster.area>
 <CAGWkznHDpw5Sw5pAfB=TdgRqsf=bmwUQ6+kvvLht3=wumNNo6Q@mail.gmail.com>
 <d9f7c779-acc0-4b8b-993e-e56e9475438e@marcinwanat.pl>
 <CAGWkznESMXeOhWnK93q1JJxhP0r4wR16cRJxiVzKZmM47GiEWw@mail.gmail.com>
 <CAGWkznEG78ppUXyoM2HKoo9MCOBJQaW=vSdSKDYXJj6kWH6zjA@mail.gmail.com>
Content-Language: en-US
From: Marcin Wanat <private@marcinwanat.pl>
In-Reply-To: <CAGWkznEG78ppUXyoM2HKoo9MCOBJQaW=vSdSKDYXJj6kWH6zjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at mx.bitactive.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On 21.05.2024 03:00, Zhaoyang Huang wrote:
> On Tue, May 21, 2024 at 8:58 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>>
>> On Tue, May 21, 2024 at 3:42 AM Marcin Wanat <private@marcinwanat.pl> wrote:
>>>
>>> On 15.04.2024 03:50, Zhaoyang Huang wrote:
>>> I have around 50 hosts handling high I/O (each with 20Gbps+ uplinks
>>> and multiple NVMe drives), running RockyLinux 8/9. The stock RHEL
>>> kernel 8/9 is NOT affected, and the long-term kernel 5.15.X is NOT affected.
>>> However, with long-term kernels 6.1.XX and 6.6.XX,
>>> (tested at least 10 different versions), this lockup always appears
>>> after 2-30 days, similar to the report in the original thread.
>>> The more load (for example, copying a lot of local files while
>>> serving 20Gbps traffic), the higher the chance that the bug will appear.
>>>
>>> I haven't been able to reproduce this during synthetic tests,
>>> but it always occurs in production on 6.1.X and 6.6.X within 2-30 days.
>>> If anyone can provide a patch, I can test it on multiple machines
>>> over the next few days.
>> Could you please try this one which could be applied on 6.6 directly. Thank you!
> URL: https://lore.kernel.org/linux-mm/20240412064353.133497-1-zhaoyang.huang@unisoc.com/
> 

Unfortunately, I am unable to cleanly apply this patch against the 
latest 6.6.31

