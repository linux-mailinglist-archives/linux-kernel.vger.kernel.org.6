Return-Path: <linux-kernel+bounces-252062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FDC930DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECA21F214B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309713C682;
	Mon, 15 Jul 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tcFF8O3C"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C13139CF7;
	Mon, 15 Jul 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721023061; cv=none; b=VGZQfdg8Bz6uqsbsU60lUhuUVWMTlWFcgXSPPS8Y9srpBMqzN8mxe/0hiFbghmphjLY77PjISO5dz+nn44C1k4H8RNKm3MhGMq7pED2dGuVm7XrRn05/Efw1ec5kbWsCobN6bb+L9MU94iMdksI66zKC+el7C6+DzA+8XlBf+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721023061; c=relaxed/simple;
	bh=jejlM2MUECGwRFBDGbgLxK40TVh9teiMJBMELQIWGes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hE7vfxajhGRhd9N69dcbYen4ihY97irpr9Yk4LEWg2zdp3nCLUZMhez53VpbFP6UZqqLNdo0IUlfeh9uzMuVLu40Gt5h+xk03xa43RH9/q3vyZl1J7k5pG6ZyYqtGseje0x4XHDosjVjY5Bc03Sg5s7AEapeW1YT+Rc147brQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tcFF8O3C; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721023044; x=1721627844; i=markus.elfring@web.de;
	bh=jejlM2MUECGwRFBDGbgLxK40TVh9teiMJBMELQIWGes=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tcFF8O3CV7FfYUIg5gFavv7e2yMp50zBXFQu6KiUVHM6AJAGuVsTRKrRVC4wUFGM
	 f7t75t0Uf/bxYgXF0Vk4DjVVaDKUwhbC9lql7HZr0xbimfOiKpe7cEjIVRsUoSVQp
	 Mt3fGGwaeZgGqFHyDXATQ8xZp7OB2t0PPNZUx13BnKcNXbtcNYuyLkDlFjyr+R+1N
	 z9Mp0o6lJ5WiTVWiVuvSnzqNS8jbqpAQjYD5z1nqKkQtW+zOKlKGneMkSCi3XK3Z2
	 SOBshkAqwvP70HVk8WZZMV91/eYiKVEwSrFwQO45HbFh3vq2QfY1CmGIm/6t3EE8V
	 WuqlwhBBH8+PosKktA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1sbBL70L7V-00ENlO; Mon, 15
 Jul 2024 07:57:24 +0200
Message-ID: <32c1c251-6ad2-4009-94f5-cc72f6f49e43@web.de>
Date: Mon, 15 Jul 2024 07:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Use seq_putc() in two functions
To: Steve French <smfrench@gmail.com>, samba-technical@lists.samba.org,
 linux-cifs@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>,
 Tom Talpey <tom@talpey.com>, LKML <linux-kernel@vger.kernel.org>
References: <18310e20-826f-45ab-b69e-dbfe47a1f83f@web.de>
 <CAH2r5mvbk6OrX59dybJvS=ANdzzidsj=rDzRUFrBrjff-upSkg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAH2r5mvbk6OrX59dybJvS=ANdzzidsj=rDzRUFrBrjff-upSkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:j1h2pwY5bpDxwy4B49KhDZS3F8MNhzv0vLl2gk77oYeLt7FK41J
 3xpI01CNQmh6J2G0vyCOIkl+fwH5Ln4oDf/pD3vW2bxOctIKYDaqL9iTCo+gThdYBGuaLcG
 g7GXzht86PV92LYAnHgGOOiAjsG9AVnq5Z9QuWR0/EtDDK0iC7FpEhuhtCfdcqLgwLiAg09
 QmEL9aVRWtOh28cqPxN5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZpdWg5RYreY=;AZnL/S1OjuXIE2O8XQk1tCoRh9y
 CqjNaQGTOsJNmwMVS4tM2kHriyKimFJsK3r1BDkPfrVycwJMtbj1iEOrLPQl94fx7MaRdhEhV
 tAreioPnwcgzUM/EiBSJ05J+ZyxhBsnwxBydPMy7LCn/len2OlaptGQFtKdU0ynXZRV/iW/zc
 iiOyrRjb/lg7q3iWDG7dnLKsjCmmcponByFyqAkYel+03h+kQNbk0xntycQA3uTlEWkWZ2GZe
 vMt8jabB3ag7W0QuJXxc9Tj4mqrSgudTTmLllfMVHCVlbYxUubtMn8575iOcQyrXlwm1rcNYw
 i2JUkbxzEt08iJkjAAC227WfF2uNRXY+e20ZgJZDaUWs5OHyFqSXgjNW16fDdSt+GThlwZzrh
 SvlyK+X8tI/uXupxUoNFm8xtL+HInRl3+aUZoe/J5JqTcu1e6QiR+1Oh2Se0GWpnZHmRcCnfq
 oGVXvouEIM02+btLKXR9Abj6c6xhYNxHP2UvA7H6FFG97B/o2be9zYEgGVrd0ZNRdh1G6nWcF
 yZ4/HIG71ImICf2W+OrOj9b91kza5WRqvtYQQ3KiqyCnA88yY1bknF+rqm1dyN7UgAOdljBEj
 CnaS25wXVfFpKzAo85M42TTj7islx34UF5U2dh2CWhScXWTV4oPNoIjS4wWOkTpiWCoZehF1J
 CvSbqFUrOIQYSKwTK9BedCzHvRjs7FZ/NrAtobGaw4gRUxgcK0YATToXXZbPxScUXf4g96s6A
 HpIPe5ECkAoBmckFmLB1yktyQ6j7ulNzcsE6qOGKz/zmG+7SNMVInjFXdKKSVVeUJepjikk83
 Xz3rwtXH7TDvR5gvKyqXDGwQ==

> are there other examples of modules where similar changes have been made?

Similar source code adjustment possibilities were presented for several software components.
https://lore.kernel.org/all/?q=seq_puts

Regards,
Markus

