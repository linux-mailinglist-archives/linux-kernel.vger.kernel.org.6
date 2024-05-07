Return-Path: <linux-kernel+bounces-171772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB45E8BE85E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE451F2E1A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96E168B18;
	Tue,  7 May 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYgFcoZF"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415413CFBB
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098191; cv=none; b=cumuQ5DKcq/a6FpjOeC+njvxE9fAf17kHDdB94tQhUtbHgOPlRa6TM0d0OizQYHCZbEMiU2m1thqAU3Q2kvqisXSPH8FekcNl9/7QodSGeRtEaLZKBd67fq+bYGNlgV+AT5W2E+jxxGa8qZClkdwO1rxUx3ISfu2QocZAFu3l9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098191; c=relaxed/simple;
	bh=gz4Jf3ondj4y4dpkh3Y5gyLp2dfD3A5nAdCohPabPh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5bko0wb2xlEB0yykhzZZ6JiewGQXNIdUlDasjcKIOb10y4OXxbvGnc4aRPTMrHNli2B6vW5eT9KiqjYomyuLbx6gSkTqDJ7ZxvfsSp1Yqslx0LgjB76Q49FoiD3LAecSlABoiE2foIPaKhy9HMhJ8oS7WQ2UU8HdzJ8ChzzN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYgFcoZF; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 09:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715098187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgzIR0YD+S9uWGtbeF9+1URxHxfb+Er2kUk5GWowswQ=;
	b=GYgFcoZFHdDT9O8zbQNUuBjwrw3TYPWDPuV7kfu2wxM2XY5R/zlVAaa7+/VEnmVBOaXaOb
	Bd0uwhVVj08huf6sHJBxSAABdmpRTNwO1UiflcVyljF+6UECf8ZIY5GV0zvOtF8p1wxO/L
	WOxNDSZLD9HnbXit5a7NqNimo/JxiqA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mm: memcg: make
 alloc_mem_cgroup_per_node_info() return bool
Message-ID: <ZjpSPRn5kVErC6s2@P9FQF9L96D.corp.robot.car>
References: <20240507110832.1128370-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507110832.1128370-1-xiujianfeng@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 07, 2024 at 11:08:32AM +0000, Xiu Jianfeng wrote:
> Currently alloc_mem_cgroup_per_node_info() returns 1 if failed,
> make it return bool, false for failure and true for success.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

I actually liked the previous (ENOMEM) version slightly more,
but this one works too.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

