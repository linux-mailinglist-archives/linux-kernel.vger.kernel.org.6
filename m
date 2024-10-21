Return-Path: <linux-kernel+bounces-374658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FEC9A6E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1358B1F21001
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA421C3F04;
	Mon, 21 Oct 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Xx+k5Ljg"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027C1C32EC;
	Mon, 21 Oct 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524753; cv=none; b=CMNGJiKhrUicFTbbEs2/roBH+8aqxCohbpcYoVSnJoiWz8ZETHHtZntoefne35sk0YGpdA9gNrWYWDx2qijudP5K0SFG+s8r/EFJUHzvcE/S6UTLjnTi1YNoDKab0Z8bkbCJZX/NanUtQ1vqjoBGpNdQdVZjwCJbRtA7eBbOMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524753; c=relaxed/simple;
	bh=UZMMV9G/mKyr06iQKfcf5/1gDBtLYIeT/mL7PmMtd2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFDdOysetQPOYVkqrpIRuuHYsDygrWMB2JVcWwlA3fwCcGxDPw1wzCPLpBFKKIum9wtFduSKwfkHQcVKsdt0aCG/mSOq7V8QL/bRVasfpVLYJMjMwC08oVVOLIbXeCQOau8kZ8tp9dT1wMwCYEICNRleS5hbPId/eMxhybBANQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Xx+k5Ljg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 61EBF42B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729524750; bh=7Y6H6MyFs+bhU9DgQCPEEHYBKiv8pJ07xJG1TdDtImA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xx+k5Ljgm+ZSmgRkeNzEaxWcnM0roaWMtE8q7lm0u8wFvdeIrsNKxdFv/XD8m/r5l
	 kYYRKretQjQEr0cI3L6kDTimEfDA/dXpehBDGUVtEUgOr8nOu6zFQkhJ740/Hgds4k
	 RaIKbcVGXXjpol+hxgj+TmSDkjWyQN0H9pZbXaQniV+Zgrl1URc1ir7Cvx0/jdGv7i
	 UjbPkvRjMTU1hQr4G8SlaiQHugrkxoGt3ZrlbOTam1udXw1M0DTn9p5wECSidqsQGS
	 1ukpgb2DOYL2pyWonWZ6h4M2SL0eg4H+n1zjBVzxoSG9SyP+G9KgJDs0365SHgCWmq
	 A9GrpSPMhqoTw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 61EBF42B3D;
	Mon, 21 Oct 2024 15:32:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove redundant word "for"
In-Reply-To: <20241018172924.159221-2-thorsten.blum@linux.dev>
References: <20241018172924.159221-2-thorsten.blum@linux.dev>
Date: Mon, 21 Oct 2024 09:32:29 -0600
Message-ID: <87msixtqsy.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@linux.dev> writes:

> s/for//
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  Documentation/maintainer/pull-requests.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/maintainer/pull-requests.rst b/Documentation/maintainer/pull-requests.rst
> index 00b200facf67..0d63d9d7e347 100644
> --- a/Documentation/maintainer/pull-requests.rst
> +++ b/Documentation/maintainer/pull-requests.rst
> @@ -50,7 +50,7 @@ so outline what is contained here, why it should be merged, and what, if
>  any, testing has been done.  All of this information will end up in the tag
>  itself, and then in the merge commit that the maintainer makes if/when they
>  merge the pull request. So write it up well, as it will be in the kernel
> -tree for forever.
> +tree forever.
>  

Applied, thanks.

jon

