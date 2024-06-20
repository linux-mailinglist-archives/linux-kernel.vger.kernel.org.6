Return-Path: <linux-kernel+bounces-222097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF490FCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3F285FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E8B3B28F;
	Thu, 20 Jun 2024 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PS2GdJ4G"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8332B657;
	Thu, 20 Jun 2024 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865261; cv=none; b=BaeuLRMC1cMV4M5BB+mFFQaH6RO49wTiOJHyiMQMH67liOfGAAmjEJS4YnYEDjpORJjzMSZO5BtE0Ffk6treco9hSpB9Q/GQnrVHbBjOKZZ22gJiZsnufLAEnUjGc5RMpS4xrEcUS3ZC02JThueVez46fRNM58xmd6umursyijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865261; c=relaxed/simple;
	bh=t2M+UiQhicdcVxQSHRebOcOt1gBXYG4LUGZsQvbB+Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omLMDHB5R/nR+T/iWqSHseczhTQRhW71UD3cc2ma574xc/9cCJXcmore7tJ8UjhmjjZh8qnAA+CtRZoMzbDjPbURd11QD6lizBy+1SYVlXbYs8kqvLrCZCiZCKOAK7Z1I/QxCTg0OF8C//O1O/6XQNZkkHagB6QpbLD5lXupN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PS2GdJ4G; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718865198; x=1719469998; i=markus.elfring@web.de;
	bh=t2M+UiQhicdcVxQSHRebOcOt1gBXYG4LUGZsQvbB+Fw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PS2GdJ4G89D2nrUnJOlk7c3N6sQ+U6q4tOerwrZzwSaWVafnMvUbTegeEoC1Y2OZ
	 8d2XuMm+LSav6bpSkBD1ggfbTNVr8VWLbu9DVIvk9w5RlWoeOY+GwzXAOGhLF8fbb
	 Hc0Xz9CM4VmZQjQtM3LHZgStsvZIE1k9AkOJ2UYmLDG5gccWJV75L3cRpgTyWuZzP
	 Q43elYDTDYo+gzOhOJ7jGciRpZHFqzEWFLd0ak9jZO8+9twIGyYXR6Hg2jJqiG6j2
	 J5yzy3+77f5vBaijpiUMPe4ZRPWYXmZPR4ACqUEPu+TSMR2wzFKNKoH4LV3HLBPck
	 kmlzZHld7aZ1xgyHdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Igv-1sXSt0457n-013nx5; Thu, 20
 Jun 2024 08:33:18 +0200
Message-ID: <dec3e8d9-0a29-4e9b-afb5-888aaef4780d@web.de>
Date: Thu, 20 Jun 2024 08:33:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dlm: use KMEM_CACHE() in dlm_memory_init()
To: Alexander Aring <aahringo@redhat.com>,
 David Teigland <teigland@redhat.com>, Hongfu Li <lihongfu@kylinos.cn>,
 gfs2@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240619050358.411888-1-lihongfu@kylinos.cn>
 <78ded683-9bf8-4f2d-9dd4-877aa86e0e0b@web.de>
 <CAK-6q+jPMPoue9w+=_ZtEjE7AohRrbPHN93Fa=CbXtrTOyhicQ@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAK-6q+jPMPoue9w+=_ZtEjE7AohRrbPHN93Fa=CbXtrTOyhicQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hN5RWVE9/3J/e8gwTmbE0X0+WkleYCEQT+2JIokmTCXVjmz8StX
 H6IVg8aL3SuVJyNFIqJ1ROLkgAdRd/rm4ml+86pqOVsw0czbVynTfBT0cTPRn6Ky3gDKU/2
 bakWroWFkfx778fLnpTvxjwD8X0nBaL9bdODyKoYzAeFIYP2/yNfFyk7l9jiWeZo7wRsP14
 lSpPxy7OW1RFbdA+Qd30w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SPe03AcFnYM=;WAr9U3dt2XzzefJKuH17280zLKF
 asxZdCNxGMSZYYuHIwiJ1m0a8fN6dFvTwT09O4BaMLgb3lEN/jWYUfU/P0od5hH7Z2GSa1xEu
 KDHOGoRpRud1BGGDKl49gESNKMrnpE9e/ktsbL/jBFuo4Wbd/L5OhNbGkjYaOgGrcjhNrs9aR
 vu7iJkOJs2/4s9au/SDvmBo8t1GAhiz//+lxvkWbNQABtU8UiVdkbik5KlMdqhtr4tUze0LXE
 fCh490BWWQRkbm0oo5+71Y/yhEycQUzjS0T5zWvMcjl0aaH9MwjsaTbAjs3n35DqWgfQksHOQ
 FPrg4/dV9TBuKbRfpecgSo3RzXhCtFQBveJK0zcZdmmS/IhCxs/PeICmKXrY4Nm2hqq/fIoso
 chEjG0i27S7ocWmq5epmQCjtz1jGt5NVHGjCQDAPQ3FJCKj6ZQIXl4rElFAR7hDMLxn+YsGjy
 CnPzeM89vtwda+S6oYPO7zKTXafRnqlqbhNpRky39rYKq15OXwablyJmGBJr0O7tg8sInH3dW
 n7uR7ImkfzLEBqZE1ZIIWx+Lru2il0n3aGUi7Lt5CcJDEPVLogKhHZV/BaJ/CaTDhp8eVKgII
 YxO20xaA7h7Is94SKdiBwF7Lq2oLWCIYOYdGh7NDKn4SxMYn7edXZvYMVmpiLNXAdlNT0lZub
 XjQ2ircBDMwIMByfcu8QHSsua9N3HLqmQUvwv0aqPBAkd5Sm94Zgyq/vO743J2ePH6Q6T2B3O
 4NrDsZNqA4DVLfsW39VR+rlnC77uVKyRHBQ9WVObKIv2j+K/1w5rRNXjW8gQmQdEBnaR+zAVn
 aq58ESNB6W1an8Al83G/YMi0DsoiHXE0XzDlFbc0s4j55gtLG+s41mScjmSNPAjozz

>> Can the three passed name strings matter still for the identification
>> of the created caches from this function implementation?
>> https://elixir.bootlin.com/linux/v6.10-rc4/source/fs/dlm/memory.c#L27
>> https://elixir.bootlin.com/linux/v6.10-rc4/source/mm/slab_common.c#L362
>
> probably only for "dlm_cb" that turns into "dlm_callback".
=E2=80=A6

Will the development attention grow for deviations of passed name strings
from applied data structure identifiers?

Regards,
Markus

