Return-Path: <linux-kernel+bounces-218216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8190BB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885B11C20C10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B7187567;
	Mon, 17 Jun 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qFy9OqZ+"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A517F397;
	Mon, 17 Jun 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653023; cv=none; b=AvoF4k6DwK78OIh2DqCstVLxCyHGqh25dvwk5TBSlbX4CNmybNVfDR+gyFVhDQy8WVBwv/2r7SzFL1w79Y13A+dMHL2PS9ziXV1tpTQNQWsbkyZN8tAnXToJQJvPOBOdXb7ZeXZTlrFl+sfFxRwLBKgIAYuQ3h3KdyP+UywB4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653023; c=relaxed/simple;
	bh=N8H94RCXX5YWmY4bchJl16LRzX71/Gf5z7MQzkptBOQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ppo+kttIbMU/P8b3qUx2idTPwDNiV5cQGPt+v9SvPSqxRncroRQDbtUsIdW0z9Jii8d7Kc3mFPeIRp9MmxetloF5hX2r0A14k+nFoMXO0iFsFdiijKOKRIQ4e+wAdVtTzRPVCc7F5oRdped0ZJcnCzVAmCPVRdciQUYbkyXRnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qFy9OqZ+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718653019; x=1719257819; i=markus.elfring@web.de;
	bh=3SqP/MMqLPtLI6/aIyy4H8OAKdv545+Ewr3toVxYkx8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qFy9OqZ+61yp2Rr2rTlaNNqY3iWEj82Su6VHQlqnYJfawxb2t3p84wmz+i+lfa2a
	 9VnvM09uvYl9MKAqtmm06clNbE0mXeOptfJtNazwkRbYbLdx8iws9V0/LhlvliNI5
	 Zunk4uoQn8GX45NhaXBaSkvTj4fBYA+bRALZinkLVvb/ybcKgFdqdqHOxyzw7BBGJ
	 5AFU2r3iE51ZRTjdJpMPmEvyEybEsdQjASm3ns0kVH3L+30XktQui8AYQYDZHErpi
	 RnfL8ZUP7qX2GyMVAhRfcsfj2iVcLLqdzbOaR1xWUtilfclR1Nn3Ss/Gt9CJKi4RU
	 g6rZ9obCMXGeqxd17w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Gkg-1sSbPm0CNW-00tTYm; Mon, 17
 Jun 2024 21:30:24 +0200
Message-ID: <3fb7f6db-6822-413e-9aa3-953a5e3cd566@web.de>
Date: Mon, 17 Jun 2024 21:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Chancel Liu <chancel.liu@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Jonathan Downing <jonathan.downing@nautel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Takashi Iwai <tiwai@suse.com>,
 Vladimir Zapolskiy <vz@mleia.com>
References: <20240614163500.386747-5-piotr.wojtaszczyk@timesys.com>
Subject: Re: [PATCH v3 4/4] ASoC: fsl: Add i2s and pcm drivers for LPC32xx
 CPUs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240614163500.386747-5-piotr.wojtaszczyk@timesys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5WMvwVJ2f6aoUtr+Iz89hHXdsaVQ1zgvfdIEvfLMhBHDYIBbpe8
 kWz8j5Flzg276xCuQhuOfkGfjJ1JGGY3ujMyZc1pPd3x6QKmrtdsQqX0puZR60X7t0lHxCa
 yn6PJPgg+aEg447/N0AipP2n+YrYMaefQ7ZzL7N5WylGgwQ1/vOzILgz7mqlOpdJg0hrWyK
 EoJrGwmfCJ2IviYQn3jgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:289MEY1k7K8=;iOOAW6vyjkidRXUo1txuUPephTd
 Lu1fLFFQ6OiCdw7XqOVx+w2a20k6HujWOHtSQ8ZBlGo/WuwY98D89FpuXLguWAWGVOl0qUIhe
 jc0zM6Y/szMGY+/WlykVXOVhOrLwVuova8HBzv7uV1hrETD7wvDm2z5WgXmqJQxbD0oy6g1n4
 96zeP7oB9vXE5vRN8plGOvQoTt7SSUequ7lc+YSbYRC563Eg2wHsMUVtXddeBQtIwH+K5e2fL
 FK/5gEqssQlX1EcTxtUDtMj59u8f3/tfig1/7zuXaemfMmKMToZZ4sPidUNjPJFfNENxhD+FZ
 sFEnxnYTxIhbJ3GTw70uWGJpy1FCI80Xz/49TVeQStMHl6rku0TMl0JSmMUoTqibbRB4kJc0e
 7VB3CB8pMhET7dINxpOTEavR1IjfgXauixR6RgI/klq8k5HxjD7R4s2CoTkyfo5j4gczHHyea
 uLQhNNkNl9dcJEMLqgeT9TbU1OAZHzgQ3p1BlYa8qjorYW5kfp+ffxczoT+vi/IUMxXJyNiIG
 RYZ1HTj6oy3q+dTkHv7WvPJxCk1gQDxvloh9NK+9bruoEk/uzlpDpAyF642GPqGqw+z2LdBcV
 UO6maK85XEM0es5DTY3E9O9oj0JX0iFlTLMn4+phGIuzTzEkmsAxwrixRsE537NT7nn5JkMLV
 1RdVvS8UeTGPMjpyGaEKa+2F5vxG19XllG9vBQk4KBooBPqzV+MoCky4+nIq1nA2scdl30sD9
 BXSDEwLRSTDA7GIgwW57s28eF/GWnmh5al7DlTHI/7o9P3KtlTaywCCpXvs+w/LHJPw7I8ik5
 3znkE+XmhoI8DG2/24UILJqI3JkvyvehkDbfd4qGA6mug=

I suggest to specify email addresses for message recipients not only
in the header field =E2=80=9CCc=E2=80=9D.


=E2=80=A6
> +++ b/sound/soc/fsl/lpc3xxx-i2s.c
> @@ -0,0 +1,393 @@
=E2=80=A6
> +static int lpc3xxx_i2s_startup(struct snd_pcm_substream *substream, str=
uct snd_soc_dai *cpu_dai)
> +{
=E2=80=A6
> +	int ret =3D 0;
> +
> +	mutex_lock(&i2s_info_p->lock);
=E2=80=A6
> +lpc32xx_unlock:
> +	mutex_unlock(&i2s_info_p->lock);
> +	return ret;
> +}
=E2=80=A6

Would you become interested to apply a statement like =E2=80=9Cguard(mutex=
)(&i2s_info_p->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L1=
96

Regards,
Markus

