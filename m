Return-Path: <linux-kernel+bounces-355255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780E994E75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599CE1C24F60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946A1DF254;
	Tue,  8 Oct 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dj9LzXPb"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809551DF243
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393442; cv=none; b=jpH8S9YSrUwjVLWLA7e/y/YJZTFpWEAqjXlBfvlNzhM2rVXkbCHzVC96wfJmVTuha3BNioWsiwhfjBU1AWwSRnILBX2YhexNhyMwEQ11t1Dbyh8O7APXjU/HZhWvc9RHFyMvEcWIEihE5bo+NiCBUFpE99ll9IeuaVCrVIlwfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393442; c=relaxed/simple;
	bh=X8tOFgj5tloIcKscQ/zZKAIhAnbbZmcvev2zOGM1T7Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PEiERBZ02LZt31qEiyjY5kq3px4EqM+aVe53zumAudNPnbydTJEGFrCNBQ8U4+g5LvDBtUrSW2UhBmJDfUlOXeJviUjVchXVybZC4MD76WO69/cHWuKRoh/wFJGJc+/DN/9MBGv+Hexe7MEVf3oOUeW14dadbIXCrV7IPZVPdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dj9LzXPb; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728393399; x=1728998199; i=markus.elfring@web.de;
	bh=adxgRSJOkFGPFpFSyKuJM1pQeF57D1d9SQt+490tSoM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dj9LzXPbqmbhBrfkURWkmkvpJY8rtnYCjgJy2eKzZb+GH0Sx9UvFiVEDzOTbE8mY
	 VuuiIaikDVYqq5gFqEUHLZp3kGOlL6mDVX+telrt9d9s1CyF6Nlq4NwOFxtUBHwnN
	 cR5heYOjPJ2AVQFgzlOG4DLQlreUPEBv7rhF3zh3hHNbJMGop9gNbdBBNsdPUGlQU
	 C9Qj3os0QZaF+UYfJfuGobUlmayniAeykyCSqo/+Md8D3RMMIZqDxxm9MEjcTxseQ
	 9k/f6S4Bn+By3iN6xtjp+JO+4YAYcLofWTJeWoPZhMYdCXqJjOnP3aJwaQ2p70V0H
	 noo/VnfA+DkoqqEUhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZM3-1tQWr81oRV-00SOx8; Tue, 08
 Oct 2024 15:16:39 +0200
Message-ID: <4366efe2-89cc-45bf-9d51-04a2afd2783e@web.de>
Date: Tue, 8 Oct 2024 15:16:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yonggil Song <yonggil.song@samsung.com>,
 linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
 Daejun Park <daejun7.park@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Siwoo Jung <siu.jung@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
Subject: Re: [PATCH] libf2fs: Fix calculation of usable segments for single
 zoned
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pbgt8tsSEsd8luFTcv8T1w/ipDMyxIIq8nNIyLdvDS+reGScQ1U
 tUykC3c29eOiFX6FFtSqZseji7fwMUBMPuC93nXcSFqd7q8G2eXJUtnbqBeMgsTS7TA1AcB
 ZA9YHEZAdWMzSeJl8D234ptXjg5Gov6mu+U9N7UPbiMdHogcwkXPmbhBMjzDUtB0YkkbyVe
 bLuEwTxw6Dmyy1K5paQOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uDqyZAkOSHM=;d0g+TTEd8ZBVUEmjALxmfNEExoq
 dbOPl10LTsHJt3rBtAqSiI9pF/vwJd09d+7P73/UegAf29UfhAU+1jR4DJyCqv2EZk1RBiK8s
 +wGvEvXuNmT8HVyPoDAQObNz7BVfJomIslIgMtoiNxvx5DmWJmivl2BsSn+HE1HVOifpAvXWV
 158UbGeF5FJGGa6sWTx/Bc4xMrxEbETK7UfPKMbA/3l/ZiPFtMUTG11EvhJq0mFEPqsDLRZw3
 nYDmqIRzncjFOG+29DaM7SsuJM6C4Xv8CH/XPvfPPK9MGAqsVJQyc+oZs6eijhVrjdx30n2Im
 WkYhvJaDWaSy563eORu8q7G84I7UnOdegygpmoPgky2Yc+w/GyomhvExGycgcAPH5jfok6TYJ
 YpBcpa2rUTR+rqzpH7a4U8ppL5J2h54PZms0SYcYg8Yr2ek+loUJAtudHWBWyP0HFrZAXXRR6
 CIPz1fRqk57sR1SqXwybP1jj/tpihJfVxhfy6pEhTDoUye4N6AwzhAK4iHku8yaTmDF3vZK23
 4aR1G/wKB7bqKWEB3aNPGZFzVh9d72h8BGlRjMkXGhTo2vZl3p2CZr21A28XBggcjc9+JCoRQ
 8c3fTRcbjqUjCryuZjkfuQjNhz3MlX897WMzk7/ONEzPMr2CcXM0JMTSUWMrZq5Bok3rdMV7h
 1gb9t28hh1HIQnBxG6iWgp3Mp1Qgaiv5Jy+oHqNAn8WCljW0IoZhBzFvJmQoF06DEIziUB1c7
 XRavrD5GM70gqrdrOOzpDR0jmkbfPaAIWQAdmkTXV6aPq4SgBFFDDG0KMkJWBIPLQjuwOQUUH
 Zby0ypSEldgcVHtOFTg5qVuQ==

=E2=80=A6
> This patch fixes the bug by =E2=80=A6

* How do you think about to choose another imperative wording
  for an improved change description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n94

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?


Regards,
Markus

