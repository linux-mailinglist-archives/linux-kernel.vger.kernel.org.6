Return-Path: <linux-kernel+bounces-545002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C3EA4E7D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A555617F2D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F22857F4;
	Tue,  4 Mar 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Aicu2jYL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775232857F5;
	Tue,  4 Mar 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106450; cv=none; b=a0XipNHicHKiuk+ST1nCvSRHlgqT3UHj8PswHZf8552z5/E0nFL3wQoeqy+Uhkk21pNzUaFJpPOC4Sgmx7LiTr8xiBte2WK7nr/5UHfUWiKQq39LMd9g8TlupPQhMXTvDEmgpxxpIzzxaXIGG/YFa+pqEluassEOY2PcRCpWUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106450; c=relaxed/simple;
	bh=RsNPYWFwHjTlm1NWDwO6UoTqu0ODn/vHOK9DCu5N0Ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDdyZwizOrWXmucB8bVUWPIGFX9cg+W2glT0ocbq6bOoFEGpMCPlax3bCPoItlAXjhUIYU2Q1abN1WtLSkGUFSnVkRYkyFF9QGARoaggmk5JyEJ8YyCEm18pXKRIbdcj05SsMBWVoK5Odn+rfgFxhT/dB6WoIQn+E7C3kkryMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Aicu2jYL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8674C41065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741106447; bh=lAoWBHoBJyn4sQVBc23B2+fS0Hrl37i8VnRYxHDo7+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Aicu2jYL0KqjdC8O/g/aeUouU1rGJBWKb+9FqIoZLODmnmYqPodpjIVSVSnOsWc5L
	 PhoKpDuggxhVkxmCW4sb7dG9kogH0IIeXBUO+PZM63sdHTDlroQCWJWAO1aEAjaecP
	 9eQ00MRTZuBDGSBs1KCjHcgKKMpwpSs1aHuQ6RvgK4spD3DLSVxJKi/+5jboabVZhp
	 o04UbPO0MYBwjrI5QCITvPeMWe03E2RxooH7PQIgsRboXRyR7fhBsDHYklEz02Oseu
	 rXhYFWUaXPml378YIavV1+Ziz46FdvptXSkoH7rbN7hSwSBkoQbX+osgxNXhj9VKAc
	 4ZATCoRmTP2tA==
Received: from localhost (unknown [73.243.92.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8674C41065;
	Tue,  4 Mar 2025 16:40:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, Suchit Karunakaran
 <suchitkarunakaran@gmail.com>
Subject: Re: [PATCH] docs: debugfs: fix spelling of "failure"
In-Reply-To: <20250220171903.11321-1-suchitkarunakaran@gmail.com>
References: <20250220171903.11321-1-suchitkarunakaran@gmail.com>
Date: Tue, 04 Mar 2025 09:40:46 -0700
Message-ID: <87a5a0eokx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Suchit Karunakaran <suchitkarunakaran@gmail.com> writes:

> Fix a typo in debugfs documentation where "failure" was misspelled 
> as "failuer".
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  Documentation/filesystems/debugfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
> index f7f977ffbf8d..610f718ef8b5 100644
> --- a/Documentation/filesystems/debugfs.rst
> +++ b/Documentation/filesystems/debugfs.rst
> @@ -220,7 +220,7 @@ There are a couple of other directory-oriented helper functions::
>  
>  A call to debugfs_change_name() will give a new name to an existing debugfs
>  file, always in the same directory.  The new_name must not exist prior
> -to the call; the return value is 0 on success and -E... on failuer.
> +to the call; the return value is 0 on success and -E... on failure.
>  Symbolic links can be created with debugfs_create_symlink().

This was already fixed (along with several other similar mistakes) in
early February.

Thanks,

jon

