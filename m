Return-Path: <linux-kernel+bounces-353169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD06699299D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69681284835
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC01D26E7;
	Mon,  7 Oct 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="oqqaHRHa"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF41D1E87;
	Mon,  7 Oct 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298698; cv=none; b=kWfj8RkMcaY/SR393y6C9rWLuBDFwxsyxgzJEBiVbdf3f1CY3cg9BrirJ7yqMKVGYf+PvR2JjfGDqv5+sxEpBzksqTuToeSwHKkyGv7B3ueSMgTof8AYhxsZbDNtROUXXzWcKIgtXAg5WK5dKOunRGUAsijzKBJskgYzqK3L7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298698; c=relaxed/simple;
	bh=4r+N6qSVsA8WQm58Kp3o1ulMUJ2PX5j5gHrNe4rL/Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWBGqoQ6PnWD/cMNU0VY67C9LkILhoSnTQhdwTHGKB7RY+nnlZFTdrVsRtDlVsSQI2+6vEZorQrXD7R7Z3jYehCN4brJ6dMX2bm61vuuXoqnTc5CKRqLrRsVoPpBpnVjUWjIMlx61L+NP1QlXARP1gA9CFFNaz8l5WH85097sOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=oqqaHRHa; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728298678; x=1728903478; i=wahrenst@gmx.net;
	bh=4r+N6qSVsA8WQm58Kp3o1ulMUJ2PX5j5gHrNe4rL/Fg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oqqaHRHabYKh+o+F8S9a3oeQ1NnXIX0nkElZmUvNqd6y5mWGzS/GustFKRstBddn
	 1NiUxfN36ZqMbmzdKpYgIZjnyN9udUZTEpOlKfCkay6BjR7OiCr6VXZnZBMTHbuj+
	 DY9uJEsBKRO9PDJlmXyrgGVbyCbyuCH+zft2lojdw59Ny8TCd8N24OZPCqheyfdlj
	 9V8nkMOX4CScvJG1m43l8XxT7fWwRN9dpWep53XkMe7u9w4dmLww80/gc5DpsGSCR
	 A+/vlm/URkRizyqBkTi3cbhEKaZyg/IAqLivgAal9QFN++zxhT5PBDpr07A0WXH71
	 zh06xUKCbmgZ456EAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1tcZUz2VPX-00cj2q; Mon, 07
 Oct 2024 12:57:58 +0200
Message-ID: <752dfca1-327e-48b9-8065-3aca7a4b4420@gmx.net>
Date: Mon, 7 Oct 2024 12:57:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240925143129.4081815-1-lukma@denx.de>
 <20240925143129.4081815-2-lukma@denx.de> <20241007115336.393f0696@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241007115336.393f0696@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vGWgOgMnbHciDEb0p3VWS4Q9eswrMzSPr/7sdET3Oxvn0+3yYS7
 xHyf91Xyog3pBNdBJMrt1XLsui6tWj1P/V4nfmsZp/hjH3yQBDEK8MtcHuvUTqpD6Pdfa/+
 Cbm2CHyUapRHGsUF7P5xvM2uXUyicukWUCD8crOJCnjE1vlx3OpWogMmFrJMGOnxyjbW9Q8
 4K+goWx23brAbLQw8Xmkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gRl0CRQ6PkY=;0I+HnMO5xuCFCGwCWe1CrZj0HrJ
 sh8mP1wgfzej5gdUNXToBEwQedc4u1nsFt2mJpV2Gm/+eH/8koDtVyXrE1ZneoKTAMjQudFfY
 nrwdF4kBXyDfcl8m+TBGBVOWOYdc4+1wTIOKMzE24fRpjqa3MIYpS7zFTogZVjC1k3LI6yN6/
 pkQpUqWzxfIF0a81+A/OwnpRqeF7JugLJ+x7jL2FIz5q4zAZQGvsGCTKi0Z6QiSQm+T/QS18b
 SPnkvJwYFoEh61mAVPgp8MyZBwy9qTt2RigzNMvbwkA4AplvraHkBFQJWI6dj6lbLq7/Wsxm3
 wXEzqrDusBlevGuCArXzFSCD5tSKEneTScVdMaoDX7AkhoRcfpnrPqY4m36pQoyiMsXIYsJmO
 ktbJfPARWIJIA+5FgoTQp4xerQwZaauDvWDL5hSOSO5IVr/PaEVlllje2iRqwE9Rrk38HWm9d
 XbZerPh42lM+kikI8RcBPfcZRsUHMWjuHjxf+T74/1Ao8WGDuge/f1SK1KQTDYbBuL5xZp5ih
 Dhvz7VQPnfyxuOAHG9us4wl5Dht3fPFtrapFb9Shu1yW0Pw5DbPbcyClQylsBb6zZxOWucEA7
 g29344T5OdCWfpTygrR4+UzGc6mmzaEYZdbkUuBQXttAJc9ZtK8mMikIuZzQN+M1SDlYxX9ZT
 pJFKSartXdCfcI80J6Q0u49YsUeh+v8nSRNx+YPnlbZi5v+nXU9Z1V1hiHvdrGGbwmk1O6Gn2
 UrMlUtNzvjR8DLHN1kYJgVazGX5m32jkVA/v9lAmxoJqKCI+5A0XoMLAl8utIZTsZUB9TGZx+
 A+aqcyAtX7ybsPEP4mjXB5gw==

Hi Lukasz,

Am 07.10.24 um 11:53 schrieb Lukasz Majewski:
> Dear Community,
>
>> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
>> some extend similar to already upstreamed XEA devices, hence are
>> using common imx28-lwe.dtsi file.
>>
>> New, imx28-btt3.dtsi has been added to embrace common DTS
>> properties for different HW revisions for this device.
>>
>> As a result - changes introduced in imx28-btt3-[012].dts are
>> minimal.
> Gentle ping on this patch series...
unfortunately most of my comments in V6 were silently ignored :(

Regards

