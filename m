Return-Path: <linux-kernel+bounces-276743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219D9497DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1582827E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5D7E0F4;
	Tue,  6 Aug 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lqGPTPBg"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7181AC8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970629; cv=none; b=FFiji2ba/R38fL5rDv2pdGmmjumMrNoO7RO81hbwxEliW+6Awxt7W2/s3eKuC9/XwuxpanMeN7rzbwxKheqXtTZkflmAzJL5sFfcul17w+rLpUuIL6kSZqE2fQa9gTtYn5PEvQ2or8axgAejE8alKoWYRQ/y8jHbOR1A6RJ0miU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970629; c=relaxed/simple;
	bh=QsEz/njIOEwlQJd+1jweVyiPy2SWvIy81sbU5T8pWvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWApnz/3vwCReoJ03XYodgDDpcCOPb+ju+dMukUo5eWBbc/bqadwz7N6Bj2lGFM9yoOlxkw34G6WVggDtbLT8CzcVYMyXYZYnZ3HrLu1mzdYDKgYrGryxGgZ2YbT1i4r8M0LuOI0Vsa2q+ANtcqFBCuCAz6oBNXcHMvFEudAkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lqGPTPBg; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722970614; x=1723575414; i=markus.elfring@web.de;
	bh=QsEz/njIOEwlQJd+1jweVyiPy2SWvIy81sbU5T8pWvA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lqGPTPBgN8OeUaEeEUOtgSXcziEGan2ywLqShFZwSVnyBr+A1YaPsoe7ZgTOT0pY
	 PrxeVMPz8Ee8FHwoU3Jh+t+LooR7LYZfAlkCXtAtMWCLGzDihbDbMP0NGQUILHvpQ
	 i7TwtZcoZCsFtbzgLL2qwiUjZT3Rf0oSg2C37hdTnE4bps64JfhCBRxOyyXBv8ugp
	 iavT+ZXk+fnzrSPQWV0AB86VKRq1RRTeyDlcrBeVic1qQeTFDBcgu+QBI9/Ta7FiK
	 4L0QZaSty3CiQH1uTIqn60I5JZxG1YOhxSIdi4i7dsCp+oHUv4nyQUsjNNESxnAEF
	 hQ1l0o5gJXCD+Zrhbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1rucLq0K5U-00l11C; Tue, 06
 Aug 2024 20:56:54 +0200
Message-ID: <de748b0f-6e05-4c36-a6ad-cc5b09718e0b@web.de>
Date: Tue, 6 Aug 2024 20:56:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/10] AMD XDNA driver
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, George Yang <George.Yang@amd.com>,
 king.tam@amd.com, Max Zhen <max.zhen@amd.com>, Min Ma <min.ma@amd.com>,
 Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
 <f66e2016-d2c8-4a86-9a6f-267770f7fed5@web.de>
 <23f5f0ea-305c-15c0-4578-ef1307621d07@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <23f5f0ea-305c-15c0-4578-ef1307621d07@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J6XKjukaDhMuC6VH8csRFL8lT4765mGsvAbvwWw3KvpbqeZrG9K
 OPHyPJkXwKYZ5wh6Pq7GStAcNjj60V85x2I5Qngcew/gQeuf/jdaEx9KRc7Z4a40PCoc+rO
 t1VAMGkYxbUH//97kTli4ZXTCJi/mIPpenNF44cR5u7Lbd41f90ZL6TFB3zHcZrpZjlaWw6
 iXme0jLWYwpxZrwuQImgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cnd4g9rne+o=;F1I9lZDQNZ4ZXNXFHGo+KLJRTz9
 PETRrhfTsFwRxjI8CqJgh6rFg2VTVStFXS+4d0KckQ2jowmfqEKiEdKstZyMC2gOWK/12YjNe
 WnoehIBjYU1dA3++EfgiQUtF3DDG6GpsmzFMyIJJYEtpVEqyXyWTHrLh84rcxe+7I5r/zuzSH
 uWcm+vk9GI+4mLw76PhHD6JMGXHk6F+BRXM2XxFiRv2s/AeDk2ZwrjMVEeXtwdDYrY5i/Zsgl
 dnCuC6q2rsmdQtd6LfxgC18tUCG2M9eckGZkbdIxHO50LukP3/4wH8N1TZ3yNqueuBiMlOiIj
 LF1dV3wkE/HVZW7k/PiMPYrGJkQs3rX/NFt2IWPkULRPFgAnx0xvBtETHlYxqONdV63XzD408
 zJCc0lfTYfYojHwYU+XB9Irx4O4dhyV9/UoG20mkKrkgcKGbbO+ER3Bf+ElT6s+ZsevFw/Yqn
 zCKF7kRvRW8GCWhZupd706ragYUcbShdqBL43BfqSLNuZ4ZqtA0rugCeaLV1hVxYqe9Pc3Ong
 nMKkKvDn1ss/7VwahSBH+0wUChUr+R64eSWl2P4ES7HaWB97cIGjcs0HgQvdc3/XpdbCEnRnj
 LNLU9MINRuL2EShRKzi7wfpFtE+rfrckNRoJKFWRe/tJ8ydIwPvHrjVQ8gr1jXVbfEk+KQWo7
 SRKZyDdIfvWGQsj7x6o3HprfHcQWZg9uDM7AFr2sL1f+ir3MZbhaZc+3NoTfYjcwBMwDYybIa
 IT9O9CoWWhWKwASDP+cPxf5a7x/IYecVy8TOJilYf5By0uA33BUTtCFClzZl/+Evg+1a3pIgT
 sTjxTXUimByzo2mg628gigZg==

>> https://lkml.org/lkml/2024/7/19/803
>> https://lore.kernel.org/linux-kernel/010a46ba-9dc4-e3e3-7894-b28b312c6a=
b1@amd.com/
>> [01/10] accel/amdxdna: Add a new driver for AMD AI Engine
>> =E2=80=9Cguard looks cleaner. We will use it.=E2=80=9D
> We reconsidered this request

Interesting =E2=80=A6


> and searched accel and drm subsystem. I did not see it was used.

Do you notice how applications of scope-based resource management are grow=
ing
in other subsystem areas?


> This does not look like a required change for upstream at this moment.

Maybe.


> We would keep the current code for this patch series.

Will further collateral evolution become more attractive anyhow?

Regards,
Markus

