Return-Path: <linux-kernel+bounces-215721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925F909645
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0965628325E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4839156CF;
	Sat, 15 Jun 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Mk0ejyL6"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57310107A0;
	Sat, 15 Jun 2024 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718432565; cv=none; b=K6SwvlRhk3ZXX2ZYb8LGClaDem+M/Ya1EQvKNhC5Dhrg0aBGTQCRLvxoap74eVB9chh6FoVJvrFlKmcmJAFkuyjoaKUSmPLR89z0tizUBKmMMu5kxlip+o3gEBNTfKfY7CJ7VZEQPZ5Ookz/hviMeM3XdOaqLFK7lJQfAD+kA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718432565; c=relaxed/simple;
	bh=5vSskR819gwy02xW9+6ivo+XO+ai0QdgCNJE+f8Tr88=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c2bxp84LH+ZakDX84mLVCARRFR3dn3WB3VcN3Wt9QqV5wJdQCKrtj90JVHjERlva6gQ+9C3CMTQsa2rBVu3mm3vHBjzRV6SubfJr1gr/Qr8k9l6sFacgX8n44Ex0q7GzhBZWjexJ6zhxM/LH7bFbJv5xSv4jxxh/xKuah1aIVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Mk0ejyL6; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718432558; x=1719037358; i=markus.elfring@web.de;
	bh=pa3yLCfa4A6/QNLA9o2k3ZKh1ub9kSYqi973JQDSuP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mk0ejyL6MK7Kqlvd9d4gRn7mle0rSMuthiK3EFI+ENSKkfgbBAZsIMtNCt8KmKCm
	 gZCAbmzHIb6IwKaP+jdG5NSYGYfomibhbIElbiyvmqa8GkKH/FQ1igyh9ECcfygDL
	 oUiVmsDH03HuQnS3JENmbgpEfg6hN2f/E0lXYiPxMCMQFsBh9oWO6hgHmuurhScaN
	 eK6QaWrDkzRw5iM+JE2XF4gwImQR0lIj4mEhxsLAGOhk2NfQdCFhGvppjIr5sTcgg
	 26j1y45g7E5tqVK3II6ZQGHvN7bhx37ppI8gtG63WcAWg3ff6yoK2kmiamcrXMzAb
	 QvhRTEezOeVF1q3P+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1s2Tzb3mNa-00SGIF; Sat, 15
 Jun 2024 08:16:49 +0200
Message-ID: <82283abf-10b1-4095-a93f-112ba8aca483@web.de>
Date: Sat, 15 Jun 2024 08:16:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] ASoc: PCM6240: Fix a null pointer dereference in
 pcmdevice_i2c_probe
To: Hao Ge <gehao@kylinos.cn>, linux-sound@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Shenghao Ding <shenghao-ding@ti.com>, Takashi Iwai <tiwai@suse.com>
References: <20240614024116.22130-1-hao.ge@linux.dev>
Content-Language: en-GB
In-Reply-To: <20240614024116.22130-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oRwLXp7KVlsXEEoDSjR0eZi+Amn5PL2L71+HDfFctrLT7AHzdGi
 L0DCe2Dw8h7+a0uuTBOKoGHL6tD9vg4xQnwGucxftH4e76nvr0ZMmzO68oGSTGDXjb0xgrT
 QGYflJAPiKWOVmt6ZXHQfHhI6LzEjt/fVgnJHh0UEZ7s3ImpDcUo76NxzwQAvCVRkgj3Rhc
 ZHIMMWd/Hu8mGiNbDpqRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lM1Y0VY3ZOo=;zQHAT6TxQy7gygvsZeRcsSh++rK
 zqwGf1S/eHrRWYucvOo9J9B/TcVdpBx4o/MgX81uBjYyZIYpixVETUWYHh8LTiHNepC8mI0YI
 b2KodUHqvDGmjWhpW7GHxBc1ViaqBa9RRN+PWx42ZFNUtivz2Sl5zYyKmdUtM/PpMDUJgskI4
 ejhOGkjYkBM33xoepVnnTuTCFLkF4O0LPpMSFy3tOPNfqvZZoKJkedDwpHLL0/xZyAInv4o3H
 pmi1bYEKcJcOLTXRGsgyPoMY0QcB3fi/iu6lz0hY7d08AO2TiwQtF5Xf2KNXZzuPvIiDBEuaR
 P16hpidkKgN69S0IetGoY5p6rlno6EdocDpzLIv+PEaKlbDG712H6b5Wepk0etzTB2kpb4S5A
 UQXFHJRT0eLlkySM6l4mV+GiDBJQ+nWQRQfn7XOerSwSDAowhg1NjQTIlSDpReZ936To2CK6H
 s5mRzn9VEMBu3sZ3u15QOSbIqiiZsg02U4Kdd4liybWZOpSWfcqeYTZYsS+HHOyZ44dpyfHh5
 KriSDy9c4hPysqXDxrS1jg0NFZDwQwbV98j+lx+bFKKWYNcMZEr/+U8Co/mGuh+FQ37ropwvn
 SuJBN7qfS/f/xZAAktqn5nU0N31yAyYydl/MwkYbMqAJ45EEyAKFxXTddy3+JYKrDIzqTp+VX
 2d4pHiVirNPUosi22Iigm0cI0zS4AHMOWpyTV/oS7OiBgxWi9bJmxPgQvV+vEiP4t6hhyFQjZ
 E6uKhk6xw9P4uE5cvXCNyquZrWCptFokufy+MdjzU9fQi8dfESy06XNWbm1KYlmMio0eVfSwq
 1OvryaXoW8x+Nr9cWnejzZrU3N+0TijjnFAUb47pgLhO4=

=E2=80=A6
> +++ b/sound/soc/codecs/pcm6240.c
> @@ -2088,8 +2088,7 @@ static int pcmdevice_i2c_probe(struct i2c_client *=
i2c)
>
>  	pcm_dev =3D devm_kzalloc(&i2c->dev, sizeof(*pcm_dev), GFP_KERNEL);
>  	if (!pcm_dev) {
> -		ret =3D -ENOMEM;
> -		goto out;
> +		return -ENOMEM;
>  	}
=E2=80=A6

Would you like to omit curly brackets from a single if branch?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.10-rc3#n197

Regards,
Markus

