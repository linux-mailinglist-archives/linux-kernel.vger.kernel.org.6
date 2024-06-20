Return-Path: <linux-kernel+bounces-222105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9D490FCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF1228520A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E73C6AC;
	Thu, 20 Jun 2024 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ShOFYtqu"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAA3BBC9;
	Thu, 20 Jun 2024 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865656; cv=none; b=TbN6spU7wDeyMdnhj6KwhLomjxeY8RrHIPLxRJa/yJclPEOJIsW15A6iOmgt9Sz44NMl4zjb+ntZU1y0pfydLSfcjL1i6dCr5OHtdVrUeGnKAz1n/JbcYo5hXZoWzSafm+H+YXEoeg+ERgpCHSbLlm0vYSFihpeWcx1NsZMwmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865656; c=relaxed/simple;
	bh=ponad8+u92cnEDqpVgN0fHjVfLm1x5nx7PXpL1/HwTI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Bv/1KfGoIuWR+Lv3Bw7alAAJ6ZcW7/qU7lE9bVLUAr2hrh+gup4lJhaGLd8b14crlgWow8t9Yd3wuRk6TTUlhBa5/Z9++bGbZUs4y17t0J2+9y1lS6cDe5vj4N+Od9h6gIviswr56gda8RnfOobkN9SEvDJy3k7NP8KElQxzyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ShOFYtqu; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718865651; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=ponad8+u92cnEDqpVgN0fHjVfLm1x5nx7PXpL1/HwTI=;
	b=ShOFYtquso15nYXVkHJMk6mNOpNfF8YEWIQZfvGQy1kHOet0pLgiiiu0LL0u8ra4HvNGOQZKmRXw7yQTpYrGb3zhzliif9/DrTTJYfQrNlU22C1PUvQRgELxqM4BYOVDbiE844acev0PEeoLd/qWcomyLCyrT3QgelELVBd0AX4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=wodemia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8qSNJZ_1718865650;
Received: from smtpclient.apple(mailfrom:wodemia@linux.alibaba.com fp:SMTPD_---0W8qSNJZ_1718865650)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 14:40:51 +0800
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
In-Reply-To: <eb13bf49-aaa3-4898-8161-cb0ea74dd2ed@gmail.com>
Date: Thu, 20 Jun 2024 14:40:49 +0800
Cc: Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B31270F8-26BF-4660-9B51-4681FABA97D2@linux.alibaba.com>
References: <tencent_6C54200469B1518482F88605A0980FBFD20A@qq.com>
 <5f6bd005-81b4-4e26-ae43-803448a0dbbf@gmail.com>
 <8BF94CA3-B91D-462E-A5EC-A4CCAFED4B9A@linux.alibaba.com>
 <eb13bf49-aaa3-4898-8161-cb0ea74dd2ed@gmail.com>
To: Alex Shi <seakeel@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

2024=E5=B9=B46=E6=9C=8820=E6=97=A5 14:20=EF=BC=8CAlex Shi =
<seakeel@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 6/20/24 1:10 PM, =E9=82=B9=E6=B6=9B wrote:
>>>=20
>>> s/=E5=9C=A8=E6=9C=89=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9/=E5=AD=
=98=E5=9C=A8=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9/ =EF=BC=9F
>> You pointed out a readability issue.=20
>>=20
>> Maybe =
"=E5=9C=A8=E5=8C=85=E5=90=AB=E6=97=A0=E5=86=85=E5=AD=98=E8=8A=82=E7=82=B9=EF=
=BC=88=E4=B8=80=E4=B8=AA=E8=8A=82=E7=82=B9=E6=9C=89CPUs=E4=BD=86=E6=98=AF=E6=
=B2=A1=E6=9C=89=E5=86=85=E5=AD=98=EF=BC=89=E7=9A=84=E7=B3=BB=E7=BB=9F=E4=B8=
=AD=EF=BC=8Cxxxx" is better=EF=BC=9F
>=20
> Yes, the new version is better.
>=20
> Reviewed-by: Alex Shi <alexs@kernel.org>

I will fix this problem and pick up your review tag in next version.

Thanks a lot
Tao Zou



