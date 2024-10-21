Return-Path: <linux-kernel+bounces-374087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E359A62CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A410282870
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0881E5037;
	Mon, 21 Oct 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rv9APw8Y"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E771E1C11
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506377; cv=none; b=kTV/ylUBMiFVcRNxy2KH1Hh3QUTIhVDyAJsVSa/q49tuZm406U9aNeuk/IlYy1gVFytdAYwy8PBsHic2AoC9F4lMfYd/DbopDDpTuvqOpvu57NxY/h8mwK5cUOCvEtVPkQhgul8Wh4F9n9DFPgtM8lllB76h2mrkDOk0n6v282A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506377; c=relaxed/simple;
	bh=cYNzRplU6x1mXgW3f1ZkHHmcMdVXmjoR36UDS02SVxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=O6DVVlUk8NsOBWBItMEhlJb9RJZH1qMlRSy+HhE9ZkiTU+sHAIBXx1IvlEwUFIfv7MGOQ6LMvtyGY5/+3y+OO5IyNM5916NSQ8F2g0LQLIal9ptDS9sHJIIawL1QCVfDgwLbm4Udv7loGEiaY4hmtEmPXPDrgFMbFmt5rQuSJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rv9APw8Y; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729506343; x=1730111143; i=markus.elfring@web.de;
	bh=VeX2L3+Nej3Vx2tuHsig1eaUnAxQKHWxv9FBnucD6yg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rv9APw8YaKdrzvL06jmZPqZSAJpXprbXGkZtG6bCZXoCAy0wS5fW4wuhQNUnXt/O
	 hzPAgnfmWsEbibHYyfNjzFjlXZzFYuJ3dYxrGVtY5sxhxw/hksDXsx7Ea9lrXmnYx
	 dBmHBefZKKpDfd/oNvf04JU8t3oWNXsR3wQJZjDHxxhDMouWcntrolM2Mm0wg3BOv
	 MpijMfqClo2XQ6KtjOQ2cb7sqZI98TWwHbPHaXkWRiYXzKN1Ryf+opjcE7DX6b9fJ
	 yjQBKuYBzw3SRwvQiSyPckf/HuVUTdPU7dnOyywPopHluCBFfOLs8YIcpZtRyQRVQ
	 8Iza8raenYVTOTbDuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CQT-1u1luU3VhN-011Dtk; Mon, 21
 Oct 2024 12:25:43 +0200
Message-ID: <d693331d-1e86-415f-8fdc-6a6b43f110a5@web.de>
Date: Mon, 21 Oct 2024 12:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
To: Zhen Lei <thunder.leizhen@huawei.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Clark <james.clark@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Suzuki Poulouse <suzuki.poulose@arm.com>
References: <20241021072120.739-1-thunder.leizhen@huawei.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241021072120.739-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tgKZesTdN07y1psD5/XYkHpKPdZJPpXSrjTRYXIvLf7ONH8bYlK
 9nS5NqU2nFRZt6nRIjNDqc+DI1aNCNAi66QClYAwG4JCMtziRje8frQvlTfF0q6C2LqRxB9
 LI0UpE5UiOS7AcTz8EdyiUhY50tIqP3ivyN7dpA4B6VLlJVOqhrqPTv1nrx6f2/aZbI7GC3
 q4C+GQkfWxG3Iu6wF0hjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ly1IXGtOTIw=;H4hezi9AlckIQuhjRp9e3OSq3uM
 /LzHHHTpBrAod3/BuZ8tCHnRlgmaBLg4KD3m9YuydxWjwHYnzZAhKZr2a8CmMEYdmPC86Uiaz
 jvM7zjzlSy1wAoXdXNNVTBdFmX+r4lHIeoLdwbOTql6yPXi9EehLS5AE6DIHBdydonUc1S+i8
 wmU1j5PZkEDChc9zhR4TWxeXml++p/ke9pcbn7224eTvif9SoSZQqMMsHdtAx1a0lGGKQH9ME
 Di735iomf+d6mckug8gR3/YVTehNvO1SnYgQLU7r+fvNdYZ8+5ftIBUfXmBNSAa/qXqtih5qZ
 K8u7lXFr7aVQseOZFQDNcoil6KaLvasBMgRHXJXP2tKAdw4MjV1EoiVvMcbEaiMAF2icPk5jk
 WHw4u6FSUTmSvSSSNwAoSZexouUI9VapvwKrfWg2kpfqOhCcUAUkDwVGRJznAbwrb53G+DxaC
 P09pw173E7adC9QEya8b/PdBAGNTtjQ0g5XwOrzIoIvvMY6mZMMsTIdQlTl5GXXLT5nk/xinJ
 t8iZrpur//h0ZRriLUxkXjglFz/QYKnYdSQEeSCM9FoQ3a/O3EWfkF+oO2uazbVePHgn9KVj4
 /7gnlRomoK4f4cXMf4QN8/KW3QM1FwNO4di2dyQ3eAfziwu+5BTxzgvK2XNEQBy4DKM0VxpmQ
 82TjpRbd3lUnOneRio5fJt29QG0qr2IyCRcS3JBYf6CahTqhlXVQ7Oz9kE1fHMYUlTdOhAE7N
 Zy2ObrUFWXudDgH+dCkvo64A3xoZTRKEFrx5HTTnlxJmiEsR975eavcXGpfgBATx4Azd4vNEV
 L29DpYW8Yro3iq7Y33xoFAZA==

=E2=80=A6
> memory instead of coresight_get_platform_data(), but forgot to update th=
e
> return value check code accordingly. Fix the incorrect return value chec=
k
> for devm_kzalloc(), which returns NULL instead of ERR_PTR() when it fail=
s.
=E2=80=A6
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
=E2=80=A6

It would have been nice to add a patch version description.

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc4#n321

* https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+p=
reviously+submitted+patch%22


Regards,
Markus

