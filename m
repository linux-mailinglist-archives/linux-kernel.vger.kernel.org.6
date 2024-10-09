Return-Path: <linux-kernel+bounces-356883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDFE996823
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39C72868DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60401917E3;
	Wed,  9 Oct 2024 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CTmscKQS"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7418FDA5;
	Wed,  9 Oct 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472391; cv=none; b=TAB0KL9E8AyqfJ3QSrppiZL1M8zTvNDxgtkEkVPIngtMtSonmN1c16g0T+uvlHpJEKGhYZRLNrtojGE4rZnTHwZSfbFVQu5zw5WmC/H/yPFu4RT5JDNUzeG0EcM2SfXZffI0mAvAjd3i7oHKJmuXNnEESW2KGhmAmFTOEAcszdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472391; c=relaxed/simple;
	bh=qX+mA08DLyAXi1H7Huu+eGvfQcA/tRypWuV1n8HMJ08=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XhSMGu+fILB2M0t21GyJeCeLwY79uLKjmtJlLJk39F7vICclav7Dc3Ohjqdxm6rv17jpVMa5LyOmJ69MSoiNS3wu/3A+C8J2yoUfUgdHjsbvGWjASExMngtdLe3SRqm9q/zZvLo4epaGclw3vtyswsY5dr2YeFoHJueZW+qeV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CTmscKQS; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728472343; x=1729077143; i=markus.elfring@web.de;
	bh=CmiVees2hX0CJRf1Bpt/vCFWZaY/cbKkPONcZT2YXwE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CTmscKQS/R58YI8WwhE+yjKW9v/7O9kIudoNoyVPcxcMDY87UqaGw9j/Ev3Rykvq
	 8y6uiD4ocauwKTNfeWSmKHqPlHsKVaIRSRRCgdGQxJXSveuhyM6b/yymXnmm7B1Bb
	 NLNTwS4RmMkfpi8IIwESggGrKs7ILfMWBFl4jLgqlnOfRDO3NvdWENqmgNrH4Ax9n
	 Q57tWUt+i4uiLzYp57qJzOln0JpOMdOb5146jZ8ARr6RvDvVMd8F1iZY5SKYgb+TR
	 mztC435KLtNLoZFoRWh6IcuBnp85FUb6ruSirmJkqG9JnIC3xCKQmjh9l1dq7EUfn
	 Oatza6V+3FFO33Mihw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Madzi-1tZUOT2Dgw-00cl2a; Wed, 09
 Oct 2024 13:12:23 +0200
Message-ID: <fbbe290b-4dd4-4a65-acfb-8150b621a5c7@web.de>
Date: Wed, 9 Oct 2024 13:12:21 +0200
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
References: <20241009094313.8820-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v3?] ASoC: codecs: aw88399: Fix error handling in
 aw_dev_get_dsp_status()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241009094313.8820-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8pc6Vr5WhFwFtYdO5jKwC4wy9m70WPVXhHQSpdeRW0xiW+GzZei
 9X8VAehrnm6M3LZRpyHB4OZJpAxRi44n7HVE8i9IzJc9y7xy12+eSih9JQNV46Sj+kP2Wc0
 O1hlCnnBF/Df2BQ/iP/+rhAGJwMi0BGWs6SzuFPSAYsD8CqzU3lUuetpJTq+nPoUPH+09aG
 rvAtUxjLpeqg1ZCw1Jkcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KxeBCJykDkc=;6U74B9J8sUp2lcGsuewT7kNrO/m
 SqEE8rp9shg7qBCkGdYsPQRFwXsnZ62/b6Cg14B97U8JzIMQ/yP3BJh9+J8stf0F844BLIrag
 Cp90dJ6J8lZLYNIXkupgh7cDyaDr4TvBLMLW4sEFrIh7IJb/rJH+6UTGszjrYPGWnMw7aYFiB
 cwK/85i87u0I7b/1Q7ec5IDqdNfntErW2V5upJZV+0hZrT2MVL/HQq+XhqfDaU+mhzag9JRmU
 VWTaFYv5hnYrH6V6RtUoRN7mOl0goRqWDVJ9JielCp8VV66udw+Mpt7fv7SWukfBT2Og7ka0v
 /b74yIQWJ4WqhMFv5/rG+3py7FqzFzkIVZ1OVieEaSTHNkSTBYWSOz9987xcMX58IOuqX1tnH
 CS1htd5VaryZKND6J60jPyCg5jyLFhetR2C+/S3WYY9x+rrgIUgmzzi0qRd/tYdIvbMNolJTG
 T6n0NSi+i+GGFJFePAgRdJ+I+I5QcZpQ0yCWZjEfD50aI8mbUqFOe9nlBCEnwlcDSemq6jCd5
 /SvSLdvd76kIb5H/QP13rgBCiBaIq/pbMxTk9Yt5kfyTY0Eex0awVw/CtZddXQg8Pk1dRPIxM
 vae4M4zaxw5Xbw4DujKgfVeFCh5LV46LCaOoZKy4J9GFpiytB3YuTAWr+FH7wf2QhzRF7Unzq
 hmXsY/F62Aoo9ZYp4oQALRUHfqwlxHZj9fxNRplKUxYZc1iRWygn92wHEzRAztLlxuEsaNtey
 QWSJ7dHGgEUyDkqMgpKuiFBRUwL+vlRC9CHYTUxBjrd2BGnS1JtRniMsp6zzZ/WpCsHwy0z6A
 pJFeboDJnnp2q3HtHZiMu9gA==

> Changed the error handling in aw_dev_get_dsp_status to return -EPERM dir=
ectly
> instead of setting it to a variable.

* How do you think about to choose an imperative wording for an improved c=
hange description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n94

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n145

=E2=80=A6
> ---
> V1 -> V2:
> - add a dot after the commit
> - modify commit info

Can it be that higher version numbers would be more appropriate according =
to
the evolving patch review?

Regards,
Markus

