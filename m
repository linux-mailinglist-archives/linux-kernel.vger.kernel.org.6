Return-Path: <linux-kernel+bounces-439023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D519EA99F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6559C28890B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42023098C;
	Tue, 10 Dec 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XkZGc5If"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35C22D4F5;
	Tue, 10 Dec 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815736; cv=none; b=bfXeX81sLe0Lzeq/nzDpODao73r49DPosJHTYca3JxNwUlTOxjUVBgMbH3p2JwKaD7kKoOgaXD+B8H5rWrH9xHLbBC4HZuLvmNljlJ6ZYaV59ia83JjdqvvmBtoMb5J+SHmoPT78zwxWXFYHeriNtelcT7O3NWXC7LZIHFor/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815736; c=relaxed/simple;
	bh=lJwPfASKJ4GC3o/QT5Qu5lI3X1tn+NdpZZ9ckGntbh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOYFsSiu677IRfo9uEiFf6PtBJtKQMM8Ryz6zNQS5BXxK9TfEG1f8MH7bXVtXDmcEtYBxjeCXfzhEiyPypxAsKq/pIKVRwGGqbP9/YR97Kv76qkBv9GqgEKexRPi5SInyGqZmYv7FTKlLjr9WrgUByYrw1C/N6bsuXlud6v+yOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XkZGc5If; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733815715; x=1734420515; i=markus.elfring@web.de;
	bh=lJwPfASKJ4GC3o/QT5Qu5lI3X1tn+NdpZZ9ckGntbh8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XkZGc5IfyRvMYvE2Z8QesN0TDuxbYOTVYJE89bOzJ5l7g01u9zMexsslgEsCjMEc
	 LILU3cUtI6u6ZwDlVnVsx25jztL97TLwnf4oxKEs8rvjjEFCcXYNPabiDh6Mle1l3
	 A/9JufRxsyNeo1hTfLSSNcOxURryiTrZR63UyI81zVjgYK/57c/7TE6Q1vDR6+wIl
	 kSI93RAlLzjo0yb9lvpqdgaSvdu40aarsLjkBjhrFbzHhlGyapRAjxfAq4KvX++lf
	 48AsmWKUT8NyPygHfObsBrPJgGtBlQtwoo8Zo8Sk7CDNilUnyMeZaudMtxxmCP3Ja
	 ccgwRfDjw14CJcn1vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkSI-1tuVo528AI-00aOEY; Tue, 10
 Dec 2024 08:28:35 +0100
Message-ID: <f5442b45-7dc7-4463-b87a-91381bf28bc3@web.de>
Date: Tue, 10 Dec 2024 08:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Fix the wrong return value
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
 Jaroslav Kysela <perex@perex.cz>, Jiawei Wang <me@jwang.link>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, end.to.start@mail.ru
References: <20241209101320.970571-1-venkataprasad.potturu@amd.com>
 <cabca893-74f3-441a-ad27-9589819cb1f4@web.de>
 <21c58803-a8ed-44de-9211-7c8742cf5eb3@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <21c58803-a8ed-44de-9211-7c8742cf5eb3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sac6gahFNftP7xgHDq6hEb9kmKcs54d2KC/jjQotC4JH1Vxhax8
 jSNVkwNMZ9YahMCU5ePfyNNBz22LjbF3ihLW9w6ZWty0Jps4ZOxs60sN0BjYuzBKjAf83hk
 /RCVP3kF66F3HM06VJgcv0FbQsWgXoAHrymAmSvEaFtPbGXwMjZAqCU8sjwH3EvhCExCptL
 gxx/4TP4IUcX13GAioQLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lgeYQjjr5qI=;0W7TBWtun0SUbTb9cL1D2nW19dh
 IMQovEZMcoaT6lEAzrRVXDTwffVnlXqBT8ZZdcORL+gLuY3FG8xRXMqxSxgrUVTo72kAxt9aR
 NyryGo/Yib941Th+MA0RvTKKn6ymvLLbiIQhKWh1n0tK/5HppYJkW4RP/2gTGFDRkjo5cEkZm
 k9acNqOulmyx6RbI8CyMJ9mmeVn88ULFjKN9Q6OY1uNOuoKfYAY/KvKfFGAXlNv+pKBQnTRNe
 CTdtWcgAtobW8hFhvjhQM2WUNPo8AhSe+bDwlwL4Zzf8B05x0qyfhXejT+V0b3r1G1hLcn2xj
 2QxwJLpT7809PA7eJTRnf0QCcI4J2LBgQMDSVDkTCV/lkf7heCsy6ofpVW2LB/B+MAUzf9liB
 lSMQcJDwtNVIi6g9SRLzNk/ZikxGBglxcyaDpf2ZcML3sa7DUNqmgPADv29+SysK03I87m2OR
 fhGq2x7BgMj2oOmbRdV1sbz20ZRRmVE3CccB0l+7MNQpEu3FWOG41EDBgBS4jf9ksOadJkRFi
 vfBaBoFYX7Pxaw1Y8xWQkNBZsl4suaxRCse72fuIDw/Q34+/A9ArUhSN7xEgroMVwjRFTrfA3
 Y8VVpt70kg4TP+HPK9yy5SNcKiAgZ7CVNKzNbiPUfGtUed5USIpYzbXkQaQazb9bgYz075nH0
 00KoiSekip0P6iV8TFsZ29MYbKXKzFZ0mNgXFm22JqTlO58qtwNTTFvtDA55xAveqF7tkCmpt
 NDpOT5l7ahg0oba8OHrc3lRiamIbOlcNH1lozTVWYoN/gofd3njRnnEhoeqVl/f1TNqrqEih/
 /QBZDzUwDnwp/iuwUH5s73fBbpbhrgmXcism/obtjl/vqjihh5R7Wg5plJuQXApJww6VLtD3K
 jD8dJqo9XBfuwyGfYDpTgW+eYFOzzCB8z5eOfR2GttghEj+SmXnRrDAQ/YrWeBG/V4bhapvJ0
 X8lw+miEJym80t32nJ07OKj4zEhZzRd0Bb0QygKefkpxEhcUmZ2P72ZKBI/dIQsf/T6/YKgVn
 iWMq087p8WeEaiICfGdXmFk+MIX7AsasHKnDoxK8Tgh39T2ttzGAGDOUHKzpfPtn+5Fw6YP2w
 DMs3mAETo=

>> =E2=80=A6
>>> +++ b/sound/soc/amd/yc/acp6x-mach.c
>>> @@ -578,14 +578,19 @@ static int acp6x_probe(struct platform_device *p=
dev)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle =3D ACPI_HANDLE(pdev->dev.parent=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D acpi_evaluate_integer(handle, "=
_WOV", NULL, &dmic_status);
>>> -=C2=A0=C2=A0=C2=A0 if (!ACPI_FAILURE(ret))
>>> +=C2=A0=C2=A0=C2=A0 if (!ACPI_FAILURE(ret)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wov_en =3D dmic=
_status;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!wov_en)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -ENODEV;
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Incase of ACPI method r=
ead failure then jump to check_dmi_entry */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto check_dmi_entry;
>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_dmic_enable && wov_en)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform_set_dr=
vdata(pdev, &acp6x_card);
>> =E2=80=A6
>>
>> Is there a need to adjust another condition check accordingly?
> No Markus, not required.

Can it be that the expression part =E2=80=9C&& wov_en=E2=80=9D became redu=
ndant with the proposed
source code adjustment?

Regards,
Markus

