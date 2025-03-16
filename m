Return-Path: <linux-kernel+bounces-562999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C21A6358B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E89C3AEC63
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3DB1A76D4;
	Sun, 16 Mar 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SbW2bn/M"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941871A5BB4;
	Sun, 16 Mar 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126749; cv=none; b=JmuW+rH/1Dd+6ACGp7L4fiqskFRgQYNJace1330PgD9hIggz2Lx+goXDeBpU3WsK2/SAJ0ta4t0NF5gCwSTcvs12WTFNMccyfHIkMBagAWG7YtPaM9+9cvl1eynEggRciV0QjgBVpNb85LZlkO27MOtHALYVcUwv/Z8nPw15PH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126749; c=relaxed/simple;
	bh=KadRx1xoUSmJtq5YD2SOV+EbxxApkt8GHAPj2ECQ2pc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nWeix1rq5GiNwlZcB3K1osMf1sQC016iBq4Qm7Ngc1EgI3PsOIALJUMEBBrjMATuZfu3v+irS41V5dCK6gNSeM/CA8z7evjBALtcUgef71qrdy1GTq+2R/Qi44o73P0ijJ0Pmc3nFu+FnRuwN9JmoInwdX1/x/9iNRmoB491lYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SbW2bn/M; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742126719; x=1742731519; i=markus.elfring@web.de;
	bh=e9pi42+lpAEfqGuH7ny5kxkJc4GrAO5+Sa0jB/otWFc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SbW2bn/MzTWxWSdxkUwBl5Or867gbHNZyWHCLnoPbYDlXDqYcw5keEr8jGxSC3z8
	 udWlAgeCC+OMT4ED7fiN2j2zVLB54QGET1Lr0/sIBokgg4O6HeqhKG+n3g6k+tzB9
	 2OzdJKRaL2CiatIwDzrWAJpseag2a8geozR6DVlOCaKWN1CO5EJVHRiSXwxkuzRHx
	 yY4sYVdtfPjTtKQFN3QPrsUsam3YR2iQlyI63p5lJkrQa3qQV7eBn6KTBzLtllTvo
	 uxophOwCSCkiCTdE9pOjtTBARdMsZMShPJGB8xMIZpD8KuS53RjxEZK36QkG+eeMP
	 TsuP3vAUH/DGiHn1Vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.60]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwfU-1ta1rT2uMq-00NFqT; Sun, 16
 Mar 2025 13:05:19 +0100
Message-ID: <d90c0678-d2ed-4e77-901a-fdbab7dfca71@web.de>
Date: Sun, 16 Mar 2025 13:05:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-riscv@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Drew Fustini <drew@pdp7.com>, Fu Wei <wefu@redhat.com>,
 Guo Ren <guoren@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <f19be994-d355-48a6-ab45-d0f7e5955daf@stanley.mountain>
Subject: Re: [PATCH next] firmware: thead,th1520-aon: Fix use after free in
 th1520_aon_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f19be994-d355-48a6-ab45-d0f7e5955daf@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N8yi/ML/6ATrEIfjSmcR+ncmpOEGOUb80sVSW2Mp4Ay37YbqHO8
 0dpdF55hEC2gXPezuq6AkCihIiKhPba4HX/9RgMgQXH9bKSCavrpAt2wydYUh/yNBvbswSx
 CUkhQ47nR/vMUouQNwFDVjGT+G0aXehQ4QcKQvEToL6T/+QqsLsEGyVYk3GpYtLFvTaNoYS
 Ktvr2SAzmzBNeEkFee8AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zyghqIrusQ0=;argRggwRiP8xq6mCQKaEC5lAM6M
 /6k59Ym3joLa1G20HgkaX5LTH3ed0xBI0SbZxMBc7r1SFwfcITYww1kpT/OI5qKuD8ib4pHEX
 OgWctpRmLfTFj04Z+OdDYKNagZq9AR0nl+oAYgC5kFtDMKqgE6vrQS5rKliYsIRgkeA6z5prN
 /b0p+/Ar6+M5SYIKSqjtlV7Kv5paxREK/8xmwnWK5eOpiituHSbvcbyCgg9CBH2N8T4BVNM4X
 wLyjSVA5lULNQm/D1RYbCqOAqtZvBXFysMwuVsUczzbR7KsB3JhUTyByPodm3smO1oxQRUcPc
 JR/GseSOs84DGGx3IUQhAS6lqXt8J9trpG/GWwUqUg3Lh0cbTGpWVTQbOjrGcsSkHpFbQKJvc
 K1iaY43M+JvoOF1Pv6w3DfCe5cnzql9c1DzMMPshgepVVlOLIKyH0nqB5vTNSMpgs9vZFO193
 KnJP0ydgyL4rC/7eICXLBQFHnMXeRfepHav7UxPOaYBLGdjH/PQaYGmQ9GOugikUjxdwaIX1P
 yI5h8ZOnWMoaHqYambHv9Xj0XyS7FLeXxClHnxf6S0HJPDPl0fX0ZNm5rs2ZNjq7DiqZnuAsl
 jIyg713uK7gnlvp1bMdP/naZ4Tfc8kgbsSqW+1vlbxdgGXElbVC3JUc+PHzU7rNU7KKMuFDl6
 zuSd4HrSg2+DijLZXTk6GjEKoMf3+4qWvCGsTQOoAps0T7mjKd9lzwnnjtGBWOeL+554rzeLY
 ai/kPxbReDGkg0wc8Laioq/C+ktJHhjC55fpesN9kTRRIWEE/7wA12e7lhDJ65lcLCkPawHkS
 Z24X/0C+H80bq/uyfV+hG5tUy6iDBsLE4TsWuNlyMMMmXnc8eMwSDkpYLsHP+QYe+hZOGdCks
 SDU502B3odT4PQ2HGGFSCWogS3MZPuJAoTmBxb5UyQ2v4nC66HfLpbtjAo45YXAyhVp8ekgyo
 7qojw36hqLRW60WVZx1WNYUgt4UVhvf3rv9oD/OlFBn+ZD/U2zHxYhmE4FZt2nZu9ffusf8EU
 3fwh+u2nZogefJWoAvXIO1fTN4bhfHJSZHoP9yHQ32vKP0c12zZ+KYnlNO4XcRbDtByrQZxR+
 aQDXjf2xpFNAmVs9QG/dMYcniR9TEE4IC72iqx95OHAd5G+DGXHjP/fMbiBXvajdvn0oLVzm/
 SCZEN40S4h8zfktWnw+ff5cAzbKZJAVEjjOH+5f5uHpI7+MKA1tqHb/JWliyPCrJgDm6H9T9o
 G5dvSi/QrBEXiqFSvbly7Bi6IlH+Hvi73FFY8S7YHruNGDkiw9CCZ+p3GubRXTpShCa3b/0qz
 UJL/aB/8Hhdjro3j7S+tViwv40E9SLkQXp1AB5cdJlu68G0V62U+Prb1qls4NEEyYJx0EYfTJ
 AeCIDNKu5p0zfeepaDjn46Vw98/qru87+/axf4RwDqqkxThjoXIxZR+lpyz52mNgIzXt01sDO
 hnHJUmovW1PTX8x6C5gflbLDdMOzq4DWxr52cDhZlaA63LQ5LMAXjto+cUIUUC1uX1kq31Q==

> Record the error code before freeing "aon_chan" to avoid a
> use after free.

Would it become helpful to mention which selection of source code
analysis tools detected such a questionable implementation detail?


=E2=80=A6
> +++ b/drivers/firmware/thead,th1520-aon.c
> @@ -203,6 +203,7 @@ struct th1520_aon_chan *th1520_aon_init(struct devic=
e *dev)
>  {
>  	struct th1520_aon_chan *aon_chan;
>  	struct mbox_client *cl;
> +	int ret;
>
>  	aon_chan =3D kzalloc(sizeof(*aon_chan), GFP_KERNEL);
>  	if (!aon_chan)
> @@ -217,8 +218,9 @@ struct th1520_aon_chan *th1520_aon_init(struct devic=
e *dev)
>  	aon_chan->ch =3D mbox_request_channel_byname(cl, "aon");
>  	if (IS_ERR(aon_chan->ch)) {
>  		dev_err(dev, "Failed to request aon mbox chan\n");
> +		ret =3D PTR_ERR(aon_chan->ch);
>  		kfree(aon_chan);
> -		return ERR_CAST(aon_chan->ch);
> +		return ERR_PTR(ret);
>  	}
>
>  	mutex_init(&aon_chan->transaction_lock);

May the additional variable (for an information) be defined only for
the affected if branch?
Would a smaller scope be more appropriate here?

Regards,
Markus

