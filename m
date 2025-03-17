Return-Path: <linux-kernel+bounces-563202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7CA638E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B0016B146
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2FEEBD;
	Mon, 17 Mar 2025 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kHfMTX99"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2F28E8;
	Mon, 17 Mar 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742171574; cv=none; b=ugW+ES0KmivyQ/y3UPLRT1hhw54lhsV2CwwskEQ04MIDQJpVCB06mFVq1qMazrPU9iHStYqAIlbZfOyHH8ywolVEmx4I66NzqxuX3H468r7U/AVIknURGv6bSz7gCuQGHP1tbAttLmKjBT33lcphSd4gm1SBG8/kIhsRv5GEqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742171574; c=relaxed/simple;
	bh=QQDMyVh4kQpQFqsjt8N5eOvDUFTlUT+SPE80T3yTzmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAAmsUCKzenO4Mxp26S3f4cVvHPklQqmVJFgr19WXHfN3ZBuebCt/IX7hiGzI6q6Dhzn8V+aPhgW9fnwZDLVNp7dd1VD1LeRSZ5LE68CfICYuHXeHdn+wXF16g28S3FO+PSMVuRQclPUkJ8U7E95wLpu+4zP2rnlojmNzI0e26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kHfMTX99; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742171556; x=1742776356; i=w_armin@gmx.de;
	bh=kZV/eTa1oGW7T91zcA0XwhxZyzT/0rIgzmxiw5LjRqI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kHfMTX991Dj87Rdj6+K0YUo0fw37rHxt3w3xpgHWm1G0rWduaAh6gRWk8Rb7a6WV
	 NXKJHtiDIDZWdvJSaY2OjhBT0aRrmbik/lQ9k4cxmiaHVBpkbohNk0Agn3wCfbPzC
	 R1M+lSAexIX39U8VkRYEhBWRvMI3/lftmwnYhUDZhd7MBTwmqQ6Zfym3IMWmxVAQ2
	 WyrJUOuliLQY4GmdWTsSzQmHQuuLRgjrkTTLdTR0QHrTPkEOEfngUcB3gnH5D/cY+
	 pxduFpPFHyLccx+Ly5bJOf/56KYBzJ6qbCGymf4w7QJG+kgAYnlLmIbRJrSOLYYDQ
	 WW4ked8BepdydzugFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1twyXZ1mIX-00B28U; Mon, 17
 Mar 2025 01:32:36 +0100
Message-ID: <4d3e34c8-d7b4-4bec-9276-17a1fa473f19@gmx.de>
Date: Mon, 17 Mar 2025 01:32:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] platform/x86: alienware-wmi-wmax: HWMON support
 + DebugFS + Improvements
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:N7nB1OMRH91WYFmZneoQI+GvdVntlL+X2Lo1yB01YOO099e+2Bj
 sU4+u4CN/bSo1jfarlJ0n+dDy/8IopT/KTvHPxoI637LX9tla8lL6Zq9to/BlogVbXZrbOu
 xAZHTyyHR/eLqPG8sndHWDqcoRx6/s8u2J8K3CyNKAm0RPT9OC1wVTNA5/BssIabYBzt46g
 kq0Jq6yPKhXOotOTvhe2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Y6/nnzBrM4=;1jaNZxUneP6eTFLxmShzEpD1fy6
 1Am2gMbixDzA6PXZ/3saz33ufwbT3eLxRjmlX0qRzh8r0RDbr46INH87zoypUXqJrxh0I8iuV
 S6xFPJgybm6nz/RX6SVCUWqDDHD3/ZRtF7UyeunpH1nh2/NFLj9ag3y03D9k42aFp1nsO3+VI
 3b9attBSnB8uijK+cDb3d1V4b+Vg9Be9Kq67HtHJyESe5TwdNQf9tR8YODhDTmJYLq2HSRvDS
 bEXLyL5DIVnej8Wz+Yc0OT8uCQs9Fr0XqTW3gYWNLmZ6/B85JhGRGa64E9Crh5y6bMlqm+CVU
 GYED9m1SSIznCAymDx/WFKonfwdZswMFntBrqDcNxakeyVf2PDQJf8L0P7pQDSj8eGiZ9LIZF
 JtK/Gj2/aXBXIZspezFr7awuAAcRNSXrs8xJKyBa+5+UXDF1JaQcNDpcX+NwcBdQtof/bPwEc
 dUmyBXCCWE/4gAbf6c9Xz81PutvHT2RvgJuMt12r0xCr2WYfZGDcql+r6xGzvFqgjn8jGexVd
 36KTlDDZGiKpDhZtXzVTb5b6xacpwXQ1fMPzGNPF5nBok+3WJREe3PYxTjunt9trTV5RST+Ww
 Pqw/7Kol/3dqqXsVf0k23TGjpmRA6GiEdpCyZEb2JplWI8qJUipaTdPp7Eq44JcUmErmfbwcp
 dJSs30inicbDOMH3t/x+nu2SMrqzO/iv8p5168tqncriOH7eFTMeTNQJRdUgY1uq274ZpLUyF
 CDDPRmlTJifjoqZRe62dVJO3NOdITnmUwmTyRdJEhIIej4M/B07IDxPg4+v6CGQ5800tKrJh8
 DL9MCdlvipUsPmX5tm//ynzOLlZKrA5vtQg1HhN1piCAvIO9WcWQu+G/ARNKqZagv8Z2hzURt
 yFhNKj2Nvl3oF4GvYNT49zDYWvDBAn+FDwYXNNT5PD0kd0MlwfFufEYNauI38ZNshdCXWj7a8
 FtjKMp4Y9aa4AnNYj93PzxW9LloI37Q4bZHP9WvqVd4p+Dt1CfPuH/Ktwsmc5+PcTS71XHFOb
 R2H/we3V/+qFKwULHoFRgO7qiHD/IpA5CoPgB4l6dHlCqkg0V5qeLcACUihsbYKT0bie0kWZJ
 9gQPIF6QGJO5jwY186gqDb2NvQrzldm5fN4LSG5993nJB6NbkOweLcoWsHqeAmBQDloEWDqGP
 ySWyRmdAABUHzV/IZrjF2gSQJZ6jWrxGTE89rWPOc8WlJa2pBYWlYDgoUpw1VSaGpq2scoSS2
 8Aua0Lm9keonJMBS5hVmlMXD4t3AQRq4V4zuXW/RbqmnrYIqYrT4gR+uHZXGw3VFfWZ/Wj1GY
 /MJmwAv6+6SdZjMDrpIdYoSriXK5o5UgTO7EOU+K36O4kEe9IlMpybMGTzp58D6J0tiTbtSJl
 lHXgoiTXuVxvAarDAKHXsSZCsBK9G39UrXhcd+XvQG/bc99GJPyaAN+UhEtM11TEMuvORiqHm
 6sEmRwZF9LE4FeSK+VeYAFSN2gXk=

Am 13.03.25 um 15:29 schrieb Kurt Borja:

> Hi all,
>
> This set mainly adds hwmon and manual fan control support (patches 7-8)
> to the alienware-wmi driver, after some improvements.
>
> Thank you for your feedback :)

 From my perspective the whole series is ready for inclusion into the mainline kernel.

Thanks,
Armin Wolf

> ---
> Changes in v6:
>
> [08/12]
>    - Define dev_pm_ops statically (kernel test robot)
>
> Link to v5: https://lore.kernel.org/r/20250312-hwm-v5-0-deb15ff8f3c6@gmail.com
>
> ---
> Kurt Borja (12):
>        platform/x86: alienware-wmi-wmax: Rename thermal related symbols
>        platform/x86: alienware-wmi-wmax: Refactor is_awcc_thermal_mode()
>        platform/x86: alienware-wmi-wmax: Improve internal AWCC API
>        platform/x86: alienware-wmi-wmax: Modify supported_thermal_profiles[]
>        platform/x86: alienware-wmi-wmax: Improve platform profile probe
>        platform/x86: alienware-wmi-wmax: Add support for the "custom" thermal profile
>        platform/x86: alienware-wmi-wmax: Add HWMON support
>        platform/x86: alienware-wmi-wmax: Add support for manual fan control
>        platform/x86: alienware-wmi-wmax: Add a DebugFS interface
>        Documentation: wmi: Improve and update alienware-wmi documentation
>        Documentation: admin-guide: laptops: Add documentation for alienware-wmi
>        Documentation: ABI: Add sysfs platform and debugfs ABI documentation for alienware-wmi
>
>   Documentation/ABI/testing/debugfs-alienware-wmi    |   44 +
>   .../ABI/testing/sysfs-platform-alienware-wmi       |   14 +
>   .../admin-guide/laptops/alienware-wmi.rst          |  128 +++
>   Documentation/admin-guide/laptops/index.rst        |    1 +
>   Documentation/wmi/devices/alienware-wmi.rst        |  383 +++-----
>   MAINTAINERS                                        |    3 +
>   drivers/platform/x86/dell/Kconfig                  |    1 +
>   drivers/platform/x86/dell/alienware-wmi-wmax.c     | 1023 +++++++++++++++++---
>   8 files changed, 1187 insertions(+), 410 deletions(-)
> ---
> base-commit: f895f2493098b862f1ada0568aba278e49bf05b4
> change-id: 20250305-hwm-f7bd91902b57
>
> Best regards,

