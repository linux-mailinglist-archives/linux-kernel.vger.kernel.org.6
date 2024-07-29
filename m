Return-Path: <linux-kernel+bounces-265142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048393ED46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923231C21807
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2F8287E;
	Mon, 29 Jul 2024 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="izVwNPzK"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7761FC4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233756; cv=none; b=e+M3dWRdbs5FkeU2ra/4TolT7JCoQg9+mFW8rtgoLVoR62YDDRY6PusYXpJwcCMzp1075AEdN71PRbc6gdTXFQrtGX4xfYFP3cJUW6T/NWJWiDkwczDvUwBWpt7/AXDmQapyZxNoCiQFR1sKNTtHrJWpkPJMrc7B4bsI4IGInUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233756; c=relaxed/simple;
	bh=ZiRLiF/K1sxF4Ru9taCaCGlR29GUbP4jHe2EWGY4YJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS+vePDJJxMf8bXvg7r41sVP/+DpW7ILf589+BudxbaSO3qBnoAteAibmZN/CA+aFpDB2R7TV1VPqJ1mGHDa/SKwPcF6/sFmlPaqN8MIj/4YLc1ecRAqUR7ddbh/j/GRs0KzF4XXVvOG+EHix0es7T0JYcyiRQQFEpGpSlyxYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=izVwNPzK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722233727; x=1722838527; i=markus.elfring@web.de;
	bh=/W4WAd4LZcskmNp9VbPLG3tCL/kPPOMZRrrIa9jaZBk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=izVwNPzK+zItEVSPpFm5F/PTXQs/nX90f4cMo0mx7aOGDx+Q8ilst9mBg7fQrumN
	 pwLnWF1aZmzr/mkFwJq39/GQ1/1iYQ2cVO90OjRuUvHanivPasQZn3IySkyfSXrQ0
	 nW+K0rfZrgfqQnqD5IJlsgDXGP9Bpf8dPNoGw02G5HqMWzFMvZIH24hY4eUZfEk+g
	 E/i5XdJqxThtNpYEuK5i6JvXXlQTJrwP8iZcnCt5ubAaSn0W8L2ioZ/LWMTdCqymP
	 6xzuXAdoctKJD6sP1ypDTWGVS3ddXn1FjBNUifLLRwNYz49s8IOrXZbdGP6q+0XGk
	 0d+19+xlbMogT5aRPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1rqQG72xNo-00m3Kc; Mon, 29
 Jul 2024 08:15:27 +0200
Message-ID: <b4f71869-60e2-4e37-9844-58a4f56b12cb@web.de>
Date: Mon, 29 Jul 2024 08:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/loongson: Introduce component framework
 support
To: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
 <20240728152858.346211-2-sui.jingfeng@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240728152858.346211-2-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VXoH1w10BAhMcK6vKxEEaf0g71jR08ATLgbvjFAdW9j/KYwfia1
 a3+pbL+ruZ65I2RVcZPGBeZVKM6ZXiRBpTqRQGOT4xixN7TjMdsWLEbzGD0/3M/aoRgIyBr
 GaCtKqRf4uo0u58D/AFmYrAYxbwAj5OqQ4GiqqR701elIJrJJuLE62xuWPwcElIHDCQ+cF6
 8R83gsvWVWPY2Mr6sfKbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RptsJlPhc5o=;sYw1A4uZJKG1w0usXi18qwMayk7
 Di6j3JazHAIS3qmwAO7bHutvS/WhMk8NLlvFyJGW0iBL/5ykofMdRCsZ7jjO79Kb3FZDLQ3kV
 3C5kCWFyA6wn06IbXuFKO0ipblHkzM0r9/wrMcay+pMyiwvR5gv9i9eP2sV++qOOE3b2kiQ/8
 gRDO/kMuY8MrcC3va3NDbaVnJ1hmjLfWJOiSJUbC8A3BmiSS33ROhAFha55LyfSXNgkJbF+rt
 ku61H7NW5gSQrsIqlAMtXelA+xnjH9Mc1bhcQnA/+ZIYWCkUgkLTP1J5m4JrLByAbN6lb+aQg
 re0NaQbqK2UH0madZUZ0DOu2XFiBUWkSEC2OwhWu46pPwJX/KhlxxFR9PshnkwW6ZBZz+rKsV
 GVac16yApZKROtvvxafTDJAqO6q535iTCwhJXyFfq/1xqrdMGp4ihzaSjcK6kGbnKa6dhkOcE
 KIYCHFD/M9HRiGJJ4em6LytZR72y6vsK/NRcawzAdpP0DW4gwGD/eQG5XKcIH1OC0quABDZsJ
 91dFHX8+Ews3KYhWWOr/kjW9BLrmsIHJgRIs4YWKOfjz78IrhSchmgDjw7HwaLrkOYeCHd9gg
 2g/jLu/Nw4K+adA1TWi++YqRmx3jO8lW4Y/9lC9064jl22caWNTbBwjo+egZIndXf6wXzm3G8
 Ur05eumy+tu8xEGKwgC61Ur/s9npbYbxZkyRaA9bKe3PUMN03rl8vEIE+gb+PufGQn0pcACl2
 7U2tiUnmWS3p35sKimM1C+qjFkbzH0HH7+7ht8gYGZq1zVCFHvPW+xkukk9cXERliAzOFRbHx
 NCeTdcY6zN/QcyVDNjkg3bIw==

=E2=80=A6
> +++ b/drivers/gpu/drm/loongson/loongson_drv.c
> @@ -0,0 +1,298 @@
=E2=80=A6
> +static int loongson_drm_freeze(struct drm_device *ddev)
> +{
=E2=80=A6
> +	/* unpin all of buffers in the VRAM */
> +	mutex_lock(&ldrm->gem.mutex);
=E2=80=A6
> +	mutex_unlock(&ldrm->gem.mutex);
> +
> +	lsdc_bo_evict_vram(ddev);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&ldrm->gem.mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/mutex.h#L196

Regards,
Markus

