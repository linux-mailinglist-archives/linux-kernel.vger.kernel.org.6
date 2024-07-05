Return-Path: <linux-kernel+bounces-242487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500839288C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E472F2840B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5841914A639;
	Fri,  5 Jul 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BOgB4UuB"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36803143C79;
	Fri,  5 Jul 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183036; cv=none; b=KjTG2zuM4ZExH63R3dS1Cv7R8QY6Eunl3fLklP7zdARMD81VJhSztMGwR+sf5EJe19NfFBgz7DNTHw0UoY6+R8airp+uj0+Y4Hpo9ZroL+DrVHWwtl9mlFpJDO7+WlejNSyITvuDTZ/qYfLW+bxeLi2101y+xUb65qQx8h5WXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183036; c=relaxed/simple;
	bh=B0KkSrcv7pinQNTj2Jy05a8iSCAPOJTg5SCVlI+4Vyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lm5Ohu1zqhjCasX1NEVCSer+aJag+guEOyhTJQvYFHI3X5gdeCwD7wUw8tyy2JNpxfn5i77SpQe4THbm5BA2NGlSUytBcCnOE13hAPpE2uesAjggUlrUhCBjtxo92VIH4xVFLggroWKRcmXS3zHMC3SAD0q402X8n/OI9yXz2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BOgB4UuB; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 81B55418AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720183028; bh=ybGJapzs/nmpHXDDnaG4kQKbRKEkJqCDF2NMtbNjWU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BOgB4UuBDKDvQxWc5nxI3sxnoQSGWUDmrmVqPebwPQXS6jo8jXtzb5XkQ3jm7HDeT
	 eKhJgXBfFKm4KzGXMX4GWSmleaHUjhTrbb118QwTuCnIwW/CWan02akeX0MB1x6zeb
	 Ty/kPvnDQ/CAbGe0Bw2YweV5YG9QcoOK3SuPPXjvWqa4GZP2N1lh/BerEksJMn+sMm
	 3xkYnusunHuVnqnsocqlCVo7KPAKY9lchGvQVuUOEHHGxB5UtlOtMqt1XTyp7rQjaA
	 f+j+twPf7UpGvFcweQbFnvNOpI5mm1lDxi2yL9Jqd1Sdn+bbiXTFC4frLu/tjZpFbl
	 A0eDXTTyJ35Tg==
Received: from localhost (unknown [75.104.111.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 81B55418AA;
	Fri,  5 Jul 2024 12:37:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tao Zou <wodemia@linux.alibaba.com>, Dongliang Mu
 <mudongliangabcd@gmail.com>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] zh_CN/admin-guide: one typo fix
In-Reply-To: <7E195EE5-F38E-4F32-ACA5-A36D79E66037@linux.alibaba.com>
References: <20240705022842.51451-1-wodemia@linux.alibaba.com>
 <CAD-N9QUPWrAaT-7UjibcKR7=L_etmGF4qy0voO8u3W+wk6G0nA@mail.gmail.com>
 <7E195EE5-F38E-4F32-ACA5-A36D79E66037@linux.alibaba.com>
Date: Fri, 05 Jul 2024 06:37:01 -0600
Message-ID: <87frsoauc2.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tao Zou <wodemia@linux.alibaba.com> writes:

> 2024=E5=B9=B47=E6=9C=885=E6=97=A5 16:18=EF=BC=8CDongliang Mu <mudongliang=
abcd@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> On Fri, Jul 5, 2024 at 10:29=E2=80=AFAM Tao Zou <wodemia@linux.alibaba.c=
om> wrote:
>>>=20
>>> Fix one chinese typo error.
>>>=20
>>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>>=20
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>>=20
> Thanks a lot,  I will pick up your review tag.

No need unless there are other changes you need to make; it'll get
picked up when I apply the patch.

Thanks,

jon

