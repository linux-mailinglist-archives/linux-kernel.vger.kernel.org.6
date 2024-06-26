Return-Path: <linux-kernel+bounces-231090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FF91860F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4AD1F212F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A6618E762;
	Wed, 26 Jun 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="l94VoYcn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D118C34B;
	Wed, 26 Jun 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416359; cv=none; b=XoLVyoU8oAt+6wS0ZRJ5sKXpEoFlfOeKRS5grybSyCPvnBfu0W8yvrcTSq3A0n89t0ZfKXdPQNH8ZlIywNNYRUjOzwiXJMttE/KMDx5d8bktBeeF3iSLoR8RlPM2dRMwDZzp/QZr9kK3V1lIg2j3sfhEjdgP27NQjhtoeUA3RW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416359; c=relaxed/simple;
	bh=0adLUO8t8jDrE8KFJgKgS1xWlQGXyFePt2oJdFvjdc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PtC0ahYpgAbSUViZxwe7N1WqGn+BayvOtHu8w11zM6oem1ddFkYtyK7cwzj1xA6YFSEZ80RfF9tiF7awCFAujQp1csobLwv7GdIoQnbuzDZAxfOJ0k0ajUCioing697MJjYyU5+uWnP+ByIidxZylCEduAzQ2Satq8JTlanXs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=l94VoYcn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0B59845E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719416351; bh=PgEyPeBVA82w0vwwqwOb+4wIK5bkzxbeIhbog1W2lJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l94VoYcnEQvybRqbGOduVQTU6AtC4I7bw3N9EcXUx33AIYaAKMv+fDtVj3Lqmc+E9
	 ufiGoUy66ihk2IiTPqdlehJfrOQLhQgkJXFUOfMO4I7/oZujEqiIH1M+8LP5NpazYe
	 /N4vRK8foLhs0HRGEARpb2hMWBlAMHPHV5JETRKnQRhet4WH2B2lBZNpW2wH6plozS
	 Zi+hOlJRE0fiLHiESdXQDGc8/TVqS/efqgNDwgcVedDIvQz2ewpm3SGcnJj8Hh/0MB
	 xlL7p8qWPpnVQUquyE8DUJUXh87LLr46mKLCME4nHB5htcodRzDP6r9iTq3G/lRzzn
	 T8RxzcwHOU96w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0B59845E2B;
	Wed, 26 Jun 2024 15:39:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jiri Kastner <cz172638@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cz172638@gmail.com, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH] Documentation/tools/rv: fix document header
In-Reply-To: <20240626150727.156397-1-cz172638@gmail.com>
References: <20240626150727.156397-1-cz172638@gmail.com>
Date: Wed, 26 Jun 2024 09:39:09 -0600
Message-ID: <87ikxv3e8y.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiri Kastner <cz172638@gmail.com> writes:

> align header of document with filename and rest of the content
>
> Signed-off-by: Jiri Kastner <cz172638@gmail.com>
> ---
>  Documentation/tools/rv/rv-mon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/tools/rv/rv-mon.rst b/Documentation/tools/rv/rv-mon.rst
> index af0f329a7c9c..bed937120dca 100644
> --- a/Documentation/tools/rv/rv-mon.rst
> +++ b/Documentation/tools/rv/rv-mon.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  =======
> -rv-list
> +rv-mon
>  =======

A nit, but you should adjust the "=====" lines to match the new length
of the heading text.

Thanks,

jon

