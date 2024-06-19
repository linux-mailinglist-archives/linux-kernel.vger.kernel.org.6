Return-Path: <linux-kernel+bounces-221772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683590F85C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E3E1C2409A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E1D15AD9A;
	Wed, 19 Jun 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tWrMXfjK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABB15A850;
	Wed, 19 Jun 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831686; cv=none; b=E5LpwPM7Y2S0slXWZIEyXW32udMkHWWvJyCIJkqet3k/9BcaaKe2ssUC17VlQQmsD0TSTEnWMOoJ4dbhEwZX8NusUcoA3tVucakJSWT0l6yyTJXBMGTNhHtQ5Cyn90QhwMyGdHuRRqw1Jzv3bclX4qyuUVq//r7jtY9CE/nl97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831686; c=relaxed/simple;
	bh=5EJXadW4oBoXMMAP0jTS1az9XdHKM3pCdDm4IKgtKsk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deoBgwohkVmYDrhu+tFrZx1cK/L5k1Srbdq1bg8jczeeIl82ElGAwXe6Gmuv0CdAn0bolFYZjh5oeOwDr1ApXIMZDKRBzwz+9aDwM8vMU39URf9v9GCprxjj3WZHw3r0HbPax8rIT3OMjEiNBOPxTp7WxcmS9KfTXh8idX50pfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tWrMXfjK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 34B8445E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718831676; bh=uZjnDhn3B+EvVBuMYNCscY8gvrKikVxejozz2U7r2io=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=tWrMXfjK1fkTyta9sZmwsRUhi2pk+rS30t4HOcbl2B8NzzRDs2qcW+VGcml/9KVXu
	 DQiHGmY7f0HtHZAL6yJ2LQpclABgauPTa+BCcUgpUeMgnZ75y23Qj61xiiqch65O56
	 HAHfe8tnvL63o9470IzPfatzNKspiyexpl4aJYSRS5GuxfKE2WrOK0+C7CRHpBll7V
	 QwjANQpjfbt18xzl+yMIAJnRG25JU32NX9X8Ikv+Tjf2vkmzWQtipqaXnoFsciAP0e
	 pTBxByOTMMUiCh3xLgR3rYmwr9yBgilxZDuRod4usPMlZn5/ZQnrJLbTEUR8iS+d7I
	 BjC4Chf8on0Zw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 34B8445E04;
	Wed, 19 Jun 2024 21:14:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nir Lichtman <nir@lichtman.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] English fixes in vmalloced kernel stacks documentation
In-Reply-To: <20240619210707.GA3570474@lichtman.org>
References: <20240619210707.GA3570474@lichtman.org>
Date: Wed, 19 Jun 2024 15:14:35 -0600
Message-ID: <87iky44ouc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for working to improve our documentation!

That said...

Nir Lichtman <nir@lichtman.org> writes:

> From cdc9d82bad7111ab1f132d1264fa6ffa323c26b0 Mon Sep 17 00:00:00 2001
> From: Nir Lichtman <nir@lichtman.org>
> Date: Wed, 19 Jun 2024 23:57:11 +0300
> Subject: [PATCH] English fixes in vmalloced kernel stacks documentation

All patches need a proper changelog, and this is not it.  Please have a
look at Documentation/process/submitting-patches.rst for information on
how to describe your change.

Please pay attention to the section on Signed-off-by while you are there
as well.

> ---
>  Documentation/mm/vmalloced-kernel-stacks.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/mm/vmalloced-kernel-stacks.rst b/Documentation/mm/vmalloced-kernel-stacks.rst
> index fc8c67833..b4ca3176e 100644
> --- a/Documentation/mm/vmalloced-kernel-stacks.rst
> +++ b/Documentation/mm/vmalloced-kernel-stacks.rst
> @@ -20,9 +20,9 @@ Introduction
>  
>  Kernel stack overflows are often hard to debug and make the kernel
>  susceptible to exploits. Problems could show up at a later time making
> -it difficult to isolate and root-cause.
> +it difficult to pinpoint their root cause.

This is a change in meaning and is not necessarily an improvement.

The other changes are fine.

Thanks,

jon

