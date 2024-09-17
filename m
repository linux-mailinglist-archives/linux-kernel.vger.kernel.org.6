Return-Path: <linux-kernel+bounces-331336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626997AB75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA8B1F25EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212BF71750;
	Tue, 17 Sep 2024 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uxXM7dGB"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B9A920;
	Tue, 17 Sep 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554811; cv=none; b=ZE5uOv9BOGVn/ye1ogRCKfqvUVZK9529hlAZU3g2S6OFybCd9a2MK3E/KGZqSYUTb91/Tb6ZgEgv4iM04Hu92TEsTwSQYjih8CiHRsd4LsN40T0YdHo4UfPIcrl4lwVRkrVhMHNxTsCiQW6BxxN/We9eAKZcAw+qpcrfI/2lyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554811; c=relaxed/simple;
	bh=ECmlqsRJHFStk7ZwMYT9duUZUwvd7GLO3f9Ch44Z8Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkwGO5LAlhkHfB/S0ljYH+jzI/mDJ5RL5BiSKHGpyasfNKwlhfEota9QGMxE39ca5eR7AyOo/TojTtFARmuYB1Q3STKnj9OXEj4t/O3n0AGywlhJoa89ZwLU/2iwQ6W2Yg5FGrZqfPXuZs34hLF3FEE/0C56aDBgLyqnXdqxFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uxXM7dGB; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726554799; x=1727159599; i=markus.elfring@web.de;
	bh=ECmlqsRJHFStk7ZwMYT9duUZUwvd7GLO3f9Ch44Z8Ag=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uxXM7dGB6VKZKpUmubvDWvD3OB78si0AyNv8WXQJROgNJTIR2KHNFXcP/qUjF/rV
	 BKA3iqyYkcellSCfPO7Oph38NQ0RfvfMPiM9duYvJAEiaCLWGsH4h8Fw1q1iseNNE
	 vK+Cb9RFMnGwwLp2oHJ1NwAaFMMb9cj3rnZNoMwBnR4n1jHVPynz9j6s9UpHyByVa
	 lSqKHb6UJl+ZNUpLMPk8kCo5GuYnIF6SrxR1oI2rWOYLR4HWrMUsEpVW0nbZWH9J/
	 9SqSOicB36my8q3yKHkhgwMZnOTSEEUMUqK31ZblPm36J+zbVAwRjue7l42UrpUcB
	 Y44TAfpVRHDzYVqCyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1sJbzr11J2-00ixc0; Tue, 17
 Sep 2024 08:33:19 +0200
Message-ID: <89021934-dc01-44c4-afcd-3baafaec7d80@web.de>
Date: Tue, 17 Sep 2024 08:33:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ALSA: i2c: cs8427: Use common code in snd_cs8427_qsubcode_get()
To: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Julia Lawall <julia.lawall@inria.fr>
References: <641210ba-571b-43e7-9007-5633a6c7434c@web.de>
 <871q1k9icg.wl-tiwai@suse.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <871q1k9icg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:onAWEqw48OFAG0o02TVKIjTAq7adZMYhMU30si8twPK3Vh4kies
 LFeuUJeClwjPMS5J0G4BboOwKMXQyMfnUqoykiFZQuRXQy7hPlOsCtexzwY2NYwH8cC9huQ
 SjZAIlnnC7bsMaKftwpGjT14hq5WHp3srgKAyPTbw8KQZTbOb/rwJUGssFcQlUAvMpoJVzz
 k4NhlvIvFXlAEa+kphnSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hGwTEXnOauU=;RjeL6AunP39P3D7d6rXEfwmc76S
 yywt6ZQ1sbhMAt1bwJBmjZnTkQcvFJdu5eRwVMwRQd22synEVHXcEXJESx/XQ6Lo7pB99Qhtq
 jpK5hjU587/hTnDAnYNG0sUffBvaQ7djVPZFs99lrznehQaGeoNEdbazZfgt/qNpTGNTFmyXe
 zFSDBzIvI9Mk1I8Q03lGECc+2Fvk5J42Aab+ivps6nCGaMYaG4hqylPZInQw4/ci+Nbiuhxso
 1MvU3+UD2cnrBCHv1w+per09W5NZZt9cOaOyeFCEHJ8aHjafuwHdwkW5pFn3hHLl0NdzsNnT+
 dzSkK1+fvpc/N7QZIfBF/b3dakBjvMV8/Injnvm+aC4PeWFHu7q9HPsqHJFnG7dZk7xN0SX/Q
 CYIY+u/t/39LkBMxHxajdKI0tokagSRlNQvoYdQFZMibNhCoqdGvGbvGEvAI4Cp1Dn/LC5hxk
 C7TWLpddZL6WgZQdW49NQAWjJFThHE3BhXBo2i1TjgA1vPa1/KlYFcHGnC8UGC7CpkYOv5NsV
 oZJfJGi3b5owfdYP35BP11/RHV5Sc2taDw5LpHsF31RZwKejytyJjyciOG7OzuVqYrmbiUjYd
 oTBXlx9j69AUucUYCB83pmvWT+WkykFkXYm6mM98Z43oXZ9H1wfOyzv3Kz83MoMeqy7gqeHcT
 Os1FzULQof2XNzZBsT1xI2FJ+xRO/+RzWjXc4Hr4LPUr+eLk+cVDdMxvj/HkSO+Evp+tD8lmI
 AsayMh2QR6yg5Ef7gGuShsJu3kSbJwStupSLxlPMKHgd9uJ3BOjidbbqATcvtusTLE3kgTgDT
 Sf6SXn9+yrYMQh3PDbvBKN9Q==

>> Add two labels so that a bit of exception handling can be better reused
>> at the end of this function implementation.

The implementation of the function =E2=80=9Csnd_cs8427_qsubcode_get=E2=80=
=9D was identified
as another update candidate.
https://elixir.bootlin.com/linux/v6.11/source/sound/i2c/cs8427.c#L385
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/sou=
nd/i2c/cs8427.c?h=3Dv6.11


> The double goto jumps aren't nice, either.

Would you like to care to avoid a bit of duplicate code from repeated
return statements?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es


> I guess we can do clean up better with cleanup.h stuff.

Scope-based resource management can eventually be applied also for
snd_i2c_unlock() calls.
https://elixir.bootlin.com/linux/v6.11/source/include/sound/i2c.h#L76

How do you think about to clarify any software extensions accordingly?

Regards,
Markus

