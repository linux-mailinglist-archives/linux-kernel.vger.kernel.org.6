Return-Path: <linux-kernel+bounces-240409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED552926D50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7611BB21C4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF748101DB;
	Thu,  4 Jul 2024 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UnSnz0DI"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052023BB;
	Thu,  4 Jul 2024 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058573; cv=none; b=uPyQ046+YodTsWXHT8EFhgKwoSrFJoR3oKWnEL0A4NDk2A3T85n2M6ABZ8N85WES4ijUJC9a4TVgoL0xo6kld5HLKFuzYQLdczWZfbEhHUjTlBiszjzUaoykI5+EgRoPp2SKB2wNrAxt0BIhNBqfMf9eq+hQxtfO0M17SXIORlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058573; c=relaxed/simple;
	bh=rUhj6IwaIpWAzijHuWuxS1tK5OPPDv0HwXy/f55Ad+w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DQParDggCD1500zmQJIfDXVr62QeVE526QLE/VuK3zBadGmaVhcSXz6EoV5GGhOGF4L4z+9tfz+Vne6UHqZ6RV0lSHLxggbWxDY1zNlAv77TtWOzDWu+yVccuJmwTfqLykA1GYaFKmPwX+ZAp0Y4l6XXkOtQ50JoqAloTzkd7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UnSnz0DI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720058561; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=xd5w7QSjQQEBl4RxIPNUVRh5ynNT+GCojAVx6qXcO08=;
	b=UnSnz0DI21ghEfrZR53D6P6SsuMtY+doATHWLf2L+DpauoEpx8jOsvdVKD1vBMc4/yfMtPydvG8kK/1y3B9xnbhcmM05DAz5+f7qDIN7a+g6wzSZxnUlewXSU4Czt8hCujXRYu3AywLKs/4SXjLgjs4k/m/O5J65kCkxFwgJ+bs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=wodemia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W9oh2cj_1720058559;
Received: from smtpclient.apple(mailfrom:wodemia@linux.alibaba.com fp:SMTPD_---0W9oh2cj_1720058559)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 10:02:40 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v5] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst
 translation document
From: Tao Zou <wodemia@linux.alibaba.com>
In-Reply-To: <87v81mrs5f.fsf@trenco.lwn.net>
Date: Thu, 4 Jul 2024 10:02:39 +0800
Cc: Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27A4A1D0-AA90-4F36-9F34-FA92E1B4415D@linux.alibaba.com>
References: <20240701064153.62303-1-wodemia@linux.alibaba.com>
 <87v81mrs5f.fsf@trenco.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
X-Mailer: Apple Mail (2.3774.600.62)


2024=E5=B9=B47=E6=9C=884=E6=97=A5 07:07=EF=BC=8CJonathan Corbet =
<corbet@lwn.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Tao Zou <wodemia@linux.alibaba.com> writes:
>=20
>> Add translation zh_CN/admin-guide/numastat.rst and link it to
>> zh_CN/admin-guide/index.rst while clean its todo entry.
>>=20
>> commit 77691ee92d4a ("Documentation: update numastat explanation")
>>=20
>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>> Reviewed-by: Alex Shi <alexs@kernel.org>
>> ---
>> v4->v5: fix one typo error
>> v3->v4: replace "=E5=9C=A8=E6=9C=89=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=
=E7=82=B9" with "=E5=9C=A8=E5=8C=85=E5=90=AB=E6=97=A0=E5=86=85=E5=AD=98=E8=
=8A=82=E7=82=B9"
>> v2->v3: add space in origin commit tag
>> v1->v2: drop the useless label "+.. _cn_numastat:" and unnecessary =
"=3D",
>> add a commit tag of origin document in commit description
>>=20
>> .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>> .../zh_CN/admin-guide/numastat.rst            | 48 =
+++++++++++++++++++
>> 2 files changed, 49 insertions(+), 1 deletion(-)
>> create mode 100644 =
Documentation/translations/zh_CN/admin-guide/numastat.rst
>=20
> So I had applied v4 - it seems I neglected to send an email saying so,
> apologies for that.  So if there is an additional change to make, can
> you send me a separate patch?
>=20
> Thanks,
>=20
> jon

I want to ensure that the separate patch only contain the change from v4 =
to v5=EF=BC=9F

Thanks.

Tao Zou


