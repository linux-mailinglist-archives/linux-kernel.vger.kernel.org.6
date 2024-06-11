Return-Path: <linux-kernel+bounces-210324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F97904258
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B342A2817B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6F48CCD;
	Tue, 11 Jun 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1K7XLgu"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804929CFB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126668; cv=none; b=k6PwAOGtEVLNEOKyrc0g0NXKwIaF1RzVbrpimi8eLDFAWGjefYOOeaU+hywFDb1f8Bk7Hlwut18feiWbXU3pwSG+cdFwtZ90pGj01627v4FJ3aH2Fdiu9FZs7Gx0V31EClz6AMS4A7134T8N9/HYBeQau0/NV5hI+4hblfe0Lt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126668; c=relaxed/simple;
	bh=myohPFwDOhAbyQK48qHOUGICyQu405sIWxL3nDzPlHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7+53O3kd7QBOgQSqxO5IOT+YEoJBaCqChA7Ccku7rbGqToYNj3pctMQ0uYivWr/wff0jFT+p4nYWsrRpy20qeRtiu//NrBQczaQfmUmKnY7yhPzaT5DVwLhDONaTQU9ZxxMJ6sEaH6+P3FRuhTkqFcjhUcWum3NZLkOw/0cyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1K7XLgu; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: 21cnbao@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718126664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3i+HyGj1VKoyFoBY2yyUEOXBAoTrzIHET6FO3GGsZo=;
	b=a1K7XLguZyWpGyUG7DGAmh39NzH9EnD1KN/l95PsIonEde1btPH7252Kez+WyPEoOOyhQU
	lAfFrulkQDP3bEbnBWCrQqMGir699/jG8fvNiFJ4yFPTcgZXkEVUyEKDHhuTtUimd8NukZ
	DgdqVZUqTYAey9eBl6sq8TOOfo3YYpg=
X-Envelope-To: chuanhuahan@gmail.com
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: david@redhat.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: kasong@tencent.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: shy828301@gmail.com
X-Envelope-To: steven.price@arm.com
X-Envelope-To: surenb@google.com
X-Envelope-To: wangkefeng.wang@huawei.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: xiang@kernel.org
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: yuzhao@google.com
X-Envelope-To: hanchuanhua@oppo.com
X-Envelope-To: v-songbaohua@oppo.com
Date: Tue, 11 Jun 2024 10:24:17 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Barry Song <21cnbao@gmail.com>
Cc: Chuanhua Han <chuanhuahan@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, 
	kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, 
	steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
Message-ID: <ly745k53gpkef6ktaoilbib4bzrwyuobli7adlylk5yf24ddhk@l4x2swggwm3f>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-6-21cnbao@gmail.com>
 <c9702789-5772-4750-a609-e44a5bbd8468@arm.com>
 <CANzGp4+p3xSo9uX2i7K2bSZ3VKEQQChAVzdmBD3O2qXq_cE2yA@mail.gmail.com>
 <emvsj7wfy24dzr6uxyac2qotp7nsdi7hnesihaldkvgo3mfzrf@u7fafr7mc3e7>
 <CAGsJ_4zTpcBj_0uC9v4YOHihx-vEek+Y6rr=M1noijwbhfBw7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zTpcBj_0uC9v4YOHihx-vEek+Y6rr=M1noijwbhfBw7A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 12:23:41PM GMT, Barry Song wrote:
> On Tue, Jun 11, 2024 at 8:43 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Mar 14, 2024 at 08:56:17PM GMT, Chuanhua Han wrote:
> > [...]
> > > >
> > > > So in the common case, swap-in will pull in the same size of folio as was
> > > > swapped-out. Is that definitely the right policy for all folio sizes? Certainly
> > > > it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
> > > > it makes sense for 2M THP; As the size increases the chances of actually needing
> > > > all of the folio reduces so chances are we are wasting IO. There are similar
> > > > arguments for CoW, where we currently copy 1 page per fault - it probably makes
> > > > sense to copy the whole folio up to a certain size.
> > > For 2M THP, IO overhead may not necessarily be large? :)
> > > 1.If 2M THP are continuously stored in the swap device, the IO
> > > overhead may not be very large (such as submitting bio with one
> > > bio_vec at a time).
> > > 2.If the process really needs this 2M data, one page-fault may perform
> > > much better than multiple.
> > > 3.For swap devices like zram,using 2M THP might also improve
> > > decompression efficiency.
> > >
> >
> > Sorry for late response, do we have any performance data backing the
> > above claims particularly for zswap/swap-on-zram cases?
> 
> no need to say sorry. You are always welcome to give comments.
> 
> this, combining with zram modification, not only improves compression
> ratio but also reduces CPU time significantly. you may find some data
> here[1].
> 
> granularity   orig_data_size   compr_data_size   time(us)
> 4KiB-zstd      1048576000       246876055        50259962
> 64KiB-zstd     1048576000       199763892        18330605
> 
> On mobile devices, We tested the performance of swapin by running
> 100 iterations of swapping in 100MB of data ,and the results were
> as follows.the swapin speed increased by about 45%.
> 
>                 time consumption of swapin(ms)
> lz4 4k                  45274
> lz4 64k                 22942
> 
> zstdn 4k                85035
> zstdn 64k               46558

Thanks for the response. Above numbers are actually very fascinating and
counter intuitive (at least to me). Do you also have numbers for 2MiB
THP? I am assuming 64k is the right balance between too small or too
large. Did you experiment on server machines as well?

> 
> [1] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.com/
> 
> Thanks
> Barry

