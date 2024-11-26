Return-Path: <linux-kernel+bounces-422010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076FB9D9338
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656CCB21309
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBE19CC32;
	Tue, 26 Nov 2024 08:24:58 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8174918FC8F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609498; cv=none; b=QLAExqOuFegSCnQnmVPJFu+cjKiuin5PNVXE460ULengnaGnO11dkhgGPflwb/NYkoYGqfsLoSiWjof1eIpAckOIur/7g2uivFKbJ/Kh7hM9hddBZvrYalC7YLeUHkmx6zvVZbwN+pUDvwYxs3kABoU/ZyPKGftiE64D3B8MOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609498; c=relaxed/simple;
	bh=wfwOevp8Not+xqFXsHWDcBF+bs9RRHns3SGuKdPD4tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgY65kSbcXmfU6+GrbJzjpUzD7ZQsxD1wEHZuS6KuSfD9jmScUlLkeDwgQkQnp5o8m9SPhH7Z5S2fP94ofFX2uNbHFJnuxDrMQ7QSez2DxuFaUKnGv/T2V2LxfKvy4AOuLLfdrCK8QoQz7F53+fbzYf4Vyy3HS42GnIgeB8TkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-8c-674585cb1f22
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH] mm/damon: explain "effective quota" on kernel-doc comment
Date: Tue, 26 Nov 2024 17:24:33 +0900
Message-ID: <20241126082436.1491-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241126002921.50035-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnke6ZVtd0g3WzWC2e/P/NanF51xw2
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7vNg8k9Hj8ya5AJYoLpuU1JzMstQifbsErozbr6az
	FnQIVbz/cZq5gXETXxcjJ4eEgInEuzfT2boYOcDsnn+qIGE2ATWJKy8nMYHYIgKKEuceX2Tt
	YuTiYBbYwihx4elnZpCEsECQxIkbR1hAelkEVCXWnZMECfMKmEnMeDqfBWK8psTj7T/ZQWxO
	AWOJeeeWM4LYQgI8Eq827GeEqBeUODnzCVg9s4C8RPPW2cwguyQEZrBJbP04lw1ikKTEwRU3
	WCYw8s9C0jMLSc8CRqZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIFBuKz2T/QOxk8Xgg8xCnAw
	KvHw3qh2SRdiTSwrrsw9xCjBwawkwssn7pwuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mK
	kEB6YklqdmpqQWoRTJaJg1OqgbHrQsXf/I03458Yy0Xse1pZqq4R0P5Y4HDGfJdTrru1trcJ
	LZ/p9viUc+PTSzdU3XoiFOqcPXmcGe7Pn9Y+b5U820KRCx9Xhm4qSstj8XtbE8cWve702dLr
	k79KrtbVO10kIPIi30VXe80bs2unUoOLSmXWJWYv1X55tu6qMq+0LXfH2UO/k5VYijMSDbWY
	i4oTAXF3Wiw+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsXCNUNLT/d0q2u6wa+XFhZP/v9mtfj87DWz
	xeG5J1ktLu+aw2Zxb81/VovDX98wWfzetoLNgd1j06pONo9Nnyaxe7zYPJPR49ttD4/FLz4w
	eXzeJBfAFsVlk5Kak1mWWqRvl8CVcfvVdNaCDqGK9z9OMzcwbuLrYuTgkBAwkej5p9rFyMnB
	JqAmceXlJCYQW0RAUeLc44usXYxcHMwCWxglLjz9zAySEBYIkjhx4wgLSC+LgKrEunOSIGFe
	ATOJGU/ns4DYEgKaEo+3/2QHsTkFjCXmnVvOCGILCfBIvNqwnxGiXlDi5MwnYPXMAvISzVtn
	M09g5JmFJDULSWoBI9MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwHBbVvtn4g7GL5fdDzEK
	cDAq8fDeqHZJF2JNLCuuzD3EKMHBrCTCyyfunC7Em5JYWZValB9fVJqTWnyIUZqDRUmc1ys8
	NUFIID2xJDU7NbUgtQgmy8TBKdXAyJD81G/TWbbYgwen5lXv3bC9W3lPfy1PjuFWW6e6o5OF
	jNx+nWk8n8EvN8mZ88/PdU6doT1nVimcNA7693nx53IF93774/YTv8wrFN3tLTJt3s2Y6K2x
	3y48PfR88oIcGSWTM3dsY8Rfzzwfuzy2NkNl8aXHoapdmsxHPfnMQ69suP0nyolPS4mlOCPR
	UIu5qDgRANtq0EUzAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks very much for the quick response.  I think it looks great but I
have some minor comments so please see my inline comments below.

Thanks,
Honggyu

On Mon, 25 Nov 2024 16:29:21 -0800 SeongJae Park <sj@kernel.org> wrote:
> The kernel-doc comment for 'struct damos_quota' describes how "effective
> quota" is calculated, but does not explain what it is.  Actually there
> was an input[1] about it.  Add the explanation on the comment.
> 
> [1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043
> 
> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> Cc: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a67f2c4940e9..a01bfe2ff616 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -193,9 +193,13 @@ struct damos_quota_goal {
>   * size quota is set, DAMON tries to apply the action only up to &sz bytes
>   * within &reset_interval.
>   *
> - * Internally, the time quota is transformed to a size quota using estimated
> - * throughput of the scheme's action.  DAMON then compares it against &sz and
> - * uses smaller one as the effective quota.
> + * To convince the different types of quotas and goals, DAMON internally
> + * converts those into one single size quota called "effective quota".  DAMON

Could we use "effective size quota" instead of "effective quota"?
IMHO, it will better give an idea this is related to "esz" in the code,
which means effective size.

> + * internally uses it as only one real quota.  The convert is made as follows.

(nit) "as only one" can be "as the only one".
(another nit) "The convert is made" can be "The conversion is made".

> + *
> + * The time quota is transformed to a size quota using estimated throughput of
> + * the scheme's action.  DAMON then compares it against &sz and uses smaller
> + * one as the effective quota.
>   *
>   * If @goals is not empt, DAMON calculates yet another size quota based on the

We better fix "empt" to "empty" together.

>   * goals using its internal feedback loop algorithm, for every @reset_interval.
> -- 
> 2.39.5
> 

