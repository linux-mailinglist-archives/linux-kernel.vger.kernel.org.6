Return-Path: <linux-kernel+bounces-395449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AE9BBE01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD361C2201A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27921CC881;
	Mon,  4 Nov 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="G0EM96cr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061F18D642;
	Mon,  4 Nov 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748632; cv=none; b=gALQZh2QYCysF4WgHbguZelPFmGya8JgdfI55sK++5jItWfBWaj7U2wCZadIP8bprN1V7f+oY5qM9Gw3RjNGKvu1nVz1pExWrcJbdi+riPjAwnYThVrsohS4UTwHNV508SShM1HxSGpoGVzQF4iI5igaFMArRI8SsQbwoI8q46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748632; c=relaxed/simple;
	bh=a2c0rEc2+aCed1URt2xgKGZx+gMTdxMxU7gRLxLofhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TusJpXvuIPrYwui+KHw9V4ysGLoYGIUZ0aAfBY6eeD0R50ydtLh0yYOViXLMbQS7BCfykwXBO3cWIThXyYdcWwB7Yi+y5RrlhBvi6IEIoHX1Dwnx29OH/N5yjRVNY5lUEnU6PVvMjgkRKuMeuALnN6oqVbhSZUDall/P962oEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=G0EM96cr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CDFC642C34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730748630; bh=0y1bj1W8QgVjR9/2nJiw3UICAY97z0JFh5PXrqhdRHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G0EM96crxH5CFq6x9X9B9Hb6JQMXCQAYeREnm9KKkY1FlzlvCEW1Pqb8khGODq3su
	 n8FUzomWl8mYLbsqz3T30dSJ4RcCOYAXP5rINLriy8nB5pE0yVv8r9Nu0JRJ3yJY2D
	 HPoaXxvkC5KAeB8hqVYgnlUxRsklT9ubt85WWp7cXGr1QQHBpaja/XCw3jmVHxqkJ2
	 gg9Yq4NYYlUFQhYJGJkIe0u/1Cy3AVNKxEH4yhxzbRoCSBTnN/CLcjpuTZZYFtxMrt
	 x49EeP86bmcN2ZCwNMHBgJzAmgFQFUqLJnEr/zrGY7rOeJHYuL/5pGW78d+dqPlPXR
	 FnVAWTEdiRYWQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CDFC642C34;
	Mon,  4 Nov 2024 19:30:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Kreimer <algonell@gmail.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Andrew
 Kreimer <algonell@gmail.com>
Subject: Re: [PATCH] Documentation/maintainer-tip: Fix typos
In-Reply-To: <20241027125712.19141-1-algonell@gmail.com>
References: <20241027125712.19141-1-algonell@gmail.com>
Date: Mon, 04 Nov 2024 12:30:28 -0700
Message-ID: <87a5ee94q3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> Fix typos in documentation: a -> an.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/process/maintainer-tip.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index 349a27a53343..e374b67b3277 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -7,7 +7,7 @@ What is the tip tree?
>  ---------------------
>  
>  The tip tree is a collection of several subsystems and areas of
> -development. The tip tree is both a direct development tree and a
> +development. The tip tree is both a direct development tree and an
>  aggregation tree for several sub-maintainer trees. The tip tree gitweb URL
>  is: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

Applied, thanks.

jon

