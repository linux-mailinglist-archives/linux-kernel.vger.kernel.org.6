Return-Path: <linux-kernel+bounces-190190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EE8CFAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6811C2145B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D13A260;
	Mon, 27 May 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pgZWwmqF"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101774594D;
	Mon, 27 May 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797154; cv=none; b=QTlOd8VKHvCnQj8+q+2VnVep8lA7aRe26h5/ViK8IIpgFJLBjRarAJkUSb97QAgYTSm7/Mmc+MP9mCnl8oeSiVQndqm4N5C+iQ6SBzuUTU2NM5zJgwCl1pbIMlChmFq4cBE1ABw0ZbOdQWfoAY8AhZfK4Fo21wY4K1kejpXzDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797154; c=relaxed/simple;
	bh=lac9lF8UnVVtLrC5XrfcvjJCJwnsqZLBWyURynO0wXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDTtdz/aZuUrli0O6CWPSWEJIUALryn2nL85yCHds5pM5ucz0VTlN59rgbOCgegj+IS0UBxeYsw7nhIHKT+V4i9rJx/Q4jjNDgxEChLN0ldpInEzph7NQQSfHN6ZvoYWIs3OKMrf6xljNdnCOw1SOfibT/f9fdKKJNAukYxngN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pgZWwmqF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716797137; x=1717401937; i=markus.elfring@web.de;
	bh=tUhLW3gSQMrfMGYIaJy3UrTLpWoedEqeyBGARH45gtQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pgZWwmqFhg/WGxzKaBPPNy/YH6jENnjw3g9zB9rmapBCAR1YFSIfCVBAEnt5Tl8g
	 Eb4njblgMVITtrJEuiecbFk99whE2mr+H+Y6aONYhqwY3njOeXke3/FuiulU43QOa
	 Rj2ANTms0NmnP9tNUGwgGNbn8vDUTUK1id0rRk+kSWE6u6tkXPYkkWfg7XHdx+7st
	 2/f69hVPh6a2C3J8eq99No+6MDQsEE4HCRdTKUkxl8C6GUclFjTmRSevnjexjbFL6
	 xRUyKvQ5Jcunp08Aly+8lqyGI1dJjf4SZYIz/jfX1cdsBkGbNMj9zERvwVtHVKYUY
	 9MbmOgCh+FCPU49lqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CUb-1sbFK82KVZ-00rtDW; Mon, 27
 May 2024 10:05:37 +0200
Message-ID: <9023736c-9200-4eb6-a254-8e7d0e0204fb@web.de>
Date: Mon, 27 May 2024 10:05:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/loongson: Introduce component framework
 support
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240526195826.109008-1-sui.jingfeng@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240526195826.109008-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dz0NBNGIB9FBnJYsIivyNBdzqCc1nQQZfrq1t+MPBBgHP6v7Q5S
 BajyHOAUvekc7piKf/IUwwgyCpNYQj3BFg7Cm9vBw3FHFZFd0hlsrewUi6G+KPiUwAWCwpd
 XKrTHEpzkNYLrVtXAti9iBKLj71ST2yWUR+vRO86UHdwfnN4A6NlT2cZvOYVtyWamLjYFi1
 YWI/Y+XcE3mppx6aEYkkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9Rnuh3skm0Q=;abL3an1p3naxwBsoYmxawzf6ScG
 GJ5s+hV5VMsODidBf4XAK76lA0szbq/jrorSHShcNSgJajZeZt+n+HsJKKG1EjXRMPf5x35Tw
 uP4jH2S7rkxo3BK8KVyhkSJ1DJql+50jWSX8Lz7J+DkLqGPjsW2TVPKauZxamZa8fR59T63VO
 rwy9Ew7yZk6x/D4UozSKkkXxB/9urBcRIqBpxXve4T4UtOnqHg/luSk/9HREOZL5haVFoKAUN
 6OTu/wLwNnNQ93+sCaP7k484y+JZIofX5c9o7Uqv6S+zE39m73i5R42wskidJ0SZtZwO5P2Re
 1mr+x9ddvijLJPF1bOGUxZ23ZEWqVsqOBFkIlQmWrgC+TTcEK8yMZHzNtE4QhvHMM+fmNr2yV
 P8xnbR1fqmpme34ti1qKd+OfD0Lmvs3dpOd86PePTYMp27m/KfQmWNYs237FRoDXH3/7kc0rz
 Mx6BsTSpU3fULwyM9lvReaIIzApxxUgAIgROD9tgvv0umLr1TDTOD/x5prGQTz7wFMpgkBGOe
 yCKWFXLo5PRUIZDegTXexmrs2npxiux3xSWM9XlwOgoeuGo9R3oQTCkf0wePmrS6AMIuhIAtB
 1dMevqFuuzZyQA//mCwEa8ScVUEnffn4rZiURvRVMUtj+IcmLi7207ixCmR7zWKhj3esGIHDP
 02lF1svbdC0GzTq39UJQQxp7wKm5HKf/9v/upUpEDbUsQDxHFg8kr5GJ7eH5D1RxIS4hwNqIj
 Nfu4HYkRNl0M8M2d6X1YeV3NeM0tcFz4GNkYrtCogvws7QkPxcWgYenEJ+91b8GvyBr2ReCFp
 SKMOHnpZv3/qZPsXFH80NyBOtUHzNkyUr/sSL8fNfTihM=

> Introduce component framework to bind child and sibling devices, for bet=
ter
> modularity and offload the deferral probe issue to submodule if it need =
to

                                                                     needs=
?


> attach exterinal module someday. Also for better reflect the hardware

         external?                 Reflect the hardware layout better?


> layout.
=E2=80=A6
> consists of encoder phy and level shifter. Well, the GPU are standalone

                                                           is stand-alone?


=E2=80=A6
> for the master, it could return the -EPROBE_DEFER back to the drvier cor=
e.

                                                                driver?


> This allows the master don't have to tear down everything, thereore

                                                             therefore?

Less typos would be nicer also for such a cover letter.

Regards,
Markus

