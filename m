Return-Path: <linux-kernel+bounces-352300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF11991D37
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED07A1C21780
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FB0170A29;
	Sun,  6 Oct 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CH/21V+m"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA416F0CA
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203210; cv=none; b=npJjyt7ShiSGW9Kp/maFx8xXt7UXdpRQmN3g9w35m1lnQV5TZEMPi/Tih5SjUhdBWSviLvA6QucgnWHvFqNlnMMVq3P0omVs9m7itnP4ntkW4wq9DOiy3Qrpcjn0xk6g5ZXdF8gUBkX8OUkXoHPO5ABCAtJdwTbvLZYhWFp1t5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203210; c=relaxed/simple;
	bh=Y4ockITT1j5FDIoYVCOvGM4GjctO3dHrsHjmmK90pJQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BGjQst2CIi/YLotLCVGmAbV3hZ15gZ9Wlz9lB/+H8yHx5Ah3vd8Ybou3qycMcczQl65MR4NFyY3KIE22sxpzl/LceGZyahZHI6rEqI5qClzOrA5yyC4WgaRAnQHyY7sV7R+IsyaP8cGmDg28XmpaMoUdkexG/V/qi4yzGtHIKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CH/21V+m; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728203182; x=1728807982; i=markus.elfring@web.de;
	bh=Y4ockITT1j5FDIoYVCOvGM4GjctO3dHrsHjmmK90pJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CH/21V+mM422lc1yL6cXpqoaCbmLO1H/kUCeEHs/Vu0udU4G2zIDCxQSxUTx30Ks
	 HNFaH2np6tV6GT8Q5mVOo+5mdA5CaThEwurmtL4GMQ+iU0qXFiVp5RzbAdj6LobIG
	 /7sOnXAqZ4rWg+YkNu2zJUJt2eYxu4anIO+cwqfW2wxfTATiTCiwt/7hzX/wwV5Wz
	 ERGfjBKuWqlCAGAKO4jju4LILm5dnqFiAbcvMv8hsr0tQ2qr6RoSpDO/GhvJb5KDS
	 XHRiDWqO0hoYfX6NgNtqo1yFTVyIwK/S4g7STNPZDPapoQjCpw8OFfGolO9LWllE3
	 G27OlVrbhPme6GbuIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1thzs44Bdh-00k4K4; Sun, 06
 Oct 2024 10:26:22 +0200
Message-ID: <2e22e3dc-756a-41ae-8c83-1a08cc824046@web.de>
Date: Sun, 6 Oct 2024 10:26:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ni <nichen@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 Alison Wang <alison.wang@nxp.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Stefan Agner <stefan@agner.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240918074841.2221210-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] drm/fsl-dcu: Remove redundant dev_err()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240918074841.2221210-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:D7nWqKs5SibDbS7K1nYXxDU1ZAn8Zg+j/upr6i1SUk8S9vVWz7z
 JpJIJRPMBiyJ4+qPZ10WKMhKcRDc20CM0vNi3lhUdCMHeyB3jQ5EXCWKfLmcLjFNbOETQ+H
 ZUOyzpEUiWolknfwZsvomLOShvG3OKwimaBOhhRpo2645QEP8AV8ftbXHGck20TFTf4Bb/a
 6ytZNNS2d33ojnK0QOhtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w8QLfmpfoQQ=;+zuftbnKE7pB1zvvuNLYB52X+ua
 zAT6ZOt06Uv9SR+tiOVhvz3SoIcg8TY7w3ORJ3WrekxH0uYMSIoi/QxcdZFAv3NvVVlOfPxsr
 8IFxF+lusft/bcv6zeJAK8pIsvkK8RiJ3fPzAD8/08cD8DN2wIjqaDLg+sO1P2KEiemqxmHmX
 4+7pMMsgHqycpXYGO1O5QZdgkN769JjjSjO+ediTg3zHdiKBr0rGjeAyq54nHoJ1y3vCGq3w+
 tDv/AeyyEaJvFogH5EG6ZgGKLuc4PdL27jBFKocgcsxnbGgQDLzFm9xHBFwrpbGxyalRx5fUb
 xrrC3BtkjREXiPxdGVcPeZptrMewWTXJ2p3rVmSfdRcViHHrcOQ4PdnGNDCCYw65YXxb2DrjK
 1Zhnmuiej3pmTP0kaQihIpM5AhKeIJ2nILAox/xql7l1DFf+6kUjmKTG/WLU96coh4SxTXY32
 SFiPCnwXiFwT3D6hVd3gkgySYZMxQ+bS4OLX3NPJ7vAH3IsK33DsBDJseyyEFV+z1+8qrWS/l
 HN8XwXKqeG+j+2NLd0e/uNRbPMwP/IVH3MSZ5ojL4BxS8OYOUeZnJl6jBMPc+mLAGFyUYVUYa
 H018M8ObjdLMs/WCLZsab2el+kw5rHfH8SdetQeOUONVCmCuwgI4H7KAqoEdIXgm5kKUxx0nB
 1etirslcalg90V/Kb17lyqj0/lv9PWrSFIOgTSXyhpcfJJbMkJ7cUZpezjHRka761yTXEtEPg
 ifNYEE7c/PlFWnIkBvhJ+JUU/GwcOcnYZjWHd4NaNHCvCNjMoLQDD+D2G0sMz/SNY8R4Z2SHQ
 gf+E7JkGm7k1rH+MSzGmG69A==

> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from platform_get_irq() function
> as it is going to display an appropriate error message in case of a
> failure.

Can such a change description become a bit nicer with an additional
imperative wording?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc1#n94

Regards,
Markus

