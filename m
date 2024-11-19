Return-Path: <linux-kernel+bounces-414476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DB39D28AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081DB282DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FBF1CEACE;
	Tue, 19 Nov 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="i8S0UkAE"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C9192D77;
	Tue, 19 Nov 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028135; cv=none; b=IRTqNuqu4QIdWVu0R8YLwnJ1Lz20bkKVXC+4Mo9OZoP9QLK3PD544OzH99nWcg/MyW278gZ3aelJCdw+UYd3XcPhQ/4VeXvONJUVYcENHUCyI8+QsaVMLK7x4pqgVNIhXGby/4yAbQyvFhjxXaIYKIic6M38FmoePZvKJqbgroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028135; c=relaxed/simple;
	bh=m/J3Kfc5Zct+7UaiUuaWVdUfIptlOQhNmwGTLRIIjUQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DpBwGDUHHD2acEoToG7KD9sCw0S06Gvp+4r5GzKgS9XSPP4QVSu1wX/gNK0IJU6cMdx6bv4Uh7ZicIbKkn2rbXmrAbtYf1jFP/LM3ZKRQRBZOK39G6bzRgfnaOp0mUTYR8+l1LdEfG7c2yEcMVvp4RdZw52GmshTIlV2fDLfazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=i8S0UkAE; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732028112; x=1732632912; i=markus.elfring@web.de;
	bh=m/J3Kfc5Zct+7UaiUuaWVdUfIptlOQhNmwGTLRIIjUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i8S0UkAE+Xx+qNGavhFzQoR6deaFt/Wrtm15qHg9TjV+/4Q5b2oMhKDHdjPuxqZp
	 HoKaSzi3NdlBWcl61GRyvf+L0a4TB6tTXdd5gU8+Z7dB7uHBRMOidK7cOqBClEoTA
	 vTGtIR2MoHdmmSKDhKGYNI/gXAf2YMXcuL9yD4VsxOqDjBueYq0ISnz/i70l8ktSz
	 1oOo0w4nKfX+d8F7UoIb2/SCOaFi5j/dVCOIfMSoUWXwfe1V0PIZEUiOCF8INlz4H
	 YuDMEAqyBdflrvndv2gKVrYctPm1pY6jqhRNoKTZnzfmdqfggB0sIgwraUu8oJog7
	 2udMwFTh531UPlHv8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1szuqe3YaF-00H0xj; Tue, 19
 Nov 2024 15:55:11 +0100
Message-ID: <940b49da-cbca-42d4-9a80-501465bc8cbe@web.de>
Date: Tue, 19 Nov 2024 15:55:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <W_Armin@gmx.de>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20241119043523.25650-1-kuurtb@gmail.com>
Subject: Re: [PATCH 4/5] alienware-wmi: Fix module init error handling
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241119043523.25650-1-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmrZhRVq7GluBi9xual2QqLudkQMDmimO38q6p1C/urNpjzFIPB
 LSpT5+rvkS79SSH1/mY4GEQEYmwn9lop2vSBrZ5oS/HVkcEI9n4303mCO29r37cP/2/+yi1
 IVAh2zYHhrFIU3dxnaWqjYT1OEQu8fwjfnvttAifXOYHu1CRQrYhYys7caOCVLKUIHIXoJg
 YfQUBXgWdpdguprTUByCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gsbrwzm943Y=;wnj7CNiMKSdgk8CcH9wWQp6b9+Z
 /jcBMy+9NvLOlhpQW1Pk8VQTDPaIHEHGFs8ip2ZplOMVx7jR4cUObSFOAcj/sl6O8exiDHOXp
 G+yJ1qT1ZARIlPqIiebiYw0IdTfORDUFSsXxw5eWv+SBPxAKChyb1aKMYuPyVxwkwP8G40mYi
 YgLQ0UNI4Ez/nXiF9/bPNlZGfvhLJv5Ppk/L2x7R6Nl7Cr3dquX4jhaSQBjPKUPZWK6xlRQsY
 xCDnYejOBC0qa8KgAZV37KED9gGGt+L5o509B8urnvmXd/MmwVZlJ4CN1Rn2AEsZAWAuSviXs
 wYLDVFQa4l4QJ4Sx8w0bX0ZKcnJdV4ov+QyCwjyE7qn01QiwBZLf+orEKxygCafeS0ZOTtfHm
 NMNIp968rGJtGHs5RNCsWycObh80Ne8GGUzyf0lcxttII0njsFfTGsKjpVGlwkV7gRgz4ccOu
 aB/JVelzwl6GZNgzA9dIcOFJXtB7ZmX1+xnL90DVRlsvyFz1HetlWngZ9mXZfNd6pFfwqpOw5
 fIjx4kjIKedctW36am532GEqcxi2S+sx1YnL3juwqs1iWtAE4F6dmWOVwofiMf1s8QGvDM1Vw
 ToKo+CmVGxmGosFVQIGal4XvZ4XUEJkD3NfJnyhbllt5tg6YZvQSZsnSOCsddMYJeM3umOKK+
 1eS4GNOtAlXW8k3RoBdIgxg99Mx626/cFeT0EUqhgvU+qbGJaAkD0ZSa6B+vmbdFCqA51G9hY
 4K/xUNY7pRFmZAG1Npi2STgE08Yi13wX9GQeaNXd3Sb0eR+B540RY1lNvVTIukSMlqNCL375J
 x4jNdNyVdQgEEtsZt9g7tdzybr4VXIDuLrk+EffpuVkiMJtvlb0kVDH0Lqy/iZ5glvVwq7Iz8
 MUCsnqDZAxnTM6QIc0d+aUfpCO3ile1tQaMWR62ev/rQEpgkimyV5v5sN

> Propagate led_classdev_register return value in case of error.
> Call led_classdev_unregister in case sysfs_create_group fails.
>
> If alienware_zone_init fails, alienware_zone_exit should not be called
> because the latter unregisters/removes the led class and the sysfs
> group, which may not be registered/created if the former failed
> prematurely.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12#n145

Regards,
Markus

