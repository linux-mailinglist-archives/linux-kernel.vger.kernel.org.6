Return-Path: <linux-kernel+bounces-531421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D7A44051
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012E24204C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8042690D9;
	Tue, 25 Feb 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Me+uzO1z"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97E2690D1;
	Tue, 25 Feb 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489020; cv=none; b=JkQJcmdT65MbmIjBgsmyjkFvrUeDHtGVN4gZiA0DsdPb/IduFujzDYO8GH1z1pu0/CuEa4NFq7g2GZpvfp1G2CQA77eK8h4+YR4gEYKyAsmyzYqe9QCYCmkzdCQdP3ctuMm77GVnR0sZSdBAb7ulWNlTwYPfnaenCHpcU0a3egM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489020; c=relaxed/simple;
	bh=Jb9vzuauP2H+kDu/VR2zAVEKBcnuo7X9NOzfhwfu47I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CN60cNkQ9lORuTfFnryeRNj7qelwR0Czod3EzbVgp7tarLumUyHQy/0IQqx7c+35voCOf9DmslMew4akyC96DL7HG7kH092/ovx6Zwbh5lXE6uFK+WlrnPKROIN/0EvO03XJQS4+eWtiOiaSn37cjS8W7j1BwT7L55mG7KSY8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Me+uzO1z; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740488987; x=1741093787; i=markus.elfring@web.de;
	bh=i029VMQrtBpgtUWTznuij9OfxhOaNdfR/97gam4psFY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Me+uzO1z8P9eVzHixCWKSE/3VfGr9s2onGj6IYhAcz7HJLJR0NAJo2c9fWome1Tt
	 XUcDnvOpJM+Uo+bJAwrIw/iIZgDOWoYJcW7tsYNTgHIRPMeYRlVGOH8o75Sq4VG+R
	 4ax2UNzU2ipPbUPA1P6x9dhyKi43NzB0BFroQuWAIr6j0VSu7A3wxKJtZdtMwWHwM
	 Dzxtn049xf9xBKsf1o4Eaoq2w4VHFczjsLc4GEh+aB7vEbJ24pIBwFq5kcldo+y8W
	 NWjFoSnmrmPAOb5c/6BoSWOI7tWbiAFena4i6JQRA+5Cg7yXDl5TAHbGSt4aDufvP
	 u7EerNZB8os18Ub5qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1tuJ6k3CHl-00LFOr; Tue, 25
 Feb 2025 14:09:47 +0100
Message-ID: <32992dc7-15a1-4ca5-a5a1-e7e26ce74fbc@web.de>
Date: Tue, 25 Feb 2025 14:09:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Weidong Wang <wangweidong.a@awinic.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Yi <yijiangtao@awinic.com>,
 Binbin Zhou <zhoubinbin@loongson.cn>, Conor Dooley <conor+dt@kernel.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Jack Yu <jack.yu@realtek.com>,
 Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Paul Handrigan <paulha@opensource.cirrus.com>,
 Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Rob Herring
 <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20250221102623.369435-3-wangweidong.a@awinic.com>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add aw88166 amplifier driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250221102623.369435-3-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:riAmvwFPUhMFynWWay+uFRh8YpTOKq3JRXHtflEzj+oDzgYxCsz
 pwvqA9YyumJYdfyoxAK0NcW9LkJ4P+pMkol3cuikR1mVzBw6piJnncVX+5Dy+r5sD0wkpzn
 SP0K/xUgKV8khIM8Nd0SGkB/Wz50NaxyFESaoEC1Tf+yqbps6LECCf4Ye8qBfTTCpqSanGx
 oXhnyLUl982ximNUlR7yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6sy7Gwobrfk=;DTZomGTNI+xtEnLkXlY4ZNPKgT5
 hZMieKbKTW543RUofR4IauZkF8cYYZaPxdGoEpXJ2nWz/y8jc9lFuK+vgZi2hDcKWNyv9GWN2
 NSEquUixnox+0DEbMW6QBiJpntJd7JgPoaobiQWiehf27fWXFMZRj2b3PBDTc3C6YZLpH89ie
 3t+h3nu0Y4XwXtPKTRJIM04u/nCprdoEprB/9ZnIV6YAyivHjlJuUKdwhK0bbrK/A/3WwdRx8
 4mKwJAznZNjsN7C6lIFrxKRevkILS+dUPVMmwaAQzXJ44oji9sV4ARmTPKCuNTk7+UD2zdLqN
 CVOp0BSAIQtPBpxNfCp+zw976Q8uXNpqiawqs1/RmudFZezsNunl1nrCMHcG+SgjaYzFyv1mO
 RpO/oA2Zsq3CpDMgf2eEsDczPAUX4oLLLMIPdcB0mF76i8S3YwRjDrKNCr9H9u97R5vcg71wn
 ZKYi+mSN2pnqbfVCiViANzCnSPZiRzwUNJalz1r2Z7XUH76qVsi3TIZDcmOm665gO5qM0XATv
 PDkAqgxYimm/JEl+gaBeN18KBu53/JN2Y8JaGxr8zDUCUZoleYZRzbqAB1kYlM5WV5Nhkgx7p
 SsSTTatj7fMSNDQSLlbTyEIPMcxoIgIVHk/ravEVk95l/SdlkkN0uqiQavU5VNXxdMF0Z/PXA
 K2AP6dkGKZW9HEK18heu8Knc3+oVefgFOkBbDe4ekMnvUpsatbd6vYCx6bvCJWPfxhW1v1iBQ
 XHUlIge1o62fL2is0C+ttrrhK/AQKsuscjIGkdS2PeCIsUgkrhSOGnQ2mKl1Ak039qlGRN2jn
 81Nc0j0spFrrXC24tKZ7RJIa0Di/99iKsQnQJU/hzsGFSwrllkGwHsdBFfjlVSuLx1eEKTtKH
 1Umu9Njf3SNoMqZa2//phjPF3w2lnw+gxPO36jCmqyrOiOQhAOPrvvPoZ3sjJ8GmHLkWXYdGM
 rAXOudrL5mecrbkimoHX9PJo4lWBQETZ9VbMfXYUevZpMqxOEKzc3PNNMxMuAaLdmkY6YmYWF
 v2EatcXiYNXKAVoRm2364cLPdOtZyVe+Qnaw4BLHzUb4AXXagvPNvG1Ehv1nglYLreQrd4aHk
 NQPtEi4ZirgSpWTl8PXXbErjxvsHwTezJHtOWYjdVbe3ol4oDkMKga4RegNes8rI3NUjH7xUZ
 na/yScXKsdD48qOz0Ndesw397RjzgrQlPval34VbWxur38sW5CqziT8lr6GhozYpKwRWVpTzl
 ShU/O2xf4nHgVAB30qQfKomviO5CIYWZiR6hAxt5XYKM2Q50Zw3sgYLUmdHyv6JK/XQVVxepT
 DYHOPIURKrnvaoiT+23iGxGS5ZhosXmXTue5jq7kkoFEJjeIBNAMsT3TA5G2u1W2/wRaqXReW
 fWcvWPTS+BsxcAUztFGgSPS0jrKnQtDgBJJw/VMPGgj92ApWYb/ocIE8g7Sx+E8xLDyHkB1qi
 xcHcIL3L4Z75j3xH5/yVB4St0sjY=

=E2=80=A6
> The driver is for amplifiers aw88166 of Awinic Technology
=E2=80=A6

You may occasionally put more than 57 characters into text lines
of such a change description.


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n94


=E2=80=A6
> +++ b/sound/soc/codecs/aw88166.c
> @@ -0,0 +1,1937 @@
=E2=80=A6
> +static int aw_dev_dsp_read(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_typ=
e)
> +{
=E2=80=A6
> +	mutex_lock(&aw_dev->dsp_lock);
> +	switch (data_type) {
> +	case AW88166_DSP_16_DATA:
=E2=80=A6
> +	mutex_unlock(&aw_dev->dsp_lock);
> +
> +	return ret;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&aw_dev->dsp_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/mutex.h#L2=
01

Regards,
Markus

