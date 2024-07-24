Return-Path: <linux-kernel+bounces-260833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A486C93AF11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5888A1F2245F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E21448DC;
	Wed, 24 Jul 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eqWvWseX"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA16FC2;
	Wed, 24 Jul 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813474; cv=none; b=oOt8WOsJ4K+xifACkvlHzRj5bwQxosrPROygqJwf+xuIMLYEVmjzR493jZohZTBfTy7W15n2CxrrhXarJu4LIvP6KP8WqohN5BtdUo6HxPg/ZbAH4BG6llsXT4UMYb2s3POHybYOqewm3dugz8HEzjVSZ2xDLd3t/WlrqCBoQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813474; c=relaxed/simple;
	bh=GI16kZp/DZvJnXEv3qKUE7rVQHnu64qzaMVHUItjoNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcSrlXrSVRBF9elEktKx853tudSDCO3eM/tRYfG9/5FuoCiCMN7O9gTa7OcOmnGxdoQfyZFmlXSe+3mvtk7yv5KxiTAv9vJ7y84YhkxTyNEm82DmKjSvdAGv4l70Xw2oUnc2Ur2rthPmV4RcGBIRaBG7T0Lqf+KdSGTI5ZACmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eqWvWseX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721813451; x=1722418251; i=markus.elfring@web.de;
	bh=GI16kZp/DZvJnXEv3qKUE7rVQHnu64qzaMVHUItjoNw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eqWvWseX8RDPKAwb2VcpWYv+kWCGBIWVyhmp57Dn7iSBNPaKf/2mo1q3+739GeO5
	 FYctuKYDMo0gWeBAwfG7ZuDmFmQzdhYIzKF9e9Cv4iyAVFwJhJ6teIO3ghKA6U34y
	 KXE3JTcrlBQfqPqNQsxJ6MjtMSeVEqJtxcqwKITMNgLsTyRA5uc/KaxeFayzfP2uK
	 fWzcocvnMpYECZLChYebvUNNGjXuqT02ZLF2QGmxiDTALaNmaQaDtzDJdyl2Epr9I
	 94Ett4G/bKFRf48NmvNCYDG7gh7XnscOp4Fg9uxhZhaltWESHdsFZH5UPnK+fjGG2
	 ogTcRvwVCg1sCEwb5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4621-1s6FvG0jk9-00wNRB; Wed, 24
 Jul 2024 11:30:51 +0200
Message-ID: <6ccf3891-fd72-47de-ab89-cdc7e9425c56@web.de>
Date: Wed, 24 Jul 2024 11:30:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/debugfs: Simplify character output in
 nouveau_debugfs_vbios_image()
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Ilia Mirkin <imirkin@alum.mit.edu>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <cb21950b-286b-4630-9052-cff9e7e56337@web.de>
 <CAKb7Uvj513trzg9bVGrjcQ8CfO4anCq7e9mgbD0eZKh=zNLy=Q@mail.gmail.com>
 <147bde68-2b66-4e0c-890d-30571a99eee1@wanadoo.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <147bde68-2b66-4e0c-890d-30571a99eee1@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RrGA6l7txMMXcnwEjtBSuPugQcQ+Aylad8jkNWgceoTGStNyfqr
 wTlrqWtDAlH0lOi3LmxFuBdFOurzcAMSBbVSOyx+7nYCzF9yEcAoO29vnrsaXFglXk2xPCj
 xn93kdCjgeIzu8z0n84elnUVbB32IjyF3DtuT04QF72Qb6Ozr7fwwcCvhY/mPFW43KB60nl
 6D7f2g3ZueR3VhfSCZLEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C3lcjC5oZS8=;DVJfFXGPfp7ihietJXxV4YSOv0c
 un3HOOokhKNsh4QAHnFrfQuzuFCEpaGi1xrkfUj7MDr+0JCPOwMXLBxeAJmlQMxLPNreUsjtQ
 roNUpubYtHHL+EVpYb0Q7I+g++Oxh5F2ZMY+vGlYo0AvceELcybcPZTxlBtb3IZCoauTU9m1S
 ht+BIOh0cb7KGtpZBbhOxYQ8kQJl7atuVYvsAFZ0SNyv2k7HbTmS3K54k5JuI6e67KdR0XMOB
 Y6PXS6gXmoN6QSN3uygBUPpKhfLQatXdnBL2nyMgwYa/9CzDsFuAybofJMTqd48qxJbvlEG7D
 1Ath9KSnstLC0AO0PDvsJgiW0gbffWXdYcDzfpyRsyQztaPnJMoW4NqlnrCsUcqXSJM3ixK0R
 gdD/GdiU3w01EVoYYfClF/bctRxLulSi/0abkHeqYXi4hzXDMRpSr3VRstAghGzYMWs3w57hC
 sBtXZouQ21rTIakIC9AUlAEO2h3O03M8bcoFzrnZMnMxKUAirtjr/tP1qZ0VJGC/5pOMa54VK
 6yCYdzL4qCqhMQOCXvkcNm/T3Aw9WkupeD4uMxwYKgDulRbnW8ka4DnRCQNH1pB/2z81XXvxf
 Zs1LcxjShshMbARhoCdgPUxYUD85eLKlTLrfYIurRgm3oT0ryXtLiex6PfRKU9t0157H7qHa4
 5D9wKxcGzpyqxOIifBWUKQP0qy4JokmQSa8Gp/YZ1d1kl/i08lbfYddTuP5VgeUO+Lfyjuo/y
 Qf95saO/iqx7QkxbB6wIaneO0g0yXG0DduVsxziGHh7v1FiyYC5l9XKd/4JVfyT1yk/6Jls5X
 AKenXixwFu+XceBf6IsDYOUQ==

>> Is there some reason this whole thing isn't just
>>
>> seq_write(m, drm->vbios.data, drm->vbios.length)
=E2=80=A6
> I don't know if my answer is relevant or not here but:
> =C2=A0=C2=A0=C2=A0=C2=A0for () seq_putc();=C2=A0=C2=A0=C2=A0 =3D=3D> wil=
l fill 'm' with everything that fits in

I find such a discussion approach strange.


> and
> =C2=A0=C2=A0=C2=A0=C2=A0seq_write()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D=3D> is all or nothing. So if 'm' is too small, then nothing wil=
l be appended.

The clarification can become more interesting for this system detail.
https://elixir.bootlin.com/linux/v6.10/source/fs/seq_file.c#L816

Was the sequence size (or the file capacity) appropriately configured?

Regards,
Markus

