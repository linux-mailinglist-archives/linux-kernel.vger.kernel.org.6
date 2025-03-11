Return-Path: <linux-kernel+bounces-556840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2038DA5CF54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D987A6D04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5262641E3;
	Tue, 11 Mar 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EtmeSd9t"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E841C6FFD;
	Tue, 11 Mar 2025 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721242; cv=none; b=GnxUKJb0mZtUQYOo/LDA0vc4zPo2fZejw2ZQxgpRgxmIw3J5Q/DHb9sWeNsmi6W5JktOsIv+WYkDIsaHSUqSc/ifSMgnqw6sLPN27k5RRsSQy7lM+Z7uwPQq5hLMpGGMWBWqdOrYfvybo1XvPxfeSibbUn38r61J3e9lbWThJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721242; c=relaxed/simple;
	bh=yYkmijGpfqV58BExzhcFmexdYjMPj1T41n3iBWeK2cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0Y/WOHRbeNAhaGHDJDhCQ7SMHrEQyPFMFiTlFzRkeDU01b6bI1F/SBmbjZMR1q+2SsqOPvLl5k2LkLxG1rNkY79cnElJfVDzL43MkhUF4s740iZ+TtSnyTCBAEIHd97fx4GzTvC7KHNKaO+cByJ/Q2wpJvyxiAOs+Q2+lQe7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EtmeSd9t; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741721231; x=1742326031; i=w_armin@gmx.de;
	bh=YhBEHq6hDRqAGLk0gMrmwuSMleNTHvdnKUmVCWv+jBo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EtmeSd9tiY068Youd9iHb8MIHc2+d/d3Y+vxvgr56yObawJcA6OWhPyXckS8L1BU
	 hguFtq4DBk4TL+KsS+1dU/MZS8iPCA04xTPAEFGP7FuyP5i6KgKnMtIsIApzYfD5I
	 1WU64MeHS+Z8VHs2mBKeFHBRkf7UW5uHcYlEe5IKVdBtQXGOOJ4AVR31XWlPx4NRO
	 OXm1ezEjI4eJhBWQ//M4Tr5VQIqKMzq9p+vKBiCt3a6tlAzJ5NQl00V19qJKBWo63
	 UXQLMycRR8aNeH87FHkqzW11aIHjxzdhCMezJIEIOtaIBP+5TcBHP6rcWMGvdOirx
	 GJnTCdbKbsQtfNqAtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1tAsN21Td5-016L8J; Tue, 11
 Mar 2025 20:27:11 +0100
Message-ID: <aec4a4bc-f9f2-4997-82a2-8f13d0c23852@gmx.de>
Date: Tue, 11 Mar 2025 20:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] Documentation: admin-guide: laptops: Add
 documentation for alienware-wmi
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
 <20250308-hwm-v4-11-afa1342828f5@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250308-hwm-v4-11-afa1342828f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n7PIhN0FFTnaMSoM0BdRHeHI9BSNOjh03ppNgYCbA9A0l589fNb
 XcgaLMynYXBb4Qh3OPv++wR/ELRewTiV1OMYyEq4Mi4RXfArn0RsKWX/OEORe30mEltr05C
 41cpK1+/NAd7lYi72yZ3tS2IfhXtd1P9x5vRHBStFNcx9IzRxDop1oqFlqjcS7YmCf64ptQ
 GP8WhW9s2tzHCH/YtoNMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I1gs3twj4GQ=;vbm0v3jAzQcP3Xbb4mY89qgeJ6L
 jnrYRazb/M8O3HkJ7ydlgZ9L9XmsUI7IlhYZiucmkGz4HhYbHZF4Rmp8czUExrWqecrrnqTwW
 SMeweMe3258jFEPLZ9iYMt8+gd8U8x/4YJ/4+T3/34HxJG5A+1sK3sDVzBVupYIFIasKn/Uhq
 pclesa/IjVAZrwzQ8FDhLQmNtp6HJArgfEaM5C5sJVItJDCLexZam8VbEt216qaLgJGb5LeIr
 0Tue9ytOgxLQ+kL+yB5RgwTXsQL0Mgf8BsClVenjMqcZ/o20t2lcdnk0Rb/YmyRNqD3jesE/2
 w7Ci+X8AUi12/FxLtNfRGxZAoDG6+CqeWe2bwsxxl6V4X9OlJEjWEe3P9Kij9Xqnf0zsH8W4h
 FWkRa8MUv4jY81VTXxzKWHffeFzwb/UStuckQ+khSppiW+ezBZmKbm4NRrmDTDRRYIEHyz5TG
 GXBZMBlDuVkqOczikijOZ+EFqwS30gpiEiZ5JSTVhjctJORRNlVVzF8q8IElXcTkxpXq35Gu5
 0ldIwyZ+yP0ScSN0aDP8LLIPVa9TMI5jVcaclyYhWGARJ9tLqA0jO6cPH4VeECO2RerZhd52R
 0LKAUwRsN3LR65rFiIXqI8XcbeHPJA6rTiWHWm84Xct6DYC2flHreCR0Rii1tPwlXbGEei/e4
 uci2vEP8ZveDWY9c0aIDsGQ/mpRFzqJb8ktWhgcMyPL0QxoUI5EtWdsFsS6x7fiu9RMPpDRTY
 q6fpXqpS/08XRSefiy6ERgdV935QMxNTbDC6LBpf4/gadDMOKiOpFcX5W9u6RLZMK5GIp++Eu
 s4Hm58BflY8xE7yXIzT67cjktLmqxBgC1vi1tKrFkjZT9DoPl+FB291WAJqclSO2AjMTyiUsi
 8eSBMJjSxpWlM7c1wlGF0xl00K2IocimurWU6qArJtBtc0zpRgK0kwXABnvzAmK7lAdvCA2NI
 vQNeQV9cnXSeEgUmUusJs/fV9NChvzgzDIq2lL47PJpc9KSOglA/zbf1vfmrrg7clz74Cq4+R
 M5X9SoLi0m8R9Zo1KReFzRJKqQ9vtpord8aLLosc8VZfbGWdyHkARytKkVGWVwdYOrV/CgJek
 6KMdQkWkisB/LrOBXg2G95r8Le/om5BfHXUWBrtqMBeuDpu8d53RK19WZcqIa7k589jvNQb+s
 FrXo3Do0/4xJVoj1DznlugDswYCGvp70RIRgw8lR+/ohwglTImYG7xgZWBKHcPAXsOby8RPeO
 u0RXmZnz+8K9/bH739l+BuySO+Ypz4xRJ82FIgndgc1WxfPJDzUjmRp8L68R45WLUvP+MutLg
 pBwJQEb6ZMCqGgtjusvT2liRrPVB7JyCirSP6AA45YJ9N4FvpIErhmT0+97pLfmaskC5v1hUk
 +IqsDBLIAQHVVTePb+1UqUzu2ZQ1DW/S5S7ts4Z5xQSK9aTCNyXtqTcFYzTuqcLmh8lWNFI/m
 oyAbfd3N7wIGJMXm6XcWa0CwM98w=

Am 08.03.25 um 21:23 schrieb Kurt Borja:

> Add driver admin-guide documentation for the alienware-wmi driver.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../admin-guide/laptops/alienware-wmi.rst          | 128 +++++++++++++=
++++++++
>   Documentation/admin-guide/laptops/index.rst        |   1 +
>   MAINTAINERS                                        |   1 +
>   3 files changed, 130 insertions(+)
>
> diff --git a/Documentation/admin-guide/laptops/alienware-wmi.rst b/Docum=
entation/admin-guide/laptops/alienware-wmi.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..fa3980de77fa457ea431b20c=
5131d7c59a836419
> --- /dev/null
> +++ b/Documentation/admin-guide/laptops/alienware-wmi.rst
> @@ -0,0 +1,128 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Alienware WMI Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kurt Borja <kuurtb@gmail.com>
> +
> +This is a driver for the "WMAX" WMI device, which is found in most Dell=
 gaming
> +laptops and controls various special features.
> +
> +Before the launch of M-Series laptops (~2018), the "WMAX" device contro=
lled
> +basic RGB lighting, deep sleep mode, HDMI mode and amplifier status.
> +
> +Later, this device was completely repurpused. Now it mostly deals with =
thermal
> +profiles, sensor monitoring and overclocking. This interface is named "=
AWCC" and
> +is known to be used by the AWCC OEM application to control these featur=
es.
> +
> +The alienware-wmi driver controls both interfaces.
> +
> +AWCC Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +WMI device Documentation: Documentation/wmi/devices/alienware-wmi.rst

Documentation -> documentation.

> +
> +Supported devices
> +-----------------
> +
> +- Alienware M-Series laptops
> +- Alienware X-Series laptops
> +- Alienware Aurora Desktops
> +- Dell G-Series laptops
> +
> +If you believe your device supports the AWCC interface and you don't ha=
ve any of
> +the features described in this document, try the following alienware-wm=
i module
> +parameters:
> +
> +- ``force_platform_profile=3D1``: Forces probing for platform profile s=
upport
> +- ``force_hwmon=3D1``: Forces probing for HWMON support
> +
> +If the module loads successfully with these parameters, consider submit=
ting a
> +patch adding your model to the ``awcc_dmi_table`` located in
> +``drivers/platform/x86/dell/alienware-wmi-wmax.c`` or contacting the ma=
intainer
> +for further guidance.
> +
> +Status
> +------
> +
> +The following features are currently supported:
> +
> +- :ref:`Platform Profile <platform-profile>`:
> +
> +  - Thermal profile control
> +
> +  - G-Mode toggling
> +
> +- :ref:`HWMON <hwmon>`:
> +
> +  - Sensor monitoring
> +
> +  - Manual fan control
> +
> +.. _platform-profile:
> +
> +Platform Profile
> +----------------
> +
> +The AWCC interface exposes various firmware defined thermal profiles. W=
e expose
> +these profiles to user-space through the Platform Profile class interfa=
ce.
> +Refer to
> +:ref:`sysfs-class-platform-profile <abi_file_testing_sysfs_class_platfo=
rm_profile>`
> +for more information.
> +
> +The name of the platform-profile class device exported by this driver i=
s
> +"alienware-wmi" and it's path can be found with:
> +
> +::
> +
> + grep -l "alienware-wmi" /sys/class/platform-profile/platform-profile-*=
/name | sed 's|/[^/]*$||'
> +
> +If the device supports G-Mode, it is also toggled when selecting the
> +``performance`` profile.
> +
> +.. note::
> +   You may set the ``force_gmode`` module parameter to always try to to=
ggle this
> +   feature, without checking if your model supports it.
> +
> +.. _hwmon:
> +
> +HWMON
> +-----
> +
> +The AWCC interface also supports sensor monitoring and manual fan contr=
ol. Both
> +of these features are exposed to user-space through the HWMON interface=
.
> +
> +The name of the hwmon class device exported by this driver is "alienwar=
e_wmi"
> +and it's path can be found with:
> +
> +::
> +
> + grep -l "alienware_wmi" /sys/class/hwmon/hwmon*/name | sed 's|/[^/]*$|=
|'
> +
> +Sensor monitoring is done through the standard HWMON interface. Refer t=
o
> +:ref:`sysfs-class-hwmon <abi_file_testing_sysfs_class_hwmon>` for more
> +information.
> +
> +Manual fan control on the other hand, is not exposed directly by the AW=
CC
> +interface. Instead it let's us control a fan `boost` value. This `boost=
` value
> +has the following aproximate behavior over the fan pwm:
> +
> +::
> +
> + pwm =3D pwm_base + (fan_boost / 255) * (pwm_max - pwm_base)
> +
> +Due to the above behavior, we expose the fan `boost` control to user-sp=
ace
> +through the following, custom hwmon sysfs attribute:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Name				Perm	Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +fan[1-4]_boost			RW	Fan boost value.
> +
> +					Integer value between 0 and 255
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +.. note::
> +   In some devices, manual fan control only works reliably, if the ``cu=
stom``

... works reliably if the ...

Other than that:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +   platform profile is selected.
> diff --git a/Documentation/admin-guide/laptops/index.rst b/Documentation=
/admin-guide/laptops/index.rst
> index e71c8984c23e43ca7cd6373b88803354dff6bc60..db842b629303c1bcf0264620=
4d51938f9bd4043e 100644
> --- a/Documentation/admin-guide/laptops/index.rst
> +++ b/Documentation/admin-guide/laptops/index.rst
> @@ -7,6 +7,7 @@ Laptop Drivers
>   .. toctree::
>      :maxdepth: 1
>
> +   alienware-wmi
>      asus-laptop
>      disk-shock-protection
>      laptop-mode
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1afd30d00aecf9a48f8c71e156affd5f329539bd..c609bc321b8dc3ab0e8d92b0=
4e42483be8cc171c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -796,6 +796,7 @@ M:	Kurt Borja <kuurtb@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
>   L:	Dell.Client.Kernel@dell.com
>   S:	Maintained
> +F:	Documentation/admin-guide/laptops/alienware-wmi.rst
>   F:	Documentation/wmi/devices/alienware-wmi.rst
>   F:	drivers/platform/x86/dell/alienware-wmi*
>
>

