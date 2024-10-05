Return-Path: <linux-kernel+bounces-352159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1235991AEA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3213C1F21B04
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7A166F16;
	Sat,  5 Oct 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TbwTYgjH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8712145348;
	Sat,  5 Oct 2024 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164685; cv=none; b=l6zFCGI3gv905oAKQsWhbuziRQJQXyna4G3XTAtcVLnFuF7XKPc9wKklQnxI+ZXCT/zqpaEwp2xce41GetHFWlYOS5DlWn/tlSJE0pAPBEyC2pjvuzEUcaTMk/kWY1aaM6LxoFQ0wwGP+qWpQPKHqBudYCLak5U7eTcl6sFDAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164685; c=relaxed/simple;
	bh=zOzyH1gnagE1mvmm8lF9xfhuY2T7VeIHHouKrGdd8Ts=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kkoy0pYqGS2NlsEIEdL7IKKLRz0reAsE01oZc/wzF1z+7EwJYYgTWe8mJtSrtyngs556ZnvPrqzx14F26+ZuZReUYR4DLy7tpMH/AWwSpiLPxECBJVsK9uZqr6NvxWYiTQdnrLycLXR9/DB0AUNp85aoF9p1boLG7lA0QpGFq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TbwTYgjH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728164671; x=1728769471; i=w_armin@gmx.de;
	bh=zOzyH1gnagE1mvmm8lF9xfhuY2T7VeIHHouKrGdd8Ts=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TbwTYgjHkGyjHIjUcUY6e2AcPcsRWF/Timm2Q+TNaFuI9E0x9HuQj+ADlhF9aITq
	 /DmQUe3z5phZfVlV+uVe5oyC/itpXpUNmF4uqeVv8iN6Kq/d8QtK5sHKL4/XBlsRm
	 r9fso9HcsSRu4NkCikSqDR+g6dlODxNvUhaaCdg7qjKQo1H0lA/tiPIsNZS1ivjgr
	 ensBMvmg016UBXUMZAvpzqQBbhEpHr6gdka+nicQLTDX09toZdYgrFU9x2CuGP3rB
	 oDPPSk+7gg68eSTCQe+5U2RHP384ODESNhqusDrSzL+HX692S6SRX20/z6kRLvqTM
	 6YR2e6CsOw8it82oEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1tPqKd1uhc-00YxUO; Sat, 05
 Oct 2024 23:44:31 +0200
Message-ID: <3d5f6c88-f162-48bb-a3b0-89f9aa021d65@gmx.de>
Date: Sat, 5 Oct 2024 23:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: dell-ddv: Fix typo in documentation
From: Armin Wolf <W_Armin@gmx.de>
To: Anaswara T Rajan <anaswaratrajan@gmail.com>
Cc: corbet@lwn.net, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20241005070056.16326-1-anaswaratrajan@gmail.com>
 <f0d2200d-536b-4572-b7ef-63be26dd03a5@gmx.de>
Content-Language: en-US
In-Reply-To: <f0d2200d-536b-4572-b7ef-63be26dd03a5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sChw0K5p3GdT1gd1m9FTj0lBx4UYJnzDkCIiXp9ifVdIPZVJJO6
 bON7ULoOBagH/ZakG86K5a+2WYk9JPvyRpJGxnLOiz+a+v5knk/eU4DJ4iPA2vowA5QC1FW
 7x9xx3SYVpgT1ZmrM+/ChCOdnaM29RmYk6DLmhsokkksAObFjryZxwpbvl1Dcw1oDGUzizJ
 ber0UUied/x76NHT6Y1NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MfRacub0WdE=;TKV9rZ735UXnDg/3Q3VzOiu7tMq
 rSSR8PEicNomH5+LvR5KKSf2NizBz9CLxwPn5aUJVj3Jo1KxVYU6K1R8K/8E94QyjjZQk14nu
 bsZ6LGfNgu+AQSOJrgJQp5IvNK//SD62kjBtPRpaw7HJp/NC5nNI6RhgxP7GJfHun5OsHnDfj
 ufSH8gMT/H3r8J32WU5vCDhMi63DNf48yJfI3Ty1v8XEXN8qNPcsBpLJ4OgaDPoPGcnoMkhlQ
 0PjoeAjTtbbWzwgy+y/LJ/Vc51qDAxU6A7mUDyaEmkps+C9//XPRh9rVW62Rt9C20OQu1TRlj
 JExITH+BabZOfxxawoMqAJDeW2TVQ9OXHWMR+mgCJlqux+Gr45iYBLAhcx9Csz9OMQFX16eAG
 PREm3oEKXjSqwKjb18InIL9PS67kfvuNkLGBYIslMQySDQTGCY8S9n1GK2Z1DhpBiKsmXY6j+
 uQgvV358qp7kjL+kee4JrERcl9eFHohkU3tSxKJUy0/lYzrB+eO4MZihSi6aL53zHOmmrYUSi
 wlYrNgHajakETTOCDv1MVtjd1Yws0yriPPRipXWtrS8wyi2bRqs1T/55fho+tkpf63VZIXfqR
 RoGCDZWw5wk4T87rdmOhI/B2RNYqq4ykamWR5TV9O757LEmPj+vaG76N6a+oZfBLtudiv84YA
 ns5Eu9slQbVQgBjcGWjarmjkwagzGI6DxDMVtxklCtg36zqJk7FeTPpZnm1dXO0usQO9o56nu
 xfNad5wE5VaPBi7/Iz1uVKq//zuJSMxZ9jFm516ORsDGIepN4XTCLXDiZr5rrMR1EZrWv3KrQ
 hM8CEWMdJoCSEsHRTn51/lXw==

Am 05.10.24 um 17:12 schrieb Armin Wolf:

> Am 05.10.24 um 09:00 schrieb Anaswara T Rajan:
>
>> Fix typo in word 'diagnostics' in documentation.
>>
>> Signed-off-by: Anaswara T Rajan <anaswaratrajan@gmail.com>
>
> Thanks, for the whole patch:
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
I just noticed that the x86 platform driver maintainer where not CCed,
please CC them next time so they get properly notified.
For now, i CCed them myself.

Thanks,
Armin Wolf

>> ---
>> Changes in v2:
>> =C2=A0=C2=A0 - Make the commit title and description more clearer.
>>
>> Changes in v3:
>> =C2=A0=C2=A0 - Add missing full stop to commit description.
>>
>> =C2=A0 Documentation/wmi/devices/dell-wmi-ddv.rst | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst
>> b/Documentation/wmi/devices/dell-wmi-ddv.rst
>> index 2fcdfcf03327..e0c20af30948 100644
>> --- a/Documentation/wmi/devices/dell-wmi-ddv.rst
>> +++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
>> @@ -8,7 +8,7 @@ Introduction
>> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> =C2=A0 Many Dell notebooks made after ~2020 support a WMI-based interfa=
ce for
>> -retrieving various system data like battery temperature, ePPID,
>> diagostic data
>> +retrieving various system data like battery temperature, ePPID,
>> diagnostic data
>> =C2=A0 and fan/thermal sensor data.
>>
>> =C2=A0 This interface is likely used by the `Dell Data Vault` software =
on
>> Windows,
>> @@ -277,7 +277,7 @@ Reverse-Engineering the DDV WMI interface
>> =C2=A0 4. Try to deduce the meaning of a certain WMI method by comparin=
g
>> the control
>> =C2=A0=C2=A0=C2=A0=C2=A0 flow with other ACPI methods (_BIX or _BIF for=
 battery related
>> methods
>> =C2=A0=C2=A0=C2=A0=C2=A0 for example).
>> -5. Use the built-in UEFI diagostics to view sensor types/values for
>> fan/thermal
>> +5. Use the built-in UEFI diagnostics to view sensor types/values for
>> fan/thermal
>> =C2=A0=C2=A0=C2=A0=C2=A0 related methods (sometimes overwriting static =
ACPI data fields
>> can be used
>> =C2=A0=C2=A0=C2=A0=C2=A0 to test different sensor type values, since on=
 some machines
>> this data is
>> =C2=A0=C2=A0=C2=A0=C2=A0 not reinitialized upon a warm reset).
>

