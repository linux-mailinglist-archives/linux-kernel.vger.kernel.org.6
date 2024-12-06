Return-Path: <linux-kernel+bounces-435345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201CE9E7659
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA87C16691C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A41F3D30;
	Fri,  6 Dec 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bVs+yAJV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514420627F;
	Fri,  6 Dec 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503579; cv=none; b=XMyXsYJIaRsIl3OygphbFO2MgwIALoGPZ1TNm1cQzVlbm/iJjOki5TdEfv/GHQCCDIavza/ke4XfFJVFtb8DjNCpGBddwmdyUDMXZ1RUFDSRizCs2eaIkdk7aYazvbbZd5uXTQYXvAfkpPDKc1Sg7ZK0+Rikqcbt/CtZkuA2/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503579; c=relaxed/simple;
	bh=2Ojndg5rYRkgMC4bmQj2uNcKs0mLTctIGHGFNb6aemk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DA8GdKEmHRIODMUBVfKRpuff7/tbhLb3xbWnBr0irKVKhjI/aBInp3crlYeegfKZb9l2bRWYuTpw0veD+2yEycKqOGxHSeEXBc8dPgrH/qJ6JUbDk1trM96iBRw7C6plaxHQr0/qXU2YHZh1p4C2WI+Kx5Nv/WCN82W2hAL3giA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bVs+yAJV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C95F140409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733503577; bh=gBj34d/gNZKD3b4UxwI8zmxmOu4ry2UMSrIMXmXkstc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bVs+yAJVkdupoH6wBkc5Hv/Cy/lBMPg7U4h6pGZzvW8iU/0+2pUc8WVLQfLgb7PI/
	 UHqJSm7PYyiH6MyVzvC/yw8juQ4z4XUj/WwIB+0U2QK5ttwcJZr7sb2e7Lq8X1JysF
	 yn50TLfJ1ccm+vmmQxbs0/SzPDGjxHuwyV+zstTYOawPHY+lEKkZEV9a77wlr0FkUk
	 uo2JlGE7/R8chK1IurUWQFGLxBkEqtd/DoRyz0p5UC/jUIXZcSiiU3CWNREme2yiIO
	 DsMQ2mtscLyou+bOE1MdCDIqRJ8RdvGUz0B4cqU8/usFZxrOA98+OXTc1M3OmnMvR7
	 KK7HNKHh34dWQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C95F140409;
	Fri,  6 Dec 2024 16:46:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Saru2003 <sarvesh20123@gmail.com>, bsingharora@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Saru2003
 <sarvesh20123@gmail.com>
Subject: Re: [PATCH] Documentation: Fix typo in 'taskstats-struct.rst'
In-Reply-To: <20241128063857.7377-1-sarvesh20123@gmail.com>
References: <20241128063857.7377-1-sarvesh20123@gmail.com>
Date: Fri, 06 Dec 2024 09:46:16 -0700
Message-ID: <878qssu5d3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saru2003 <sarvesh20123@gmail.com> writes:

Thanks for working to improve our documentation.  There are a couple of
problems here, though:

> Corrected a typo in the 'taskstats-struct.rst' documentation. The macro name 'TAKSTATS_VERSION' was mistakenly mentioned instead of the correct 'TASKSTATS_VERSION'. The corrected line now accurately references the macro 'TASKSTATS_VERSION', which is defined in '<linux/taskstats.h>'.

Please wrap your changelog lines to a reasonable length.  This changelog
is also a bit more verbose than it really needs to be, but that's less
important. 

> Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>
> Signed-off-by: Saru2003 <sarvesh20123@gmail.com>

You should only sign off the patch once, and the signoff should include
your actual name, please.

>  Documentation/accounting/taskstats-struct.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/accounting/taskstats-struct.rst b/Documentation/accounting/taskstats-struct.rst
> index ca90fd489c9a..acca51c34157 100644
> --- a/Documentation/accounting/taskstats-struct.rst
> +++ b/Documentation/accounting/taskstats-struct.rst
> @@ -47,7 +47,7 @@ should not change the relative position of each field within the struct.
>  1) Common and basic accounting fields::
>  
>  	/* The version number of this struct. This field is always set to
> -	 * TAKSTATS_VERSION, which is defined in <linux/taskstats.h>.
> +	 * TASKSTATS_VERSION, which is defined in <linux/taskstats.h>.
>  	 * Each time the struct is changed, the value should be incremented.

The change itself is fine.

Thanks,

jon

