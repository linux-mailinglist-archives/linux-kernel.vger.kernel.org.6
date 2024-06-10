Return-Path: <linux-kernel+bounces-208867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963A2902A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447A528290D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733884D8C7;
	Mon, 10 Jun 2024 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o565Ppp0"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487174D8AD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052202; cv=none; b=WCihRc4dgrL7qDwDMqZ4t9DKVBfk5R2ZKJpZYE9HVys88Di+daXBSdFkwEOv78VQIfVusXmwBcn2dQN+km70xrdT1EkGc3iRpeZJbma7CeFW8I2FQVGuAYA0e4jNf9V5tio+c6Ljo9s3fFXhVHn8nB8DmX9kjLenxwRzjNUymN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052202; c=relaxed/simple;
	bh=+atSc5zHsdMS0skjiFYlGfZpkjkkMKe1giRVAcA2SE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDXchU8c1vtfM1eQ7p1acUzoW9q2LpijLJTdB1QCobTAguCADEYWzS8fTBpacrxX2kQWHDOv8Yh770RrpqgTMgUAvpHTum86/TcXcC5lFAkHu8m/22J+KM5iRubKxG/gXXPBwWEghBFmnuU3OpAs4yTjJRl5+OVw3ILFxR4aZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o565Ppp0; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: chuanhuahan@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718052197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+atSc5zHsdMS0skjiFYlGfZpkjkkMKe1giRVAcA2SE0=;
	b=o565Ppp0gWCACnhv8ESr1bs0XryAs2JpPECDn+zeH7cv8Y+bVxreEv0E8eURQe3Qv6JsX+
	m3koFtxPElpQ9dJMDGjY5CDZoK2rHNwU/qUrKwS/okv7e7b+HW3Dh29fEkAyCAh0Qz5DHz
	LjXcYdheOkIX04Ndje9avI8J0pETnM0=
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: 21cnbao@gmail.com
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
Date: Mon, 10 Jun 2024 13:43:10 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chuanhua Han <chuanhuahan@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
Message-ID: <emvsj7wfy24dzr6uxyac2qotp7nsdi7hnesihaldkvgo3mfzrf@u7fafr7mc3e7>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-6-21cnbao@gmail.com>
 <c9702789-5772-4750-a609-e44a5bbd8468@arm.com>
 <CANzGp4+p3xSo9uX2i7K2bSZ3VKEQQChAVzdmBD3O2qXq_cE2yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANzGp4+p3xSo9uX2i7K2bSZ3VKEQQChAVzdmBD3O2qXq_cE2yA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 08:56:17PM GMT, Chuanhua Han wrote:
[...]
> >
> > So in the common case, swap-in will pull in the same size of folio as was
> > swapped-out. Is that definitely the right policy for all folio sizes? Certainly
> > it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
> > it makes sense for 2M THP; As the size increases the chances of actually needing
> > all of the folio reduces so chances are we are wasting IO. There are similar
> > arguments for CoW, where we currently copy 1 page per fault - it probably makes
> > sense to copy the whole folio up to a certain size.
> For 2M THP, IO overhead may not necessarily be large? :)
> 1.If 2M THP are continuously stored in the swap device, the IO
> overhead may not be very large (such as submitting bio with one
> bio_vec at a time).
> 2.If the process really needs this 2M data, one page-fault may perform
> much better than multiple.
> 3.For swap devices like zram,using 2M THP might also improve
> decompression efficiency.
>

Sorry for late response, do we have any performance data backing the
above claims particularly for zswap/swap-on-zram cases?


