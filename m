Return-Path: <linux-kernel+bounces-267998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB5941F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5017F1F238B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6C189902;
	Tue, 30 Jul 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gTLNW1Bf"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291917D8BB;
	Tue, 30 Jul 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362749; cv=none; b=MIdyBL7XykeW/4xdI6YYkA+S0XrZkrEgMOMbBAss/caxkCC4rbC7uUk+J7hXjkOIs8wOLNOKrGZzJXFnxcPqaRWFLbBlOKUEpiYw8IASIE8Mr5BE29JnujrP78lnGRPi8CeRIKBo8KAayHPgik7qX1TI0bwCnCiBQ7tA12y9Zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362749; c=relaxed/simple;
	bh=1eB6g6HeJ03uqsCA2JMrfAN4wqesA1hbtTRJ/6jKMLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9igqJ9GYO0flGjUsvYhmD7tbnzk5qb0H8YZeY8Rw78+wEqsqVrmahVeJHS7s7wxA+GrSbN1eChQn0gHpbKPfQ0zhGegom5+fKQ4v3OVgNhe5mI5nwj2qkKRB6L+EB/KD7sgneruoHV+lbN3MMGWqUBUSkzhEAx58g8egMdoXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=gTLNW1Bf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722362726; x=1722967526; i=wahrenst@gmx.net;
	bh=EBLycss/rG9rOzogO/BwdFtzgsIKTGDNL5zpnPZfUAo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gTLNW1Bf8oLgaF6Wg1JQ16fp44XW8fFmszpgyimNbxO/J1Ms6bRfte01OgOqSdtA
	 MpQ1ysjna1Jqq429TJ7mNgnUlXZvKgKj7BUk8cPTbpgGMtcnnW1bDMDEChWgEnMSo
	 S9b/bFDKBsqWCFn9wk+zAacRC6K8so9uKe/GuDJ7+7ybgRHrye4Ngom2GPxfdTpkZ
	 ROWKHEuWp/1QLPHXMGBl53UfvBNqlVpK+qZ99OHfQqziYS7UDZ5TjD+L1Cpa9hQiY
	 KVqSjfgdAbleaABn+gEnVtSAs0Yv9PD1KhwPR1Iebl3S1WjRX/6bG2bFEWhzgBQDT
	 okitYyHiae00OJCytQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1sRxKm3spV-007Lwq; Tue, 30
 Jul 2024 20:05:26 +0200
Message-ID: <e0692316-f8c5-4ddc-ab39-ba70cbfbdf28@gmx.net>
Date: Tue, 30 Jul 2024 20:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq: Avoid mixing bulk_userdata kernel and
 userspace pointer
To: Umang Jain <umang.jain@ideasonboard.com>, linux-staging@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Yang Li <yang.lee@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240730170840.1603752-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240730170840.1603752-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r6F2ajqwTFiDIIcdGiKC7cRFQTFfWOMNiLHRho78BPgzvQHRE66
 7TTcjjxJT7tzttbXeobj4O6hm+eIwC90RfIp3nbXHtYdVDktbFTmcFJj7Hyrgzrwyq4ULMI
 1gRt7yqGzmEcu7tYHnM4/jaTAoacxzQt8bMVu16YbPw28cQHFPDL39n0mLfzkPjU8/OXlBj
 OZZVv9ziff4tm/g5iyJ9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iv4rs+u/dYY=;yruVDa7Z0GAFOwmpfrVkmPPzvpQ
 JzIekW53Lh9Mzyx04s+Byb/YyLrgYms+976UkwHYdfN0MCRsndciDXvyOvCDn26EZXWdWnJKD
 RtmZmJu9ZqOa2eog7A+dc+rOJ9124EKoJp4n0fx9oY1m03BdD9N/8oALSbM/zpvM3x9v+bBP3
 kcRl3LKvCXFuixxGFMNEF99pDvGssnTtXOyNzNhEGV4SkhuLomkX0HInBqerFyeh+URXPQfhP
 H+fKzl3AYhFHVpV7GDKcsq8eHS2JRWjtRawuAS9kcxDUWti/4Mx2toFKwFA77mS/vFyKn9fiz
 G4OLL3spcYjmtIJBaz+epUxTyHnik9N+o5EZseTUybdOGpUfuHFbBHBrBlrnWs6kib6y4c0ez
 diHF71KkigDpC0RTswzJ3q89D7xwG6AfCmmKE+XXk2VNAiA52ZCnL37GJRDmpSOwaqfRKLT4G
 iItrxu6H4P4a/8RfeWSafosVT7jPU8Zsv8a5lINzYKUW6h1UHtFn/pIQ/NnbSlAEC1thdDfIZ
 lcLXFXyDn71GyUc1fzYglhWvqXiKYR2NAKF4fV3WAmeBbFmEaSgU8ndvxVer7dV1ZWx/YM2o6
 sLpMDjwNMdpKSCjUx4u+hMC2ncPDdCxh2P3cjpkbq2ADx/Clf9sXTsieTDxrvyBpVWv7YnAaV
 UmLsNUYKjxk9Cmyn8T4X82rtWXp59doUKE8SYnW41ijSeN0J9i/spgAzmDCAQ8NUrJVMuLGh8
 2F6h44yWTszTIB0QAkfT/pdEafnlDpxojr8XHLg6ya+l97wS6a5PADTakBsRcCvFk3896tOeA
 ykJREuvEzk2DFdfvP56o9VUQ==

Hi Umang,

Am 30.07.24 um 19:08 schrieb Umang Jain:
> In vchiq_dev.c, there are two places where the __user bulk_userdata
> pointer to set to a kernel-space pointer which then gives relevant
> Sparse warnings as below:
>
> vchiq_dev.c:328:26: warning: incorrect type in assignment (different add=
ress spaces)
> vchiq_dev.c:328:26:    expected void *[assigned] userdata
> vchiq_dev.c:328:26:    got void [noderef] __user *userdata
> vchiq_dev.c:543:47: warning: incorrect type in assignment (different add=
ress spaces)
> vchiq_dev.c:543:47:    expected void [noderef] __user *[addressable] [as=
signed] bulk_userdata
> vchiq_dev.c:543:47:    got void *bulk_userdata
>
> This is solved by adding additional functional argument to track the
> userspace bulk_userdata separately and passing it accordingly to
> completion handlers.
IMO this patch fixes the issue for spare, but don't address the
confusing member naming for humans. It's not clear that "userdata" is a
kernel pointer and "uuserdata" is a pointer to userspace. It would be
nice to avoid the word "user" for kernel pointer in this case.

Thanks

