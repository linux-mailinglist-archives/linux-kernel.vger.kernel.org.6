Return-Path: <linux-kernel+bounces-351921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D39917A2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 17:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FBCB2222D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8BC154456;
	Sat,  5 Oct 2024 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hPYki3H2"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1F14C59B;
	Sat,  5 Oct 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728141152; cv=none; b=a2y+MvRic2k5aK8Q7VQQ+uOdT/fxDHefY4QaG6q2PfWMVpclUxcnEHSKxN0OceIsct/WMa2kH2ElVVrxKKS61/JfH5uhCMjBS0jxl7rggvKZ6NplZ1A3nK4xgfOeGetp5eFwvrYGawoR7R3pqysST/bOQ+XE7d0qSTVe8wZoqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728141152; c=relaxed/simple;
	bh=mBn5to0sSvDbFm7DNPOU77k3HQV99gZKeuZ2tMn3NV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+6JNVDp0wHIyN9hWp1tx6sKBNqhCgPk4bhFxNL6IUjyo2dX86VEADGN5WHSGDI8UJCYkwlai4l4moq28/k6+dT7/ZkUVmDlydM/ua/grRDUCkpY2n4v5C/op8PZ63sRRbKGid5Qx1yeIkQ0ipk25PzaO5TeYZYkw7u6TP0ufJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hPYki3H2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728141144; x=1728745944; i=w_armin@gmx.de;
	bh=Jg73qrV+f+UDOvfyfGx439nhC6L5X7z0km1/uQ+djcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hPYki3H2rzbodt8f7J/y0GMlZsuxoZMOprnY9V4QxeRNbdGPghxPZXesMtZJmqwl
	 aqpJWiJgR2CGXVSTmRisinkly4UIA2X5xUEvvXh0+YsdVdjwCUEsKFK39WMD43l/a
	 g544Hh9PLAQbsiNZZIkOJqe3y/Podt63nv8rGVBJwgWVGKUXmZw5kY/lO8AaLcdcL
	 FGn7muvI4KdUBeMZzBP3qji11XbXIDcHjyf55i6ELkuPUUj5BCCVCk9cX++PPIcXs
	 Jzy5lwyPeBdB/BaE1vvj6wSpkesYzjSWmedJXAqE9V6jHwaqbTvmySstWXvptDuVs
	 Ogc5AJ4KNkmt+zLUvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1ts4ik2hTl-00zEk4; Sat, 05
 Oct 2024 17:12:23 +0200
Message-ID: <f0d2200d-536b-4572-b7ef-63be26dd03a5@gmx.de>
Date: Sat, 5 Oct 2024 17:12:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: dell-ddv: Fix typo in documentation
To: Anaswara T Rajan <anaswaratrajan@gmail.com>
Cc: corbet@lwn.net, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241005070056.16326-1-anaswaratrajan@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241005070056.16326-1-anaswaratrajan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K0zAfBnub7kgOR3W5d+WyEYt4GqaRB0EM9u9GMe/4JjVr2qNFVZ
 FD4Y2PnCZOI5m5dUFqjIjqma/PnVe1+R9FsKt/IRk5sqdZBzmVIZYBuTHX9p6sNqV2kU3q4
 oicMrYTgGTQg8e9xZ/HJhKkPmu2DqYDjwIY8eO6uLf/+5pQtK5nCQ998YUSAIDqW0kDAWRv
 wqssD6gxZjnyYUzK8QxWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xmM7Donem1s=;KdAN/oiQUQaBX8iqC0Kot3rpd39
 TXGV0RsIvfp33Y3GtCWReE8cBRdxMgLjQBjUtmwckTnnU1laL0zxtnX8M+ualvRjw8Gl0cG4O
 qj+eZ8qzSV1ZiCd1augGlpUyE7yws/3o354QnBEXfmVLb9S8nRS7NIY0ur9XZhiJTVwKBPEB+
 ClQnQcnbmfHfPItQOZ9Vh7pFk5EKIZ3eXJwsMGp0SX3zajZs5Ld5yWFjgissoTbICzDKMOWbd
 Z4YrNCfp6bYeZjkfdm3Sz3kRVmlctqqvfoyWUd8zYkKp7VcNKW418yz8sztiqUfyBIjNN4Npt
 ORjo9Z30e8enuSfzTSyuPLhk7fkrPcysM15ZubHAQ5eOeEmhrRbFNtqoQCyeymWmPQlHbZ6FT
 Cy6zPoS3tQTHWpA9MFtXxECNWnpUqmyhCGnn0+BwB/IGishkot2d86KAiaJ6U1NxPzXO/8Na2
 27Xiqj/qRzk6SUYSWsSwhjMcqu9LLdlVOj0mhZTzQETX8UEsRmHD1ci7RBnfjoNI1DLoXCCYx
 wn2W84F6PWmYOzjIRQ59BTfMLTpO+uJPMgE1VciV/BXtBRAEYUhHSGpR8R9vNsVNuJGovB6BA
 f3XLh2IIXbod+7QqOJYRffP8ummvYGl/La801p8IQVoa+L9f8TEHmpZAXcJb4xMXMvlXmMteM
 B/25pm2+zlJ7Lo6unV+6KDkRuanKfIAAuJjD/7qIwZ+q5KkOBebWgQSZveOa4WANMbMou9zAV
 R7BOR8OSRZP+YAn0Wb/ddeleO89Hr0+kNeFfvHGHGWMJk07m3bOCiQEm5AFpuWYfigHJOC+C7
 iMhfBcrZRH0yuzC1K8Jzq5O2Wu7T8QZJ9U7WlZ4le73bE=

Am 05.10.24 um 09:00 schrieb Anaswara T Rajan:

> Fix typo in word 'diagnostics' in documentation.
>
> Signed-off-by: Anaswara T Rajan <anaswaratrajan@gmail.com>

Thanks, for the whole patch:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> ---
> Changes in v2:
>    - Make the commit title and description more clearer.
>
> Changes in v3:
>    - Add missing full stop to commit description.
>
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

