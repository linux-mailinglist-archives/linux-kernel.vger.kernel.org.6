Return-Path: <linux-kernel+bounces-207746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C541901B76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDC31F21F60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81891865B;
	Mon, 10 Jun 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rDnh85qo"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3A1CA8A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002516; cv=none; b=pprrSKcGxRbLV/EamDAaxT4UyFPz4iIfM8DjS1vxPvormZdkZc4vpGsxqSGSZ8ybpxr/Bl6HAftSJ8YxdCT98Q7AHCsF+ZWDsZK+zmMOvCntn7SJ1s6fjwjI3OMbTSDB+nx3HnE9LpoiSbJzxy/FmPyC4IL7kNzKJVT6CvU9NB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002516; c=relaxed/simple;
	bh=icWl2mW4gsTh79Dtr/VKuHNw5qX2jEW3RdcJNZb3MJ0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Mfh3MUO3Yi3YQXNb7RebSz8UhqbUbaSrLtIXevWGCjATllmPQaJQxbrY81SHBDJHyCVlI4W2oWwm9HF4A4+saKqD7OsDzLROpIW8WiUS+CymEJpXoPOHA28EqzvScNH38WOxTYpW+SAeePsj9xd7SLLPbLlcxm/rCFSDVuebpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rDnh85qo; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718002495; x=1718607295; i=markus.elfring@web.de;
	bh=9BY2lnviANQt5LFXardZ1Ja67QMdHaXFtOahZxl5GW0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rDnh85qobaTZx5plf8ucIjiGjCwBja+3QWE/P01kWherzc1ghScWR40sacik7cuo
	 QWkmYPLX7trRudLGzykfNOOkmSDF74AYySu0qusN5wxcRgj8lYHnIrC/JDGxes+vr
	 SiuNkmS+gyyH1jgiUDO//rM0xeAlzwuIKKyTAddfwGfN3Puwp5bkQ2dkCaVe39iJ+
	 Yz8Qqo/2ga+EbYUKy8KpJDnwDEU59ufGlrn4lCRDbN/5vDtSLii5YbmUJd+XfV1qa
	 opV21U43yxswV4quw7p3xcEHfdLebcXoXUe0c8rvHVsGeUK7d+Fk73+9i21byOMEm
	 uF9i0RGJrLiRX9KOZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCz3-1rpv7k26cd-00PHkN; Mon, 10
 Jun 2024 08:54:55 +0200
Message-ID: <2904522f-8981-459c-8f8a-5dfa6de40331@web.de>
Date: Mon, 10 Jun 2024 08:54:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexandr Sapozhnikov <alsp705@gmail.com>, linux-nvme@lists.infradead.org,
 lvc-project@linuxtesting.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240607134340.11-1-alsp705@gmail.com>
Subject: Re: [PATCH] drivers: nvme: target: core: deref after null
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240607134340.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMo2DT30EkJwd/lQVOYtidkkkXOcQVOo4S3SIygw+m8jw8Qz6qf
 FlIwe3QTsMUAzR8NhF3h6PVroXnYEvom0CN6NHcHtDZ6q4lvkplTX8VKM6UnKbWHN//WVyA
 LaTJ4IyaBYFw4TQSOB2suhWbQ+YzAuIq9wa+9pketoVZEQPUTe1EVsjS0kNpzyXAOM3B9eG
 XIyqIVVRl+FHZ72FLFULg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7gBCsE6Z9MA=;0ar/JH+9Rf2g0rpBzMwAVqrPfrU
 OK7Y3Oi/zo2W7Zlm+U5rL4+34TyqaMZtNrLBRkqQ/QplOsiV3zWt2DrKdH7qolwKmta/I6g19
 0S/DazL/MZz43fwwZK6nHFQeV3LKv+3Nn3opGb8CTp0yceg4RKMdQuuZ27uSiPGgmjpivtBw9
 qxFHQ9/5Ab7Ah8pLOnHgRtSaU+IjaeHV1bQxpPIGwEqV3ymg3tpBDbp607G7YV5xwJKeYGxiQ
 K1JOG/loEY+hpr1beWBgG5J+SRALwL4H5gfk5Q+a5ixZcNKTSIWHjraTZH4jfJDuMfFWiKTRS
 ZNkBniFP+GmR45l4+8AVBFP0W6I6+PZM6CTGz+Uo2cFdwJAhO5rMmjYabMA/dT+nft9EpG797
 9MRqj8TDJVJBoiEWFiOQmrjDWexc4CBzdtvnyTuzpFXjVFaM2WGTKxLd1Qr8B+sQ+gUXWLnK8
 dGsc6XHeICYsfMJWEwO3Ts1tzDRMWK+bv8NrJ+FB3KYlQpbnfurQpPyUtanZ7lf7eqh2oF4dx
 P7mdW852WmPQxVwPUXalSh7k3kXD4vLQBCisS4kAEXwdN1kVLhZz2AlZbVr6NEVjqVjg2sH5+
 jNeIcxCfvjCw/S0qo/uqHtd6+0Vbqas8IllgNtFZDbo7M87nCqMygXNfIY/OxfrNGehqeVDiH
 tmg2RRGkPco2wqvpe2mVxgp8KMmr5MC6Cz+ekfq1EL7DdvPDoswEmaJK+ylP9Tx8PT0b+Z04+
 WKxB3JefCSdChNUnrBsXS1As0/G1vJ8IrGtaentloABXrGY018RkYtXUWxEUeW9zJ7BILwsES
 oadLL8j5NQrJYFJ4kENn+ddBJTRahAq0vbLsfn3kl51c0=

> After having been compared to a NULL value at core.c:813,
> pointer '(**sq->ctrl).sqs' is dereferenced at core.c:838.

* Please choose another imperative wording for an improved change descript=
ion.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc2#n94

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

* How do you think about to use the summary phrase =E2=80=9CAvoid null poi=
nter dereference
  in nvmet_sq_destroy()=E2=80=9D?

* Is the subsystem specification =E2=80=9Cnvmet=E2=80=9D more appropriate?


Regards,
Markus

