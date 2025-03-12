Return-Path: <linux-kernel+bounces-557848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DEA5DE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E428D189DDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5A624DFF8;
	Wed, 12 Mar 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XEwLSIwp"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9EE243376;
	Wed, 12 Mar 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788076; cv=none; b=XeAni/cR0BnuWpmfk55bgFJgZT+tPqHO7Wd3bCHOFTJh9YPrEHGMBjtzV4qbiosMJdbxACyuoZCtl0UnjyEE9DIHbg1LYv9tGSIq8+YXqLQcmw+0G13IcsUD5BRt94EPhg+7diAr3LJynRC0cFECerqn6AUroC3o5wUvc7210yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788076; c=relaxed/simple;
	bh=BLeYRhcdEL3qm8+Dg5gyp/bHdbIvZRbqE+W1QtcJa9Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ic/kQdmyDwlht62N+4hVnOXDuR3n9gH+SSthNIVUsMVoKF+7TGTRaARcuiVHXe5IWTHTLLY99fpp84lI9EGi4wBEFg5m9n9wTcYCJbxMEWgAP+9emwmerEaz1zi4nW0rk5a3SUWQ2jpblXAyyXEbz2qe2L79ASw0sn8y80Cw3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XEwLSIwp; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741788047; x=1742392847; i=markus.elfring@web.de;
	bh=elMb9757xEh9e4uQsN/gdF/SVVTajaw0f8UaKE74UKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XEwLSIwpwP0kKruwCvRm7rPzcISxjmJl99nyxNGoG47P5Wh3nGlyhxPnY/hc1YZJ
	 TjQI+4V4gFHMsOi3Nr0sHopDZmD645+3Yc9y8+6VWecrSwSSzdghW/9mwHe5iUHma
	 Lkeb+Dib+keicdp+U5kMWF4Jo8Lhu3qy9DhOw/6kYZJejkOxbTmJSutK3YuvwzUMg
	 9Sv/GP1eRZZ5zB0MstejphFUbVwYQtq0q8yW1n/oBVQpBD+hQDTsXZZFeEETLS5lh
	 VhDAKr3XBPRV3k5GnqhVaVDo5YT+Q/PcoiE+Q+HpjWsscJP6ToEJM4vG4XCananNh
	 KeohjR1x1HRzZCmcbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6BN-1tbf8F3diP-00TJZ3; Wed, 12
 Mar 2025 15:00:46 +0100
Message-ID: <85859be0-95f7-48f2-bc51-488531529075@web.de>
Date: Wed, 12 Mar 2025 15:00:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Weidong Wang <wangweidong.a@awinic.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, anish kumar
 <yesanishhere@gmail.com>, Ben Yi <yijiangtao@awinic.com>,
 Binbin Zhou <zhoubinbin@loongson.cn>, Conor Dooley <conor+dt@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Jack Yu <jack.yu@realtek.com>,
 Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Rob Herring
 <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20250312120100.9730-3-wangweidong.a@awinic.com>
Subject: Re: [PATCH V3 2/2] ASoC: codecs: Add aw88166 amplifier driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250312120100.9730-3-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXsiOiJ0Clwg0NW3EaCHbbcLltCLB2mlIgmufah31UeZw7l65tk
 WoE7LMnu7zTOLORMe1+cOTYfD2P9/4/BzUfNPwHtIp4tyz6R/VEb4kb2kntShc7Fid8fRp7
 en1CDllyRxe4HrAfGQ44qnYhyx4tA/Tp2sWegaEI0tsaOKQHHNxrOmjcfkpSCx56TDTfGNr
 VJFx1OunnjDzydh4o0TZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LrJ9B/RARBA=;U2yCqLaLuqXdFUS0cY6t90fVm+V
 JjGI7law1QjbwmJxtmS/2DK0no2MCzOIwTOLhwnyQxjFMKA06CbhTUvWHb/0M6Us03aNGCyFH
 GV3nj6qNbMirBM/U7yGOHVocR8VVUThtqpBlpTTDBc/rj8iIkjgf/df8HDYPmJjuAoPvJ8mWI
 xqe+deqdGVwV/4bmlEBTR/kItQgGNKxCfCfLN4UET0r/wqssE87TLlj1Y+ALdxHtCEGgCyw8M
 d8NfT23FkUf7nfkjtgJm66vXjbZzcwBAogj+dlpQsTGASQQjL3U9VMHdxLRO8QXKSszv1LzLG
 14AAgfJO9S6qsgbP//Fa+6DiN4T8enTgYi6sVL/ipgHuG+DZ0ccrb9hCWM8T6UAtS0Z4IhLwD
 NPGnn4D+oSTKyvNb9th7hUkh+Mw/1nrJKjLoNf+Mv+zEWaeHO6LMfvRxQeRNhrnV4bxaxqj7f
 tSulBk7ZKOhUzLHx1y1Wofzo5s2QN3NfntU5PJrmx3aVW3DNUHS+i2Jt4PvvYStpnULIhEnXE
 1Yk3/+E4HZiLEzd+xGHO5Bju9vUi2FtJ/jYaHZW2ZZ+/3CtxqxTBL1pIrdoRc38vN+JarH5ng
 P0ygVMAYDO5QiBH8aUlnuJgbuBJgn545npUU3UE8bz2cf6tyWetS7zR3C9A8cqmCRPXaGuywW
 LbK92wITRgDazNJ2M8rg0TzU02CEOTo3jvrJWCrcUNzHQIXzIqafPXOeE0WXH5PfkTmnA4LVx
 KuISrGjfv7IFKmu7hWKdnflBsUJMp75Ko1Bz9EYDJdyqIWEiJ0v5ubwgZrX2BFC7TCQAO3MK3
 zmuDCHzQpFAx6x3PYNm+MbZlna2xzTom/DIZYma/+5aHiF0b/9RJkuV3wh6pkYSgDud+FAYeK
 0O+JTJGIUI5ocLMgTW13bgbE1RwbZfNYuwreEL2S/6e3oog32iTRE03kyhAi8Hh3ghcGGDHLj
 uRSs/8sWT30gBnJyF+Epx60E+eSdTlm94H2PRN2kn4IbgprnazfWKx1edW8929c0HPbikZl2P
 VoJcHvrIsOHdSkbMw+kvI/u/9uwY3+ZvVl1a2U+diUFq4KFvXGiCz+aOsj3jZp/lyxCxqYAUQ
 UGeeCE+zf5eAp6Y5zaQYHCTTb07jFcaSiXzlj26maOSiSqNAnSBmpe7p62TQYfhHaPcFGXow6
 qLFezCc01DEO+GkfATYUyz0wwPIkbkeSynlIKDgIUysKgiYDbO60euIijFVZkR8v/XoOriS76
 vD0YiV9vOJ8p4NeTObmmAcCteLontrVQYKBrYKGFBjk/9JcIJiAJCvMj6DtpGsfIB9MEw9d5I
 wEnRqlMvhRwn1e3vWctwSPz8nnTgONG47jWkDNA3QIey4yVvjvxuPOyHn2K1nLxOfMdR7IpNP
 6eYw5umnTuGAv1MlIvEt7+kgOJM6pGTRCBHwQYcPqeLdLauW+FELbx5ZwGYeDVuK2UehnVxPs
 crig+v643GRfaSnoayuX9DCregovBISNr9p9Ap2N3JYYjP467

=E2=80=A6
> The driver is for amplifiers aw88166 of Awinic Technology
=E2=80=A6

You may occasionally put more than 57 characters into text lines
of such a change description.


See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc6#n94


=E2=80=A6
> +++ b/sound/soc/codecs/aw88166.c
> @@ -0,0 +1,1933 @@
=E2=80=A6
> +static void aw88166_startup_work(struct work_struct *work)
> +{
=E2=80=A6
> +	mutex_lock(&aw88166->lock);
> +	aw88166_start_pa(aw88166);
> +	mutex_unlock(&aw88166->lock);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&aw88166->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.14-rc6/source/include/linux/mutex.h#L2=
01

Regards,
Markus

