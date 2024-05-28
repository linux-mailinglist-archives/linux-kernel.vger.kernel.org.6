Return-Path: <linux-kernel+bounces-192745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5598D2189
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F861C236CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A5172BC1;
	Tue, 28 May 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HU0AVVPR"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCD172BA4;
	Tue, 28 May 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913362; cv=none; b=pkh6UH4/xrxJhob009r49/4PvMpsh2fmu70uHgOW6ma6GPRnzyjVxVPczaNl9Fj0D2bFkTxtNZHZNaWrb4mupuiNMp+sAfFQdfFWXAyY8NJpcGgmEST2OD1Ge/1gstBCQ7QyoP47gby1GyYgdYXNHg21sEc9Wgaxd33FO884+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913362; c=relaxed/simple;
	bh=kpR2fFczl4zrmb4jbIi8NsKzrZZ36Zbggc2EgLO+vSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg1wk1l4V3X4z3+4+M8qImpeGjUxP2oKP2bh0eIeS9eGZfhmOLKJoxZTRJ7fJUJq7y59R8Tu7Aed0ai1uCw9gRPc+BP0giBEp12Lj3Eo2TBDV0yGM5GmJa136ehjgXphcnfADbDJRIUzyR4pOrfbQLT3pVL15A9Q92T4YkwHriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HU0AVVPR; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716913344; x=1717518144; i=markus.elfring@web.de;
	bh=7KM1xuNiCDT4AGTVfn5aUlOhf2Cxr9DbH5hJVtIXgBo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HU0AVVPRMfIJjsn6LmnbDkx7JtYrWx20cImP/KI3AhFTBlRTgEUPzAzaem13l2Km
	 8Fo5r0R7QwfenWl5LtdRCIH7aTSyR1deFjKZRgwGKV/swXLgdm1I8fTAUshcxBM++
	 fRkBJlAfa/8LNGBDzdzSp7D0j80v2US1yc++H2scDAEwge8WBUEr1biNmBEcbySWj
	 LRG5tlq3yGRf5I6kLCCYqc54FGT/x7OUdrheOLTu/gag9UmujPWOuBNn1o+sLtlWS
	 T+quZWHUP+cTWU0+GPhJBT1GztH2z0ne9GMPb+UPhXbwdAJASd0/ILBGiOjzlyU7u
	 uAkjWZq6Aumd7Qn/HQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkEhR-1swe5Z2Ywb-00kXG6; Tue, 28
 May 2024 18:22:24 +0200
Message-ID: <a2036c46-0527-4ac3-a40b-c9c2cd3e185e@web.de>
Date: Tue, 28 May 2024 18:22:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: soundwire: fix usages of device_get_named_child_node()
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bard Liao <bard.liao@intel.com>,
 Vinod Koul <vinod.koul@linaro.org>
References: <20240528063533.26723-1-yung-chuan.liao@linux.intel.com>
 <0080bd18-58e1-4e82-96e0-e64d2fa978c9@web.de>
 <9d5f2625-f3e7-4212-8c9a-c22f137f39d9@linux.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9d5f2625-f3e7-4212-8c9a-c22f137f39d9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BTQELw88TuHdzg24tV+ZDlWviFo3A2UTKj79AOudD3HtO0qZAuG
 OkPxT8mN8jE40HX3GVawWdL54FLL1DiGteLK7mLSlX2NK9dp+3kVCcnLptWLKe+4Dze8jHX
 mg0kWTkvrf+kGRYfYXQHdPGP7D7IDQIJTIJR+EzyLRzsg+3/v1X8embj9lfjKTjAWNeg01X
 sfODsivz9slGbY6MUFbaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:js6plXQPR28=;NxkUglzSnCjMlmjBbGwe2TU+qT1
 dquw5HV3GSAdqaW4R1byAR1VsCQ+J8a7a//PThtcXar+f0cwLPhY7G0CtAO/ixp9bgaIzgwXe
 d7Quea9tMzGZmZr5KuwEsU/qDPhyGDnECcbGhsVHx4iNoDSBlm7sWwppy3PQCP3QTp7YZ/58j
 Fm4s/ctHoTzwRsokAuVLrDyd3h0wIn6dH7/E7ixjEVHj4IDmtHS6gENzkTLChmB1QxF9/4tUa
 VjPIiQgVEnhq9qKWTey4ZWQimLX6a4TMGFddeafb3/HqL6cvBED1Awhl2s6B62YQ+fb/Ebx+C
 6cZ7QOPPq8EhI5Qku5yqq5GJGkByHdYJnU04JE/5/W7zrMsSUnPUKhDzg53ID0p/Nxyx30zAx
 HSw3lvOyWD7U8jJjC9RqT8AaHN1DfRF324NmFtku0ITcz7RpQIp2EjGZkm2EwN7UZdSYm2wNF
 DlITDKxgVNgtfpQuS9QHPr3KTPaupIrcnwZ1MI9ZfnffNsPeq/DEB6XlJQOsmKog+63xQJWAJ
 xQfOSw66SIb1Pr5dZBAxxgtb109QuRsjfFWjc0HjKobbIAxNEm9Vrf5bZTB3p9vy/X8mkjTy/
 2cDVpQ9EYDov5hVxPNG3tYVt6Q2m0n/vxCkYNiNdX+FgT7okMzizN1Sq8x/tIya98ZrpdT2NB
 XDMXnVx5HyZycUoL4DrN5FbGkGRNJqwFNW2vLs5AhfjJtGjMh3ATN/okE4vZqybY1PwgQABHp
 51wcv4vIvspyJKfL8PemwDeZfHMjJxnl6WYaa60CT7pDUsQrQoCYhGSE0somERX1KlvE07f+B
 7pdvOyBytyk+J8ZcH94mcKzvn72dvG6nuKBhebxBb32ao=

>>> Add fwnode_handle_put() to avoid leaked references.
>>
>> Are you going to respond also to my previous patch review
>> in more constructive ways?
>> https://lore.kernel.org/lkml/eb15ab0a-e416-4ae9-98bb-610fdc04492c@web.d=
e/
>> https://lkml.org/lkml/2024/4/29/493
>
> Sorry about that, both Bard and I missed your comments.

How could this happen?


> On the Fixes tag: I made a deliberate choice to add all the fixes in one
> patch, to show that the usage was copy-pasted and done 'wrong' in
> multiple places. That makes it really hard to add a Fixes tag since the
> different uses were added in a time interval of about 5 years.

Is it interesting how the affected software components evolved in the mean=
time?


> We could split and have multiple patches if that was desired, but I
> would still not include a Fixes tag since the leaked references are not
> that bad, we read the Manager properties on probe, and the peripheral
> properties are generally not used by codec drivers, so it's unlikely
> that any user will ever see a problem that requires a backport in linux-=
stable.
=E2=80=A6

I became curious how the exception handling will be completed here.

* Do you still care for the usage of goto chains?
  https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+=
goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resou=
rces

* How do you think about to increase the application of scope-based resour=
ce management?
  https://elixir.bootlin.com/linux/v6.10-rc1/source/include/linux/cleanup.=
h#L124


Regards,
Markus

