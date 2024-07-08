Return-Path: <linux-kernel+bounces-243944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A180A929CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F736B20955
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F91C287;
	Mon,  8 Jul 2024 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ush8vxmx"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C313ACC;
	Mon,  8 Jul 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422636; cv=none; b=qsujqcyuuF7VHs6rbhGa4ZrDfiYgg5Jc0aRvGoLszUhE66PKgFRdSs1Q1jQc+pIoPJ1rM4Fa6sEcl+4nIyHAKj3jfuSt47qPG3L496nlJr3FuIlgHnwI4p8qxX3y8wwxRUXcXPRSdSrEAQGSNIxvfs1upepID04mR7H4fhcr04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422636; c=relaxed/simple;
	bh=dsbLp7BbzLwr5pkBfGcpEadAFzTk5V5tler4D1YulVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXJZwfGy8KCMMkVY29K2q5DlP/iKwvltSTSd7U6kizIzXst1Zpfq2yiGyqqkhhZP0wMfCHdPuY4AZ6hI3JFdMNfyPfEStJDp2+hUEZfONvXEttwrsLq3RRP6MbnkW9gzGYmubQt3PPwknRSSeoksNDdm4mMl+mJFOj6m6Vb/Q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ush8vxmx; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720422588; x=1721027388; i=markus.elfring@web.de;
	bh=dsbLp7BbzLwr5pkBfGcpEadAFzTk5V5tler4D1YulVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ush8vxmx2Ke/5BgJB3uZ5I1qLyviKaRqZa4HeybcXqzuozjWkA2UjeXAP1p2FbsH
	 0aqtMUsK7CxMbQA67+pWhGexeMMwzXFMcgZmtqT89K2c1HcxTeJzED2jgHQDavt4I
	 9ORt2FKQcsPugBjwzKwdHS3VDsfVSUa+rtR/L4cFwrHj2tSxUfkEOoq0o1eA9gpYW
	 ByCxpGjVn2a1g8JNNp9hXwx+2ZjS0YulCTI7rykX6qBUiZ9iEiu6sw+CvypnaFND1
	 wzMAbwnpBl2/9bDX60ztYsgf4wOPfPTswJzyYMVqCIMWc2zy+3xbEcz99CUejQ07X
	 MfYYJmsfKBpl49K2KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1soklB1Vzl-00Ho02; Mon, 08
 Jul 2024 09:09:48 +0200
Message-ID: <5bb059a0-b94c-44cd-b18f-4e2a79a6e8a3@web.de>
Date: Mon, 8 Jul 2024 09:09:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [09/10] drm/imx: Add i.MX8qxp Display Controller KMS
To: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240705090932.1880496-10-victor.liu@nxp.com>
 <6595d4fa-2e83-4380-b36e-9c4d910aadea@web.de>
 <3b91320f-730e-46e4-9c96-8c348bf9a2a2@nxp.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3b91320f-730e-46e4-9c96-8c348bf9a2a2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZFDSWkyyalWyOFIig9SO2WM02MNHSHIkbmdG+A5Z3yZlFb8Mhq
 cTJN60ko+TR3/WLilCtUAGSkAbjXDbvsuATZnkS/EQMhUwzVdqrjyPsvuvJhThnHUzsGBxt
 +zz5hU8giM+2aLSNTVmu3oXtv4NNGf5aUcZ3zBswNK0TGmPFDvYG6oGDFX8uAH3DYcpW16w
 eXTnx3S2VH81Bj1TzbGgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9D+LPmG7TBo=;do29/MKV/GC3mcS425948u80aBB
 Adfa5xzyA4sNgWisMHP5MApTFgPWNrB5mrqNTOIhyFKftorxfWEsj52jnEQVVFwMxS6T61Z4v
 QBnURRW7R3TjaUeITtSJqriZ7+q94jt3kEgZNrzO5x10uxHULatYJ+AeaPnOXAwYEr0DVxWGC
 ZxYGg1tvx88Ar8El8n/vY2FLccwEHgGxsNSL28t+NFD6vcP1mAgG/1xFYnPwN+qkOY6HWa33x
 ncWv3Uhei5JI57D3egfrs9fNB6wb7bRrg3/1vblMre5iKNMBEmBsam3J+BP/lBX9KxkVvRCw1
 zd5KE7C9rXoveJB/apWNGg8fmYxld9Ex5/nlmOVkpcuur85+a+C+FooY4rHUAf1v8QNTcxbW9
 R3demM9LlgMHqjnzzVj4FpGfYHwtdJl/bbClfVM1/5R8TuAROcOuMgqlA/dkeNNuq9kPu51tS
 qQcBGaRjaQfQGG0tRZisSGbh8mi7Ahm5Lt3VLz7Lux3p8zD3k2mIwg35lCpy/3izr/s6wXZPc
 uDfMDv+Sv7a28CXOlmTCQLqL/BtoOhbCI3fhz63vCeD2N4YnG/z6pwZoeQCtl1TXdJh5s0JLC
 91/43e9NQkYnZy14s6XieeOaIb3R50AAEjj4DkmGK5Q3WT5DTDn/CSQS6OklakOwK0KrIo3b6
 J2PcyH3S0HWU3Z0S0rwIYSVC0yI5N7yU06PHHqGfojhQaUZjZol2HcYMKbU17xA1fuT+JyMYf
 qjCHqeuZBD6vj6ZBydsp+GoLSK8nPJ16vAtaZf+5MUZaMaN+8gaacOZdFScf6acosgcGukPXy
 dVEao9+T59e/SpXZTU2zigg78UJtY4rHsmssTxyiFzZy0=

>> Under which circumstances would you become interested to apply a statem=
ent
>> like =E2=80=9Cguard(spinlock_irqsave)(&crtc->dev->event_lock);=E2=80=9D=
?
>
> I just follow the kerneldoc of drm_crtc_send_vblank_event() to
> hold event lock like many other drivers do.

Please take another look at software design possibilities to benefit more
from further applications of scope-based resource management.

Regards,
Markus

