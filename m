Return-Path: <linux-kernel+bounces-174361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E58C0DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3402E1F2185E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094014A636;
	Thu,  9 May 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="P9MFooZ1"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C45101E3;
	Thu,  9 May 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247622; cv=none; b=ks+lyAcah9yx+z6gJ4iA2/ws1ZRcJHU3iMWImVl0KSjg4RfrvYGNor8P4isqBB+kmt8LdNVg5H5tGRq//sYoK00pUT2F7bHHQmZRxk7FGFidKUdJ6KX8FZPcc5v0fWc/wkfQTu5MorEx7ldtdzrT+kbEkRGR5EzNhAe6X2qHNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247622; c=relaxed/simple;
	bh=PLqcAN8ylArfPy5ldczpzKsQ/Yhs9FiS8nAfLWVoAV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bj6srfD1UKq/ofAexP3j7pDQjy8IYJ0EzxwADP+NSMK4kmES6OmiVWv5ShOdd67bEQROACs4Wl9UKQdfhasKS+bKMFqUzmilD5WJQcHUY7zRKfpLJVv8CLGBh5hMnikNoHQUbxgXtwR14UIJF5P3E2GJFtgU/9xKSIhu3SpSK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=P9MFooZ1; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715247611; x=1715852411; i=markus.elfring@web.de;
	bh=6erL+CJ4MEwWtXIGFAdsov7RXqeTqbfmoi4OzhKygbo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P9MFooZ1Wqu8Em+CFbA5PJTLKKvz0WpStWS4rWbwZOUPQsNzFU4o9mms5ve+nvvM
	 W5KXE/Og0bKo0AmEme2KaUmRK1OzyMlg+GygKBqjR/KlR39MUjCjZ36v817GKkHXa
	 LALzfKs2sDARizsu5cTMe8+to5YPJCN3sPVhJ5cKj72XncBDdxB0bkm05JNLRy2xf
	 Fb51fiTw7xIgusC0HJSq3Bytu9zm9E5lTnFZjaXoPb1DWsTV0NlPp5DdSSDoWbYDY
	 ZClhN9b35Zg2w1EW2op2932LWREX5iVCr2tlC3GtvXztyfwDNClM0TlV5n+Apr8yv
	 Nu/lvztd3PD027IW3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6pf-1sopqG31f5-016gBF; Thu, 09
 May 2024 11:40:11 +0200
Message-ID: <18e3ebff-8993-410a-867f-0c84b9b4aed4@web.de>
Date: Thu, 9 May 2024 11:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] time/tick-sched: idle load balancing when nohz_full cpu
 becomes idle.
To: Yun Levi <ppbuk5246@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240508192213.31050-1-ppbuk5246@gmail.com>
 <a407d12f-6845-4f51-a112-6bdc17641ff1@web.de>
 <CAM7-yPS6ecODhv-FQpYE5OE_LufmtKRg4htp9JH6MBUF03N4rA@mail.gmail.com>
 <5886464d-a867-471e-858e-b4ed732a1d76@web.de>
 <CAM7-yPT7z6phHOUVOMxebRxiqw6un1N3hQK6O2AeRfmnJhK4kA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAM7-yPT7z6phHOUVOMxebRxiqw6un1N3hQK6O2AeRfmnJhK4kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VJCrJve63aysRIr3OKSw5877IVAPEWuDxxp8pJ9t5Yd2XCdCM0/
 BA3VtWX+DSPZ6Bnxx+Xd7JGkVTdwDITRIGk5OJePFoniOUzIDLMepnbZLQAjiZaYJGVoeIq
 8xL7pN0zBDzgzlVU8voXV4ftiW4gqYAIFDAXkbxIsRoJqeie5DncfgW37POqoaQrHksEe82
 eqDpRpanI1Tfh2bcXJ96g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+PhBIwKqQb4=;3X2bBdyy7d+64fKrECW3jxmelDp
 309eeMfaPQYhXQSwsY7xbdIU9cAfdSI+kW1BaByelzGJ44mGYfoTX1mQZ+KWxpbVyRM+TLVXV
 SC3y0BWGgMAex8rGh37SUxKI7Zp2r0J3QXX3MtKRpB7+TQ2F/czPgpvt9tyB69MQ3nHIJXARP
 yNAvGlz1LJ8+aE+07Xpw4HyfEimvRL3T8OOa50qL7D9wKU+0+AyHK5c/kzT9UIZzGlHrlEK+d
 AHQOW79DFosPVTJkZVb0WWJLJP40eeMtQDuHQjzo+Si6lDlC0UBy4EbdFevd+VVHfkUp8Pkln
 Pt5nxS97kE8XECsGrTO5QrQ+I5EAeeCfDu9E38cJwZChUgKWvnOTpVijMJDrblLQ4hkLMPKil
 VQGef0YEG6gJvju3RlgalaG5ys1tpvgCqslYE0e9jriJHYB4mJcPpAeMDXgXI+qVv96H0xoiG
 3VwMLEANYvrgD4w3q5d5Ymyz9rHmuR+SZJCwzTdyClmha+YbZlKYylrMnoXkauNoBcSyYOuyU
 XHO3KErv0fedG6eI/qfemKAoeA0L8kMMrzDlUFb4t54lHFFayf1x5lyueDN0MJoSidciovv+Q
 l2/wUl+kmxRa62kWhiC4svtuNDnYSDy35huA5m5l4WT0GNLRCoikAcoIkUiunyb+kultCbMyz
 6i3btsTJkR0N4kek6gG0AjbD6TzIgih51h8ur8ESwPNroKN8aaHux8JMfx1kbfahsjVuLCJRN
 MBFolp1T/BAksmbH2pyCwwoSI/Q/mLrJEFBJwDp4Cd+yrPtjLWf4fv0KOiCGNwthQ5L9ibWkp
 Z9rbjVW64EZ3uo2KQqdCzhWRwXDj0M/XlPM1o+jrpKo2s=

>> * How do you think about stress condition ordering concerns around
>>   the system configuration =E2=80=9Cnohz_full=E2=80=9D?
>
> Well.. regardless of the stress condition, it wants to fix the
> inconsistent behavior
> happening when enter "idle state"

Were any special test cases or related analysis tools involved
in the discovery of improvable software behaviour?

Regards,
Markus

