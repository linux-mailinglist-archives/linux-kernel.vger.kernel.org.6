Return-Path: <linux-kernel+bounces-356581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162249963A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DEE1C21127
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64B118E345;
	Wed,  9 Oct 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XOcORy7x"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BB1891AA;
	Wed,  9 Oct 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463474; cv=none; b=gEpxuRnuyit3kA5XWDgmgpzvLyKEe/SuDdeIV+hD7+m1YT6JDsbEzZQpqg/yLim1adPTqcuKqLLiZYabrm0rBEd29uJw9m7mnL/qYYUCcoXagJICT3SIcLR+DPnfCu2jjVqjkbXJ/8Gmd+0twaFTy5b1fTaCaSV4JK6k8TJn40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463474; c=relaxed/simple;
	bh=+mtaJQP4GNFcQWgKTjmHM/0w6+oNJjQy82KD6z4/F1s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jjBMrJUC9PkEykwAhtrGHyVdCwkl9UDmIiahziXRm6f41cWn1eapAc8M9YADu2AP4aHC6SbLXTy/jYuIwXvcAMomH4qnhiALfirxdCR7Zqe7H4bFevLQSQxxY+N1sAWeQY4r3w7zXXjBc2FMup99inOcDeuutoZf85Zw0MXOUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XOcORy7x; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728463434; x=1729068234; i=markus.elfring@web.de;
	bh=uZo+r4EnGv8c2iHS11F0czEcf9nBPjy5LsYCtaZSiVM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XOcORy7xWs8QtxkOE8HFI7NEYQjTwOgxfg3Q9HumF9VatFzz/MADqFJL8QpKacfI
	 mwSz6UDCwZmItOAGdBDyCa4iJmtEuoxT4IDgfUv4bBzq1DqVg/SRGkpX5IRDxpcvL
	 EfAi/jNSPSW8bSQvwg9iOJiRYLyJR2gOn9GXpih+AaKliOLjBLLd1LoEEvIeNkBic
	 xcZeUe3UUSGo4BzIn/WKHo5D1dLozTBkbr3hreSvL6biB9wHR5ZfOkqBu0v9Q6I55
	 rNiAURepZDWB3w8lQvOIUdXLYy2Ea13gbMBr4SQFaCqlWE4E3zZmD8xeN/EddxDrP
	 sL/0mqQ71ElTRlmfgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1u3gW604rM-0164PH; Wed, 09
 Oct 2024 10:43:54 +0200
Message-ID: <01d7c030-1d80-4533-9279-2b6961e712ac@web.de>
Date: Wed, 9 Oct 2024 10:43:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Weidong Wang <wangweidong.a@awinic.com>
References: <20241009073938.7472-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v2?] ASoC: codecs: aw88399: Fix error handling in
 aw_dev_get_dsp_status function
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241009073938.7472-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PlXmTsnaZtsARTF4sMdTjhMix522MdecsOUtNRYZiBia3tDF7jc
 56X0yvNqViKP/nbHyex2T3Ev32vEDaJt65pIyLdTlFHlYJmhxrOWZPNoAm9Ery7LZw+kR8N
 cLYzczl3qSTtqHx1wzXmpR/ulO7bA6gIEiZUBdteay9cBUGZCu7wxmG4+6B5ctci5ytfD6f
 GtC1Yu6t42TlJZJEthEkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kRIMdFOXWp8=;kG5i8LHkG7wvlwwvsLnMwRvd3nZ
 cM2MTSxWpI8aEGPYKqCsFdfjvZCcoXtZ/bc3VC3Yzzg+4tMVIr5qwICiWBHMr65hjAGN2F9ad
 fFztAW82LniTo4aR23TQdTuh2OkdE/DGVUItACPqeJx+i1WhDBE1NOur85EXXeiVZET3Oa6s4
 /oKtRotRT0vdbxnXnWOOqtdo5VMpicNrC3xk35foTxdS5BpFWo619JJNrkRfudJ5ABTKqR7F7
 ZyDXQ3BD0jrahf70BV0JAx+lxWp8mxGmX2cgawgHLYkZPY2J6TPuKqB3wS70ZHU4XMVRjnnUa
 ZddyJMnsJL1z8p7K2VJlQ8tD65h42zX9ar1O7Rau7tgxh8K3egw+UjAr9oQFJrXTDLF8s8n2z
 trj8RZTJ+Iu5Jmv64EqQpjKbTsawu9ucxcbBiUBYwk1K2VUTP3yIzHVeiO+V4CeeNYOO4HMhe
 fAtONhCAdzq2n2AbcK74iNPSGEhPs0qUU9cj3aQ80B0oaZGMuf4KWL71g1ifRWn60sl7P4ljy
 bcb6YvuPraSskjd8cPUOYI2TaZMjt9K5yqBMGRfDV6KMGrezwoSkdRVlgqx+M6V0V8Iy0OoZ6
 7uaN/NLYsgwt0WAtx/sz5u+DJTt6rKcijcM2SGmDBoi6EHWP4eDwNwxbDyGAc8HgsBXmWPyIm
 FyU0JN4LOX9+H4dC9H6zY/moVKG3R/Jefg1HZHEAbMvtzQqA54x16sJ3L9Sc9yHLHy4bBgB5R
 GCpPN7mTP7LRyMSX9pueBV6LBExWSB4POr2m4dZXg/6I+WcrvAJ/fx3gG0nir9saKAW9sw4wM
 6R82vk5C5qz3V66FyPkS8ngg==

How do you think about to replace the word =E2=80=9Cfunction=E2=80=9D (in =
the summary phrase)
by parentheses?


> Added proper error handling for register value check that

  Add?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n94


> return -EPERM when register value does not meet expected condition

* It is usually preferred to end such a sentence with a dot, isn't it?

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?


=E2=80=A6
> ---
>  sound/soc/codecs/aw88399.c | 2 +-

Please take version information better into account.

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n321

* https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+p=
reviously+submitted+patch%22


Regards,
Markus

