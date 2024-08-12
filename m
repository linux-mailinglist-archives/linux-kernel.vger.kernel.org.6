Return-Path: <linux-kernel+bounces-282926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9B94EAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE2828125E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9116EBE0;
	Mon, 12 Aug 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="WGQC4v9C"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BA33C7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458107; cv=none; b=uUt+8rR1kT2x1gTk5snCTydKw3jlB+AlsB/aAGOjNgZdt8I/VWMrym2rodZ0nl0/HgF/HajZgEWqibNltqPk8rI4RXPqYakXmC7JprIgA9+gGVL7PCnQSFGO3vnHMc4MTrpiApqrnkS7ar45KfvKLRGjxvZfRClQCgUUbud/+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458107; c=relaxed/simple;
	bh=1urb7h4FdGSXSqsQXFG2kiMZ8nreKlLBoVe7Io1ozMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=faRu1GADQfxtRE/HjxHAHP+bEuGqZJEBdGoQGeNcBH487EEknqT+3rtk2B3+0AsqXeklf96UpAspswVaSyv7Tu8p5FI4Jl+vOHWIUXtiWls+DNAXcutDV+337gTHcfiKo/W1FWlHvaQjY7fD2P4DkCKAWohTvp0SqPOphGspww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=WGQC4v9C; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723458098; x=1724062898; i=aros@gmx.com;
	bh=1urb7h4FdGSXSqsQXFG2kiMZ8nreKlLBoVe7Io1ozMQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WGQC4v9CAkjBdiFJUUHH6AtdUvFjzdVw5Q2kP90TW/GGmBBGKne+x/eTIdXhF2cP
	 kZvq+U9v3h16DwRb3rUCRSo3q1DuBRduSEEyW7zaqzMkD1lIEy4fD+3IX/56vVM8b
	 bB4TFGOmKdVp1uPQo+WWK9uvXDQj+9OC30rLXnfBj7six+M01MVRFiG0WxreLNxkm
	 lccsC/6iOvQzEzghU9IVJNDUL8aadVZlMBpENP6UyyyJWwhl5FURngBf/2+3Oo8PJ
	 Pmd8T+MCFVuVprWtpgKQViH+P5qjd2letdOiUo47j7WnJ6wEKFTA2sWsCXCYDsHK9
	 Hvn1K9eQPXlji17Fng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.2.110.18] ([98.159.234.3]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulmF-1sLvIP0h4V-00sl6Z; Mon, 12
 Aug 2024 12:21:38 +0200
Message-ID: <c94c72c4-ae86-4560-9ae3-bc6912fbc20b@gmx.com>
Date: Mon, 12 Aug 2024 10:21:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Kernel modules compression handling
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NegYe9L3IkTR12DtYQy9fip0K4pz6NhA+Kj5J9vVsKmnuFJ9vp3
 y3eEfx78u6+tQy5Ba00McaavOOvXMo5NTKFntrThdnhGgbxuqvJPpyN1yKGKJ6O1DwVxeef
 CqYz1oH7KAzaCAJdkQ0aoDLJX9RKb+yJvb4OGCFDaL/kNfHBTMlDfAecPWEZ43wKm9Iyl2b
 KSQbag0RO4rlRisw+erkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+vHVPKJw8jU=;CGaMgqo9aMSzEsbt3o7ijdqDNay
 /8pX+3qSNTWCblZ89wO5+7V43y4iTEXzDlwa7eFrhrqMEAFcEzOXfTZMu2m155LTI6h3as6y+
 txhY7WA3YxO5q/eBEnkaANUoVpetYuWQvoyPV+D5rvNFUftXJbIpy/SoEZCLlpA8SXKypi6PP
 bBM8WfzfpuiKliatQDK42Uqgy3mO2YQGl4WxWWrQ6gQxek+hS0jbnFS+RIuq57r4L+4ekCdTW
 IxarGIPr47N9LoDv51eH5eGD8rLgY6JAZwWuYP24Udxd/Lqih/oeGbkHJ5s5pJ9wEgtJA+bRj
 TtuW8KdUBXGJgIHkeYGzlYt7xBkKOZGdRzH/2MTmBIIVk8cu0725kmw4urN2tFFxtaHT0+/V0
 vp5dumeklGt5eYDxhqhvB/SdYmMtHlLif7Jc99jUDcH2Okjyhx81omOfEUkiuYOy6OiQIWXzw
 YN9/3hnN6B6TkqrGkAwJfugYLAEC88/cBlrUZ3i+4DQVLbowN7GL5P15Ukwcolaqsd3E09FeZ
 WYmyHWKOTJmFsNUaXTMBKr82PSI20GyrpxYh7MgS3OGoGPyl91GgOgMuefmxEBHl8HlHutbai
 E9IEB6qE0cJ27t2WW/PbrdEw+13kiVzdfdCGXALbXbDsgcpbUMN0WONbhYySS8mzBFfqLIlHp
 3AHi2X7NiW9R6E0w58ICa09hz8kpg52h79HT4rviGWRMmjfyOLQQTu7YDK7nI/kSHvNNMlqaN
 3g+KeQOHpqWu7lW3RBh4w/HjFyYlTlfAlx/vWqq+PHm08iKR5LWk1te907m48ap7Mw6FMRhaL
 5LU6bD9DLiWi0ljM5TwZbvtA==

Hello,

Please correct me if I'm wrong but it looks like the way modules
installation is currently handled in the Linux kernel, first .ko files
are copied to the destination directory and then the chosen compressor
is executed on top of them.

I wonder if this could be changed such a way, so that the installation
script (Makefile?) applied compression on the fly without again copying
.ko files.

All the three compressors supported by the Linux kernel support piping,
so it shouldn't be an issue. I'd love to write a patch myself but I'm
probably too stupid for that.


Best regards,
Artem

