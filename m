Return-Path: <linux-kernel+bounces-306348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB07963DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C01C222F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3397189F54;
	Thu, 29 Aug 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AcBvC2sW"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECE189B95;
	Thu, 29 Aug 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918168; cv=none; b=s35c8g6YAJ/bq3KBEDy9okFGZfuGf8HYi/BCFL3PuucSUxBhLeKF5QXftko+8rfE8/k9e94nM+d5vVtOa3syF5jxmYifpLJKOeDjz7iU7WW8Irm7soAnGEZcn9K9Uiq34QBlHHvqu+P2ceLv2dehf59a0GQPHCf6RWYe7ZMtvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918168; c=relaxed/simple;
	bh=9xpPAV//CdEZt3ddIwqbRUwBwI+AzwP3oDC51Ky0oQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G273VUzio0TyYfYn4pldunFf6m6i7VQN0nUgZ8e6INRZuYrAngTts2u/ynELnCT/YB96i2WJFMd8yu6d1l97I2MTwlYbTSK9OXcTV/H7mlWw3QW4WGa/7o+wKcZ78DpL2q5PcDRmIiCVevVDfX18/q91sdWLIBGutNwVLRmDGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AcBvC2sW; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724918153; x=1725522953; i=markus.elfring@web.de;
	bh=9xpPAV//CdEZt3ddIwqbRUwBwI+AzwP3oDC51Ky0oQg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AcBvC2sWO88Lymuu8EKRtp++ox/Kwt1xMnkv4g1BPKdYrZelPP6xodp03sZV3J8c
	 UbNKYaR47ZiE9+SyG6kxjB6+kNeroiZpI/HZ80Uxl/k9Vu73ujSdh7z8ee5G2s5pO
	 GpZSmQ1zPqBNaERefCCeVn8cJdBCbHECETljeItaHPjrVi/dcH9BTEidaBjdvWKon
	 Xh/jl/lLgbWWiV6PIqEx5XmpvFAWXiywQKsTKRNRmj2XvitnH+vOd2f3yAZcJhUUE
	 yL/ve348Pk9D4llz2CdhFGoSGp+i5Hhpr8vXf1Q512R3vnESo17XO+keW0D7ooGf0
	 RtNjO8IXXba387GxOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuON-1sVcSS088z-00MbMP; Thu, 29
 Aug 2024 09:55:53 +0200
Message-ID: <22213ddd-90b3-4d33-aa80-4b3500a21a2e@web.de>
Date: Thu, 29 Aug 2024 09:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tools/mm: Use calloc and check the potential memory allocation
 failure
To: Dev Jain <dev.jain@arm.com>, Zhu Jun <zhujun2@cmss.chinamobile.com>,
 linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240829055621.3890-1-zhujun2@cmss.chinamobile.com>
 <716f7466-562d-4bbe-a8ec-851a0b289db5@web.de>
 <37577635-89c9-4afe-a30d-add02c0eb896@arm.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <37577635-89c9-4afe-a30d-add02c0eb896@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NfFVen4h15z9+e5jTgazkR7xfYakyPD/MaT4846uLXYRjS0xRek
 mAwqEzhUL2u/f4CzwQuB1AMxFrIzoPdiwUuZdrRqf0b/TgrNKdRNHp0J+DVBFhengwMhtt2
 e+FP8iuAFOCwBeDDtUiDFT10ZsIyCuxjN8rCDIBgWdw+NRxN33jm4VdZNqT/SoW/m2TFmmh
 cxszndiHq/XYEZENS2L1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f8YdmMQ47M8=;rnL2sXkMbq0C89SYZmNo8H0ukUG
 7u/6IhOzXQErvznNaLFz5NKs4iixAkmR+r8w+CID2gJXICepxW6nt8eyImBr6C6p3aNHFlDAH
 iTUat3X9KR0bpqFxA6OtV9PJx9E6OKprRDSGVsnh7RVFBy1G3xLEF+bPOIUnmciTrjbCb0v22
 0jw7OMchNIFufhkPBFb6ubMuZ6/YN2giHYYIZuje6ERfQdFxBFjHFY3QnUPJ+9iNucB8MPIr0
 p31SfplFCaDZ5r+BBkG+CGtWCkpEY93N5Y3Gu/LaXGXDgxsc7e4tN56TW4Wu8sEWWvvmBFutI
 EKcFHFkPeTjGep1iJLkAEYa3/4DihvnclYWdcG2EPn8l9JfhQQMSJJREsgyYw1KSU0bvq/S4X
 YBK91Ep1D8DdSmtsxg13idb6Gv7AIni8zquOHRuQRW1fsMCkAjiAmYgM9kz0kse0XYXF9nrOS
 FXA/9djM/qOVsNw7OLMEdpuXa+NoOdDYFkc5DAxbL65mzI+s41P3OTLmP8aDEldP3RV5zP3CZ
 FXqW8nee5NhuXcvB/24CNdBI0pYoB8UkDp9QRSRiNw7rt0nmdl6UzcjuteuCZROG4bnulE6Us
 cBwpHEVrgRii5xwK0AluNn5CFJ2Qy12K86OADn59SNv4+Ggs32ybGKfNs0YLDXBE2ArsYPvNR
 CLNKUlCTHGv8EbhT4+hgEk6GMgWixI/uMiZL5ZjiIaExHcTD6qqS2Q0o1n4obC5KBMUOtVhke
 LkSx7PXGzXmfpjGL/XEPPuzXQ9D9MOG8VIh+LKCiHIUfuEDzoNHNXG3MBH+IP6ksJwXYs7aon
 9K8tecc8Zp/0B/IF8QzQpQNw==

>>> Replace malloc with calloc and add memory allocating check
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(=E2=
=80=A6, 0, =E2=80=A6) call by calloc()?
>
> Calloc returns zeroed-out memory.

I propose to improve the change description considerably.


>>> of comm_str before used.
>> * Add also a null pointer check for the detection of a memory allocatio=
n failure.
>
> Which is exactly what Zhu has done?

Can the commit message become nicer anyhow?


=E2=80=A6
>> * How do you think about to omit the statement =E2=80=9Cfprintf(stderr,=
 "Out of memory\n");=E2=80=9D?
>
> Why?

I imagine that a returned null pointer can eventually be sufficient alread=
y.
Would you get helpful background information from the variable =E2=80=9Cer=
rno=E2=80=9D?

Regards,
Markus

