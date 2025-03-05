Return-Path: <linux-kernel+bounces-545891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91447A4F330
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0894188CCCD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD097DA93;
	Wed,  5 Mar 2025 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KufZQRz3"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D501E50B;
	Wed,  5 Mar 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136528; cv=none; b=CnrzmTVx6VtBpB3YFw/pM/HJov3ZohmdgE9aGewlGG9tPKFKPt9X3WVHMYcie0ff+U0M1zX83X6OpN+J/xlI4cmsCRrY0+NjxSYHWz/Mcf4/VsclB8J60ylEIxrkuoFs9LHV6CDCKtSCkYlHZoJqEhpvF02Z4DEFs04KvL1GKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136528; c=relaxed/simple;
	bh=2CRRSZWXwUgzHy/torwlHaCerSZ2r5MbQP5Se3y/fkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNeOUubXVeQhqM4kyDyvGgtSKbJqAuwppSX6xBgqYOeuGxZGd825PgIH43ktucdb02W3mTbPGO8D0ahcnqtsr1BJnWflDsHQqHuU++L45rU7RVjDrbsQK8uSPxwT9zyktJ5K1ceMGrFpwdXpELyvpn37oFAqDLn5ininm8LnYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KufZQRz3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741136514; x=1741741314; i=w_armin@gmx.de;
	bh=h7oi+4F1yMUNrbooOmWNrKKMsdORjM32Rl/x46TsNmQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KufZQRz3Kld8/c7gUxPvWhNbs+dJuKq/h29vZODBsmhYqEmDhH3G9Ft283ul4EiA
	 8PmggDbwN8ovLQch0SDzbSTiEF3144+tN4pMLT79QCnocuhiE7igbAqWDP2JJiXhc
	 5Jjpmz7VDYD6B+XbuowFsjiPXVJbMzdI+X46oR3wHzX3TULGqL4t9mAdt6Msp39H4
	 KobwIiUK9b/n0lDZgPzn70huB1Q1KhXKaQRsWq6akWPAAnsZLVON7fsMgbLTMB8uz
	 gNqYYo2uso5pnl85luNBjGulqg9qLrWC96FY6F2lU7EtLsPdY/9t546fZQPwGtnlg
	 bV+AWDSkSUpZ+YPy8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1tcFA838YD-00KiiB; Wed, 05
 Mar 2025 02:01:53 +0100
Message-ID: <8b20fef7-d57c-4bd8-9d0e-1dda9a7391f7@gmx.de>
Date: Wed, 5 Mar 2025 02:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 FN-keys
To: Werner Sembach <wse@tuxedocomputers.com>, mario.limonciello@amd.com,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <20250303190442.551961-2-wse@tuxedocomputers.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250303190442.551961-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8bJFjjRThxkyknYX1pp8nxqpk/QntQAp25nHZrf70I1kA+mWt1H
 TYEkgmLdWO0hHWF4bVOA4I21v+/rT4NyRXrPrafrK2HGBTsolT+12GMRsEg6lWwIWVPsSqP
 9Mj+IzripDB+jvT/DvoUfJW9nr+92SJ+WrV56jy3hpkggGc0u5ep7fOk9JomEqL+OstLswa
 cSTzCqLF8MBISJiDbVupA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7E9MOcDRGwk=;mHxltk79v5Gk0Hujay2R/VVPUzQ
 BczZRCk2DT0K/8iZAy6MH8uQl4RGn2L4wPaPcWF0pKv1cHQh8pnhpLgAEzTugQbCG0r2mBuJJ
 VtqIXP2djbZU/rJxBze5RgjfKK9GpYlvZmQX26m9xdhfj8oMxL+es3KoeWGReQQUPOCvBmCl2
 5DKnC0H73Fz2W+4ZXk3YALUpVJYbPqbF0SGIGnBuNOxMXJ49Bk4U0xRhEzUINDJhFQ7vjYK+L
 VgF8zejhkPZ933KP+pxIpFYI8hnDBXGonBZGdKiGcu8gGoIrZD9Y+MXXlQO0XwCDcGneJb8Vu
 h3qs3EatfWFdeYWaCY8zTGQ5R0+5bhoM6kOLVFnxDfoQ7cB365bcR8ojn/XZGOdaEtf8MBkTF
 Hl/MHes3m4Ltz9NpEJ3Xt1YQ55+QNHsEI+uHyGFNxTUVWslYtUB0mVdn7dddv+O4ISp+jaSxk
 WnjOX3A/xYbPCKNlH+4qf0l4a4rjWbKBbChAOikGuw16AaCGc2UVG+YrTDfbJiYWwlR3bIYW6
 qObgb1vG0ujFctzYh0TR6kVQmbjPQmW602O6+b609OCdo7CM5Vj20qC8slWAm5ol3k+lnhuoq
 Vpodccxr54nieBRUlWrNHDm5FJhHmpTMmbLo2cbntNBPQZljyOU5/H105kLVg7X9Bp5lhR/kJ
 kGvpHPDRl0D97y2D1wEyD96W1dUE6svaXngXmpjKF+L6Ek/jyb3qQOhojIe68Hkhn2sN5uGkr
 d5lMuz4Va/skLo+CnSf7AUjOMQ1H3SZvDZAH6gZokVXPEPGqe2X+MNXG/3tkTRclj2U4w5twb
 w5DPtCvt0ChlJ9e81qXBogrYybvCWaloNnjAOnDPB/pmDkdWJu4Ibe3GXGLyoh2trQM/j+xz9
 wXIAu/mkdwdQSzHeow0PLDAKoqaWCE8yYUu2P9vv4yDAoy14Hofu+uNwL/rsEhD48HnzFx3Fw
 kekssF3AAiaaHJRx5/3CwOVwlWD/1xg9kwuGqyYfay5/EEo5dYv6K8/JW9jjlVduwiQeqerEy
 qZSYdGrWTMCxGDMWY+kL5MEKRwaBwwywt0dGLuUZyQ2k9nwSytoM6ykYZPUqvLWRFWhRfezo5
 Pdqc2UaaGdHpcwmQX+uYIXoWXX7RE8BfkWE4BqFLSv+jfSEpQkoFFWrec9/pRafcqhtktJIGy
 GRX/93lkxETuf0arftcPXKjulE/FLaAztevar9Ft0sdnkt4EmmP7PQRsjxmIj0/BU3G8u9QDq
 FIc6mli3TcZho5gSgxJd1g4JmehyZwQ2spET2TJsYr/Q53sQzP51pPQAL0mcXoHirVmoXO6l5
 NJyv/WbKJWNcoM63iL/16HkbyQJBOIVRy8docpQsQPRNmhP9Wgku4uhEbg3p+X7Uin/qv1FmF
 lSx0i4GkniACcxKwJo5aH7lcjXbK7Thj2s67jY6JwsmIPW3n3gvydAzGjG

Am 03.03.25 um 20:04 schrieb Werner Sembach:

> This small driver does 2 things:
>
> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku=
 to
> F21 to conform with established userspace defaults. Note that the
> Hangaku/Zenkaku scancode used here is usually unused, with real
> Hangaku/Zenkaku keys using the tilde scancode.
>
> It suppresses the reserved scancode produced by pressing the FN-key on i=
ts
> own, which fixes a warning spamming the dmesg log otherwise.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   MAINTAINERS                                 |  6 ++
>   drivers/platform/x86/Kconfig                |  2 +
>   drivers/platform/x86/Makefile               |  3 +
>   drivers/platform/x86/tuxedo/Kbuild          |  6 ++
>   drivers/platform/x86/tuxedo/Kconfig         |  6 ++
>   drivers/platform/x86/tuxedo/nb02/Kbuild     |  7 ++
>   drivers/platform/x86/tuxedo/nb02/Kconfig    | 15 ++++
>   drivers/platform/x86/tuxedo/nb02/platform.c | 94 +++++++++++++++++++++
>   8 files changed, 139 insertions(+)
>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff26fa94895d..d3fbbcef813b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24178,6 +24178,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kerne=
l/git/lenb/linux.git turbostat
>   F:	tools/power/x86/turbostat/
>   F:	tools/testing/selftests/turbostat/
>
> +TUXEDO DRIVERS
> +M:	Werner Sembach <wse@tuxedocomputers.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	drivers/platform/x86/tuxedo/
> +
>   TW5864 VIDEO4LINUX DRIVER
>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>   M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..9b78a1255c08e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1199,3 +1199,5 @@ config P2SB
>   	  The main purpose of this library is to unhide P2SB device in case
>   	  firmware kept it hidden on some platforms in order to access device=
s
>   	  behind it.
> +
> +source "drivers/platform/x86/tuxedo/Kconfig"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index e1b1429470674..1562dcd7ad9a5 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+=3D winmate-fm07-k=
eys.o
>
>   # SEL
>   obj-$(CONFIG_SEL3350_PLATFORM)		+=3D sel3350-platform.o
> +
> +# TUXEDO
> +obj-y					+=3D tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/t=
uxedo/Kbuild
> new file mode 100644
> index 0000000000000..e9c4243d438ba
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y	+=3D nb02/
> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/=
tuxedo/Kconfig
> new file mode 100644
> index 0000000000000..e463f92135780
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/=
x86/tuxedo/nb02/Kbuild
> new file mode 100644
> index 0000000000000..8624a012cd683
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nb02_platform-y			:=3D platform.o
> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+=3D tuxedo_nb02_platform.o
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform=
/x86/tuxedo/nb02/Kconfig
> new file mode 100644
> index 0000000000000..bed56276b9b36
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +menuconfig TUXEDO_NB02_PLATFORM
> +	tristate "TUXEDO NB02 Platform Driver"
> +	help
> +	  This driver implements miscellaneous things found on TUXEDO Notebook=
s
> +	  with board vendor NB02. For the time being this is only remapping th=
e
> +	  touchpad toggle key to something supported by most Linux distros
> +	  out-of-the-box and suppressing an unsupported scancode from the
> +	  FN-key.
> +
> +	  When compiled as a module it will be called tuxedo_nb02_platform.
> diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platf=
orm/x86/tuxedo/nb02/platform.c
> new file mode 100644
> index 0000000000000..68d83b9b4c2f5
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/platform.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/i8042.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serio.h>
> +
> +static u8 tux_nb02_touchp_toggle_seq[] =3D {

Hi,

please make this const.

> +	0xe0, 0x5b, // Super down
> +	0x1d,       // Control down
> +	0x76,       // Zenkaku/Hankaku down
> +	0xf6,       // Zenkaku/Hankaku up
> +	0x9d,       // Control up
> +	0xe0, 0xdb  // Super up
> +};
> +
> +static bool tux_nb02_i8042_filter(unsigned char data,
> +				  unsigned char str,
> +				  struct serio *port,
> +				  __always_unused void *context)
> +{
> +	static u8 seq_pos;
> +
> +	if (unlikely(str & I8042_STR_AUXDATA))
> +		return false;
> +
> +	/* Replace touchpad toggle key sequence with a singular press of the
> +	 * F21-key.
> +	 */
> +	if (unlikely(data =3D=3D tux_nb02_touchp_toggle_seq[seq_pos])) {
> +		++seq_pos;
> +		if (seq_pos =3D=3D ARRAY_SIZE(tux_nb02_touchp_toggle_seq)) {
> +			seq_pos =3D 0;
> +			serio_interrupt(port, 0x6c, 0); // F21 down
> +			serio_interrupt(port, 0xec, 0); // F21 up
> +		}
> +		return true;
> +	}
> +
> +	/* Ignore bogus scancode produced by the FN-key. Reuse seq_pos as firs=
t
> +	 * byte of that is just the "extended"-byte.
> +	 */
> +	if (unlikely(seq_pos =3D=3D 1 && (data =3D=3D 0x78 || data =3D=3D 0xf8=
))) {
> +		seq_pos =3D 0;
> +		return true;
> +	}
> +
> +	/* Replay skipped sequence bytes if it did not finish and it was not a
> +	 * FN-key press.
> +	 */
> +	if (unlikely(seq_pos)) {
> +		for (u8 i; i < seq_pos; ++i)
> +			serio_interrupt(port, tux_nb02_touchp_toggle_seq[i], 0);
> +		seq_pos =3D 0;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct dmi_system_id tux_nb02_dmi_string_match[] __initcon=
st =3D {
> +	{
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "NB02"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static int __init tux_nb02_plat_init(void)
> +{
> +	if (!dmi_check_system(tux_nb02_dmi_string_match))
> +		return -ENODEV;
> +
> +	return i8042_install_filter(tux_nb02_i8042_filter, NULL);
> +}
> +
> +static void __exit tux_nb02_plat_exit(void)
> +{
> +	i8042_remove_filter(tux_nb02_i8042_filter);
> +}
> +
> +module_init(tux_nb02_plat_init);
> +module_exit(tux_nb02_plat_exit);
> +
> +MODULE_ALIAS("dmi:*:svnTUXEDO:*:rvnNB02:*");

Please use MODULE_DEVICE_TABLE(dmi, tux_nb02_dmi_string_match) instead.

Otherwise the driver seems to be OK to me.

Thanks,
Armin Wolf

> +
> +MODULE_DESCRIPTION("TUXEDO NB02 Platform");
> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
> +MODULE_LICENSE("GPL");

