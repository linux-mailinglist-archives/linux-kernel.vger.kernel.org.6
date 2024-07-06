Return-Path: <linux-kernel+bounces-243076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A823A929129
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411371F21F48
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B818040;
	Sat,  6 Jul 2024 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oPTTeg1k"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72BEC0;
	Sat,  6 Jul 2024 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720244924; cv=none; b=lD/7D7nTPouOnJAYADs+TiQ4nOLb54RgfD0uYSdxXbSaYjMirRScbVtNDtAPECu+1zdr0H2MLOQPtlVJkw5xuqKT897lWBcu83OKV7EFT9wmn2nHDViDHWj+CHaKts2nc6vtPWBRphrGMeHIreylPSl6dsznPvmqFEmmyXHvxxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720244924; c=relaxed/simple;
	bh=I1k9ZsyGzCHSfLPR0X93qOviMBHDCU6ThhhGWNjEZR4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YCZUC6zRrjw/LYqkEjykVis0Ai8YxjK3wi/wgSaRGjGZh781AXDzTq7iKXyXkTVngh1I+n3URY2irNEtTLiG/2CZHtAquMhB7NO1rQTnZh+v2AKQrjId05KwZ+NRU0gDnR/+Ctmsd5Opa4OYem3DeLAbOeGYZuYX97fIQ7UQxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oPTTeg1k; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720244912; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=IziIWjLNMd2iMDJrrsmtrIogq2CTxxl3TSSYNG2sKOE=;
	b=oPTTeg1k7ZNoGhiqdNximKgTseTcrUWPTHXGo0Ob2tva4ecU1ucHvh5UQzj4r6lYrrLlQo+Nd3GZr2OWjVHFFOREQCMA3jRNCz8JX9mIlHtCoBf0dvZcQXxhphKz/IUNXQWgiUtYj8oSq0mAqkD56glR4N5LoHyiD2wGFCkv6rQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=wodemia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W9wXMmc_1720244911;
Received: from smtpclient.apple(mailfrom:wodemia@linux.alibaba.com fp:SMTPD_---0W9wXMmc_1720244911)
          by smtp.aliyun-inc.com;
          Sat, 06 Jul 2024 13:48:32 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1] zh_CN/admin-guide: one typo fix
From: Tao Zou <wodemia@linux.alibaba.com>
In-Reply-To: <87frsoauc2.fsf@meer.lwn.net>
Date: Sat, 6 Jul 2024 13:48:30 +0800
Cc: Dongliang Mu <mudongliangabcd@gmail.com>,
 Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD0611D8-1892-41FE-B29B-9EEA4E07F9C2@linux.alibaba.com>
References: <20240705022842.51451-1-wodemia@linux.alibaba.com>
 <CAD-N9QUPWrAaT-7UjibcKR7=L_etmGF4qy0voO8u3W+wk6G0nA@mail.gmail.com>
 <7E195EE5-F38E-4F32-ACA5-A36D79E66037@linux.alibaba.com>
 <87frsoauc2.fsf@meer.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
X-Mailer: Apple Mail (2.3774.600.62)


2024=E5=B9=B47=E6=9C=885=E6=97=A5 20:37=EF=BC=8CJonathan Corbet =
<corbet@lwn.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Tao Zou <wodemia@linux.alibaba.com> writes:
>=20
>> 2024=E5=B9=B47=E6=9C=885=E6=97=A5 16:18=EF=BC=8CDongliang Mu =
<mudongliangabcd@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Fri, Jul 5, 2024 at 10:29=E2=80=AFAM Tao Zou =
<wodemia@linux.alibaba.com> wrote:
>>>>=20
>>>> Fix one chinese typo error.
>>>>=20
>>>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>>>=20
>>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>=20
>> Thanks a lot,  I will pick up your review tag.
>=20
> No need unless there are other changes you need to make; it'll get
> picked up when I apply the patch.
>=20
> Thanks,
>=20
> jon

Get it. Thanks for your explanation. =20

Tao Zou.=

