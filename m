Return-Path: <linux-kernel+bounces-320317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96839708C4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262AE281E18
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1A175D20;
	Sun,  8 Sep 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RwrT+zjy"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCA16EB53;
	Sun,  8 Sep 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725813179; cv=none; b=iEtkJU2t95Rk56ICCtbuw0DP19nbWOfqbukLmcVJFfyBg6s6mWPwYk57DGn0fJY2YNJ+LaMXU+fLR6fkNNvej5l5VO9eBWFb3WK+tZwJ60IOW0NT4zz54vckErEGYQpEa+lk+eF2kUAxiOnHtR9H5F384BH/0wMFHtuOf+jGjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725813179; c=relaxed/simple;
	bh=mHVY/RFhDJeMtkzU2Bj0n7ZfFvxuJNwR2boIwfTkeoA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FYZRqp/J9zYFoH2lh1tZUXuh4qLe/pA6NiGaeOqNukUXGggv1DXS3vgJw4VXWicuXp3Xy2SlBX1uOBxpu0aPUt4dBckh+Eu3BEBrvApIMRGlnPGeOCoN5QFzlx7Ka5mHAnwZsIKPR1GbBpwB4lzCq0X0Atu3uqLNve1WOPdoTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RwrT+zjy; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725813154; x=1726417954; i=markus.elfring@web.de;
	bh=faHD4IzwtgCYeAGURuCec9vYzIfY02tRv23dap76ghA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RwrT+zjytruupymGStnEKodarxfiobZ+BEz22DuLGANnxNv1xtdE2L/vZ1CEnZX0
	 0fi9NpEe1Cm+wtWUU6+o/RR6KtMqDj8e1dX3xGsC1ZZ7P4BoAb8015uUrVz5w4zCg
	 VWyhx6ZLJhPkMd3NwkvhuVnJZk0Pk4cqpR/jHS/SMXWS4e9gG/mr3J7Ut4RTbMxyV
	 tsQuMv1NgrBcZPZ4N1BCLVLH1PYvTM8enRF0YXAIeg5mm6cwqlFApvmE92q//lGGr
	 uOG9flXuJYmLh2nYIFWEI1CHLeuuQYGbmLjlA5jAy1Ig6ruopzmJJYCsTQi6kHbAe
	 ysLLLQfTGeaESHMRMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIgY-1sAiEg04Uu-00bxzV; Sun, 08
 Sep 2024 18:32:34 +0200
Message-ID: <21196d4b-fb19-4c3b-9e28-5b1c892a0b35@web.de>
Date: Sun, 8 Sep 2024 18:32:30 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20240903090620.6276-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: loongson: fix error release
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240903090620.6276-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uDZPp5733zwM6Ntgj36NoUvI6s75st25UrROQzyw8o3fQrGYNEv
 8XIsBgul65pBTvXwuPOmZbXlSxInwxDu05tY5PSo3lRYKUrqjN8rMs7NX4UuAfS7dOjdS6J
 K0p2PJc0D4P3rx3y+B7mO7qB1cO7S2YhA+95uXX1B4nMx6Xofv6IUJQIA9OQ/4rCvHCuCcu
 SA4GfnaSR1Y3OZnJdEpNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P+OeBumc19I=;DC7c0nkt0H2Id3M2+DrKc+CYMua
 Zr05QnR62+pzxlRN4ptXNpeGg5B9nkODnBGDVrZFueZuHdpsCAxG7QuEBCCIEdWj8sz/AcgV8
 mKywAAtd3F0MWhz8MGaLjVBaGjAvfbkLC+OqBn3mH5P5oxK0Dd/Cov6mf/k3RtvjYeyMw3yVx
 Dwo0R5eqvuBOtd7hEJRTuQ4czFEyAeBAklmIg8nBG2dyfeMYQ2uV8KnYW1RONjNrtGRlxeQoO
 +TRVeAGNJuZzLHw5o5QZ0AC/cvOsIzymJT4KA33CGlDdUe7HWVC//jYgIbTUjlW22iT9npf5b
 XXWCkAtCEp6Ty66ExlGX3ftH4/1YO9P2SeRwG5YeF5wL4BDqAKQCghzkY95+mweKKMfRQK+P/
 VueSQrDyNjZpDx7YOKdDICYTMjFkbcMg/qbuRdozmjGDrfVYHKQ3OhRR+Tp7kleezuny8jzcR
 Y1j6ftgbJKl2wtmmIRvANTLNJRhyWG2YNGDB9W9KO7LUBr5oFWKSOP+W4POc+Bmh5GJgOfal4
 HUgB7hTZQIXnvTbyvBOWjHBAkdPrYgjB5f5GldDmR5yauGfpGRUgs+1xdZqsDz0JcgRGHVL8Q
 vhLq4YRydiwd9lYJAJu7HYl188UnoadKWrgNRXQE0Awx7ENX4tAAHe6sHuWS6d8EK8gQ1FpeG
 dp8aoMTYxvS2RQJWl4IDXgFv1GAAqVaccXXWwMMfX5OQtAJMMxzb23nkiStsouZCdBZIpKp98
 Fo6NqJ+VpqfeiNlnDReSRm3Q1AH1aIgPfGsAFf8sVqfx2hZgf+MyTvPGnwJflNkyALs16sUCE
 klRz2l9e5y3+hot6Qis8e0bw==

> In function loongson_card_parse_of(), when get device_node

                                                 device node?


> 'codec' failed, the function of_node_put(codec) should not
> be invoked, thus fix error release.

                       exception handling?

How do you think about to increase the application of scope-based resource=
 management?


=E2=80=A6
> Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>

Is an other personal name preferred here according to the Developer's Cert=
ificate of Origin?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n396

Regards,
Markus

