Return-Path: <linux-kernel+bounces-207378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3590164F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CBAB20F4E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D16446AB;
	Sun,  9 Jun 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mLG6eW5Z"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC05258;
	Sun,  9 Jun 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717942084; cv=none; b=ZhjXb/rWwVzXVwijYJE5anURTKUih2EXYHRuwmj7yoHf80HptOzGbuYZOSDGviZ45CtHPsi4SATLXTaUQKOVrnFMw5AmqREwnxH0uf8oe+tsQ96Zt15r0gvvEu4d8x/t6cNBfIWYIgnKyUtQo0LSDTeWtGUpM30j2p+azT9y+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717942084; c=relaxed/simple;
	bh=OBxLFjmBv5Y1bDFc5KIIMYkCmQY5Bu976Hj/qpkXfiI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ora4sOVQ4FDeFMxPoEST2v4opEbiFCPSTKQcejDs9QuY3Elz2eP6s1qzfcdt/K6Qa/CgWIhFLx/kNlvuxi8JABoaIbEACv55eDArwyoq8VMIdAFAA9mvFp2vBW2I0O23W3KXRg3BbIm1TRKRp7sNMtRJDj9FZy7jQumXuiiPSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mLG6eW5Z; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717942041; x=1718546841; i=markus.elfring@web.de;
	bh=ZYc6ViqrmU+5mJe+gq/gz48E0wJG1FsE0M6nt2ykiS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mLG6eW5ZLwDVlW933fYXZTqHYdugG/gYiuVtSYKNGN8i9K+1Jura0dlf5+58RAgW
	 8OxdpUcJoZHM2CUgAp48zsTGW0BD+8mTk4pE4diilOdDeAJgKtzcHjH1TL38kYfkH
	 u3Y0D2zQiqCwVSWVaXgE2PZ72ijaahSXNWxG2Vhkvms5f19vKFYnfsaPNgeEZwIbI
	 TQKfoaSoXv+ng1GZeyyH6TBxsV6ERM6G8bL7hdNalriUncVsVjlKFcnvmp6qdDi+4
	 vYrnMop5Eq0i2TkATHf1MZPUexhnSjNQVosWKX8qi8+Vege8+VsWRQUlqdv/Ck+xf
	 yAHVNNfuzXW8YgSPww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHWx-1rswnd3yJ3-00LQdr; Sun, 09
 Jun 2024 16:07:21 +0200
Message-ID: <85e31039-15ee-416f-89fc-a018307bc7b6@web.de>
Date: Sun, 9 Jun 2024 16:07:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Qiao <zhangqiao22@huawei.com>, kernel-janitors@vger.kernel.org,
 Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240606121133.2218723-1-zhangqiao22@huawei.com>
Subject: Re: [PATCH] sched: Initialize the vruntime of a new task when it is
 first enqueued
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240606121133.2218723-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gQloGkDdGamf40XcJqdP+/GPIiZ0zAPzjglU3CwQ7ifISUNyeWZ
 jTD2swiwY9ZRM9lWF7g6jlqHsNrtZ4CZ2EVB9QQIYNqWCNHw1DjFcQYs2DBy895JYonfsvP
 IPJIcX+irmEs+y3p9c8Ck0cLkrSgVOHRfS8x9aGW1OmUYncFAIGpS/VPBp/nBiQml2JIShg
 FFs/qjHCYEJo7kiGXeKNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jFA0np/W/f0=;famAjMx3WEWs2eRGOOmCmCvUQ41
 6WY6ikmPfe5ruKAhQXoIxV9tzTBJY+k7qrt3n/relM0fThejpt4HBMvpiTFKmzyT88vcJPTvD
 hlHPK8AJhPK1e4GAgAxYNdavgwamkg36i7FfNs2RwAOhhKdMbDfQi+qaS78JOE5ElgOSRz9Xg
 k7XmPxGCh30Be/bI0cczg1twhpBoNNqlV3ZApxA8feWkWs28tffmHTncX5SpLoAJVnGw2IhMm
 /WNZIWH+psKMDcj6PCniBKrbekCmQM5DXH2AYe0MRcQa/tflXenBYxXERddGRmQCR6+1ltAFe
 me3Kt+Tzdcy7D1sY3qvuebhw4GN3IOvIC/aowt/9szWm1hDxfwa5PGLVyx3SZJwAnQpnfqjJv
 HZ+naZBkhyN5CLuK4mTcvfreLigeINWO6U5L0Rhf0/RVsn67Mzd2hY57MkQHwFq1apd6Xu9oP
 9eFJiKW7ptJutBfzsjYGFfBNAvOJraJOTmLFs3cRah63NEzNFdPdi6rmGNrJ0ku4s96/Cg1Jz
 Or3HozKvktqxPYavtRySYvEdIsXZ2WvLYR61+1w/0ZgXMsIs2KOFfeyk1UQ3E03He0CbwIByi
 T6MtVK3IwwbjAYNEcwycfOwjYrqCJhI3rak4Sw5Sn9lER0n9Th7dMLs/blBqQSUEh6yB2nj/r
 hJRM91h91PLWfG2HiJYyoB+KG0PZOgGpAExmQxG/t5+MACQQQMJK9YJBopTDt3wy4ycYT0zyL
 xHuKRTiW73/rh5Yb7/am/8Vpn3qRGSmnSgFBa4fLTBL71tSAqt/emf5yaV96+3pGINgBv/W0M
 lp84TzczjwNj9114GalgDCwwztbw0y0EGR2LoII0T71Lk=

> When create a new task, =E2=80=A6

       creating?


> Because it use current cpu =E2=80=A6

             uses current CPU?


> To optimize this case, we pass ENQUEUE_INITIAL flag to
> activate_task() in wake_up_new_task(), in this way,
> when place_entity is called in enqueue_entity(), the
=E2=80=A6

Please improve such a change description also according to word wrapping
because of a bit longer text line lengths.

Regards,
Markus

