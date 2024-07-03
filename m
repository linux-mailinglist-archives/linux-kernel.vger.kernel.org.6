Return-Path: <linux-kernel+bounces-240297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FA926B76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8243B1C215E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9498218E75D;
	Wed,  3 Jul 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Zr+SO+du"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6413D638;
	Wed,  3 Jul 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045369; cv=none; b=ki6pBUrOvRdRmXs090NHOxYBi7jBbB0ZpTF9zGw9iQDZhYOCFdfib2ij3lDsmAtVUM7Iu8xD5ICoLV+9tNp4ZrgrM/Xx7xKym+/Hi9vkne4e4x6Be3cxaM1t6hK+GJqEtqDAMZRiiFF8CqWj8EfB8Qo3PWtLLrv3p/T/e49DsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045369; c=relaxed/simple;
	bh=heY2XzMbOjVHbm4QYZNdG8tCVsQhay/Rp9L7ERc7sKc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNNvOpzO12z5l0kewLruShqtr0UtrwPepxQ8Y8p4reo3Qs/o/edfgFyDkdwZxWJXyqfvjny7gpN/2jp58RpfhiJ7cRhopc1SkAuvAqcA0V/ERSfKjZob8QJCeUxNYGnXVvlUpt245AglAD1uk1ImxBTGhYJS/L84hIFfihvk4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Zr+SO+du; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C05034189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720045367; bh=6YUncoupi0JqTw3u0eh7HX5S3IBZtcexmjWPdsyEqH0=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=Zr+SO+duQQzVyPVxQ76e/thpBh+lCivbVwR5YA+je6ntwnhLiGZsm3GvURiWo/B6P
	 GhAX9kNiHxsEsZ9iRSii9iE0BV1S/YsAvOqVz2dzdPO4Uv8PXTSxFen9oRnhRfAEb2
	 cCAd6cfalg3f5W46c/g/S0CjHmpcF7iDLkN6qMftz1bOz5SEXxTFT/twtDHg+4Go1h
	 3/Q2xQMK2a8yjEHt7YosccsLpGEeuUCDgIu3BmTMUrr7kuPjYExDOEobL5AkkKJBRe
	 WgWs1uNiis+J8SYA38B9zZPgbP0G7MHySvvO4ulN4isbW8hSQpl2lsFUpWhYFRcDT7
	 C3KhbCLV5zaRQ==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C05034189E;
	Wed,  3 Jul 2024 22:22:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Daniel Watson <ozzloy@each.do>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/admin-guide/mm: correct typo 'quired' to 'queried'
In-Reply-To: <878qymrjrg.fsf@trent-reznor>
References: <878qymrjrg.fsf@trent-reznor>
Date: Wed, 03 Jul 2024 16:22:47 -0600
Message-ID: <87ed8at8so.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Watson <ozzloy@each.do> writes:

> Convert the word "quired" to the word "queried" which makes more
> sense in this context.
>
> Signed-off-by: Daniel Watson <ozzloy@each.do>
> ---
>  Documentation/admin-guide/mm/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index 1f883abf3f00f..8b35795b664be 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -10,7 +10,7 @@ processes address space and many other cool things.
>  
>  Linux memory management is a complex system with many configurable
>  settings. Most of these settings are available via ``/proc``
> -filesystem and can be quired and adjusted using ``sysctl``. These APIs
> +filesystem and can be queried and adjusted using ``sysctl``. These APIs
>  are described in Documentation/admin-guide/sysctl/vm.rst and in `man 5 proc`_.

Applied, thanks.

jon

