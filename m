Return-Path: <linux-kernel+bounces-184813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F418CAC60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610541F22552
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854516EB65;
	Tue, 21 May 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KkASYUL/"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A657318;
	Tue, 21 May 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288177; cv=none; b=bC3//djn7Wgy6ET7QW1txtjWr0NtufCDROGZppz9Pr1P3UJl5RVCAnwvVMjLBLXwawTX3cd4qSkswwJ0hmd/2+C5UKU1Je0+mKX/IDtZDMFh8PE7Eeb5IJUaXMAB+NCgZ47CG43bnL/vPga2yHoiPzZ0uO/7sbBBHkOqtyf2ddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288177; c=relaxed/simple;
	bh=Tg4pXebzYZXN2Pli6Vmk3YgtbtHbGDQkMW1CuDQ2UqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJFkzVLe/v58kzI1O2pd4mvUbjV/Keiba+tDy7INqC1yCT1812yAkRD4rLe6V/8eDT2uH2iRYeKLpDF3USbKXxsw3sQKNviBpdO2aoND1eww3+0VjSNlVokuok5q3nE5fOb/Gf68GsULcLv26RoxlD53Il0fW5NgpOksmPve3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KkASYUL/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716288160; x=1716892960; i=markus.elfring@web.de;
	bh=Tg4pXebzYZXN2Pli6Vmk3YgtbtHbGDQkMW1CuDQ2UqA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KkASYUL/b+oDYMPxcdxRaEanFcZT/GbzLyYWPS9Ry1okmAQBVzUFm3pTgX903FwB
	 aJCXNreTH4zvKxGm5uHzRdDrLnN8oLo7k0HxxY6WcrgNJDC8r/JSTqmDA/7x3iV0N
	 Nunk3t6K16CHRmVXM32l8zH29mY5IvvvN20CEMYdvd9uY3VvbYW91aB3TcXHM93US
	 4SF008Ff9Lnsh00pyTvzcI0R+aEbDnxZJNBVoPwjRC8iHIHMHDuMIRcHlRCYr8Wdf
	 Dt1Hzyy559zsN//Su827EHQ4B43T1ofDmIyjJy/09Q83O6OWf/MMuKoSGG243y0lE
	 eaHmta5ITEdzGYrtbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJNT-1s0C9f1NXL-00SaQj; Tue, 21
 May 2024 12:42:40 +0200
Message-ID: <7b903568-d8e8-4a06-b501-8d49f3f0fffa@web.de>
Date: Tue, 21 May 2024 12:42:37 +0200
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
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a8eb3ba6-eeab-6c0c-7b57-4fde508853ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EN4cLFIiM2svvyDD2RmxxV50adw9OX/fWs+YpzfL+1IB9FpHEK+
 byKHXsShKMbUf4GZCzuVmc9vgXaSntUzXJAumBnkFlMrDrOJH/lLS6Zbg17KxCO6xtgPOWu
 ScimlLF28wJdXBDMlc2nwtdtbYl9cMUNlJVs1r7Qf0R3apIEpRu/AWkisjXgSwZpGJOEz41
 3eWwOAvardOS4AiZvuhJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ktQrzzxWaeM=;fsO8QLzb+L2UgLn0l+EubfkilLu
 NvUoNwwjkypEz5jybvD3DLczurW7KWLQXf62TEda0F3V/aw7VMKXfzME48akj8D7wedcEuOBI
 QybPU+nNqQDBa04giBS484SQv8CLRiQfrHDzghJZ+0M0C6iyE08W0BueOQecLD3z5E6eAPspK
 lTt8uOr7tNtqhhaQNTLjqYhBE3FARJlPqkGvcCa9ejM5Jm8UOZNuJzIhw6ZXX2Cc9VNVbZQB4
 3phamZW77AIz7zK3DSFyhDhXDq33J3JEw71qyjA/vxiuoqwSPxsRGCj+VhnM9qfnb1hnDdUaC
 nBdUo7giUh/kFuFvJJvOcN7fetq+yvs5WS4ETnwtrBgysHB5styEfLbxTDDupwoO4Mwvw97D4
 hfVbPo6lUd5WEsnM4tza/MtuOHkHxv/EFQbVWAmxXT5SES1yWrp/axS+zljIFe5xO1zHgM5jZ
 vrfgZB3Em27dvkBkaiYPXGWqzdyI5Lojv++sZSH8GZousjREBw0r03Dgyod25TU348x3z2Pc+
 13sxCLtM2PWRccYOEO7yo/v1bPpLt4wOmqVkmDivqqEecDZvqO9d4VZND1Jb+85TCP2XnO4Wf
 QW10h4TcneX3dQrdKaU+rDUWkCnvDgabeeWhX76h//AS5csqD7GIR+JwkkEvSRlFv1csoZe3z
 4klnx/Wo3r4b47k36Z/fhqroCUIJPC++i2ms3BUOy+AiLZw9lNlVqrindXy3MrMFDCgv6ibAT
 g7A2znhfcc2VCzQDyZYRW4NHKTzY14bfKijCgqfu5cFqEAqStSgq3rp0n0BSGFUH0P/wwWaKC
 PPqvzjTbvzmyH6utB2+n/ycbguZuc58fkcvauTISb5dlI=

>>>>>> =E2=80=A6
>>>>>>> Fix this by reordering the kfree() post the dereference.
=E2=80=A6
> We'll not waste our time in wordsmithing commit messages to perfection,

I hope that you would also like to avoid typos in change descriptions.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n45


> the current one is good enough as was stated to you already.

I dared to present some wording concerns according to the running patch re=
view.

Regards,
Markus

