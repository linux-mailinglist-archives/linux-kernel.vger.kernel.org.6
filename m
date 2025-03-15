Return-Path: <linux-kernel+bounces-562788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC8A632F1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172F83AEAB1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998C1EC00F;
	Sat, 15 Mar 2025 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UmdLH82c"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CA18A6B5;
	Sat, 15 Mar 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742082986; cv=none; b=Yg+9pf+jZsOEaq0Tk9WnVco4ATgxiGQ6qUQeUux+/uDSRy0y6TfC7E+G0QkG189GXDv0W5g7UDGFkPiiA7ewYJ1yOHd86Aj9Y5dK1UOzIhTtDsUuky+9k4irsjQ5r78P3l7zzSodcCgOwr3AQpRp+f/RHA+wHerGhiGGR1OoRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742082986; c=relaxed/simple;
	bh=PzhmgenJ3h72aVvP8IAUiuyjeWtEHoS2ME/jYBCx5Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgneeE5e4pVekgdHdeFS5/cS1ec6woYh3lYDpd8ZrVthZr4HBAgpmSYr/liCfP5M8xoXWW2p+0sDmA0TYgV4XJfX6NP66Nqa41aDrldQhElJckhuxDLV/2B1en7ZlXcvq64mhBxw+x3SkYawIe1mRsx7IjBUXoeYfxQcml/GYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UmdLH82c; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742082981; x=1742687781; i=w_armin@gmx.de;
	bh=Et/gAZ7nppr/aQkVU0JcosHyHQV4uGDc568wjuu4uXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UmdLH82co6MMdokHS78ghWEx8FNumghcKHme970aH9VdYVW6JqsRvFvo6uNvmqVI
	 6M8B8DBNXvVc4c2XQDjwZTT8UChPhycqwWdMGbyC9xRuLtje3z3sCnSr3KgtBkI/e
	 Fh8YUcNbiP0FGfrkRoYaA3HSP9GkyGbQ6VER1aGnLB3q+RxoyeiktZbnFpkANtWdc
	 3Iy4DffD9ccF5h9kWF50pMNhGJW0YTj+HQRrpVjLKfdKwkY3B7BGoaUayhjnGuxm/
	 LgKSA6KN806b5YjMJX/0sBhxfshvK1Fmtsy14otITAzznbRBxpLv0jJnO6OZpmpN9
	 fE8eV/JEMzkzfxEK4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1sxlx33yKb-016Rmf; Sun, 16
 Mar 2025 00:56:20 +0100
Message-ID: <f1075a73-627e-4b37-9b83-bac0d02675a5@gmx.de>
Date: Sun, 16 Mar 2025 00:56:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Add Null check for device
To: Chenyuan Yang <chenyuan0y@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250313162820.3688298-1-chenyuan0y@gmail.com>
 <ff53debd-05bd-3a7f-89a5-2110b8103fad@linux.intel.com>
 <CALGdzuoWo+sT5ShVRpY6Q0R=5GOBvbOY10hyvUeT8DL9vsSj3w@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CALGdzuoWo+sT5ShVRpY6Q0R=5GOBvbOY10hyvUeT8DL9vsSj3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tOGMzw/D+JuTMeKtHnt9g7WkxQYW9RFODQCoh/9N75H2dwM0KO7
 0b5rCeVjtMoFOs7BiLVH4hDTnGVtBrGGcSZnIDrWoHkpyUvoYhGIwv/IJubM7+IaZ8SVoAn
 MLi8LPxSyvSVcNbl/R+Ewa2Je4B+hwQMpoG4NR8/chDCrww7drO+WDehGJd+k7flxCAnGzm
 YUFPFf0NkQBU3A45n14xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o84Vlsv1pEM=;1K5yBBE9kXjmr/F8FjvOReRLQfI
 e79fOa8gcSA3w0MckQcXurnppkR9QLJdkLslwewoz+r5k12iYc87QQdZg6r5CG9+U7g1ugacx
 O9tT2Zn19apW8lVIPaDXs6jgdl1moKZwgiPIYTDSySQLSZCXyY0kw5tC6wAEKrfBK6oXhAxy0
 w5FIKZD948mPUAaR/x3DtapL/pgOn4JIlKzq29d1o8NLY8KFHbDkztdiq2SCbBQUi4icO0Jc6
 LlnL4KciAIesONtQZwW3UJ1t18ue/rg89Hg00mKKn6g4GQQ7A7eFwC+f4qwXxwKB7rbMDPc6l
 1iXaTTPbpj9tSvwnlEOYPNQZ5Og1zr9YYsFx/2yCNL3jklzaX90fMUy3WgErjJDH1K2/9H3Cw
 zS3/x9mE+/3CEp59k7WgtAhQcksWD0AxBBQtWvU8WtOGTVkftOeI7K4uobGo1XEihgM3xr/v+
 7DnCmZVO8oT+rIwv+7pfmBKLm9IlagQ6mLdBOHOI7zXGmS6ykikSBQJC94tI3EA8bJj3FNls5
 r0qVnx9PW992z2dL2kqHZGdp6A+UAep6stXz1svN3g/IFPVrBbUR5qf5FO6lOt0Gj6OtEYh1M
 ZDlFwoUoyDA/ODDRDAxsNM4DKpuonIJwqyA/BjHxCUpvey6wmDSfi0jeTBAGWnXmEsNHDLGT6
 CksijdnO+01HcmRYbrk6Ms2s4fn9zL0L88NEqud/QrdGZ6wxrTwhAFiQMaetIFSxHATcg07qa
 SBKcgH2DRR/dWq/Xbk8iTTa7Z3BeV1rqq7ljiSQzi0e49rx41ZuNHnzeqE1hRl38ZSDg3SSW7
 pEXz0W5HsLY3pvBm9xBKm9O2F/cNh2TwSMfXYtdK5ywf9gCY4+8juCtPV/zr3YSmcw/iW/P+F
 FeAh2nkguvsyaGoIbImI4koLFShRteCuEvIe3nzsnexgqVdtL2Pcc+8m1dCTIqk2cewBVeeOS
 4nrA+7MjEaqmdsujbExSYAD3Px0noPNDZjZk8XhbOe/dQeJDzx/NDe/piFQhQnwTwL/P9zwdl
 841Qxuqqq9OPH9dN2m0lAVmghahigy5Eu8Yb2Vz7yl55ZxU/j8DuM+RUJfYmVZzCC6Fvmlq2p
 2VEJuWcZ7QfWdDKs6HUgWP1Fx2eSejZg+02Ky9x/ID4QfKV5zR5IzkzlsWX52t7jMYCsSRyN3
 VYeu/A2BR4IM57zAGOhZXWAjix5uZlzdXDh/aZRL/hEedHog/kIlWUcIGNRFkUWuU91n9iOcY
 70WwoPjSwJCYr/UyIFvF4Z1wS+nLT9fnLGAUbm3a+2vM55BmHy/WrLiEy2mR705SNtFnWq7Yy
 KqrHmG6ZvbufOsq7DDSxjzXFjMrKiIw3KjGWYHgXcfCR19NlQC5ojErW6QTFknXPvOCmGqF3f
 cJGj4AmZrZEac6iS4S+vhYkJHgmgAbYFW5f/hD7LFZ0tZA9dBn8zg4T4jMy28jEh2r7DBoT6x
 oWF7Tz7eidkjmmFffxCjhBYhPRZ8=

Am 14.03.25 um 17:29 schrieb Chenyuan Yang:

> Hi Ilpo,
>
> Thanks for pointing this out.
> This was found by our static analyzer.
> Sorry that the checker didn't make further reasoning.
>
> -Chenyuan

Please avoid sending patches based solely on warnings produced by static c=
heckers. They often do not fully
understand the various side effects and semantics of individual parts of t=
he code and can thus produce bogus
warnings. Please verify that a warning produced by a static checker is act=
ually valid before sending a patch
next time.

Still i have to admit that the source code of the parse_wdg() function mig=
ht benefit from some refactoring
in the far future.

Thanks,
Armin Wolf

>
> On Fri, Mar 14, 2025 at 6:41=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
>> On Thu, 13 Mar 2025, Chenyuan Yang wrote:
>>
>> Hi,
>>
>> Could you please be consistent in style and write "NULL" also in the
>> shortlog in the subject.
>>
>>> Not all devices have an ACPI companion fwnode, so device might be NULL=
.
>>> This is similar to the commit cd2fd6eab480
>>> ("platform/x86: int3472: Check for adev =3D=3D NULL").
>> Please fold the paragraph normally.
>>
>>> Add a check for device not being set and return -ENODEV in that case t=
o
>>> avoid a possible NULL pointer deref in parse_wdg().
>>>
>>> Note, acpi_wmi_probe() under the same file has such a check.
>> Hmm, is this a bogus fix, as parse_wdg() is only called from
>> acpi_wmi_probe() so how can ACPI companion turn NULL in between??
>>
>> How was this problem found??
>>
>>> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>>> ---
>>>   drivers/platform/x86/wmi.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index 646370bd6b03..54e697838c1e 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -1091,6 +1091,9 @@ static int parse_wdg(struct device *wmi_bus_dev,=
 struct platform_device *pdev)
>>>        u32 i, total;
>>>        int retval;
>>>
>>> +     if (!device)
>>> +             return -ENODEV;
>>> +
>>>        status =3D acpi_evaluate_object(device->handle, "_WDG", NULL, &=
out);
>>>        if (ACPI_FAILURE(status))
>>>                return -ENXIO;
>>>
>> --
>>   i.
>>

