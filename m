Return-Path: <linux-kernel+bounces-519705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB48A3A0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60287A4828
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D526B95A;
	Tue, 18 Feb 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BSCCx7cK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18326B946;
	Tue, 18 Feb 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891584; cv=none; b=BY9lqt92CexgNEhVBCCrWjwAoll5PN5Y/1qLuORP+ZbIpy/9iZwAz6HQKIIh1XO5M73/SdsuHRtq/v3XKY0CR7Qi9Xahp+gKKgXfpi4XwK90iL6ek6XknULP114pLKXYyAMyJ6D49Xni3I517yqd9s2nYKYwXlwQ0BMZIs2bCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891584; c=relaxed/simple;
	bh=yiYQkJmgh5KtX1ybp9e1CiAvqpnog8wemHUJ2Xt488Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dbAMU2CJsKQ5RXKXb8TBItNnzQgRiIYo66Fb+952Ukv4UIPJE3j6AzIXBjJe1Dle1HNP/g3BKieDzFAwNV4OrZlebHM8CEjNX89OGJlFlsAbSUEvvFsErLjdWJK7VgzReRwWw+w3SVFvMrFnqg1zfW8OTiWV7qj1dJI3bzNt5yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BSCCx7cK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A136148EB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739891575; bh=4gf5JdbgJWegtB585WY5Jp56LsHto1xmDBzp2Fqa8v0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BSCCx7cK49Kn1pvuV+I9DV34ixb7LKT49Spj38gRNQ2XHyXe+DbirbKJhTPV5Mvgh
	 Gftaz49wzgWVZ/ykRsKqqJaqAl9QuqYtG++sHCCOVMEl/0qHdU8IMcdhKq3KRtokiT
	 Wkslxb3+t01SkEl04yCIDqtx6wok895urhwx7gdZBh1L20tsBgTHZqwFFoWlRBpL4v
	 c4rUaTCk5EKr9qzAY3x5vCljOjnubayb7wPx0bF/I4bmRcfK23B5AaeNQf3ZsYUCli
	 21zJYAg60egK/qA34n5A8Gfm7t7BnIF4Nf6JvTqI3ey+bDwc20grnad66PsKmTmQU3
	 XP+xSjEdKmXrQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A136148EB5;
	Tue, 18 Feb 2025 15:12:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Armin Mahdilou <armin.mahdilou@gmail.com>
Cc: shuah@kernel.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v2] Documentation: proofreading Documentation
In-Reply-To: <b45c5b7c1ec72697005afbbf870100cc4a175572.camel@gmail.com>
References: <87bjv91yi3.fsf@trenco.lwn.net>
 <20250210192754.30283-1-Armin.Mahdilou@gmail.com>
 <b45c5b7c1ec72697005afbbf870100cc4a175572.camel@gmail.com>
Date: Tue, 18 Feb 2025 08:12:54 -0700
Message-ID: <87tt8rqoax.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Armin Mahdilou <armin.mahdilou@gmail.com> writes:

> On Mon, 2025-02-10 at 20:25 +0100, Armin Mahdilou wrote:
>> Fixed some spelling issues in documentations.
>> 
>> Signed-off-by: Armin Mahdilou <Armin.Mahdilou@gmail.com>
> Hi all,
>
> Just a kind reminder about this patch.
> I would like to know the status of it and as it's my first patch,
> I want to know how can I track if it's merged or not.
> Thanks in advance.

It's in my queue, please be patient.

It would have been good for you to add Randy's ack when you reposted it;
I can fix that when I apply it.

Thanks,

jon

