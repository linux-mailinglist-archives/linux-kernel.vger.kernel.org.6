Return-Path: <linux-kernel+bounces-179723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6E8C6432
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AEE1C20BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67DC5A0F5;
	Wed, 15 May 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iaz+Kt6f"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66B1DFFD;
	Wed, 15 May 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766655; cv=none; b=jIRblhvVXBW10+9BxaO0XciwZI79CLItZkg9Uwo9+BGxPw5rpOe36z6HrHTUhH4E3K0ekDv2Xmp9GMfy/CQ9leN0FIhSsxRRsEKBicc68BLTjvnETMZu+fVvtwmTapuvn2L6tclgcPJURZg7JcrkElpxx2u8hjq89w86lZmYNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766655; c=relaxed/simple;
	bh=DDg4R40TccKAJUix20z509ItiOhu6/f0gMNcrGMRpuo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qE88qpDWyY0yzYyyzq5d8CRaQZLFugAFcQccea3BaNNVvgfhhXGCXB4we3tyGnMYEusXPdF/UyhLMw61hSglZ+OWg57EiUSzZdDq3E3SGTwVFC4hXz8fPya3AhZP0AIxtpTCD1uV+xH4IClpoz0hJkvKPtzV3XGjh5I8IAgrRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iaz+Kt6f; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715766620; x=1716371420; i=markus.elfring@web.de;
	bh=SqxkZvoN9xImjR8xkMwC+V+NgpQ/yJZtwSs0BJUtt7g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iaz+Kt6fMpL217FzXfk2gk1GKgPQof91/TUnFK1Gm0RG+gp578YvmL2rE5nwqi7h
	 kFIpdLZeIR98oY6zFF1pGygsh4EbSyDIWoONoHSCvxU3sPlcIrta+9grWwxMPm+j5
	 2J1zejUMl+T8bojWCSfOXRbzcR4OXNG1YTm9UrXdq4+1+cQXAbB0Z8kIc7xEEW5VD
	 0HBzEZpCq+zDQeon8eVoDkDIEmCt2INwg7PpD8YAHE+xWwo4bMpNxowBwlhMuNUus
	 ugQXqKxmO7OKwQVq9AvTiSDXk9CTxrJlmWAaoDfU4aEP0+shYyEDIiFu+Q6U7nmXb
	 Pv4yBMwJxTudCXGXBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1sH7RI2yU8-00CIiy; Wed, 15
 May 2024 11:50:20 +0200
Message-ID: <b0c57221-25d1-418e-85ce-d5a8d31a674f@web.de>
Date: Wed, 15 May 2024 11:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kuro Chung <kuro.chung@ite.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Allen Chen <allen.chen@ite.com.tw>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kenneth Haung <kenneth.hung@ite.com.tw>, Kuro Chung <kuro.chung@ite.com.tw>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pin-yen Lin <treapking@chromium.org>, Robert Foss <rfoss@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240515072328.1010920-2-kuro.chung@ite.com.tw>
Subject: Re: [PATCH v8] drm/bridge: it6505: fix hibernate to resume no display
 issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240515072328.1010920-2-kuro.chung@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CJ6RIIFqLGJvulUgVtl5ZxlIfTQd+O+AlqIfJkYaxdN0UrkuvhZ
 p+3W7No3kexCVFkkFUqpdiFEREbi+W45nGGTCN45G6dfQNjHXcFJ7FjZEsiaIPtus2nsQJI
 Nc5uD9VmIbYLNr/ssagNb1CqjZypULVq4yeO4kWUxmB/NytyMBUlOsEN7nPjZojAhf0PLyt
 y7Jp6cwOip1O2zrPvWobw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ydA1YKoQGlM=;e3sVT5ewC1KaQdhHnhDcc8hXaVX
 +nnDYQid5AnAn9MnFY2N5XBbD9OXnz/Oy2TUMaTtjJcXgEge9DKJ8VG6++k4NT0eDtXooRX8/
 siG7V3wr7X0yJkLQ3WXkxxgMLBCUpdAy2PnyqX0S8/und8qWyA/ad51lPFXVl9igaDNOxQeLS
 o8kZ3N6ZNSFMMMwp1YU4D5PEbRQFJVgwgHTsE2NqCDyb64HhLg2hJnMtGNec7LiV9Bs97srNk
 mngBaieLEOLN0BB3sXppwD4MLIuYNJtoy7D0hG08OFVpWZ10NwTGGFy2NTOPJRCyshgsquh3D
 +wAh+Ovl5zGjZ1eTjCTysufezWeJE12ZJtB1pGzvn1abSlWfTu49VOXNxzVe3DBkE7kraFg5a
 z5JJfl/oPrQrCTb862Xdl4w/hQYprlRTer0uQVml30WJJDQOosyTL1ViovMGGswdwvEzYbtt5
 t+t7xymeiIf9bdhT4jhqlAM7g+S6VSbiezbF/pOHAntPWZ6cC7CdBndgzvm/wAAlBk0BD3pQ6
 UXq0QQ5P/4pfynRsbfPA32+uHbZYcDJcDRHGWVdFU/LAWu+ehC0vDmzijLRy+OfqDf3C1W0LG
 mmHTuGEYHWjQvW4dN//di0gTfRgPYwH+V7mBAdvj0Aw/NOccGV9RSyeulL2U/cxm3IiXdfevu
 v2wqc6luPg1kQkdfB6oumrFK5M3pI//oTUGWrkCu1jLMOOZ3lU5b1O5UvoJE6yjiB/N/ysiXw
 McVohdygQTwbiHNLBfOgTM4c0Clt3jPl3G8Nh9YSJ+mZQlknFMdTMjSdN7mjtpjCuk8JCGGoX
 v5dkszirEFKutw1o7YlfuZhxBnFMOu/FUDYckXgptkJUI=

I suggest to reconsider the distribution of email addresses over recipient=
 lists
once more.


=E2=80=A6
> But the input FIFO reset will also trigger error interrupts of output mo=
dule rising.
> Thus, it6505 have to wait a period can clear those expected error interr=
upts
> caused by manual hardware reset in one interrupt handler calling to avoi=
d interrupt looping.

* Please reconsider also the usage of word wrapping in such text lines.

* Will another imperative wording be desirable for an improved change desc=
ription?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9#n94

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?


Regards,
Markus

