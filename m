Return-Path: <linux-kernel+bounces-245111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106692AE7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63A21F227CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD7446A5;
	Tue,  9 Jul 2024 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="M3I33o1D"
Received: from resdmta-c2p-566137.sys.comcast.net (resdmta-c2p-566137.sys.comcast.net [96.102.19.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57894A15
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.102.19.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494804; cv=none; b=EZFC7Om3RgbzEHkSe0XLHShNrvAke4m56mE4ago/C/H8oYJxQ1MBfbw75yoQLnyDR1jnEt+52dnFoM6s7V1VOaaFz0c5ai0queMCsM8k34cAwWrWMBHUYvuer6pVT0puJwgVQlNrL586u3DMLFNSLL9U++agq9QSsAuX04LzTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494804; c=relaxed/simple;
	bh=Rrb8+ibnnMm/HC1Dj1A7wiyNXZZbkqhbN0VkLhkbv4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hNGU5QeTuDNcoO9hO/vmW2HLjrykOq2j9daolFSJfJIiRjCgPcwGo1YGKeHjKFElt0xCVZ9UqNzRbag+PahK7CywPF+FffwMNPDWkAaADiFKsZLv8pVPfIXqie9yqjrUUXziRkcyHHGjsPu+W9x+qNbwQynKWvCIAaNJvhcNW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=spacefreak18.xyz; spf=fail smtp.mailfrom=spacefreak18.xyz; dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b=M3I33o1D; arc=none smtp.client-ip=96.102.19.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=spacefreak18.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=spacefreak18.xyz
Received: from resomta-c2p-555955.sys.comcast.net ([96.102.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resdmta-c2p-566137.sys.comcast.net with ESMTPS
	id R1E7suPrmAKPiR1FesJOFj; Tue, 09 Jul 2024 03:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1720494646;
	bh=Rrb8+ibnnMm/HC1Dj1A7wiyNXZZbkqhbN0VkLhkbv4w=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type:Xfinity-Spam-Result;
	b=M3I33o1D4MKqrgrY+/DajoOmOSBcLYVmw7THJtiFx5qK3S17QJzfFL1GnLCvpLUIE
	 bd4c9KwZ9aLqM5bVA5oeI9QcxmPAkqYzoUbUG93rcd9Pqo3QiwuKxXSvSQwjAMlHHU
	 EznV61wLErqub5AjGOThvoFyTM+UmmWrKbCz/fvA0neAN+5gcfJUPdKfV3PnMo2N0G
	 C5NPFV9LSViR1xRLDE+Fdfjt1fwvYeC8wLOOW7ozATfYqcmEAEZTMxj6u3OgHbddt0
	 osRe/sryQ5mNfLpJB/CzP8fIJzWt3nzTSM9sMjZ1fuS/Mt2NVoxwlj2pDH6IdS7Gsu
	 E9HYJdLsVg3ZQ==
Received: from Outgoing.brak ([73.233.191.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-c2p-555955.sys.comcast.net with ESMTPSA
	id R1FHs8JKbHWxuR1FIszQaj; Tue, 09 Jul 2024 03:10:25 +0000
Received: from ZitZ.localdomain (Linksys01880.brak [172.18.18.227])
	by Outgoing.brak (Postfix) with ESMTPSA id 54EBD9885;
	Tue,  9 Jul 2024 03:04:23 +0000 (UTC)
Date: Mon, 8 Jul 2024 23:10:18 -0400
From: Paul Dino Jones <paul@spacefreak18.xyz>
To: jikos@kernel.org
Cc: anssi.hannula@gmail.com, linux-kernel@vger.kernel.org, 
	paul@spacefreak18.xyz
Subject: Re: [PATCH RESEND] Interpret 0 length ff effects as infinite
 (0xffff) length effects
Message-ID: <tuzl6nthh6ieab3wiwgn4qli4pxd4qycxliy2bnrjewevm6umx@xtdxo5wvpq64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2406040954160.16865@cbobk.fhfr.pm>
X-CMAE-Envelope: MS4xfLwWkqFRKmk+JResms8wJntCdLma2aFuC0i3k7ww93eRxFy9xczYGqFDpGG5OWZOJ4ChRUJ521GAnpsgPGGOVoCvkOl577F/N/uYUFZDqRKi/AqwHoeT
 h5xWmkdVOXUe41hJrh2QcClzKAVlocwlm3tRKRelrtvpTDgBZOBwc1K2J7/LUET8gFeJQqGKd16DdHdax2r4srfinnwwhZf3UMrn/WvckJMGXe5VA66iYY3v
 Bscf9BvIZzUGNPP5Er5Of2XlwcxrtZvBgidB+C1SgfRa7A2U5DcJ62TxiDTJEHqX

Hello, and thank you for getting back to me.

Without this, a lot of wheels do not work with proton and wine and other
software.

A lot of the community is already using this patch or other similar
workarounds.

I can't think of a situation where sending an effect of length zero
would ever make sense.

If you read through the first time I sent this patch you will see a lot
of the research that went into this.

https://lkml.indiana.edu/hypermail/linux/kernel/2210.0/04133.html

- Paul

