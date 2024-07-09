Return-Path: <linux-kernel+bounces-246122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2863492BDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54961F2711E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BDF19CD06;
	Tue,  9 Jul 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tZ0Ke6Ij"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE019CCE1;
	Tue,  9 Jul 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537608; cv=none; b=DjGB3XLuWrSWfW/vyWEMOczpNACE5CfQQu32PHtYYbInP9IBEdGorgkjs3x3MNSV3/Ad1CmMyPX4VaAWP2wVadYdy/HyC31HxfQNrReNFAHDM00FqQMUDATT43wjqftkV/Xm2eNEzArNyaQ/IMdbUI9eXVIc6i7GEh50CfyQ4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537608; c=relaxed/simple;
	bh=Ev+hYYCgQuT+OInBf7HOjWwJu3rpgA3FZ5vehiFufpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SYzTsIy2GGmVcj+1SenBQ9gyntmogBxaqAPb3R1GDttqV655AYpDGgxRSebtILqFL0TBl25aOgxDo5+/o8Cg6g3t2ZWHlSPuM0JyInfT4VhPqez/gcL/AX1vHU+imut/xQq2YSyqIP3dHpk4ULcOE7XrU2fV54XseQuhyNC+MKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tZ0Ke6Ij; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5831541A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720537606; bh=+aZefzjyqJcmqhE79dhI7IuzKowlLWiHzqxibVnrW0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tZ0Ke6IjtuJUW90INGiHySZBmgCKtM9RT94BUkyaztoM77aRUPtHhc57hNdSZ6aKC
	 zWcHKRjxyLLqjGiGrJF+10PXHvqE3yBYanquhPyXVNA/rdpMXMJsWBHGDKgI/HDlQz
	 7GO0Hd4kHDrbxjqhYKyRMVDoGu3v33TTlmP//Eq4xknw2Uy6GSKbtkBU4cAjhjZhSB
	 gEVq9tdqKnjhT+2h0oqUD35FaLIqauFsiNZqUv/b9a5mt4cttC6FaBOFwdd205TePF
	 1E0JQW2Exhkg74YOryQpexp5JMVnkb0Xr7+2fTV0I0pc65/zLkEEnWGNRHPIIuCoEO
	 ICp+gAo/skEXg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5831541A36;
	Tue,  9 Jul 2024 15:06:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Zenghui Yu <zenghui.yu@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: alexs@kernel.org, siyanteng@loongson.cn, Zenghui Yu <zenghui.yu@linux.dev>
Subject: Re: [PATCH] docs/zh_CN/virt: Update the translation of
 guest-halt-polling.rst
In-Reply-To: <20240707161444.98715-1-zenghui.yu@linux.dev>
References: <20240707161444.98715-1-zenghui.yu@linux.dev>
Date: Tue, 09 Jul 2024 09:06:45 -0600
Message-ID: <87h6cy8v0a.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zenghui Yu <zenghui.yu@linux.dev> writes:

> Update to commit 1954d51592b5 ("Documentation: virt: correct location of
> haltpoll module params") to fix the obvious mistake.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  Documentation/translations/zh_CN/virt/guest-halt-polling.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/virt/guest-halt-polling.rst=
 b/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
> index b798d1cf0b48..463d1d829062 100644
> --- a/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
> +++ b/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
> @@ -76,7 +76,7 @@ guest_halt_poll_ns=E5=B0=86=E4=BF=9D=E6=8C=81=E9=AB=98=
=E4=BD=8D=EF=BC=89=E3=80=82
>=20=20
>  =E9=BB=98=E8=AE=A4=E5=80=BC: Y
>=20=20
> -=E6=A8=A1=E5=9D=97=E5=8F=82=E6=95=B0=E5=8F=AF=E4=BB=A5=E4=BB=8EDebugfs=
=E6=96=87=E4=BB=B6=E4=B8=AD=E8=AE=BE=E7=BD=AE=EF=BC=8C=E5=9C=A8::
> +=E6=A8=A1=E5=9D=97=E5=8F=82=E6=95=B0=E5=8F=AF=E4=BB=A5=E4=BB=8Esysfs=E6=
=96=87=E4=BB=B6=E4=B8=AD=E8=AE=BE=E7=BD=AE=EF=BC=8C=E5=9C=A8::
>=20=20
Applied, thanks.

jon

