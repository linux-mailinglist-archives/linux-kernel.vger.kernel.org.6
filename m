Return-Path: <linux-kernel+bounces-232380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64A91A7F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3591CB2397E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AAC193071;
	Thu, 27 Jun 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mtyrB/lD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF613E41F;
	Thu, 27 Jun 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495332; cv=none; b=f7SnVvoVLE9MJmndPeLV3qKqCMQNC1vgO3ptNk47xw54CVF09xrXjk6zduCYwD8rQBiPSWnRm/9C3k7XM0T98YJzhiWAu36Q4jWZwgsILj9o/B3gWMNU9TDPw8QXuNr5McbKur9LuF0YwkC1NfH1tVynyy/nLDrf47LSWo/YnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495332; c=relaxed/simple;
	bh=pTKuIe9/YmDaHNjxPpbXHGyhcrdJe6sgTA2yII4wYBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZsN+R8oTHlCM14p1tDuwWf+bTTZAR8H22jyWaY2tAjUlwzDqMZjnOYLPSGEK/atxbcaTc083N4JV0WLbneGyTOISebBVC7xy+fNP0Z0+tM2UMTKk1+n+qwmPKoSM8Keleae+piGTjT5YJ89NmfMl/cZlr6GipyreRxTltg88ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mtyrB/lD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719495300; x=1720100100; i=wahrenst@gmx.net;
	bh=pTKuIe9/YmDaHNjxPpbXHGyhcrdJe6sgTA2yII4wYBs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mtyrB/lD/MaEGf7aXATIUbLwCQoQdAxYidxRcGH3r0PWF/PkIFoehT5Qw8Qr8jmu
	 GXc0QuOPzDvlEIJXY+kE+oZ9i8XffmolCjNKb3csxX0+0gCb0ycAcf/5N3ZhlaXbF
	 rPQr+0rcu1ifvpX89UMamHNYtVRqXCle4T+jCf4XoLjmWXj/qL7LrtQSXD5JQO+vV
	 YPam7MZrfQAr7YwhoiASAJn7JvwjB3vlX+sFyJmo9Y8m0fRLqi/kQtOVf7fQlCMXK
	 4czXfIlML5Zhj38gSmCLwtqg9dEVuv73KX8Qjd0R7RAxBCThgU0nYxVKplZ9L6AyF
	 cka63OFTCa6uqn4k/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1soCTp2gSz-00k7Pd; Thu, 27
 Jun 2024 15:35:00 +0200
Message-ID: <148a8d9e-6012-4213-aaeb-f47548a83b7d@gmx.net>
Date: Thu, 27 Jun 2024 15:34:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_debugfs: Fix build if CONFIG_DEBUG_FS is
 not set
To: =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 gregkh@linuxfoundation.org, umang.jain@ideasonboard.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240627124419.2498642-1-bero@baylibre.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240627124419.2498642-1-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ODqEM1xOq7NNYUf2wLJeFPacpSSFiZ05hxsA2CATvHJpdEiUmSP
 E/ZovIFjKTH3FcRpDc28XUB20m3uEJESZwpAa5va2A9lDteRBTHyvP6JMz9vbWlKnEk3ywF
 /wRgMqVEoYp8e/u1oZLaGxFfXPgAhAJFkBDqrNut3hZttBRi8U63lg+WWocbsQMzL9asxdX
 XsOmSbVOu+vEol2kX8gIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v/83yD1TKMc=;Ox6NeYvhdn8GSX0nEhX6rVomXuj
 UzIhJ88HeNFeP/3HtPH+m7uGEJIG/RVgHURTzLeuMk5QdbnRQaDvkMHUDS8bVBQVcmA9DuyN1
 JCcGng/CATFl423pk28WB/NgnxSMmCb34co6zwc5iR8DOdS4wNV7Dx/ZI1zIAfJHNXEIsPuNn
 FydUp/wA2toI9W0XKMsxFmPvqE9fXJAT9AnY7p3OnfbiCQQk7eKlMzDsbIJaZEiKrFKlecFqi
 3KIYCgSIPJ2u/gxpHo1sOKm84ZT+GuV29/bfZLv7TPFA37nuhRdawh++kam3+A09J/ATUPFtl
 yXQKo5PQXZ9gPwyZoCXDJFTwsrsByZ4cwYPf3LO+67sqgdzGGFcHFk+gA6VBTYUg5lQ96DtHc
 7EE2xvZ7WUkcVM1mE6AbHnO77YV+Gz6smatGDMEKGHqyYLDUU4W2EclHPdsFqz9SjCIKMNP8v
 uTCUqiKAIiMCFRYwbokIc5OS+sndXra7YPMEA0f3oFMKhOWpDzhF6IyIUiTlAbIrz/ik/bb4a
 0bFcQvM98mTeGZkd3sB+6Y/6PC4SBrP1eGmyQc86GZnbuveP4FZ0NZqe33jaCpE17WxwvDrnL
 kCZCvxQV928079wP70nRQPQ0PD79ZaWQaKYK8+zE+q5VTLZ0tCqF5zkdTsH+DH/4TFLoqcdB4
 WwyUt4KR2UcSs44mqzk7USlI9/pBNodMXCwWVnyjIm2wgMhFgQ355fBZjS2ZyDKFRuHTCNDuw
 5tay8fnsAVsQ4ClVH1n2BIfd4ec50GmN92rF7Qik8oe8FHxAgybJaDZlrJa3HlhnBw1X6TJlV
 /cfyemJB1w8NhjkmTX6cj5k3+5oBjjog2fI+k3hOsO31w=

Am 27.06.24 um 14:44 schrieb Bernhard Rosenkr=C3=A4nzer:
> Commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> vchiq_state") adds a parameter to vchiq_debugfs_init, but leaves the
> dummy implementation in the !CONFIG_DEBUG_FS case untouched, causing a
> compile time error.
>
> Fixes: c3552ab19aeb ("staging: vchiq_debugfs: Fix NPD in vchiq_dump_stat=
e")
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
Oh dear, thanks for fixing

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

