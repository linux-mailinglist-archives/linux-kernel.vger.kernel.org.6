Return-Path: <linux-kernel+bounces-257672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05231937D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946671F21AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39960147C82;
	Fri, 19 Jul 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mXBttteO"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179F59168
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421264; cv=none; b=beUQEuABbEzp6nKX3raIuDx5eqbtwbbyMaa2tcjFfcZL+Le0MLwLQLy1oAv/CRHWSRlmXoguo/e4aXJ0FSQMrBph2AR/Ui4ZPamOlJHVUnd8h5KVzgkN7wBxABYx88iQbApNMLUf0ZaCjEZMx0f+pxolmByFYZ5pyzRRTun9Y3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421264; c=relaxed/simple;
	bh=Ac9SXmSv9BsgH64Y8UQDr2unEgLUtz8gJKOfNFLyV5Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tLo2UI3D0886Tf+fCw0fe1ij/87k/nui/EKkKe9Gr0jJ1siua7TO7u7D/o2xrFnlqQSiBDDdRRiw77TUIfNlQOs13vRNbJlAK1tvKpYDbP0TlSKm8zoRaXYatKQsXurrRn7wPqcklCl14kBUdC8GKV3L+3FeMyhQMa4twg2jewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mXBttteO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721421236; x=1722026036; i=markus.elfring@web.de;
	bh=PukH2qFKFXa2q7NpTYxCFyDmx5ddZ3D4vxBVtVFhw7k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mXBttteOGXocaTLgoIKNri+abgQrTQC76NQSbNfbbkxb1QY4hvrrzB5InVwDoPby
	 HkxY9w06hgyGNCBdbkmrKFHnfd/oD/0Xtz8/fnCnErv4Evp2fnuJ0XOdiABL/CMss
	 7xmyCAsGJgEXawmSGipm0tmLE95FI+Feru1qyQXl7vq8j+jREe5XiZ/vmHGDzEv2N
	 punlbhh3ktZ59jZWA5eRcQOpJf3SvKLLT+S4NGd57V7ZaMfRY8iia3H+SJ9pFskYC
	 Cvc27NT5oHDwoZfjUmQnPnmmWzOuENb/1sLeqNvKnwGQGg7iLjZ8aHZ+S+GyRfirl
	 Z/px0zY4Cry6Tuh41A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdHC-1slKBs1r24-00LGh6; Fri, 19
 Jul 2024 22:33:56 +0200
Message-ID: <717a8269-95f5-4aae-913b-0108c6dac70e@web.de>
Date: Fri, 19 Jul 2024 22:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: George Yang <George.Yang@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Min Ma <min.ma@amd.com>, Narendra Gutta
 <VenkataNarendraKumar.Gutta@amd.com>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240719175128.2257677-2-lizhi.hou@amd.com>
Subject: Re: [PATCH 01/10] accel/amdxdna: Add a new driver for AMD AI Engine
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240719175128.2257677-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kKNMDZqIip+Hff6rrnmybURwGR/5xjlOIrFZOVFzSdr9YobNnSp
 ndqc/GyrDdD2WIe5Ra+7bUTj37meM5oH5US4C64IgmaaBbuBdydxmpcrr/3RIfX1dy2hrr5
 PTUS+rGhNxvJP8dTWYyDcXPcVSlMkgS+Km0pL/YpYR/RnKsXWVwvs4EKjNEkC5gmUABcNaY
 o405sLDzyYUb2fQxwyykA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N1p+GKVthvM=;CWF0JvLNwGvSsJUrVG8Y0AIbpaI
 AxXaeVkr+UndlCWofOfFkYccNcJ0Dhqm7kiPrjUIQ8gOXk2dL6oiJxMv5J7TdiA5BaLRU1Vhe
 MX28HqAMBKi/NfyO/+XKfY2SIRgUP6cVsKcgBkcF5oCu2D7/g5ImJMKPlryjgB6+0HVuWjGa3
 b3i9CaxCUH/oh0RYClr5ngS4g0V4ODYt3yivU/fF0h3JZgnj68eiL3DpAC6C+IT4AjvcfYQUm
 qraW3Z+CrCDflnBIoJQbkeJZie4IBX+5vVGqulFPTdam1Ganogj5+yBxj1mQIMHnDmE9+AqqO
 9Fbt6fr+5fo6rblO0TI4avzOiGfseiJe6JubV0KtkxSTytmvdd9/ISYVr3eaQgTjjuBTDn4UR
 JUgyy0BjeMqZZwVoKx8g1PA6vIkKmN9ibhSDwaFFKo91QmSrRLv6nT0xpBHCHi8TBU/unJjLN
 wcVjrdF1tzPwwNPMH4VmNG8zoGotIg4kVWuy46zhZOPqHJAhYThlW0PTplDlwQpYCmg1OPQIH
 ku/nLOyu4LL1D7JSWkA1SOLTZ6a01b4NYF5QcmmjWG2CdoEkN2pSsT0tzZ/Hn8NKD9zJTfy7q
 RdYBU4yerrol2VPDKygw6BkHz2GYGe53vZm5VC5gBabc65ZJVM5PndiuOvfyOAC1som4gmWGq
 GxmmuKL872Cpq92Xjk4NlGWLd25r6BJdz3Vbwf13MzUTTCGyd4YVV9Ry6NjH15jesFkQ+PAA5
 YMStiw96smBnpf68pmSfFrCNp8hByL8DHpEgNqzIOGqONORW4fdhF0Mc3KJgICQg+X6kEx+sB
 2DABJ130sO8UBt4zdh7D+Mmg==

=E2=80=A6
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -0,0 +1,182 @@
=E2=80=A6
> +static int aie2_init(struct amdxdna_dev *xdna)
> +{
=E2=80=A6
> +	release_firmware(fw);
> +	return 0;

I find the following statements more appropriate here
(so that a bit of redundant code can be avoided).

	ret =3D 0;
	goto release_fw;

=E2=80=A6
> +release_fw:
> +	release_firmware(fw);
> +
> +	return ret;
> +}
=E2=80=A6


Regards,
Markus

