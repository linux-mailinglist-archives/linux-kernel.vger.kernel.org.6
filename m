Return-Path: <linux-kernel+bounces-445100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29319F1140
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52741883F79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B51E3DC2;
	Fri, 13 Dec 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="g5agXLge"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC91E3789;
	Fri, 13 Dec 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104736; cv=none; b=SqRHrBwvVAzdaI/dZPaBuo0QM5To8zl/Pd5ZtoBGHDn8aJP4Y6q9YqU9w1/flyzK3is0oVSLkZIkvU8+Vwa1Yaa8E3O9QaydPur7nZcIl/q1HZ/qj1lcLnCWaQzitlxa9vfh6KC7hlifkFXCQZuZcMSKqbaHc/pehsO+lFBSJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104736; c=relaxed/simple;
	bh=xWsyGA4ZYAH7V0y/q3nVTrZNG3guIakRZh9+7Q2dHD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KjFw+TOxWeonEdH878y7g4FT0zR+eRKBJXtRnNZU+phLk2q0r8qIXkslGf8RJIbUNX+OfuySHASCHlVVEyJjOH5njV0bqBZYtdhGwPV+FcT/TzcarXGBDh7cj+3ozsoKCLbANfUQkg83zeA3Vy9EJgxbRmAmEl/JBRuhnEzYVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=g5agXLge; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 276C3403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734104734; bh=APGEPC/cOujxi0mMe6Tz0MEaxQJvkiiuP9/dhDMpykI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g5agXLgehgR55GylxvWLy9BBpqXwIX/7UPergJbsOz36RBQjkq9ofGcJvd8QEltrd
	 srheNVmyVAAAvetYlWDsn2zaDYPjLNs2gI3x2x8qkwSmtuCNTmWPyFhoUwZRygLNMg
	 APjTUZA9t1sX4585M8+8mHVBubQdQFYNKaWMGaYPs0NEampsUybkt+M6mZQgh1S1hc
	 BY+VILbZpaGNBR7UUeQ2CG6um6DPucaSoY8TeocB8xGrvGJe2rHdOFojhQ/N7ibzWP
	 p+eS3J7OFurM6JaTOZBKvZI5S5wLjINgNaQc2SVGOw4NJ+fHpOkEuJfeSTcgRuwS0Z
	 yn96Yn8zFaREg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 276C3403FA;
	Fri, 13 Dec 2024 15:45:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Saru2003 <sarvesh20123@gmail.com>, bsingharora@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Saru2003
 <sarvesh20123@gmail.com>
Subject: Re: [PATCH] Documentation/accounting: Fix typo in taskstats-struct.rst
In-Reply-To: <20241208083320.16190-1-sarvesh20123@gmail.com>
References: <878qssu5d3.fsf@trenco.lwn.net>
 <20241208083320.16190-1-sarvesh20123@gmail.com>
Date: Fri, 13 Dec 2024 08:45:33 -0700
Message-ID: <874j37y4bm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saru2003 <sarvesh20123@gmail.com> writes:

> Corrected a typo in the 'taskstats-struct.rst' documentation. The macro
> name 'TAKSTATS_VERSION' was mistakenly mentioned instead of the correct
> 'TASKSTATS_VERSION'. The corrected line now references the proper macro
> 'TASKSTATS_VERSION', defined in '<linux/taskstats.h>'.
>
> Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>
> ---
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

For future reference: when you send an updated version of the patch,
please mark it as such ("v2" for example) and put a description of what
has changed after the "---" line.

I've applied this one, thanks.

jon

