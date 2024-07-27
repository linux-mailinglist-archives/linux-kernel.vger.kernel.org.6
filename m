Return-Path: <linux-kernel+bounces-264127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E145693DF37
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956641F21E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD356F30F;
	Sat, 27 Jul 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="tOILh6sn"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F103382;
	Sat, 27 Jul 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722082161; cv=none; b=hVA2S5BdnxjPP2lXxylXVFcyOj5myLtOWbQKargZv7EOX6hoXLTpZeqZDIxRrKI7pyAr54Dd4Q4cKGVEL8SKhQSFKKggwBd4nxs5IlFyBg1YY9K7Ds3CbMiN+TGhSJR6OU4KP9G/HtHSuf8lN3klzGNoKe6dXXnrewBauWu7QOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722082161; c=relaxed/simple;
	bh=eLEYHa+txvP+ORLO1DCQFTF3C165+1lS1YxZqje5J3A=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=DeGWkNYlNAe5jh97HxVHqMNHnW/m1aaaU/hdkT76YC+V6kzf23bgg2yPfj1j11KLHTr134XIWAouvd/hkV22B3zwQ3Q5IWBCRHq82BeTIgNPaBZbSPlT8ngyZHA0WxH81nyjxwtvaoyxjXaqbFF3h7BzYBkiJdsUbPpdZaGddBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=tOILh6sn; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1722082135; x=1722686935; i=frank-w@public-files.de;
	bh=eLEYHa+txvP+ORLO1DCQFTF3C165+1lS1YxZqje5J3A=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tOILh6snPTqW9mFqqm1CrUJLwTATYXkQ8Hr8kNRzyhFdnEQ24kzQKr6HbZqgpSNn
	 IwDYtU/3s3YMjrpw57f04vChsEDyap+5O564IMtVrfkwE4T1+SICXINbnLLre8yWH
	 dzxA2jwLhZvRN6JoYmZOf4cjNyNw/G/Idh5lsNSZubwcEsDScpLMvmG+k9J30kn8i
	 qM+XlOlhawYZLkOyQP8T5JYTgyhWqJ6yNmpyUUy7S6O2/ccMBaaHFCDYOO13oAbKW
	 +QqBiAtSJy/enTRpH4FXqK7vyXwQi53K0hmcY5HvT9qyskuNV/lGJFEsTrVPJJvle
	 gHIvA2KX+jq0dSH8zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.78.50] ([80.245.78.50]) by web-mail.gmx.net
 (3c-app-gmx-bs28.server.lan [172.19.170.80]) (via HTTP); Sat, 27 Jul 2024
 14:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-3bc6fc80-e245-4691-9a57-f021b080d070-1722082134917@3c-app-gmx-bs28>
From: Frank Wunderlich <frank-w@public-files.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>, John Crispin <john@phrozen.org>,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: mt7988 usb broken on 6.10
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jul 2024 14:08:54 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <2024072712-paralyze-overthrow-ea04@gregkh>
References: <trinity-c8e0af34-2704-476a-9454-bf5001256eb9-1722013999541@3c-app-gmx-bap12>
 <2024072712-paralyze-overthrow-ea04@gregkh>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:CbCz3z3Lqvb4tz8Jopzw/pM4eonOQHsnprkPdh8Mmb3zZxcFK2f79E781zfvABNzOVK4S
 fqKGamZYtuFniMTxLY8iZJwgGMI3oATZDiujaUlFv0tg9D9aOnJdrS8LX9X1OZtsvXoI4XafDYzi
 FTErfxAGxzb7uX59A6NP4GYyP7ZBU33mxk2GcrEH2yBY0a9KmxpAO6Mb7CRZQrTnBRSIvDM2ZX9q
 TZWujumc3WuVUblaPvXvJw86T5fFSJYpRiogWcOFwvyY4LZW6sas+q+2tiSCG1lLcDZmyxQtbBb2
 9Y=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LE2+ll9mjvg=;GoNkjmUw+Zn4trXBKg3J5Pz0lA2
 wa3IIY91QoDY6VA6IHvvk2tKwKYIQdEVYCB0iuRCGiKFTSkInXLpR/NeFNSf+IVZtP/b7uhsP
 JVPSAtvjGrADvle5DUsoyww91Pup6ymhdaHhIv7bPZowbniF4/nEqc8iWoUeLdum2BEuQfEun
 e9fOvQgkTYzT7MpKIz12d+3gpSO3lWJBeDezf5ZkgrTjYeILtWxUb7HLbyc2ea0quR3V8JEVo
 S2UmdygXtjHpaJwUM/o49EcD98EHVISY8yaPUsgSJaEGpmxOgYjmqPQARRNvYU65+M1CqVD/A
 bodWYA4dpu9EnSjr3RRU23vj+jfZcD26t5zl+sxI2ndA1LAs8dT/2mZMYawnq1RSRTLnU/4X/
 1FkK8XKJX22fLbFO4SYRDtws9NQyty9L05bJosPOGA2ykXmA1ptHdHbO8FB5+22pq9l7Q92h2
 m3NlJrs8LOqxnXv92OOVlPCvrmbkoiMXiwVNXwJH7f+oK/rm+axDH9Z/ZgoLXLCgj0VYkd3in
 LQ3SkLNbhUJAGVEPPaGen5ToMxX2UXLfcsUMD8anARJpXH2dyVJx3nn7xZ3rby5GZkJXeu6je
 gSbGW63jhryav6h2tBjeusIA6hLfS+NNMlMQVNtQDno5ja8wi19k8MZbgCnlsZG6qOz4Y7G44
 b7C1/cMZYtiD18LAmNDFxUm3tUzbicYTI6FXewFfvQ==
Content-Transfer-Encoding: quoted-printable

Hi

> Gesendet: Samstag, 27. Juli 2024 um 06:57 Uhr
> Von: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Mathias Nyman" <mathias.nyman@intel.com>, "Chunfeng Yun" <chunfeng.=
yun@mediatek.com>, "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGio=
acchino Del Regno" <angelogioacchino.delregno@collabora.com>, "Daniel Goll=
e" <daniel@makrotopia.org>, "John Crispin" <john@phrozen.org>, linux-usb@v=
ger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists=
.infradead.org, linux-kernel@vger.kernel.org
> Betreff: Re: mt7988 usb broken on 6.10
>
> On Fri, Jul 26, 2024 at 07:13:19PM +0200, Frank Wunderlich wrote:
> > Hi,
> >
> > i've noticed that usb on mt7988 is broken in 6.10, was working on 6.9 =
(with some additional patches like
> > for pinctrl and dts as this chipset is not completely supported by mai=
nline yet).
>
> Any chance you can use 'git bisect' to track down the offending commit?

because in mainline there is much missing for this SoC/board bisect is a b=
it tricky, so i tried to find someone which can say this error can be caus=
ed by a limited set of changes so i could simply revert some suspicious co=
mmits.

But i found out that we had some major differences in the usb devicetree n=
odes i have not expected (and to be honest not checked prior to posting). =
After using same dts like in 6.9 all is good, sorry for the noise.

> thanks,
>
> greg k-h


regards Frank

