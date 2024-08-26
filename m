Return-Path: <linux-kernel+bounces-302306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797395FC66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229D828736E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA619B5AA;
	Mon, 26 Aug 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="B4XIXZsx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD2B677;
	Mon, 26 Aug 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709907; cv=none; b=ce5+GRD6kbIqq86aGbT9iWGtNjBdT86bWhpr7dlP1RU2EzV1mt9fVfbZN/f1Cg2Wrq0YeHh6Y+Sxetz4GXXnFbDtiVricC33SVBFGX++VYKVvkKo0CNn77yI3wO01k5yUL7o2GuQQRWKu+KeWnMfKQXKR95lB3Eu3v1LlBjmZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709907; c=relaxed/simple;
	bh=IjWHayed3Xgh4hwDl1NCds3zOOOL6kh3/k7gtzqmLvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQCTm3ts2fvfRsY2AiSYmGSWrKqii6LymvvJE07/FJcSDaQcHhI0GGmgIX9aVljB+Oxvee7ZudhYPHeR+gnYMtlOKXJcg+Y3Pv67pe3O34X9L7lkA/owq/7R6AOXOuWN7LCv6ookoUwnWsECHS1f2DhxwrltIxK0NO8p/YnkDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=B4XIXZsx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 19F6842D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724709905; bh=O93izcclSQSIUW8zW2pcpoIRD+yumVSK2HWs8pc+2tU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B4XIXZsxP+PU+G7gPomS4if8ja4eSNQOFm0j68PxTGZr1SBQIJlT6Rhuy5LUeFwHd
	 4gekqPs0g000kwWVpw+RBqIWDPR+1cm+lurF+MTfl0WAk+kcxAKx4vSjBfmYqKR9pp
	 Oa2/1nzvNSKFlNDQphcJq6vwGf+QPRvYg5HxLUFwi3WrlQ1tXFCnOYjxP2D0jHKTzJ
	 Cw3JamJoBzTPBGgV3fP7ZMH0fB01CfGhZDikdt5KD5UVLkPxmc1WHtWKboi8ilpx/5
	 gC6Ob9pLWemi6jPpLVATCbC89A8cGfWK1buijSKo6FnHq8HNn9CKh0YJlsxGhGSCEM
	 uKlBq5m5qGDNg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 19F6842D39;
	Mon, 26 Aug 2024 22:05:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>, linux@leemhuis.info
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: Re: [PATCH v4] docs: Fix grammar and phrasing errors in
 reporting-issues.rst
In-Reply-To: <20240816104902.123452-1-surajsonawane0215@gmail.com>
References: <20240816104902.123452-1-surajsonawane0215@gmail.com>
Date: Mon, 26 Aug 2024 16:05:04 -0600
Message-ID: <87le0j54a7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SurajSonawane2415 <surajsonawane0215@gmail.com> writes:

> Fix grammatical errors and improve phrasing in the `reporting-issues.rst`
> documentation file. These changes enhance readability and ensure the
> accuracy of the instructions provided.
>
> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
> V3 -> V4: Adjust line wrapping to split the long line properly.
> V2 -> V3: Re-added the fix for the line: "That's why you might be need to uninstall the".
> V1 -> V2: Removed the unwanted change to the line: "try search terms like".
>
>  Documentation/admin-guide/reporting-issues.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

So I have been trying for a while to apply this, but have not succeeded.
It has a number of weird white-space errors.  For example...

> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 2fd5a030235a..d0e645fc845a 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -56,7 +56,7 @@ developers. It might be all that's needed for people already familiar with
>  reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
>  everyone else there is this section. It is more detailed and uses a
>  step-by-step approach. It still tries to be brief for readability and leaves
> -out a lot of details; those are described below the step-by-step guide in a
> +out a lot of details; those are described below in the step-by-step guide in a
>  reference section, which explains each of the steps in more detail. 

There is a spurious space after "detail." that makes things fail.
Fixing that was not sufficient, though, there are others, and I don't
have the time to figure it all out.

Please go through the exercise of emailing the patch to yourself, and
get to the point where "git am" will accept it; then resend.

Thanks,

jon

