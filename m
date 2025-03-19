Return-Path: <linux-kernel+bounces-568683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C714A69947
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003BA3A5EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10101213235;
	Wed, 19 Mar 2025 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rmbagfGI"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E41E1C3F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412450; cv=none; b=VL2n79MULzpeS/8u59t+sA5wro0cTqn2MeEvKgLmGY+bgADs4itJLVzVEZX0n2pL48GzJaEUWlJIW7qDzmMA2TG67vnuQO1miV38IjLxBaMTvfrFRrjgP6VvPxqy+iR0Pluakubm+O4UQbPuccsYdaYS8WoDQi1WW1r6eBfF6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412450; c=relaxed/simple;
	bh=DTxzun+gUvrsEUiBL9zGZsTSEMdGP6mFnSJ9xN9HF2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxSffrX2HuKcx/2GPNW6OQGvnSoKBwcUyU1U4KC+0X332k1olzJZoAcEhq7mydhY+xPH3doCfbOLJj7RsAL3KBypsFXLxGa/kou/fJl4XSPIC82cJjPthgVbctu1PfKK5kiuM2NL+iJgO2ltAo0jOOksnU9FLb6uIBqxVzgMohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rmbagfGI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 12:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742412445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZiap64g8PWqaP9A/RNcdWpawC9YJsZVtom3gXzvjSo=;
	b=rmbagfGIAuUu6eOihLERaOUKIATp+xlfmTWTVvBsfFUpuEXsjxx+BoiXxnJkWczGGlDq/r
	mqmT22bz0OZPCklCCh/35FHhmRL1bkTELkFMYS2s30XzEzC+KtFZuQabYDXG4oDyPVnwYf
	gX5RdjdI82wbo0Y0uVj5sqBeW+1m5xE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, kasong@tencent.com, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Message-ID: <gkuatggv6jhbl32x7rpzlcifcno6hoirw43v35vtkfflqmepfw@wwyz7x6hc4id>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
X-Migadu-Flow: FLOW_OUT

+Tejun

Hi Zeng,

On Wed, Mar 19, 2025 at 02:41:43PM +0800, Jingxiang Zeng wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> memsw account is a very useful knob for container memory
> overcommitting: It's a great abstraction of the "expected total
> memory usage" of a container, so containers can't allocate too
> much memory using SWAP, but still be able to SWAP out.
> 
> For a simple example, with memsw.limit == memory.limit, containers
> can't exceed their original memory limit, even with SWAP enabled, they
> get OOM killed as how they used to, but the host is now able to
> offload cold pages.
> 
> Similar ability seems absent with V2: With memory.swap.max == 0, the
> host can't use SWAP to reclaim container memory at all. But with a
> value larger than that, containers are able to overuse memory, causing
> delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> out of balance, especially with compress SWAP backends.
> 
> This patch set adds two interfaces to control the behavior of the
> memory.swap.max/current in cgroupv2:
> 
> CONFIG_MEMSW_ACCOUNT_ON_DFL
> cgroup.memsw_account_on_dfl={0, 1}
> 
> When one of the interfaces is enabled: memory.swap.current and
> memory.swap.max represents the usage/limit of swap.
> When neither is enabled (default behavior),memory.swap.current and
> memory.swap.max represents the usage/limit of memory+swap.
> 
> As discussed in [1], this patch set can change the semantics of
> of memory.swap.max/current to the v1-like behavior.
> 
> Link:
> https://lore.kernel.org/all/Zk-fQtFrj-2YDJOo@P9FQF9L96D.corp.robot.car/ [1]

Overall I don't have objection but I would like to keep the changes
separate from v2 code as much as possible.

More specifically:

1. Keep CONFIG_MEMSW_ACCOUNT_ON_DFL dependent on CONFIG_MEMCG_V1 and
   disabled by default (as you already did).

2. Keep the changes in memcontrol-v1.[h|c] as much as possible.

I will go over the patches but let's see what others have to say.

