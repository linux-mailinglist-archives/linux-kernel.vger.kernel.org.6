Return-Path: <linux-kernel+bounces-556844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF7A5CF62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB7F1887CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4558B2641FE;
	Tue, 11 Mar 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fVfGsjRF"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6812641E1;
	Tue, 11 Mar 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721354; cv=none; b=WqP2J1UuV3Wyo1opUmsS5jbfSnYDcHsGjDTzV9md5dfp5ILEqbRP8Vivtc6IO8xFkM8KOu/wGHkn5WesbyGMLR8cU7zYxuCjqWzQvhMYh6Zhff4bBFcpKlrVRFH6eyggQTp/gwbbVvTxGWQurTQFLaxVB9TxkB885wM7ZM8QqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721354; c=relaxed/simple;
	bh=BnvDP9g+PuYzXk3tUvt9fcaAT5hIIF0n69gkWDdzmfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLkeBfVOVPr27T5A2FRSwTIXZ2/8JZObxsCAB1vtM4/t+GC0JLoNTxwjpe4LO/f4PUSJaVxeAH/rrWv5rZCdaZmOEdUYOsPJe44QjeYZeHgx4+V7vWUsXfAtm7ai/imatxL+cRK7FWMgn+OYE5+En908GQNPjXhQzLPScolqITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fVfGsjRF; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741721350; x=1742326150; i=w_armin@gmx.de;
	bh=VFDNMWCtQw6Gr0Pfy6TE4V2/RUTMPQMFRwaYVpGBKR8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fVfGsjRFZWtnCkP/NwWcdOA1MlvRyW5zx6ZC2aECdfqCbpFJxFS3xBmeTmWkL6Cq
	 7t8OBnVpg2H2f2jefgWPAkJf9etUwCcwKRibJxf6V9xZmzlivRxmPRUc/Plie3Bzl
	 /ThTKX7nd113Dh+CG1i1iiOZ27ppwsv0vrjbfquQ6zSnxjpCgrfgrWCkjBUg0JyT4
	 lqBEasY6a5/vj1IcTTI4Qg1cgzemU7YfSE5U5L+4jQOErzKfinxc0IySOX8bR2b1r
	 o8ttORh0xmVwu7jACFfjM5NQpMgb1UbQ/Tl/l7cctNA5AZHBtb0johY9hkXWKHwfo
	 f59T+pR0kZTQ5WU6qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1tICZk0zuQ-00aq4R; Tue, 11
 Mar 2025 20:29:10 +0100
Message-ID: <12000214-9336-4817-acdc-5b1e009c10bc@gmx.de>
Date: Tue, 11 Mar 2025 20:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] Documentation: ABI: Add sysfs platform and
 debugfs ABI documentation for alienware-wmi
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
 <20250308-hwm-v4-12-afa1342828f5@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250308-hwm-v4-12-afa1342828f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:r8iBPsGj6iugRGosyILiV+Vp69xBAa9Y+eRMFUUVM9K+bSsswWf
 WONzsOkBG11G1twpGEyN6gPqTAmyoa3zGPADXaXKrwAAu1Jo/eV0FgB8888Ta4kx/i667Q+
 y4i12kqw/Wt4E/Ec2pqbLQ5LsYc/bAs/yU88GGBpErw5RcT6rhCWD7Ino9IAV3XkdcGB+ph
 99LQQv4UvPMfRlH+m6zcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MSSoZb074GY=;QLzI7AtrF+IqEVsEV1unoAxEJ9X
 y7Dcb5EXXHCNxqdDxCnuY0/BRx/4VL9mUhinTtOS7GEFpHu6gJg1m0sT+u1pQtnA1tMsnq1kS
 EdoZmuvfnNJ5kbCoHhmZQ4F//MQGXz2LzJboucRDeOk0npIwbvLjecewhluO2OnpI593wXoE4
 vyZNMaghl+L9b0ENAliGU4u/0gMJnhlBytoexbnAJ8FzwW9nJpLoDTasrev5yCtK+M81o/Xi7
 y7Dky5iplY3gx7FGe4++Ss4BTYm0qAgEftoUZ1SGd0EQuOz9pLLmkH1eGkOe215mya+OhzgU4
 rTE7RH+rBuvl0bvd+KlTy4VKqRQ9xRX2Px/5vTgNBZFZI74qzx0KbLxT7z5sXUI806l9q/ZqL
 ktRsK1x9FsGJpsK3Cb6MHLUQ+Q6aeCIhjyIlTIlbm/1xnxBEO0Q6+V0YxK4z9AUW4PLV7YXED
 noVGpQSFV2/wslOwynMocs/UjlUdymf4AQDlKPhaqxjEzb53m0UP7JQGPmLEvYDdPkwGTj1xw
 /vuhFS07VPCdRNS2dh/K9nHle/EGAXILCHXg/jOdkWgV3oiGXnV8vbfmnYdiwsyUOeRb22pPK
 bvaKJX1Fyy6Xa1XqjsIu4b2atHyBtsm+BngNPtaOsrzoyqdYX+2DvnUNgL+ItqSU4kQk2eTLs
 WNOSFmtssXTnKxm1SNNn6BqmeHonNqcrMr6O9euev9KT8Vh+mgGxqt1jFA6EMfa0MUtm7Z0+4
 XR4bnnKVvDIaKARh5QAgsWylRF/tSHN/L067LTj6ZSbJoVlBuxQFhMv41hf+MPkruS7vKo/5d
 n1BrmXZQmNC3c8XzwWU4iCV3liQCJJZ/JsZkSz9+A5SayIDjVbPKvYfpDee+3giAb+PQbSi+U
 pWQpN2waWGcTtsHY2tDckvHTmilYKwdsGMFlUSd1rZFhdUR7OawbSjYeR27L/6wqC5h4VtBF5
 bS4vdvigjsDUUiEnkJxOTVT4Od6ezru/wBM+pXYd8a4r+CgLIlYhxoz+oD68TFCP51ZTFigA0
 zDB48GavQMzXtv4OZ+MIG7MlcOZGmLffm6YWxE2cdouPRhSM/R1zAosNOM4QE6e4jEObPNvjc
 7Fghy/gzfMCCRxUb2Og82ZKGIFm0D8W4P+6sY6L6jGe9GWv+9m9cmY7M6j4tqKJxNFDdlRyu/
 glcxj1CsD0Dqddx4WK6GVebddA+C2I/RjJ+59epqFdphjsryCXLak1VChEzhGwngkdnq8acxl
 tXZA0d614Dqi1EfddaC6NCaee38shHfJ1K706ebiNJlC4bVOEMtHToITEbvctqrUuXdVOGnzI
 NOmbHk56KLdFgFM6ulAD9nXh6dIZ6I0BKwtGgilaTr5n+8MMZaWumjfxXdAKDHJPfaj5AoE1r
 cwS3YZleTyeLN3Gxcx+yTqssjVShTXHvp0oD0vT9OmhUEyB1lXvCCj7TAGkR2Kl2LmesrhJde
 ptX4sCQ2ubuvdC49ZSTV80hS1zVY=

Am 08.03.25 um 21:23 schrieb Kurt Borja:

> Add ABI description for the alienware-wmi driver.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   Documentation/ABI/testing/debugfs-alienware-wmi    | 44 ++++++++++++++++++++++
>   .../ABI/testing/sysfs-platform-alienware-wmi       | 14 +++++++
>   MAINTAINERS                                        |  2 +
>   3 files changed, 60 insertions(+)
>
> diff --git a/Documentation/ABI/testing/debugfs-alienware-wmi b/Documentation/ABI/testing/debugfs-alienware-wmi
> new file mode 100644
> index 0000000000000000000000000000000000000000..48cfd4d0b002efd7b68d9c1d3aa91a3a05f49db5
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-alienware-wmi
> @@ -0,0 +1,44 @@
> +What:		/sys/kernel/debug/alienware-wmi-<wmi_device_name>/system_description
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	Kurt Borja <kuurtb@gmail.com>
> +Description:
> +		This file exposes the raw ``system_description`` number reported
> +		by the WMAX device.
> +
> +		Only present on devices with the AWCC interface.
> +
> +		See Documentation/admin-guide/laptops/alienware-wmi.rst for
> +		details.
> +
> +		RO
> +
> +What:		/sys/kernel/debug/alienware-wmi-<wmi_device_name>/hwmon_data
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	Kurt Borja <kuurtb@gmail.com>
> +Description:
> +		This file exposes HWMON private data.
> +
> +		Includes fan sensor count, temperature sensor count, internal
> +		fan IDs and internal temp IDs.
> +
> +		See Documentation/admin-guide/laptops/alienware-wmi.rst for
> +		details.
> +
> +		RO
> +
> +What:		/sys/kernel/debug/alienware-wmi-<wmi_device_name>/pprof_data
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	Kurt Borja <kuurtb@gmail.com>
> +Description:
> +		This file exposes Platform Profile private data.
> +
> +		Includes internal mapping to platform profiles and thermal
> +		profile IDs.
> +
> +		See Documentation/admin-guide/laptops/alienware-wmi.rst for
> +		details.
> +
> +		RO
> diff --git a/Documentation/ABI/testing/sysfs-platform-alienware-wmi b/Documentation/ABI/testing/sysfs-platform-alienware-wmi
> new file mode 100644
> index 0000000000000000000000000000000000000000..4877b3745f4e5b503376d375bf48464250328ce2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-alienware-wmi
> @@ -0,0 +1,14 @@
> +What:		/sys/class/hwmon/hwmonX/fanY_boost
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	Kurt Borja <kuurtb@gmail.com>
> +Description:
> +		This file exposes fan boost control for Dell gaming laptops with
> +		the AWCC WMI interface.
> +
> +		See Documentation/admin-guide/laptops/alienware-wmi.rst for
> +		details.
> +
> +		Integer value in the range 0 to 255
> +
> +		RW
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c609bc321b8dc3ab0e8d92b04e42483be8cc171c..faa377126bda0b9c848760495dc893982f3a4c3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -796,6 +796,8 @@ M:	Kurt Borja <kuurtb@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
>   L:	Dell.Client.Kernel@dell.com
>   S:	Maintained
> +F:	Documentation/ABI/testing/debugfs-alienware-wmi
> +F:	Documentation/ABI/testing/sysfs-platform-alienware-wmi
>   F:	Documentation/admin-guide/laptops/alienware-wmi.rst
>   F:	Documentation/wmi/devices/alienware-wmi.rst
>   F:	drivers/platform/x86/dell/alienware-wmi*
>

