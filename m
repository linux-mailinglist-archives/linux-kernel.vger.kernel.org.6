Return-Path: <linux-kernel+bounces-303668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E89961362
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AD32844EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE71C9446;
	Tue, 27 Aug 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aig0Wy5w"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB81A0711
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774136; cv=none; b=cztXTHo9Uit4alSosr5u4YW3lkOv8jUNXmDFE9Dgdj7K3bJ7xuvyfJ3KVtW6tIVKHtO6ESvr1q3p3iwGeV724Xek2gGaEfx5UFM4hGuqeztneGmzfbNVOxBazi2BDd6fO/8uTRHToseeD7VWbNSTNjvG7h1Een3LrtdK9KVvRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774136; c=relaxed/simple;
	bh=r2ehhlPWxM7rm9BtaSU8wJLR7j5JUwtomsjowwIznsQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Je0oW0dnNzvyL0Zu7/XDUHYbH8SfTkPzDSxlqGfeq+L6vE8QAjV/9eymK34zavfSfBx57S8QprUQeoHCvnjG4+UQ4vV5/YHakrI8AQN43gC+tMKAJCVG+63yyR4/VCTBtETHKmcS0ZsoGygTQ9WXZQTlIscAMLcB+cnx80ZpSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aig0Wy5w; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724774084; x=1725378884; i=markus.elfring@web.de;
	bh=r2ehhlPWxM7rm9BtaSU8wJLR7j5JUwtomsjowwIznsQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aig0Wy5wfjT3HBvOySCyv507JK9UmdDKV/qI5j9PShurqlSJ+/zLM7wylw2TzNVk
	 Zr87n2nFSt3YC1bi4DvB5dWnpStibOCMbAr1WydCMAwSD8hIdI3uh6CzQHxnNnAKB
	 wqo+vgwuXqWP/JsqwqcTkWi+0Qy9YUkoR5CDPtygsSv3G7oFPHTMJ7pfjJPdaZeuX
	 2b5RRczFfjIspFtlgq6B4CZYlgBNwta7JCJ9vRXG7AsRn47fFi7cQgmEcXD8h/R5A
	 dcvxN+4ueQzgmASSZGNSlq93D42sStbKVxTja6oaXtLa8DmzRumQ4g/De5v3cRmTo
	 hSmBCPMx98lQtbd3qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1sDSvy0sys-00f6mp; Tue, 27
 Aug 2024 17:54:44 +0200
Message-ID: <384bc620-b7fd-4594-bf24-b1b7b26a59df@web.de>
Date: Tue, 27 Aug 2024 17:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yan Zhen <yanzhen@vivo.com>, linux-mm@kvack.org,
 opensource.kernel@vivo.com, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240822022704.1195439-1-yanzhen@vivo.com>
Subject: Re: [PATCH] mm: slab: use kmem_cache_free() to free
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240822022704.1195439-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L0ek6BSdON0AhkDR/E/gtYOUBRqewVTxZcnW5vTD5Hr2jTJms7Y
 JQ7bdjt0U4h6EWmVAGMN//gg47zsUPykv/H+7nLd/GObC0ioUWgro5CW0vf3xT9FpEG/vxj
 0r3B4BIYDE82dX8C6vakpTLzcs9nA6HO7sVxTzfj44SquSehSz8qcjSftsC7jbEYRQCrhAI
 g7NbyiLl6SVQufAF033aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+wNNN+mN7v4=;L53yq0uGKQB4Z8xQkugghFXd7c9
 3LOeobKeKDOGxiApgglN+X0/XK4SSeh3oGalFKJ9fuFVS1Bq63390QWvmyEoF+T+4fMVb0gT/
 uu+x22p13QYMJ/4vd5wHzNdBSGuTg7hbJe8G7mN6eWXxfS505uomfQ5bAhyPIKM6iBetjyhJ9
 acnjj1eHUNZA9Sd3kxzDSAtpzF+jmmKAo5lWR5sRBZqV8IfmHKoQ3aaSHTPbJvfj1znDbU++/
 dqeMjXAN/Byy+KD6aEDvwKh7rrPtOyMF2t5pL9oTzDE6F2DCS53dZI5Uyxplc7xX2EyA9JcRb
 hT7Z+6cKNRk8tD7XFemDLtPJokMJPq7vy/YyJXEkuvOj5vTq4FwGdL0UkFcl9Ic6s4qieCzDw
 90ofwYPh7hCzWITPURNKaHWQXAcnHyTT2rPTx91E5EyVFOvhSdavob9sJqwLwFs0PcG+cOFGV
 D9YdcEpCWnRH1t5PDWGCHJt2sVbRGxdNKiKhHVGWis+pdK9rGFxPznc1eXMtvt2871AvsuLCf
 CuxcZZNl7tvW79YIHKybLv7EouzhFpm4TiG1pUiczJYhSIn1Slxb5rkGaKW/K4EDjGCYC05kZ
 zzb/IZwW0/I1zDwq9E5m2Tdh8K9PG8iJRwbCwkGOsPLkMAb7DDWAdusMtylpAIly4nMgltIba
 LkPOCKdgS48p94Vi9T4+RCg/ZgbI4uvA610JsAWlDZov9j5yvk0v9KuMU1tGbsxpbLJSIOs1f
 RdRhmOdbWVzYLa8SK+CwJib7NE+7uWl9LrLcWQjq0XJQjB+9RmGH/nI0gNnB9yXdRAP5oTFsu
 S39qat2R/ifNUqtNsbSyUd7g==

> The kmem_cache_alloc() is typically used to free memory allocated throug=
h
> the kernel memory cache (slab allocator).

I find this wording confusing.


> Using kmem_cache_free() for deallocation may be more reasonable.

Will =E2=80=9Cimperative mood=E2=80=9D become more desirable here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc5#n94

Regards,
Markus

