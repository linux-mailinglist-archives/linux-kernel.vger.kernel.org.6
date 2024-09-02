Return-Path: <linux-kernel+bounces-311655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C17968BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22C11F2155B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C701A304A;
	Mon,  2 Sep 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dk3v4ddq"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D851A3029;
	Mon,  2 Sep 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293396; cv=none; b=DqsMg9Oxh2ugDPrIpeKRJ8kDu3+/Czj69xIgGYdne8Dh9WGTovyEUah3mJYmRdREECQmYTiMcGjYQU9SJLMfWCZJuBm0e90WCQdPTLi4PkhUSDDe1XINpRDfcAlnvwH0E+w+17HoyBLGsI6a9Vh8nJsSXT0/ioUEovdAKr8SlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293396; c=relaxed/simple;
	bh=uW78ttQeZfySdExpqlFHWcPaS9qRF0bSqhB1ftl+Li0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=X3DrcOgreaigr76j+RtaKuaSTZES1TLo4Pr22MLBLllTHAYJ3fEyghpwzzr8rLYyeW9OLRMFj8MFl+zt259Ch6J0XmN277e9M1u3gdd57VAM2DwJR2n9z87bK2vC3zGtYkSyEfMZagfUg/e56VDGcHOkH6G4+2IfetMBiaG9H1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dk3v4ddq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725293365; x=1725898165; i=markus.elfring@web.de;
	bh=KMmYQS/7ZWS7BkK51oztGFjFJOQWg3j7Kq7b8VXcAto=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dk3v4ddqLwtFIcOOuHQ9RPzCsrwU7qNiCLsHYMcNwi9QEjeYgrG49LD68BS9O2HI
	 +NKTbtZUs/VRD4ba/8CahUeGTrommqwtsWJMKRW8Hy5dnrZi4Ps68Ihi0eLkzz3ev
	 bZaWdMpSdhlD8OZ8em51VbDplUJXAkmrCnXs/4K4t0MTqkT3QZkLVX9kXSx74diQB
	 SB+WzTFOdnD+ESe4DqA7EZ++q2DsR9Ai/FTnjWVg3b3WLlqtmrv9kSVCo9ksKzYbw
	 fyfGZCewcPQA7mQIeLFY/CQAspXGd7k1Rew9hX5zChrd6Xw4Q1NuKi3yqQ10MRcqu
	 KTqJa7P0DqZ87IKEmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXZh-1suBtO184J-00Gfls; Mon, 02
 Sep 2024 18:09:25 +0200
Message-ID: <8d30da7f-7a12-4052-b846-66fad0ccb392@web.de>
Date: Mon, 2 Sep 2024 18:09:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Coster <Matt.Coster@imgtec.com>, Frank Binns
 <Frank.Binns@imgtec.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Sarah Walker <sarah.walker@imgtec.com>
References: <ea4ec650-d858-42c2-ab59-e17824069ba9@imgtec.com>
Subject: Re: [PATCH -next v2] drm/imagination: Use memdup_user() helper
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ea4ec650-d858-42c2-ab59-e17824069ba9@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2IP641OvAqySSsQCSeno5LeZ0c8/U6wHIWmAl0Jl1s1cnFAkVuh
 s2Zf3eSI5p2YDKoFk+o6qoMkVH+ZeKPiMgeF8+aLwNQD1xE9kL41LH8GhvYTOsJoS3brU2e
 IJmAtthSCiVzjy5jy66xuQjdjAfs4sh+ojKU6CINmx6LRoJSz12VsZlW3xJwruK0vn0gaj4
 x0HFi2UfHi1rxxVwMse6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:quvIM9LSWoE=;zatZvy5PHOFpPDYXB4g0J1t/uib
 CMX60/faYt1H0s1MkAaYi+iAaR0EW5lRJSEJosfepws58A+lM1jwT+2k3Usz/LYhmVBqbTLB+
 3yXhNzxhsYTQ6QTs+KQlQgbTwHM8bHL+NlvwNnvIBMe3Fkg1RLbzsiFWv43I1JdF60fk0XilG
 lED+TYt9oAJNHWS67QNFzBQFFx5+1IE5pqyXSC6g5yFJnspOrxz9m0EtYUUfPqsDxMiybWetC
 gbAVgEJotb914mAZHojqR7bItOjqQW7tts8V83jO53MQH6gq4ACsRMmzMVyMIZTpaMKsIgl1h
 pIx5xj3b4iSbaTJqSqpFjYeh9ZjpAePIek8JYz5L1Bd2C+VZlkla5lklVuUxcFhNoNqL0u/LP
 B0TDpXgJGNTg2Ez8DzA0DHW1AmKE1/AHtWHJiASh04S3mzE4JOoqy6FKx8Nzz2Gd6/PGCNGnE
 5Vo2yy6NSeV7giMgOgY5kSSbxxYaPKCyxFU4wd1iVkKiJ4ilw2m4F+xzuFvETGwXCak+9f0E/
 ymcBbjcWDeV2jSQMzg8GR86P9upRyomTZf8InvBIVG0nwHd3M46ADM+U6rENWsnW8aqKEm3zN
 G4Dwaplfow8wNnmXWLtwuNwNmFPkaqtNO9w5LSHqcJi33INsJ3adj768NMHN/DKpe0HPW27uC
 NYsYD0vKlL7ID8enS25w0Ke/UZLBbHejYKrBz9+YmU3o8W+7g2BKAmL4qX9HQoKp36HX6Pt6B
 3TobWqCGcj7+zTmDg4NNrBVRiu+x94Z6dTr2dqnOs5uDJ+3Z5PBQdNr/+xSOqvGErtC1W+45y
 1caZHVQRfBNfLSWNQmS8mbpQ==

> > Switching to memdup_user(), which combines kmalloc() and copy_from_use=
r(),
> > and it can simplfy code.
>
> Applied, thanks!
>
> [1/1] drm/imagination: Use memdup_user() helper
>       commit: 2872a57c7ad427d428c6d12e95e55b32bdc8e3b8

Do you find any previous contributions still similarly interesting?

Example:
[PATCH] drm/imagination: Use memdup_user() rather than duplicating its imp=
lementation
https://lore.kernel.org/r/c07221ed-8eaf-490e-9672-033b1cfe7b6e@web.de
https://lkml.org/lkml/2024/1/28/438

Regards,
Markus

