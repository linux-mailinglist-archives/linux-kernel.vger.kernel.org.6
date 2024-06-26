Return-Path: <linux-kernel+bounces-231616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC8919AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49375B20EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38225194083;
	Wed, 26 Jun 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rmfe6jap"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2D181B80;
	Wed, 26 Jun 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442493; cv=none; b=m3IgQ3+UXVQhyjZvm8UcHqMezdDOq714Y4paPnDupEJDXSB2eUbhkk/dDXBTF6v4dfcFuggg2zrAmRnDk3XmgoUK0yhZbd86v3iVdS/jzItZ3rSXB0jKiFMq/y3GGkmN+YpyBlrKIWnEIBrCVr7Tf3ycSbn7hiL7q3sk8aPQBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442493; c=relaxed/simple;
	bh=h+O7Tuz44Jj9yHWiCcME/fAj6Q9eRd7p2E2xF0qUOVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpgLyOdUAQR8U2jFywy66sAfCJxSXoQqSA5FKq92P0yiOrB/Rr5qXSqGmEmQ7FQAWlTpEUiGC/bSyUTj9zFCqkupi6B73rOJH2pPFUpHAEM6fMCUAIDuqd0NCghpY7QjDM5R+Ez/TlF8+iQRquSyNuUVXl9Ax1zRRt0qAjYPE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rmfe6jap; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8D40745E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719442491; bh=md+BSMxbPW1GZvXnRNahMlC6lV5ZIT4XzS67Wnd0GEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rmfe6japNNfllG9T/UupeJptVA+oJFpFjaw/8SdAhnGgzPf1yhf8mPbyaH7kKHN/u
	 nx/E8kSOpL4ecMrLHTjOCDSXoUJO1JJAnX2Nk7RUM0lZwKddj/fQMeQsSJ5YMZYBPZ
	 4SKF1pecvJozsCb5DrI5Im/kB5rmiBvItgQpRp30805/fLnkmutLGFP2as29Kt59vk
	 qNQobWjRrlckVKfvboohBw7uKCaHm+ox90n01jRN7II/yr/Gt8Rp1XDhGQMcfd67NV
	 3ryy6rF2SCoGisOeLW2zWYxceG9Xqk995JWZdGkLKpBlEFgnJ355A1TrooY9KFT2SO
	 YkBL6vNiui/wQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8D40745E2B;
	Wed, 26 Jun 2024 22:54:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Diederik de Haas <didi.debian@cknow.org>, Thorsten Leemhuis
 <linux@leemhuis.info>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Diederik de
 Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] docs: verify/bisect: Fix rendered version URL
In-Reply-To: <20240620081355.11549-1-didi.debian@cknow.org>
References: <20240620081355.11549-1-didi.debian@cknow.org>
Date: Wed, 26 Jun 2024 16:54:50 -0600
Message-ID: <87r0cjxqkl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Diederik de Haas <didi.debian@cknow.org> writes:

> When rendering the documentation, the 'html' file extension replaces the
> 'rst' file extension, not add it. So remove the 'rst' part of the URL.
>
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  .../admin-guide/verify-bugs-and-bisect-regressions.rst          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> index c389d4fd7599..6281eae9e6bc 100644
> --- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> +++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> @@ -23,7 +23,7 @@ mistakes occasionally made even by experienced developers.
>     up in the reference section, then jump back to where you left off.
>  ..
>     Find the latest rendered version of this text here:
> -   https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.rst.html
> +   https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Applied, thanks.

jon

