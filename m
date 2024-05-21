Return-Path: <linux-kernel+bounces-184862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCB8CAD28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26C01F22E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190E75816;
	Tue, 21 May 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wgsCrfJT"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994BF62A02;
	Tue, 21 May 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289811; cv=none; b=pKS9Vf/aYq90mRDNlYB9Hp2iVYGtN8T2KRenRsNN5KwoI/0JH/oFoa2QA7WSYTPpUA/FFQje/UFI70c2DTdjnNuHO8TVTSl8deQvzcU3FtPg24gRdlYJt6GvkCQCbmCto+CqoI81fV1sNMRn0+336GaGb18dnTMLFF+r5/uvooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289811; c=relaxed/simple;
	bh=DJGVySxDcaA0qqbl1dW0CsQ+3WLDEGkEAiY4DqJErHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8XL7ZY1dl1n6Zx0aoIVoyA69jjUN9QTPuz5FUkaWiHZOdfOITjMYJ6TLQW62Ul2/sOjxjth9AmeWF/8vA766Kvy2oY83YDQLfTRrbeTO3ySKtkNiI4ZBAsFJz7JZch8j76wYw0i57Dsjsrf3WYw/aM+4JlqyS9+fDxsMVR+yLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wgsCrfJT; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716289787; x=1716894587; i=markus.elfring@web.de;
	bh=DJGVySxDcaA0qqbl1dW0CsQ+3WLDEGkEAiY4DqJErHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wgsCrfJTTavBxx9Sg6FkNoMiafg72ui66vNF6MAB6EQQw8SLhafnrzg4nNuSzxMh
	 6umuitYSCqLkreBRiBJLekfcKhsKWAVgVuPrgq6Nontcp5Y1aeAqL8ao+m7R5qF1F
	 JGiS7qZsIBQUOTvbEwsfEeEb2KMlpyDWO/D73xd8XcH14lSgXtyUOSPoHdnxZIOa4
	 6N8U1KS+vAEOdy8jftK52UJy/1Rojpd8eqeT5ZJfTXE8HZU5yoPrk6a6ypmLypFZr
	 ZhLjYNboKOlmyCHtZ4TcbUMX8eFq/Ea9irbWot2/FaHKO2y8Cg1T1aJz3EKpqnFB0
	 VEY4b1K+1Onfcd2qcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk4s-1rz2Y440hW-00TPnH; Tue, 21
 May 2024 13:09:47 +0200
Message-ID: <9c179632-a7d7-4dcd-ac2f-89ef77d362b2@web.de>
Date: Tue, 21 May 2024 13:09:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Dan Carpenter <error27@gmail.com>
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
 <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de>
 <6d1bf351-77cc-7fe9-2d62-8bd99789e4f1@linux.intel.com>
 <d73fe99b-dea3-4792-aa1c-c3317f296003@web.de>
 <5287fc2e-91c5-442b-b66c-6eb1fe334ce4@redhat.com>
 <51368bcf-d2e3-42cc-a112-a1a485f29c73@web.de>
 <a8eb3ba6-eeab-6c0c-7b57-4fde508853ed@linux.intel.com>
 <7b903568-d8e8-4a06-b501-8d49f3f0fffa@web.de>
 <c158e0f4-fcbd-13a6-ee98-adc26160c3c2@linux.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c158e0f4-fcbd-13a6-ee98-adc26160c3c2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wEems1hmqOzz9DGcszFJEgRyBidNWmoaMZGZ6NA0tFjE3qroV//
 5eNN8GGaBAGZ972bGP39WxoNy98nNqJf/n1QeosexAtIcvndhBPKlTKlpY/cd8azQz0l6rF
 yj9y0/HmxvJ7oa++xjmKGwleypoDrvD1BBaZKF11DUis647ZjhMNM29HYn1c4SYspW8SHHk
 vzQb6C7k7sghtPj9elchw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZuRWjz0ist4=;uxK+tgwHMLpx0uNa0iRenQCQCoU
 jTqTHzGT1pk6V6YD5Te7NMnQMK624sWiaC7p1PqIEZbgmnpOTLiGYPsSnr/8Y2+LQihtO74PH
 orBfEbqWNLCPNUFRjZghKDtggZZFDOwDrs9Sc+YRqUsPYue9j6o+cqi5JFEOE3K4xe7BgXle5
 sUhDoH/wAT3NKhhz48mFUvHywhdal9d1fj+QOpJaKd7FaIqYpBwkB7YPhBLdTwBeT/XSUersG
 LU1MA5eyCGNABddhxkcb/CjLncJhRirRaue/MbT3id7koxHsOyhxfnOr+PukmOOuiICldLKZ0
 QLRNvPIYYqf6h9wx7+gdILumyGeILwT3+YA30Lm7DNz52Pne63tYUfUqGjb/2HLYxjAuG5qV5
 LId6Mpn6yoLoBS3sQ6VtHKronctaAYfj4+niExE9WIpAXy/1vKJAw9yxokrVObBM2vdqx8Alv
 lsq5nvS0qTlpJBnwGDv2kGDp7hdcKv4K/Rme6D7qzgJXV6HXaOJ/89ZHcE3RRRDKkLEc6vti5
 gLzR7qK2mCvcsBlU3NERiV4sjqLjeDvHGR0zTPf2Pkt12RhneNJoLNbxICoaG5d7xdhudVLeQ
 SpR9SmW0bPuv2PCoksH21j8nMyG5x+L9qFKQzJ/O+allrDpeH+O1Cp0xvzG33IaUnOYmTkloX
 QsUFhy/IEtpuarE9qIgUGmJCkdtSubW0V/mxHis4erXNfbmTjm2f0dttZsVIhJwk/opdry2L7
 o0lsxT5MZp8HkNtnSBG2UBCrgwF/jKsnaOr/KaBLtUjgB2TwQL/e5AgU82VzWQB7a03g5/gkB
 bWR6JUXljESPh80c7VZno+JJJrxmodRt308ae95SpEB7U=

>>> We'll not waste our time in wordsmithing commit messages to perfection=
,
>>
>> I hope that you would also like to avoid typos in change descriptions.
>
> Now you start derailing this with off-topic references to hypothetical "=
typos".

Which alternative term would you prefer for the word combination =E2=80=9C=
the kfree() post=E2=80=9D
(for example) instead?

Regards,
Markus

