Return-Path: <linux-kernel+bounces-336017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80D397EE15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050361C2110E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FE19CD0E;
	Mon, 23 Sep 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYeic13N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D080BFF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105136; cv=none; b=oFprZwxPFxVZUKvwUBuQhX3URkeLY/XGsOD7Y4QGknbJ6AMC9DzpQDJkgARcBEEuXvvw7MAAsxGRZCs9OSoDTpu/deiYv11PgouWZOC/B8BUWwUcYqVfUSY3Q7YDrySnZDD1gsDvHKi9rY3oQGZGNBmDNcHnPDJUow3oF5/4zB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105136; c=relaxed/simple;
	bh=ACUHe5kDZc77KXWyN6kCP9hWgXL3XrVwmt23+q+O0yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFNIR6LvCkq4rVt+4c+SOs8zvLELQmVVIrvtUF0AxkVK//o8y14Yvl7ScaxUesjj54isqJfXm7JxJt/sNhtDLkbFlthErfiDhDDftAFMCNH3Xj4iZA4LJzyWDBbWTNfUK0zzy4af5BjKVET4f6F8TSw9CNZ1m3kmGxuvbpkkxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYeic13N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F6C4CEC4;
	Mon, 23 Sep 2024 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727105135;
	bh=ACUHe5kDZc77KXWyN6kCP9hWgXL3XrVwmt23+q+O0yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYeic13N/Suai6Y/iGjlRzD+lC/DEDTySMBorpKsOpMgPRns43QLMui9pQPcrWIsN
	 cbRX2qk99p3XLGL4UqEgbQe17uVrogkXpx8U5KzT6rPArEWs7l5Mg1fqinQeZQ4Zbc
	 LPnD7lMQM049aN4A+5Wv8BkaZfNsf2yMfxsjb8FlkhJvhlX7a0XjBIb0MGgDYYhVu8
	 sX1MzGJWef6CqNAkHM5cn1Nu9ohV9lN/OPb/GkRbI0w8KaAxaxjisfatRnc7/E5zq4
	 jL/SRDGJuKcbncgO7MFY54A68dciYT2koO/zidnAQ5Xp8VFC9oKibg89doJf8gemix
	 qXro/NSetAwnQ==
Date: Mon, 23 Sep 2024 05:25:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: xiexiuqi@huawei.com, peterz@infradead.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 1/2] sched: Add dummy version of
 sched_group_set_idle()
Message-ID: <ZvGIbtGCReTl8SVD@slm.duckdns.org>
References: <20240923135431.2440320-1-liaoyu15@huawei.com>
 <20240923135431.2440320-2-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923135431.2440320-2-liaoyu15@huawei.com>

On Mon, Sep 23, 2024 at 09:54:30PM +0800, Yu Liao wrote:
> Fix the following error when build with CONFIG_GROUP_SCHED_WEIGHT &&
> !CONFIG_FAIR_GROUP_SCHED:
> 
> kernel/sched/core.c:9634:15: error: implicit declaration of function
> 'sched_group_set_idle'; did you mean 'scx_group_set_idle'? [-Wimplicit-function-declaration]
>   9634 |         ret = sched_group_set_idle(css_tg(css), idle);
>        |               ^~~~~~~~~~~~~~~~~~~~
>        |               scx_group_set_idle
> 
> Fixes: e179e80c5d4f ("sched: Introduce CONFIG_GROUP_SCHED_WEIGHT")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409220859.UiCAoFOW-lkp@intel.com/
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

