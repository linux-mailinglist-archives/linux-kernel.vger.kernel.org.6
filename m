Return-Path: <linux-kernel+bounces-516333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB2A36FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5335C7A4540
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26F01E5B7C;
	Sat, 15 Feb 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aDjnA9s0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A31EDA0E;
	Sat, 15 Feb 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640289; cv=none; b=Z9jC77WDB5iw8GtKi7rzAHjxyrK595X1KwJ77J7ddsdpox10VRMNZyI+PD1DLqIiD58OOSaPCAik5nxdMiV2QCMxyBf5oCvox/uqefW8kZgE0mZ7BmCx+OK2MIHS9g/AF0J81cSu7DkmPY30b4nuaSGtOhuW89l3Y8m55qgRsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640289; c=relaxed/simple;
	bh=zQ4Hu9V3Q1RlwIFXw2CbMDOEByVx4aMYdTSjK1ps8Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AUy2jF0kKTTC0cRUQhbsbA+qjdDiSfAJI2mTgayEtB6Di+aT/2JzW1uhRzsJYLdpIBV0OIF1phMiBN3/i2mJAX9OX6GDqGA/KmVrlMN8GHHAz5U3y96aRQN8p+fjGdeSX3OyWkzq4SBtaj5hYu9/ACRyNtvZcTCpScVMeE9ib1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aDjnA9s0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EC8AB4119F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739640281; bh=0eC5bOMZ4dF5H7XdlMIGeLpjcaa673cbKA7YmBjcdb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aDjnA9s0iapDX+QoDeSSUqXalOHNGljCRta8kXQx6lKlkt83APELt6ZIjywlt+Ssw
	 a2DEm17/D3Cg0AlwajlYMjzGhAPJIuZ4lh+S5WXvlVB26MbNIScHrURPNxz7sDuk1B
	 FF5aUmspJ3Zn7nyvYKDVr+EeUOZy5oAfjCjwwTUCjrBJLTeLPFDRrCSHd6w/d1ysY6
	 Kzl6UciMAbRGM4bnEfs0PFwhWWn7hp7preUblDHacCt+YRQT/xKQ+yxQBKbT9Lug6T
	 AIw7BKvC25STNp/dZYmoPVITEGyGfRlmGTdPUDVkqis0+kTACpPPcDMiZOWrUmunsV
	 /64NmH/NqFBDA==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EC8AB4119F;
	Sat, 15 Feb 2025 17:24:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Suchit K <suchitkarunakaran@gmail.com>, akpm@linux-foundation.org,
 skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Documentation/mm: Fix spelling mistake
In-Reply-To: <CAO9wTFiZ8wyangitV6RZLYiL5yF5CV1eRXYYzJKhXyP2UvGDJQ@mail.gmail.com>
References: <CAO9wTFiZ8wyangitV6RZLYiL5yF5CV1eRXYYzJKhXyP2UvGDJQ@mail.gmail.com>
Date: Sat, 15 Feb 2025 10:24:40 -0700
Message-ID: <87tt8vunmv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Suchit K <suchitkarunakaran@gmail.com> writes:

> The word watermark was misspelled as "watemark" in the balance.rst file. This commit corrects
> the spelling error.
>
> Signed-off-by: Suchit <suchitkarunakaran@gmail.com>
> ---
>  Documentation/mm/balance.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/balance.rst b/Documentation/mm/balance.rst
> index abaa78561..c4962c89a 100644
> --- a/Documentation/mm/balance.rst
> +++ b/Documentation/mm/balance.rst
> @@ -81,7 +81,7 @@ Page stealing from process memory and shm is done if stealing the page
> would
>  alleviate memory pressure on any zone in the page's node that has fallen below
>  its watermark.
>  
> -watemark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd:
> These
> +watermark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd:
> These
>  are per-zone fields, used to determine when a zone needs to be balanced. When

So why are you resending this patch - has it changed somehow?

As long as you send in HTML, your email will not make it to the mailing
lists.  Please configure your email client to not do that.  There are
some suggestions in Documentation/process/email-clients.rst if you need
them.

Also, please include your full name in the signed-off-by line.

Thanks,

jon

