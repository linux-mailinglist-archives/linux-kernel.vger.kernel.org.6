Return-Path: <linux-kernel+bounces-387824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E83199B569B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846C0B22B64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9C20C006;
	Tue, 29 Oct 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Wq9IYcxG"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067720A5FA;
	Tue, 29 Oct 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243636; cv=none; b=LVmacbjUZNfX7lNEWMdDGtiiIyFvHlmh1j2fmWJfMj2U/65uOMZKT7vGZMz1Gii0oJqu95aPBJOs1fJz0KHs33XD2jrEJvncRhfZLZMLzWQCyQFeyPNuBpp4lg++6JdFFvc3OEMHUiSUV1MjmprBvdAnnM21s0ie1FMe2fGsw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243636; c=relaxed/simple;
	bh=8T+9eeV93Jaxcm1UHEFzjo4Mi/b/S9AURmwuVLlUq/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXprEEQ6KW2ypCbXv7LzUTLc7DBrEmGN/JSuJ+PRreNJbTS0v5hhI6STVy7Xj/ridLH1k+y0k1SZ7SjSqZ4/obMBWqyWfppG+lkY74goT3dqOsc94u34IehRTatfZpK/DZWES0xn2rV/VEjtC4tNPBZXW+BplaSy0ABlhW5YUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Wq9IYcxG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730243626; x=1730848426; i=w_armin@gmx.de;
	bh=EboE/IOcl5FaWspwrb3hM38s6OEY7a7SKXuh7NwXnuc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wq9IYcxGo+TAJRSZgHZrKhjvYspDlwXcuYBf9skOAX8vGlBxF4CbqPLm8gtc7rLH
	 9oHIw37HVhkCVuuGk+5N70wpnz52ffnQXnz1PbnMnamr7qHy4zRKzoGOkzzXNsdDv
	 oYoI306F1pij/9VQC9Eto/4HCDLuB4ccrlPTJAJ/S+RZRyH3TiHzVqyhP8K1PKnH5
	 jFdKTnwJSp/1gOpAA5DO4qYta8MuBqftWAulO3fVMyjeP0NOEJPfxDYhPn98zUaTJ
	 VjMsNmNYETsjdX0xL1mX4LTHTPqFmC8NAS6R0BjVfC639jY7nttPVuUx5C0i1iv3p
	 nA35xmQHKgte7+P2mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1tA4HD0Ka9-003qGU; Wed, 30
 Oct 2024 00:13:46 +0100
Message-ID: <677c9b97-8eef-4001-a276-e9bc68538b81@gmx.de>
Date: Wed, 30 Oct 2024 00:13:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] alienware-wmi: added force module parameters
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241029135107.5582-2-kuurtb@gmail.com>
 <20241029135354.5937-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241029135354.5937-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lG/McRLvV1Bzip+wRaCShemt6YPGUBkV9XWc9nG3fH72wD/fdTU
 gHKbryiO0CKgmeQt6HikA7SvlAbLl1UhkFNA6OuyH8lXrVi78GruVamq9/udY3K++SKlXBt
 WAY3i4oQPeNzajBoXR7XYrlVRLGoJL5hbmyDlT31Zw75+TIQ5GE0YZ7C7pbuS0uMW5Znmv7
 4yqVon3QjN0i7UlWGeMfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gPhcztdRtb4=;z8dT6MEMGoWH0W5cEOlvxPngjEF
 FBhcTncr/z/NiM5LaziBD0uM8iOul2Uf2uSzy0BR0CTbVbv+7j/f/wAV4zVtX7ycqHsCPaKni
 ePwJMV++e8/TAvu8KjjHSrFAvU5dAy7UfkNfMcWvgbDuhoadPUrkkxEn0zBvbBNUIB4LBxGcw
 81oV2WPvIXls0N5E5Y7fYp7QkOn5sxqMAqK6+32OUCEZEfcdZ0LzbFw60Qj0UZdsJXkD345c2
 rQXM6Y3j2KFyN+FHzDvoYiet7ahkxUWLpXgLwqJ67EdI9wA63Sy8SyQMiKdMJEHJDbXJLveBm
 fnxFSxRW1eClQMaU33Kj7J17ikFdOIJ9XhqjsoHLddDCyRzJXL8tkRy8KoviJXio1VyJE0Sye
 aclrEZrLOBIeskDYARyI/U7cxOPEpApSWCtchdl9sHJRIAGjxfV9uFuTvQheWDe+o7oeUmR81
 xm8VkLdeG6Q8S3TDzFvYJcIa/YMfQLCqunmge/DD1hcPt01Z6ZBE/+M6MztsD7xjQWYTqqLON
 /5HMIBunqgrT/FwXqrVkn0HGNaVzPc8ojVjWQcTroRrfesT9gBJnylvZ2dOkutKGLcF7rcMY5
 6jodqk6a9XjFEl4KEiLYygvZxm0ZRXgPQWM8VQBALQ/atV+GYi2d0MqQMuHVKIvU5ytjr9esb
 tnMKHp7bF4koqEKGIgBAA5s2SVhYwoNuer00V6mqEed7Ohb8qmIv5x56+Fajjq/NtTwApspkJ
 y7je4QdkTX8Byq0jimIjYrdEXfEYP5ANq9fhkpMCeHNd+5CAzD3lWJdHRQo7NGgJtx6YinpuN
 pyH8M+VCv4asbXqrjs+R8NjQ==

Am 29.10.24 um 14:53 schrieb Kurt Borja:

> Added force_platform_profile and force_gmode unsafe module parameters,
> allowing users to force `thermal` and `gmode` quirks respectively.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v10:
>   - Introduced
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index 1d62c2ce7..91f0e09d0 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -42,6 +42,14 @@ MODULE_LICENSE("GPL");
>   MODULE_ALIAS("wmi:" LEGACY_CONTROL_GUID);
>   MODULE_ALIAS("wmi:" WMAX_CONTROL_GUID);
>
> +static bool force_platform_profile;
> +module_param_unsafe(force_platform_profile, bool, 0);
> +MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal=
 profiles without checking if WMI thermal backend is available");
> +
> +static bool force_gmode;
> +module_param_unsafe(force_gmode, bool, 0);
> +MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile i=
s selected");
> +
>   enum INTERFACE_FLAGS {
>   	LEGACY,
>   	WMAX,
> @@ -1075,6 +1083,16 @@ static int __init alienware_wmi_init(void)
>   	if (quirks =3D=3D NULL)
>   		quirks =3D &quirk_unknown;
>
> +	if (force_platform_profile)
> +		quirks->thermal =3D true;
> +
> +	if (force_gmode) {
> +		if (quirks->thermal)
> +			quirks->gmode =3D true;
> +		else
> +			pr_warn("alienware-wmi: force_gmode requieres platform profile suppo=
rt");

Please drop the "alienware-wmi:" prefix, it should get added automatically=
.

With that being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +	}
> +
>   	ret =3D platform_driver_register(&platform_driver);
>   	if (ret)
>   		goto fail_platform_driver;

