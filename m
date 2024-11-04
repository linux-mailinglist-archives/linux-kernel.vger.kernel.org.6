Return-Path: <linux-kernel+bounces-394481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A09BAFBD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF821C21AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9401ADFFB;
	Mon,  4 Nov 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d9FQ15s9"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2C1AAE27;
	Mon,  4 Nov 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712969; cv=none; b=hXJMplEW9hye3yhA0n0rsFjiJQgAzEPuo3nS15T2izx3XsbJQ9OX1VHKc3Z5+O+Ad3R0ztI/9+Z8ZHvuSBAuaLm2OWekhMNOBdzzInqQB+dVcgITfAcCAoCscESEDU36PbS/rWDqVrLd6eOaZnM+uuAzT9k9BDH9kXWSIpctGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712969; c=relaxed/simple;
	bh=OZU7EisROitQm9UKkAKn6cyUaMVFwrs2M+6wFnp01/Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=N0ZJZ9GILjisRovJHWf2dYqaDn5/ExNQa8HA523tsSUHb9CTU3/Zwp1B2BQUlIynlG7tPipQh9Pgy+FqHafiIq2RJWSUrD/QreNyO/auSWpfRQAptuNh0+PyVN6s9NhFQepc1cCUcU7pdrYdLH5NNgApNftvtW4wAgiy4cr5ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d9FQ15s9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730712935; x=1731317735; i=markus.elfring@web.de;
	bh=OZU7EisROitQm9UKkAKn6cyUaMVFwrs2M+6wFnp01/Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d9FQ15s9wCk8mgTbgGwrPDKx6h2mFTz4PtwupuQRPe5CFu1bnsQLJTo4WzFuhf1U
	 u5wGWUwDsDA1n1w3C2gaC8RtwNNCSgxqgmC2GNTIrZ+/GYNj0EKNdFsT/RVKmbsPl
	 WZg4kJfggvkkCTUf6RP7xAU0svK94SAnubVKwBdE8wTCTLjRJm9RtXWIdooWYfrTJ
	 ZBIBvrD8Ql/I6q7RYxILXTxzAvWNbG8PTjvZ0kuWId872VN0ZbB5BQVjKR17IhOio
	 KFo/5y0mYE6cDHhFHgJcpOqxKtIYpRtCD7yFXtQYrQT8020OywEHrUnKN2wLInnxP
	 Uk6YILANqF16QUbEvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1t440L0IOQ-0043na; Mon, 04
 Nov 2024 10:35:35 +0100
Message-ID: <e1ac11b3-b746-4564-8daa-3527aa13e348@web.de>
Date: Mon, 4 Nov 2024 10:35:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Emil Velikov <emil.velikov@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 syed saba kareem <ssabakar@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20241104091312.1108299-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Fix for ACP SOF dmic tplg component load
 failure
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241104091312.1108299-1-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t147qZrJLa7AZUH9g3WArVAjME+fFuU5SLNNeXrUy5CyR7KC/0q
 13dGdV5l3Wtxp+pBeckAoYriBuRraampOJgd+09FsuQtzRUR7imp5sNBY7p5MU9oqkeiGnn
 WmyFVQxZQ5ZJz5MdnP1BjyVgCbQVmHeBZnF+CICS1961SVTjojfC+PYqDFI9/c1KHxWZo6r
 FB2rCuDCo9NEjQzWh/0Dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Iea/YmE1kSY=;gVxxXN+WQbtUWzm8KB/OPkIBUzQ
 IsoFhOMRzEP/cbXJV3hbF6DxZjnbAzJTZ++yN3kNrIu67qXHS/cZmc+H6pbFzNbGx535rUm1W
 lH/tRWVlntQff5dy42GrJsplSgDTni2+t6aFxRjR108EeDGUXLJiCY+Eol5bg8fZcw0CqoSFZ
 gkcd37r1mjS2CX+gfAi50nqUoMCUCod3ujsC9G7VnbUwU8zWQZKaXG+Zmpc8Eh0tmr+tjWinz
 Bshafa3Xd2KAf7ZaUL4Y/jdk3YWEXmmPDJKEZpJICTPAqVTxf7YnLrAcIZZqP2QXkRN27grAp
 1A25LkSO/Jg17ROCFe9HQNlj8K5LgNaC/NJOthP8YSmUpKnJTSnCjhZmRut3kLO3V07In4xUH
 Z7YMwc4q3rWdC/pr+poef2amGE3OvIAepHueCI7ICjtAkS3Mh+jhozbW9Cqj5E/7TGwRunyUH
 iWSohZNcqeRfrYHBPZEyJFvU1PaGempmw01PhwPHCuP0UP05LSQ1/VxlIY7rOZEgSiMbjh45N
 nAweqyt7L1cZPoVHTUmw9F6X7OUFtvJPX8p6V5WVN4n6cW1F69DNZRJDXIVcTLt/tsEco1K2r
 FZQoNg2Qa0TRAfPpS27o1KfJdHW34QPN4xiGI6RNpcwW3JG1/af00njjT3x4SL9lgMpKTKoDS
 RDJwIRivSc6UKLFehoF58XacEGtend7WTXk5UUv7KRvAW8yWiyFFZSA5TkigZjLI3HuLCZXnG
 0ZF13E4tAGE7GLwM8GdAy6cLpTfnaeCndgEfgHRcEPOowlEyx/hFqbNaUFK24BYHeyF00eooG
 rd9UZS1R9n56omaiWcytNLbw==

=E2=80=A6
> As SOF framework assigns dailink->stream name, overriding stream name
> other than link name causes SOF dmic component load failure.
=E2=80=A6

Will another imperative wording be helpful for an improved change descript=
ion?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n94

Regards,
Markus

