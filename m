Return-Path: <linux-kernel+bounces-522378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50817A3C961
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C090C1891160
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E07622DFF3;
	Wed, 19 Feb 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="A7GIG5xo"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF921B9E0;
	Wed, 19 Feb 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995892; cv=none; b=UA8Qf5DNN4gLxZr14KlPcFpAv4ARVi/HjpGTsUwjxhKEYGzrLvfLDwt5FWn57WglLna/qbVqKn9vc03aOOK07hhs0SSujlUFXFcKKscqdXL57N1kqBJdBt8Vd8LAIGfs+fNzM3XovweGIagHaX+0FPzYIX/y0s7c+/UnokXpsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995892; c=relaxed/simple;
	bh=vVc8kNeKRrfQX23z0vb9lTZ07UAQytComilfQtfkp3c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OsWIw45dOA5nIpCHuThGhI6gABD5jK7krv5UaNIs9hNznsq0igIa/+DdBndXaPKIKMRipTGxFfpotumALM8b7zw7JZ9oXD5n6vosgKGD9flt9QQHMb6uDLKgDIF1vlSXKk1rZtempcWmZsKVYKzIoncw3rYxuHYGESaZGzpv1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=A7GIG5xo; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739995867; x=1740600667; i=markus.elfring@web.de;
	bh=vVc8kNeKRrfQX23z0vb9lTZ07UAQytComilfQtfkp3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A7GIG5xoQLXADczgbO0CvHCP644fS1ow9URsZy3kefibGZYUD94krXbiDwdPw2xy
	 6XckxWP9jkpt6rqrOBAiUG7yrKsRZWGtDJITGT+xrO6coCFEaiIqQEmigEN7N+K1n
	 8d8u7B3diTqYrYXo+TV/B3ROwLFDX6HrCB3gGURiu/+JumHczCujbAq5YsZruEaly
	 iclkdC0f5hPFAdXv+Q2+8RvkATVy00VfmkspDVtFVGAv6zdrAI/RgijbgsIFVtvxU
	 MKo1ead4vcNgQJ6rG7gfYsXtbM9uyxldfManPQdCNXl41rvCmdn5AvL+j44pOXFyT
	 H3F9DXj7aIv9Q0xsrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3p7-1tWDpF3qQp-008Xvw; Wed, 19
 Feb 2025 21:11:06 +0100
Message-ID: <8923aaae-becd-489a-bfe1-8c1c569d8d48@web.de>
Date: Wed, 19 Feb 2025 21:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Josh Don <joshdon@google.com>, kernel-janitors@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Segall <bsegall@google.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250210195117.1074569-1-joshdon@google.com>
Subject: Re: [PATCH] sched: fix potential use-after-free with cfs bandwidth
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250210195117.1074569-1-joshdon@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X3d0E9WrjagRkba4BQm0pfUD+YOsvBTW2m2USxRtZE4oOAsiyi/
 n8JSJAmZ+gc5ElVU0TBeloHmbm0LEk5tfjHFdNr4DddiSWCz0F0osNqophwlK/1cs1w84ka
 ow40DtBp4665Y94uxzt5Q+aQjEtJJO8Usu+xGhxKLyPPY94Nu9Ptc7Nh/1p8nOsmbb9ArvG
 ybxx5xNdhE2aGllDcVyyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MAC5JS6jmxM=;mXe69x3zsDUjeVuwGYCr1umOBbN
 EYoBsIrLDJVE0kx5f08ZH2ujWwi3HFKVAjaQ7C9JGE/82OO8yn5QY17EuYHl8xD3pHclp5ZAd
 Xv0odmOgC8Xn9XXIHPDxEXOiv4oVwHjzgrNxAI9ViEkUCNfOBxSNHqSocxyMLbQTcb+RXwK24
 kT5+BEmv6MGkvpUODd1TPHIExeZ0jJ0uIKhvnqh4qwQ1eh2ntgOkBkpxjrK7clmT7yQ5rBllS
 ykbHazLRVEP+UevlridiRj+P1bUZWaNZm9Or9GrC7GYtJhxMm07wIqvHGppfHRiTUuFgKn9Bn
 fuqD26bEh/2PmqKh63VUit91Z6OV78D1AyvymppuA4c/x5rZHaVFewuz8CSzcSu6lERqMafL4
 f8F7eoUhIk753QL185elJKmzgKS39+sAoknJ8p4xIRU1Ch5BH1byuZLAwX6toSiUliawyfQjd
 t6aGlFMIgGtteK+Om4HyYHSwXxzgSECmcBMpenYOc/8G5Mem3M42SAarvFJ3oX4iCM4D5NyHg
 qemFJL/UCNTO19X0oaBgoJtEfvzqGIO1m5dRyxgRlmmWm+4HFHgDR3+NSficsrtnry3T1h7/g
 rQCsJLJqPJ1Fy98at0NE2Werl6iJF5eNe7cWjKvB9Vy3S0vBGPUUP9Re1wWMtZv5RXlxoqpwL
 2/o7f6sN8ywA5c4OPsZJ7trsz4XBUxsOZ0u6qhS8mkslPsL8ilZWEXVK7DC+NjRqj15FbI9Jv
 gjlrDEwgfBUq8GeSxWFtRy/ou3ATf3ZkGxWPjxZtii5yRgKthjgl9Y87WFAp4iXbKBTy2cMeB
 9Nw+Aga0dfiqoFlSekloCImBiDy3EJhinpt4Qf8EGVnBUNg80Tolq35hYCmBO17G1hxMg4HWj
 Z53uCHnjaF8xrcBHq1GpHj8ryrevxHCB+IxvrjQl791dLdaJfNutrOXUw5qVjay83oOgw3MaY
 +JCW14aPH86s5MfiY/1pbo0IKFQrLbTld7+e/dJWCwpwZy/KY1Tmw5Wgc5MxkL8xMl3Iy9ROn
 hc8G0kauWQGHxVgMPDf+2r3BOV6BL/lVNuiu0pBS0EkEYdKBOyezTom7XrSRMaCzWmQWhM7nC
 ekoQeIR2L8MyXEvm2PoKZYgdthXb7iC95p+0j2CRaXodv5LaJDRGborB+nTsbWjrbSxjidb6H
 H7/6ud+hxw+RkhO/y2WcTZyTJR3SGGTde9vJxff/O/1Nr5ZZmseXzSce9FbykciWGVyBQUVu0
 ib9HntGxx6iA2n2DNYYcz7VaEWnnYSlDh7hLjx+1Hu5Q4kd0JHM82k3yFZ3yNm4ti1RCU2QVO
 XQwprT1NLkU1l0im+sbbAQYUguO0cQFtxL73cvnzjRgdqXdr1Gg4X2v61YLW2MnrW0I0RR2CZ
 Mq9z6FrknGJuBWWtTkKLFd1nZ5NjkDCR89nC2bQFoVQo4/ZOpYIzNWYdyxnpuUbo3N6Bd38Zx
 el/SSb9+RU1CgjulB6UGYQWWvITU=

=E2=80=A6
> For full correctness, we should avoid removal from the list until after
> we're done unthrottling in __cfsb_csd_unthrottle().
=E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n145

Regards,
Markus

