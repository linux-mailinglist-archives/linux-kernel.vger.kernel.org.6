Return-Path: <linux-kernel+bounces-320284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3997085A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6186B1C2153F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9AD172BD3;
	Sun,  8 Sep 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ri4P40IL"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D35165F0C;
	Sun,  8 Sep 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808534; cv=none; b=bZBW1HpsZ+2NR5ZcC1jvQcyUYnKqDq6FWdXboWojewQDsVM1ZRWc903gOKCiv2Ejj+cA+xh/epCHxRVZnhngK9tbFHyFjhNd9ByJ1njMKto3BOY/ISpceOw47zQaj5THMcL0swKxZ3PISr4QTfGBv4I13cMpoChbJXOWkNIcNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808534; c=relaxed/simple;
	bh=q7i6mrl+IckXzwqCOYUFSUbpol1lDAbjjF7BMvihBzk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=P4QPUVs+GLqq0GxriboIpOX6F6SNxzT/UyTLUCPo5Qw1S55aJVD0OkJXpVDmtHvQY5AkRFet0oj1UbEiuvccP0vvZpaPoDms4bRZos+otLJ+EPhlXxUWxRK7QjoI2V+i8ryZWNduINaE2cE+8IlrM2R7k4+fS9haHD3mHy7YsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ri4P40IL; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725808514; x=1726413314; i=markus.elfring@web.de;
	bh=Bb7EHTjOG1C0O63SEwPhIbNU8U263/zeF0Vt1VmSVXw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ri4P40ILOPoSNbQsoFMHW552390DzeHtfExLZm5D4v0TKm+yMeNYAZ5HIetN907a
	 +9SX38sA+coCAxFXYYRXHGfCm50hIQXXNOejovqMKJT6nirJg+0C8dqY/Jpf0oYnR
	 e3FtR5A/R71NMk99yEAyZ4bqyISKU0andp/H11HdWKP8PI1tushHbG8eUK61+pb7a
	 cOyASDcvtw6skr7/FhcQH4FUnlEHYWCEMV8OUXkpDLETIcapBXb7YkRH7aFSLux+d
	 LhhEEtOft3tEBkYmeyCcO933kkyvF5Hh4QXOW9jIQchYJc2Km9YiX3/lTEwHD5HXB
	 g/1VwzvE4C/kw/92NA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7usy-1sjRkh3TmM-005ePE; Sun, 08
 Sep 2024 17:15:13 +0200
Message-ID: <c5264db6-857e-4047-82ed-549f06f38681@web.de>
Date: Sun, 8 Sep 2024 17:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Bin <tangbin@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240908124124.1971-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: soc-ac97: Fix the incorrect description
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240908124124.1971-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0tB3tnW8fETOiOrtpibeYZjh+FuxP/VDjAYjS7pfrF901fhF/dB
 i9Ceiv5AKFq37WgpeMKdB3n0Yybf3cWBOeEGtixpp9kDymp24vFv5Gco/4t57+QMRIXC9rv
 UKNFxhpoASG2J2CUJ+ScGwKsnnKdwtY8qb5j8IUyLvGHaoJiXbMER0hb4v+/SCLM4KYBP6L
 g2jFsLBB+nDJLNxkwb1zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TGbcTdpzA24=;fNipOFBFNc0CgqrDWbXo5zYMr/q
 1V5X8Ig881LRiN4rDwJObyF5DFF9we3j2XE/AedzP7gxpNzpIY8b4RKJTHCG+1nNbgidlepE/
 qYVmOuzJB8eFUzgLxWejZHHhjCVFJezbpqXW+zdBkhi+ymGGs20Hh4qSOGOW+XKRB/+HWVceV
 BJcNPGWCsSkwyPQkbAhjQA8hw/4jfdLq7/6CJSlF1LF0Aed554+lkcSqJ3zdqgDsLBhOOUP7L
 prt4Y6sbOx5QAHLOrGe6rQYy9x7H0CyCLN8zpk7pLGwCYdVzQ0p/cZC9XN7fByLge61di9oZ4
 LBGta84h0K1qq7iRbiRYDRBgFjWLbFfy4yTCvh9CXyl//pY1eIxb3bA5RXewq/HPYzPuCOjnl
 wbtnpa3E/qwHpd1lWDU6ipHQCMMLdCH2qmncBfX6pT9Hpf/uZIwYII2PGZyjPa8xTy9/QXvV+
 iD1K4CEea+HightSxQQJHTcwlw/OvL1/fqZL8nxjVxEUrM5LzHA+/pAq3EbI3lMRsKgcs6wFu
 L8l+0m9CHFFbCMc3H5/W1/vvqnGifFCiKDeBlQh19QhKnBlpyOlgDRlGtrIuN/tBePECLkG2A
 K7esA/xundhKlmQ11CtVkOtZpENxzgFYX7+aB4ftoWhAYf48Bf7UgpRBAfH0rX78s14haBdKL
 kx+RqlBJLA3mhtcGcUPYza4m8/Wi24hRx4RcWvdQ+P1k2KRSD9GQkuNbi0W20GEu5vZ6y2LNr
 inu5ryVpVqq1T/gvl3f8ju3j+o6k4aF8OpbDYfFczf5lygeleitT/UnJaLYWsqIDg2Qq28tH/
 9YAy1Mm/JmIkHrRpv9iUifIw==

> In the function snd_soc_alloc_ac97_component &
> snd_soc_new_ac97_component, the error return is
> ERR_PTR, so fix the incorrect description.

1. You may occasionally put more than 47 characters into text lines
   of such a change description.

2. How do you think about to use the term =E2=80=9Cerror pointer=E2=80=9D =
here
   (instead of the mentioned inline function name)?
   https://elixir.bootlin.com/linux/v6.11-rc6/source/include/linux/err.h#L=
31


Regards,
Markus

