Return-Path: <linux-kernel+bounces-349700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D14C98FA31
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37EC1F23F96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F271CF296;
	Thu,  3 Oct 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qk2H5B/t"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F841AB52D;
	Thu,  3 Oct 2024 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996621; cv=none; b=TnEsp21aDJzxkDe3mSWkwc2YI33vvzTI/NyL3+ROXHGX1UjSRsavBzeSNihozq0W2HwaJHvxPudeCTq67d+NouZCZqQtsAaD6YtzsySOBlGMXe1XHllGkxCJAwd0Vjfz69wyFKVTvISjtTN4fOqgSt9IJaN63U3THurR8kZrSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996621; c=relaxed/simple;
	bh=RlBHWrkvPIdEMvHPzkeCP7Y0MeQke+gep+nbMAKkxPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwkMsvX6GNg6noI5tSF/71tMTEHmDdrgGzdTbOcxBEoQZkvKD+x2ZxKucAY+o7Q7BzUYlT8jcsCuhvmHcPRGihZtgdtBZhofklykv4m1Z1RCxKAIIuZEWGd5Vhih221zj8Sa7YaPX9qAxEim9O/ub1Mu+zGSk39jv1Hg8nC5PnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qk2H5B/t; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727996610; x=1728601410; i=w_armin@gmx.de;
	bh=nGQ2e3eWhWCnCEzigv0/+ogytIWxpyFa6ZW3FmJvq8E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qk2H5B/toLiXozMBVngIUDE44Jjo1bAVMGCk20qtWPIwqxkjOn0BhUAOikIgjrjF
	 wlAyfhwiLLDIL4jRtnHhOvkuBoY5VtYjbuckO9TJKvHNVfMigwXb/M6tkd28Q634W
	 GNW/Uve5KQDBX/fSmXOSayDcWpQuasfdipB38dFvnbjE2+y1IHlasHwQyY8GEGX7i
	 1Oo8oRyt9VAujVqDSfLhRF3+l+UyaCPbZI5TC78jkKFmw8d1QjqeW+6oQJkjoW+/I
	 UHUv/OGDFJVM/EIHjj7rvrbTlhkOMB9E4edFLLcWu8ZgYVQriNFsDO4nncsf7WRyo
	 FrgWdfcC01cgcwJZ0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oBr-1s09Zv3HVd-00sqpX; Fri, 04
 Oct 2024 01:03:30 +0200
Message-ID: <17bc2698-9113-4cf0-b58b-4f9db1813753@gmx.de>
Date: Fri, 4 Oct 2024 01:03:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix typo in Documentation/wmi/devices/dell-wmi-ddv.rst
To: Anaswara T Rajan <anaswaratrajan@gmail.com>
Cc: corbet@lwn.net, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002100748.309707-1-anaswaratrajan@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241002100748.309707-1-anaswaratrajan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8NV1QISHBdcUWuIi9vy5D0xmjN0fZXEGGGvD9lT4oMCLKmD6H6C
 RlA1ThF7r9oDSPqb4Up+5q1OSOrLkaYvXYipFJaGCQTiAApr4N/4hYhsvSTayPvSljEpKYL
 6tAv/PjeB18ecZFLhQ8KmqiPQrZANcrd3egkAfPSGUh6XoTnckcA9K+sPMFTHnd/0LBhldX
 VChwiXks7GENusqzkE95Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pLYzM+Qns9c=;T7hfbrlG61qcrBwYBn7Mxl6OLkS
 Er3QJJH13MQ/F/EQRatzDimkJa4r15fsjo9pzT+vs2XrCwFtrt++0T12nhSTAMD+vT2YMlmMk
 Nx6T9Z6GIZO+iLG3nT5zIzIAEzUtf7rrGaz3or+7tJWg2lsOWTgGzN6r4uHLqUUBM0/ob5fY9
 lD/FAbZQlLLNkr/zaAcZeXuMeafRGa/CD1BxpzotUceicO3B6Ckypv2e8io3SKZLuSAFhBI02
 0kB61C1rjLuiDLcqDj/CuKzC3lEXbX9/5czBrpDECiUeQShyXK6m3nHHJz8LNeZzoUo+rLhnz
 GmF35LBrkOg6l5qYEZVICkvXUv0GDdYWmG8oNNsoqC6BVWmrTZFKd6vglEn5ifeW0iLhcJvEH
 NwUQIWdnm0VLXD/EsPAUCNMBa8XmLAZQOzZVaQpcY8Hs2kjFsOkMSfHQIiENLIRVd4u6AEoGa
 LlIS2LJYmTe7Vss4VAvzR9x8quSU90q+jFmlR/XibUPqjxxPbTHsqJqUV3oRQv3W/NJ2xUQ7Q
 ucPv/cXHbnWZTvyWf8FxLcXKr774t8KE+h178WTuy/30c6RVwcxMv3NBA8ZFqptHHbgPYkcbB
 DoHMTRW2JLSFjQIODsyM+MFYOMgFu8LiimMiE1pTQwWJ76P45XB77qgqKfxIsy0tBWiYhpbHG
 PyKaxcExHbuz6WtLQw84O+AbjKJZ2ZmsPEtkVVpGYbHdHbMoHB0oHGDD+UIDLXELTBva7TdQ0
 I+Wk4UaynF1NFsT98e6AcLJuWh3bV4VnMo1TRd1dTUeudzck3JOuAMwb/6G/8d5Vb4pMtWDR9
 YC9v2Mf5HapqDYg+nYZodYFUDa9xdcnPla9bL6pHvoiMY=

Am 02.10.24 um 12:07 schrieb Anaswara T Rajan:

> typo in word 'diagnostics'

Please rename your patch to "platform/x86: dell-ddv: Fix typo in documenta=
tion" and
rework the patch description so it forms a full sentence.

Other than that, the patch look fine.

Thanks,
Armin Wolf

> Signed-off-by: Anaswara T Rajan <anaswaratrajan@gmail.com>
> ---
>   Documentation/wmi/devices/dell-wmi-ddv.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/=
wmi/devices/dell-wmi-ddv.rst
> index 2fcdfcf03327..e0c20af30948 100644
> --- a/Documentation/wmi/devices/dell-wmi-ddv.rst
> +++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
> @@ -8,7 +8,7 @@ Introduction
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Many Dell notebooks made after ~2020 support a WMI-based interface for
> -retrieving various system data like battery temperature, ePPID, diagost=
ic data
> +retrieving various system data like battery temperature, ePPID, diagnos=
tic data
>   and fan/thermal sensor data.
>
>   This interface is likely used by the `Dell Data Vault` software on Win=
dows,
> @@ -277,7 +277,7 @@ Reverse-Engineering the DDV WMI interface
>   4. Try to deduce the meaning of a certain WMI method by comparing the =
control
>      flow with other ACPI methods (_BIX or _BIF for battery related meth=
ods
>      for example).
> -5. Use the built-in UEFI diagostics to view sensor types/values for fan=
/thermal
> +5. Use the built-in UEFI diagnostics to view sensor types/values for fa=
n/thermal
>      related methods (sometimes overwriting static ACPI data fields can =
be used
>      to test different sensor type values, since on some machines this d=
ata is
>      not reinitialized upon a warm reset).

