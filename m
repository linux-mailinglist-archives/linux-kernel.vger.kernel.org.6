Return-Path: <linux-kernel+bounces-237792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45F923E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2575F1F2261A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7B16CD3B;
	Tue,  2 Jul 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PA8R9hEm"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BA15DBAE;
	Tue,  2 Jul 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924881; cv=none; b=mpjYU0OesUPZ9c1fVkBZEmOVoeA6pAApz0fwySnoRkfP1R6Bx7KzpkAamB7dyb3z/f2YzUXIeORHpuNdpvTrGA19AQTxTv6vN/Ks3cjjgsdh7LgM7w1c6d0SlBUXN3E5P1l5a2obuDhQTcVIAkio7BRau/okrxerBbDMm4z/CQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924881; c=relaxed/simple;
	bh=2iIZy7SlB0jAZ9TkAiqve6GfYZdkRUOk9lB99hJIXNU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sjoMmybmeKPrmRiJVFWsp/LQx3aTfZbSJV9wBRFO+CJ0vWZq9RY037K2ytmv7+0+iOZocUjDASaWQ/HZ/D3TwKMlwhf6Yj0cfcr7LEqUITvZIp1DHkcQ/SS+8cJldntVkDXomYWvHJd4XU2LZbZWuxCyimjh/4XyzYHMJfTsPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PA8R9hEm; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719924856; x=1720529656; i=markus.elfring@web.de;
	bh=8EdSDaPZ3LtCvKt6hB7EMQ4nfFXkwws5F1h/m8sBfHA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PA8R9hEmr8R47HD2hSoDF0K/T+/fJUZdXStU+yq6qEO6lVh0ceIv25u+GpokjGXu
	 eXkINbbEgR+/BDWwB4h2VD1VafzobTjBuT+A+MU0Lk46rmQlY2Eh660TBKU6ji0vg
	 Xes/r9lGRaMu9IiXJmCihJ2t/V7dHspnk1ggL0a+Z9jMEKmzBMe7pRIbJsRySXAq+
	 fkoRptvX2/oFpLChs0Y75/khCUvfCqEDWKSEgCSGmysHe2aaf09eYcrpe9Fhsw3t7
	 VmT/NPGqc0seLx8A7ydhxOzcefLH/zcid6s5X4vjjBgWW356datqElhcd77cGAHbQ
	 Cl/cVlkAC7IOBY1/9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi4yz-1rtP0D36u1-00pMe6; Tue, 02
 Jul 2024 14:54:16 +0200
Message-ID: <8b083a48-5e56-493a-b235-60afaf794fd7@web.de>
Date: Tue, 2 Jul 2024 14:54:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] libfdt: check return value of fdt_num_mem_rsv() in
 fdt_pack()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iKiFzF4NqJPmgTpvG9imowyhVJTEdTTNPfyl4Lyzlejcj5mt7D5
 Z+GsCfXT2LLj8Y6N4HdQO+bjvzMAQoOy5147IZ0yzYRmTnOk/snGXGSr8wgGDdBDVRx+Aqz
 TsY65tBc8TeOwNvUawZAqylz5W5guiAMX/9TszW9rttlCJ7lXqIkAemIhT6cjcBaXPX2o38
 zCgWlGUflyxZVJcMnu4SA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IeHm/+z6TIM=;z8KTcBoD8+RvSXYoP47j+u7DMg0
 pWuXUOKHtVAFMN6ZO7gPNN7zK8Up75W4nD9C5aeCSbmotezL0dbeMUEFyq7CQb3S5BmhO0QH9
 3W3as9Oqygov0LqxH8KJLxqu9fvhNCTGj93kZBfJzgBqNNWUgyatqNy8N/EIr0p3rowWhhVvk
 7Y5gMQV5phkWcRuULXzwAAoJm6wHN5Yu4fYcIVZOijMVsP/hQwe+TEjKGajJl3YTbwL9F0+/q
 3P5ATcBKCm6YpN2dU4GlR2yqZDlLMZk7aCJMfUeggY0KS/k2XVi5JPaxpE8EzYVvHuZhd7LxY
 I6tKzk1R2G+0PJxKVCV1vbVXh8wotSmX9zYAUkg2VwPYF16kGD7RNbiyFflT+uiyBJDAE3g6y
 4h/Ij3P7KG2zNyoLr/1V94gPRGgLiXDa/vU8SubyCZCkUpBvOPWDzyPOYZGvSFiXX1qPloKV+
 s+wzC1s6zwbrPzvVhAAgtZnBrqwyxGRxeVuaLrwntZrIsC5M+9V3sZLStbivVv8XdKQCWvm+r
 OaUZJwuMMjZHO/R6MNpY39il+O2D/KHu652dPYWFOu4wYHov6ukhBGXODQmOdPMY9eJ8YyLVh
 4RePvk7SjIodIDwyyX4lHt/s9ROp0ZHu8xv2o2/kzBCUaMR288MZV2JE5Vg1pZgDcsv6XY1qr
 /cFrGOzCONimI/I6gMLoyQdVvXhXHzyoxgkDLPdFoFRL9v2XAiuz95IjoJrVp/5FuL5013m97
 /Jo9vZ51v0U+4iG2ZTl9T4BaWLC/wsomawfrmFX5AoqIxWAWz/m7YqYDBNIthxrgU4vwHmjWU
 gdyBKQgcfsomxV791W+X9XHyNgyMeh7B+q6/8pN5MsFkQ=

> fdt_num_mem_rsv() may return -FDT_ERR_TRUNCATED.
> In this case fdt_pack() should propagate the error code.

1. Please choose imperative wordings for an improved change description.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94

2. Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D)?

3. How do you think about to use a summary phrase like =E2=80=9CComplete e=
rror handling
   in fdt_pack()=E2=80=9D?


Regards,
Markus

