Return-Path: <linux-kernel+bounces-356326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB18995F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78245B21A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079E01547DB;
	Wed,  9 Oct 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="utdjyNuL"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CB22EEF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454762; cv=none; b=l3rY+JbTQpnjren14LHP+0wahXXBy7ThveRdAhq39iZc8NlxGuOLBU43WuhNgcX8o78/raQliieSL2b4aG9+HZox9/DiM7MjblGIcyK5hEy3MKyYKk36sJwnz5mRlVfdJ8GXFol/Eyglp5RDfdSkur9P3t1AxmAVU3zJhWwDEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454762; c=relaxed/simple;
	bh=HRA38oGK9W+6ouCF5TvVS6flY4X7LGvurMTSKz2Vd4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbKEQD9i2NIxGVQx0+AsQJcN+Eq6Dv4jH7msA6cbtxUC+5n06QnIEKWpjbfSkEvqZzHJuy7eIJY/CBUXtk9HFvt/F0Dv3ItEZsy1XrVjvrUEgWopYf1qpcAngyHGzwht8u4/Uo401eEnad1xTIigBXA2leSg8R+hgH85uJ4YGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=utdjyNuL; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728454753; x=1729059553; i=markus.elfring@web.de;
	bh=ZtZX1vZUBgjO4+SGVzMvXWL65ePGhiBpJhklPmYBB5o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=utdjyNuLYWnjs0n/nn3Uds+BwrbctFgGeP5CzlgvNHhFmO7yvhz9lLujQKr/5uSy
	 5CSa/3ja8PzRUxAtvsdVIyLAjVe5pON31WjBj68QJT15pS5L7GchM5SGwhKzElVok
	 9eZ4PqjzUBMAIMA1+WskDq9GOUWScJdeSe0/l4HIS1J2+mhLoZ/tdXjdxI7djXpoI
	 XVWZ7IbXGyASFBj7hdFPozFUAeDPqGunV3G6tXlHYYRflDBmcKXkqc0YezTsjwXA0
	 BMjdACvxYkkt10jqDY+9KJZ5gSPl2tsBZyDr7qWExCoMoLUP1/tqvTD1ifzbkT6WL
	 qgBgDZWfH4sAzJP1tw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumNL-1tp8vW45z9-00sMd7; Wed, 09
 Oct 2024 08:13:26 +0200
Message-ID: <e1a3cb30-1ccc-4a1d-bfaf-2767b5d08042@web.de>
Date: Wed, 9 Oct 2024 08:13:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v10 4/5] drm/mediatek: ovl: Add blend_modes to driver data
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Adam Thiede <me@adamthiede.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>
References: <20241008064716.14670-5-jason-jh.lin@mediatek.com>
 <0116377a-cbf1-45d7-b961-4ef0198ad8d7@web.de>
 <09159834fb362b2e6b3aaee70b4321c07d37601c.camel@mediatek.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <09159834fb362b2e6b3aaee70b4321c07d37601c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JGQJDOCJHmYZ3e9104Aphwc/tkO+tdF8wud/mdYUCpghL4nZqsN
 yh7znJJ4Iq2H2HacvgcmMPTwFGs638OggnRD+0ENRLdw07OkUVloOMRpE8YhMtwnQtzYdKZ
 knFku9GC8MZ1bkpytqdqI8z9jJmQWJP5jc87L6LmvHxEPDXq8ixdEW35DDdRMxj2VxFnzYc
 5GgxCjIvGPNalJAhI5RRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:97lYOmTDNuU=;zJBVCapPm4JHGIT25M6PRO0Y9I7
 5L8piQVFwTFGDPhaYEjVbmiUZw3PyQojcL6UuqXezcVU9BNu6q7HPgNY9gPqy8eBoGAFgZcAz
 uNpJhmiSYwJzfqt8MQDajAohfR+1KjAXBoRIZEYRCrOVZd8WlDVkmb8cCFziJgPptsc3K5pdR
 /x7IC+4l2A5Qm5ovhq1dfCXXw3Sn+31JyNTQUF8mD3OwePyu5oeIkwmTzXfgU0JuwkWMJUeEY
 JwP/UE62bkrdBtkeihRemYvq9ap/LlkK2QKJ2MmqkP0HOy5pzWNDylrjk/aR4d5Bw8Bgy+dLe
 uSPOKQapR4CZMyA3YBtfq5aDyj7D1Fv241rqu9itWIgh6+QK41oBgJz+q/hVKatUlHGQCgMfk
 arKo3x963JvbOZZLkrE9hTp58SuyqIZapY56bcE3xP15Zjjwg5RmEs+BJzsPlEJDvlsu5akT3
 Rjd9JCwDWoCSn9/c3eWRL4oQS+QyqjPxeTAwCFKNQ5BMptsPSQFGyAsvgT9qC+/NyhI+oXbi0
 oYJE0DAm/+02G1Xzk6tpgN5lw1IbsiowTBELc7DsnmBIMcQNyZ/PRHK/OiW5IP4rlo1Ez7WTl
 iiy935L0Z4yBecIpybAkBBZ4LrhPbCUIFmMWJJu3D+rSr3XvJ/R1gUZFYHMeSy1OP85hkAXiC
 q2zbKh/W320FHVx0ccxal6Cp9sA0uGV9S0GsWQOSq68U0gfPbnUPdAlOuOqq03Z9rnz5ZRhDn
 vKBjTdGvhrla10xxCCRbW091QegLVRFlPkoilEPMeuLrFayHKS8K91/NMPE6euBSH6aYlAgOy
 0+bprEMFkMtWE21CzJNSDstw==

>>  =E2=80=A6
>>> pre-multiplied is supported in the current platform.
>> =E2=80=A6
>>
>>                 format would be?
=E2=80=A6
> blend_modes is the driver data that describes the supported blend mode
> in current platform no matter format would be any one.
>
> This sentence is describing mtk_ovl_fmt_convert() will check if the
> blend_modes included BIT(DRM_MODE_BLEND_PREMULTI).
Do you see another opportunity to improve the change description
as I indicated?

Regards,
Markus

