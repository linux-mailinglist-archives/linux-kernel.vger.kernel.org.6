Return-Path: <linux-kernel+bounces-222061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF8990FC59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336942849E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150F383A3;
	Thu, 20 Jun 2024 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wCZqAwfS"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B51B974;
	Thu, 20 Jun 2024 05:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862824; cv=none; b=r3db2Yv2YaaQemRfekJtWuSFcAS70VLuZVYLEZ+liweBsj7++asZU0wsi/XquuyxxA2sVzTFXU06+jKFCksuTvtzudTgDRtn2y/gGblHOLNZhb64dVjdD+SBRd6lcYSLkKFvFm1m+sJsNSncqXCu4Ls8M0LrRAk812HVRqKtTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862824; c=relaxed/simple;
	bh=LX1ae9Ucy6tE7OgwZDQqPWAi7bFXaRS6m4mE5A4vJyA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QRH2L4+8K83IUAOY6Nhyws1jbYyUOiOGVy2q9USJcpbOADgGq7SSf/GF+Bvt8NNcVK0dJlXTzNuE0r2p1Rp9cyyM1fkJA6eYvqpd3zhKQ6xGHPtY1d1KW7og0IC4LUEk98k2CSSARx9nHjkQKBeUiC3hnUYNv2ebp1TqKM4wS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wCZqAwfS; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718862812; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=eE9A/iipdQOkdKHI3+6IjQxFk248H2941ujTipyP1bU=;
	b=wCZqAwfSAyyKvmcuF9FIhe9ksxifrbgkj/4Zb8jxtaP6ON7AgvqLyxXEZMyYL2pUAyx2eMT9bT3OGT2LpXa/jAQQQ7khkHzcXtBiOCa7F80s8smDeTh7cPqvq3t6spYovAR4E8gOSvc4KkHvFjOoSiLOeOOIwn6tDx3M/LZcJmM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=wodemia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8qDdKV_1718862810;
Received: from smtpclient.apple(mailfrom:wodemia@linux.alibaba.com fp:SMTPD_---0W8qDdKV_1718862810)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 13:53:31 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v3] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst
 translation document
From: Tao Zou <wodemia@linux.alibaba.com>
In-Reply-To: <5f6bd005-81b4-4e26-ae43-803448a0dbbf@gmail.com>
Date: Thu, 20 Jun 2024 13:53:29 +0800
Cc: Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FE78415-9A02-4859-9C11-6A46EAAC17E4@linux.alibaba.com>
References: <tencent_6C54200469B1518482F88605A0980FBFD20A@qq.com>
 <5f6bd005-81b4-4e26-ae43-803448a0dbbf@gmail.com>
To: Alex Shi <seakeel@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

Hi, Alex. Thanks for your review.
If you receive the duplicate mail, I am so sorry.
Because the settings of Apple Email is incorrect, I send a email without =
the text-plain format.

2024=E5=B9=B46=E6=9C=8820=E6=97=A5 11:18=EF=BC=8CAlex Shi =
<seakeel@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 6/20/24 11:14 AM, Tao Zou wrote:
>> From: Tao Zou <wodemia@linux.alibaba.com>
>>=20
>> Add translation zh_CN/admin-guide/numastat.rst and link it to
>> zh_CN/admin-guide/index.rst while clean its todo entry.
>>=20
>> commit 77691ee92d4a ("Documentation: update numastat explanation")
>>=20
>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>> .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>> .../zh_CN/admin-guide/numastat.rst            | 48 =
+++++++++++++++++++
>> 2 files changed, 49 insertions(+), 1 deletion(-)
>> create mode 100644 =
Documentation/translations/zh_CN/admin-guide/numastat.rst
>>=20
>> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst =
b/Documentation/translations/zh_CN/admin-guide/index.rst
>> index ac2960da33e6..0db80ab830a0 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
>> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
>> @@ -68,6 +68,7 @@ Todolist:
>>    cpu-load
>>    cputopology
>>    lockup-watchdogs
>> +   numastat
>>    unicode
>>    sysrq
>>    mm/index
>> @@ -109,7 +110,6 @@ Todolist:
>> *   module-signing
>> *   mono
>> *   namespaces/index
>> -*   numastat
>> *   parport
>> *   perf-security
>> *   pm/index
>> diff --git =
a/Documentation/translations/zh_CN/admin-guide/numastat.rst =
b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>> new file mode 100644
>> index 000000000000..817043676c90
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>> @@ -0,0 +1,48 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/admin-guide/numastat.rst
>> +:Translator: Tao Zou <wodemia@linux.alibaba.com>
>> +
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Numa=E7=AD=96=E7=95=A5=E5=91=BD=E4=B8=AD/=E6=9C=AA=E5=91=BD=E4=B8=AD=E7=
=BB=9F=E8=AE=A1
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +/sys/devices/system/node/node*/numastat
>> +
>> +=E6=89=80=E6=9C=89=E6=95=B0=E6=8D=AE=E7=9A=84=E5=8D=95=E4=BD=8D=E9=83=BD=
=E6=98=AF=E9=A1=B5=E9=9D=A2=E3=80=82=E5=B7=A8=E9=A1=B5=E6=9C=89=E7=8B=AC=E7=
=AB=8B=E7=9A=84=E8=AE=A1=E6=95=B0=E5=99=A8=E3=80=82
>> +
>> =
+numa_hit=E3=80=81numa_miss=E5=92=8Cnuma_foreign=E8=AE=A1=E6=95=B0=E5=99=A8=
=E5=8F=8D=E5=BA=94=E4=BA=86=E8=BF=9B=E7=A8=8B=E6=98=AF=E5=90=A6=E8=83=BD=E5=
=A4=9F=E5=9C=A8=E4=BB=96=E4=BB=AC=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=
=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E3=80=82
>> =
+=E5=A6=82=E6=9E=9C=E8=BF=9B=E7=A8=8B=E6=88=90=E5=8A=9F=E5=9C=A8=E5=81=8F=E5=
=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=86=85=E5=AD=
=98=E5=88=99=E5=9C=A8=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=
=E5=A2=9E=E5=8A=A0numa_hit=E8=AE=A1=E6=95=B0=EF=BC=8C=E5=90=A6=E5=88=99=E5=
=9C=A8=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=E5=A2=9E
>> =
+=E5=8A=A0numa_foreign=E8=AE=A1=E6=95=B0=E5=90=8C=E6=97=B6=E5=9C=A8=E5=AE=9E=
=E9=99=85=E5=86=85=E5=AD=98=E5=88=86=E9=85=8D=E7=9A=84=E8=8A=82=E7=82=B9=E4=
=B8=8A=E5=A2=9E=E5=8A=A0numa_miss=E8=AE=A1=E6=95=B0=E3=80=82
>> +
>> =
+=E9=80=9A=E5=B8=B8=EF=BC=8C=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E6=
=98=AF=E8=BF=9B=E7=A8=8B=E8=BF=90=E8=A1=8C=E6=89=80=E5=9C=A8=E7=9A=84CPU=E7=
=9A=84=E6=9C=AC=E5=9C=B0=E8=8A=82=E7=82=B9=EF=BC=8C=E4=BD=86=E6=98=AF=E4=B8=
=80=E4=BA=9B=E9=99=90=E5=88=B6=E5=8F=AF=E4=BB=A5=E6=94=B9=E5=8F=98=E8=BF=99=
=E4=B8=80=E8=A1=8C=E4=B8=BA=EF=BC=8C=E6=AF=94=E5=A6=82=E5=86=85=E5=AD=98=E7=
=AD=96=E7=95=A5=EF=BC=8C
>> =
+=E5=9B=A0=E6=AD=A4=E5=90=8C=E6=A0=B7=E6=9C=89=E4=B8=A4=E4=B8=AA=E5=9F=BA=E4=
=BA=8ECPU=E6=9C=AC=E5=9C=B0=E8=8A=82=E7=82=B9=E7=9A=84=E8=AE=A1=E6=95=B0=E5=
=99=A8=E3=80=82local_node=E5=92=8Cnuma_hit=E7=B1=BB=E4=BC=BC=EF=BC=8C=E5=BD=
=93=E5=9C=A8CPU=E6=89=80=E5=9C=A8=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=E5=88=
=86
>> =
+=E9=85=8D=E5=86=85=E5=AD=98=E6=97=B6=E5=A2=9E=E5=8A=A0local_node=E8=AE=A1=
=E6=95=B0=EF=BC=8Cother_node=E5=92=8Cnuma_miss=E7=B1=BB=E4=BC=BC=EF=BC=8C=E5=
=BD=93=E5=9C=A8CPU=E6=89=80=E5=9C=A8=E8=8A=82=E7=82=B9=E4=B9=8B=E5=A4=96=E7=
=9A=84=E5=85=B6=E4=BB=96=E8=8A=82=E7=82=B9
>> =
+=E4=B8=8A=E6=88=90=E5=8A=9F=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E6=97=B6=E5=
=A2=9E=E5=8A=A0other_node=E8=AE=A1=E6=95=B0=E3=80=82=E9=9C=80=E8=A6=81=E6=B3=
=A8=E6=84=8F=EF=BC=8C=E6=B2=A1=E6=9C=89=E5=92=8Cnuma_foreign=E5=AF=B9=E5=BA=
=94=E7=9A=84=E8=AE=A1=E6=95=B0=E5=99=A8=E3=80=82
>> +
>> +=E6=9B=B4=E5=A4=9A=E7=BB=86=E8=8A=82=E5=86=85=E5=AE=B9:
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +numa_hit        =
=E4=B8=80=E4=B8=AA=E8=BF=9B=E7=A8=8B=E6=83=B3=E8=A6=81=E4=BB=8E=E6=9C=AC=E8=
=8A=82=E7=82=B9=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E5=B9=B6=E4=B8=94=E6=88=
=90=E5=8A=9F=E3=80=82
>> +
>> +numa_miss       =
=E4=B8=80=E4=B8=AA=E8=BF=9B=E7=A8=8B=E6=83=B3=E8=A6=81=E4=BB=8E=E5=85=B6=E4=
=BB=96=E8=8A=82=E7=82=B9=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E4=BD=86=E6=98=
=AF=E6=9C=80=E7=BB=88=E5=9C=A8=E6=9C=AC=E8=8A=82=E7=82=B9=E5=AE=8C=E6=88=90=
=E5=86=85=E5=AD=98=E5=88=86=E9=85=8D=E3=80=82
>> +
>> +numa_foreign    =
=E4=B8=80=E4=B8=AA=E8=BF=9B=E7=A8=8B=E6=83=B3=E8=A6=81=E5=9C=A8=E6=9C=AC=E8=
=8A=82=E7=82=B9=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E4=BD=86=E6=98=AF=E6=9C=
=80=E7=BB=88=E5=9C=A8=E5=85=B6=E4=BB=96=E8=8A=82=E7=82=B9=E5=AE=8C=E6=88=90=
=E5=86=85=E5=AD=98=E5=88=86=E9=85=8D=E3=80=82
>> +
>> +local_node      =
=E4=B8=80=E4=B8=AA=E8=BF=9B=E7=A8=8B=E8=BF=90=E8=A1=8C=E5=9C=A8=E6=9C=AC=E8=
=8A=82=E7=82=B9=E7=9A=84CPU=E4=B8=8A=E5=B9=B6=E4=B8=94=E4=BB=8E=E6=9C=AC=E8=
=8A=82=E7=82=B9=E4=B8=8A=E8=8E=B7=E5=BE=97=E4=BA=86=E5=86=85=E5=AD=98=E3=80=
=82
>> +
>> +other_node      =
=E4=B8=80=E4=B8=AA=E8=BF=9B=E7=A8=8B=E8=BF=90=E8=A1=8C=E5=9C=A8=E5=85=B6=E4=
=BB=96=E8=8A=82=E7=82=B9=E7=9A=84CPU=E4=B8=8A=E4=BD=86=E6=98=AF=E5=9C=A8=E6=
=9C=AC=E8=8A=82=E7=82=B9=E4=B8=8A=E8=8E=B7=E5=BE=97=E4=BA=86=E5=86=85=E5=AD=
=98=E3=80=82
>> +
>> +interleave_hit  =
=E5=86=85=E5=AD=98=E4=BA=A4=E5=8F=89=E5=88=86=E9=85=8D=E7=AD=96=E7=95=A5=E4=
=B8=8B=E6=83=B3=E8=A6=81=E4=BB=8E=E6=9C=AC=E8=8A=82=E7=82=B9=E5=88=86=E9=85=
=8D=E5=86=85=E5=AD=98=E5=B9=B6=E4=B8=94=E6=88=90=E5=8A=9F=E3=80=82
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> =
+=E4=BD=A0=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8numactl=E8=BD=AF=E4=BB=B6=E5=
=8C=85=EF=BC=88http://oss.sgi.com/projects/libnuma/=EF=BC=89=E4=B8=AD=E7=9A=
=84numastat=E5=B7=A5=E5=85=B7
>> =
+=E6=9D=A5=E8=BE=85=E5=8A=A9=E9=98=85=E8=AF=BB=E3=80=82=E9=9C=80=E8=A6=81=E6=
=B3=A8=E6=84=8F=EF=BC=8Cnumastat=E5=B7=A5=E5=85=B7=E7=9B=AE=E5=89=8D=E5=8F=
=AA=E5=9C=A8=E6=9C=89=E5=B0=91=E9=87=8FCPU=E7=9A=84=E6=9C=BA=E5=99=A8=E4=B8=
=8A=E8=BF=90=E8=A1=8C=E8=89=AF=E5=A5=BD=E3=80=82
>> +
>> =
+=E9=9C=80=E8=A6=81=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=9C=A8=E6=9C=89=E6=97=A0=E5=
=86=85=E5=AD=98=E8=8A=82=E7=82=B9=EF=BC=88=E4=B8=80=E4=B8=AA=E8=8A=82=E7=82=
=B9=E6=9C=89CPUs=E4=BD=86=E6=98=AF=E6=B2=A1=E6=9C=89=E5=86=85=E5=AD=98=EF=BC=
=89=E7=9A=84=E7=B3=BB=E7=BB=9F=E4=B8=ADnuma_hit=EF=BC=8Cnuma_miss=E5=92=8C=

>=20
> s/=E5=9C=A8=E6=9C=89=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9/=E5=AD=
=98=E5=9C=A8=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9/ =EF=BC=9F
>=20
> Thanks
> Alex
You pointed out a readability issue. Maybe =
"=E5=9C=A8=E5=8C=85=E5=90=AB=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9=EF=
=BC=88=E4=B8=80=E4=B8=AA=E8=8A=82=E7=82=B9=E6=9C=89CPUs=E4=BD=86=E6=98=AF=E6=
=B2=A1=E6=9C=89=E5=86=85=E5=AD=98=EF=BC=89=E7=9A=84=E7=B3=BB=E7=BB=9F=E4=B8=
=AD" is better=EF=BC=9F

Thanks.
Tao Zou
>> =
+numa_foreign=E7=BB=9F=E8=AE=A1=E6=95=B0=E6=8D=AE=E4=BC=9A=E8=A2=AB=E4=B8=A5=
=E9=87=8D=E6=9B=B2=E8=A7=A3=E3=80=82=E5=9C=A8=E5=BD=93=E5=89=8D=E7=9A=84=E5=
=86=85=E6=A0=B8=E5=AE=9E=E7=8E=B0=E4=B8=AD=EF=BC=8C=E5=A6=82=E6=9E=9C=E4=B8=
=80=E4=B8=AA=E8=BF=9B=E7=A8=8B=E5=81=8F=E5=A5=BD=E4=B8=80=E4=B8=AA=E6=97=A0=
=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9=EF=BC=88=E5=8D=B3
>> =
+=E8=BF=9B=E7=A8=8B=E6=AD=A3=E5=9C=A8=E8=AF=A5=E8=8A=82=E7=82=B9=E7=9A=84=E4=
=B8=80=E4=B8=AA=E6=9C=AC=E5=9C=B0CPU=E4=B8=8A=E8=BF=90=E8=A1=8C=EF=BC=89=EF=
=BC=8C=E5=AE=9E=E9=99=85=E4=B8=8A=E4=BC=9A=E4=BB=8E=E8=B7=9D=E7=A6=BB=E6=9C=
=80=E8=BF=91=E7=9A=84=E6=9C=89=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9=E4=B8=AD=
=E6=8C=91=E9=80=89=E4=B8=80=E4=B8=AA=E4=BD=9C=E4=B8=BA=E5=81=8F=E5=A5=BD=E8=
=8A=82=E7=82=B9=E3=80=82
>> =
+=E7=BB=93=E6=9E=9C=E4=BC=9A=E5=AF=BC=E8=87=B4=E7=9B=B8=E5=BA=94=E7=9A=84=E5=
=86=85=E5=AD=98=E5=88=86=E9=85=8D=E4=B8=8D=E4=BC=9A=E5=A2=9E=E5=8A=A0=E6=97=
=A0=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9=E4=B8=8A=E7=9A=84numa_foreign=E8=AE=
=A1=E6=95=B0=E5=99=A8=EF=BC=8C=E5=B9=B6=E4=B8=94=E4=BC=9A=E6=89=AD=E6=9B=B2=
=E6=9C=80=E8=BF=91=E8=8A=82=E7=82=B9=E4=B8=8A=E7=9A=84
>> +numa_hit=E3=80=81numa_miss=E5=92=8Cnuma_foreign=E7=BB=9F=E8=AE=A1=E6=95=
=B0=E6=8D=AE=E3=80=82



