Return-Path: <linux-kernel+bounces-573989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE4CA6DF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09C0167241
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5452620C3;
	Mon, 24 Mar 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FPKfG0lr"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D125EFB8;
	Mon, 24 Mar 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832637; cv=none; b=kUrrUf3HiiDnVZ7jP2Brn3XEudz5PHeCZNaQBJuQquYWKsQ9mQlklKQZ1T9dAG2RBwwkjwzDEGVYQv7qqhvj2EeVUPHLw0STHknIW0EFhrzn7Pndh4eS+1Ki5XcOgGv5T+TxYuxVvUzkCg+IKDWyk8uUYtowp2sIsGtd5+G5o9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832637; c=relaxed/simple;
	bh=1hxG8gdHP890ZH1YLRj5nh5LIlbPKK256d2HS/XMVfw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SSyqvSoSWhVBWrjW8qTvJC7zBNjh5h5O2DOF5o49q+Z7SD0TTyJ7H2MMqOrEljIOGmf9pNY5ns8H+elSlqPNlNcEKPDsZOoyWXpF24BGKAJrnyP3aJugPCtNf1JwXzEqeVZQj5HiIEE2oMzs1iHQNeUxtrHA6rFXd1ziiXVG8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FPKfG0lr; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742832610; x=1743437410; i=markus.elfring@web.de;
	bh=1hxG8gdHP890ZH1YLRj5nh5LIlbPKK256d2HS/XMVfw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FPKfG0lr+u82VXO1B0+k2wR6KWaPtuUML2OXujXiqQqSqvZb/OJEb2RR/12HzuHw
	 XG5tNK/R/wnB6fkRbCn54/ZMCEhQhLifXmWOsnOKkmy/d/iM3IjJ9b59ahBe5gyV9
	 P77GiKJXmpkxHQul5HRmF9GLz7WTOHVAAgtENn5HMmSTB8YK2o9/U7E2vEX4MsecE
	 f1GT/0ubUSP2IhN74KIQV73RB8VVYA1NMLfCBuOIP/cCWJemXUCbztnQfH2tvYa63
	 pxIanO1PF8GPtoDUFcO4/qepGocFje3+rq6mPICGOMV1pIDPtUtJACMGoBbAO0t12
	 tHsdpvjsMGAL7MwTBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzkOL-1tA1PX1Mxt-00yMVy; Mon, 24
 Mar 2025 17:10:10 +0100
Message-ID: <32e08068-164b-4642-aedb-3c7a1658406f@web.de>
Date: Mon, 24 Mar 2025 17:10:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ye Liu <liuye@kylinos.cn>, kernel-janitors@vger.kernel.org,
 Tejun Heo <tj@kernel.org>
Cc: Ye Liu <ye.liu@linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>
References: <20250324090748.753195-1-ye.liu@linux.dev>
Subject: Re: [PATCH] workqueue: Fix incorrect error return value in
 apply_workqueue_attrs_locked
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250324090748.753195-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJ2BLYkJOi9v3DclRbMTKOc5WbAsviL4EC4aOXo23nBL+IuyLGx
 MT8ynO/buZnzoLBFJzAA4VvMwQrr2UlBWUtJdGrzHIlRu35bYE7lY2CmEudOqDV/sHaKzSr
 GhdHNF7j/VnO0gLvJD57blO6vY46wmuvz0gjldl4YIiss27ttX4J8Hl3jQuELhJa4KuBRAi
 M+OPy12nFMqe8jhbz3P8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dvge/m4eYpQ=;g1Wt346hFIbpzxmNPCpbVteNw38
 dZbGgqkK9+81ypJurpxnbF4RX9teTOX8rcwzO2d5p5tIWv0RIICWwXvKxuPN/Oqf+CCVwglyO
 YXOaliq/exNLKRk1+tDDzqsnRznwVSLOv4VBinxFdzScmm2QPb5f2vqdVHu/iRfRHyM1iayXb
 tmCIdJztfUC/6q58iSFNDf7qe2/ixsmz7AfG4rETdS8TBAx0hEVckqRoPFKNjDU+IhZyVl59k
 rhGRMgbHFibCmkNBUEux4A/t49oVmGAqXeJycICV5mOYiP0EsvNVfmk3suQFEmq9numqOsIp9
 RrmUq0HgaJv9w2dp9yzAV2bPWwEcufop9/9FXSJjaKm+E40z6ulTg/9HEswE3ZykMH2CGZ3p7
 P+26vpBIjZu3nTOsTgFyQSRUbhdDi8XJawxaBol+vBt4jwDTaNIzBKv+Qb+ekCWZmXlErdeS+
 5PHkRHMSaP2JTh9yMrKrTGn46oUodWQ9IprkXTqKyogtU1a+YmKbhxfHccMxDAqyUiqF8XXp6
 8uNd7dZoHlYwl3Jo4rmjhZO7szDXzZ7siRNI1aKJjSfDtdIhqrf3moDXJ3njBTiC28fuMqsWc
 w/edhwHEi20qkYg28pnwrAvOOhLOw8S4g5A5+4zlW4TAGNAdQZBcHLefbBRXnOHjQ5VvfJIsz
 gYWhiyQ54+liTCPsamS6/nW2/l/+68WAeGsfX9cD+4Yi1+MLt4nr5Qn0vESOj/rFNeoOlk1K0
 Hb15BbrlV85oqmdLLAi2fFysv+5X2pmJjsNox0Pha6l0gByh7HUpF9qw3mVLRKjHoaXG0hzRI
 uHQ/yxcM551QRATMvhFZFKCdlUj65gNjV6ir/HQ7uk6NZY3/b6j+p0allv1fXuxS3yCJThqge
 JCQiRsz2m9R0RVWFXXihcWarCc91I8lWODwUkKQVUVFXOQ26hkS1QgSz7XCn4Cq+nkMPlLHhJ
 8xHBLwKIRgIzeaFIew4mKTL9bDx31tUaLNbTQYjner8PjhWYaKcNnEx2ZOjtogXfPbIpCdQvv
 AR2EpPBUoFIWscmI6a0x/R9e1sbYkYh5D3jozq75V7K/2TrJMnQU1tD70VQiDsZrbTKKUmAhD
 H36SFyST2o5rHnNuKC9RixljBPpdQh6H/RmcLEVvQ332QEZCsz2kj015+MU2QiixDU4N4vKOu
 kCZiqjUDjeiKRpuWvR3uwLDO2jy76af/p2EXkfeAEZi7xKTLGeyydDslZuavd8vouXwKc1Wyi
 zRBaCqczEifTC+45MzG1uGw4vgbp1d2tmm89zPZrKML5yGNGDXJi5TlHY3hXe5KIAOrjF6cTo
 t4esPbb/+vWRr9YkJQe/WAdg7W9IjsvdyrDuT+4y6hDhmpYd4iFpxZouxL0r1S1D44VzzMOwP
 SCMvglN9LnsyxLx15R/A00mcN+RdzFzjNibgyVbIkDc1nVTsCvGz7NF+pVJTVMSgxAISzgP+9
 H71FRYDevBkeqkNM2E9lERVZh0KP1HIEv5JT8nudto4HIMw3/

=E2=80=A6
> This patch ensures =E2=80=A6

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n94

Regards,
Markus

