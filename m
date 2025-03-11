Return-Path: <linux-kernel+bounces-556992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B816DA5D209
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C258188A2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C2264A94;
	Tue, 11 Mar 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="afZqlG7E"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675561F4CA8;
	Tue, 11 Mar 2025 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730038; cv=none; b=tM02XpX4EgT4JTjCLNz/1aWsyJBT+O5B0ZdRhDO0cnOwzCmw7Nee+U9TPLeojAT/j3Ruz8P/ls+XjCC+5m65nmvFit5iZ1+yKvUpOInHzjBgq4H84SLG99+771rrDpBQk8tzaFicBEY91Gm3BrlOLeqx3+cPyPvDG+KVhyKl230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730038; c=relaxed/simple;
	bh=mKzUkYarQ3/as3AfYs4QM3zv9D62ramYgUOYVFHQHwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbcVzh16kozCgDZ5j6eWrOFOYZWaHkE8a/zud+1J9GbB/BxvwYFAgqf8lW0CdODQegOOAxBKtF14UTObTjHQ/G7UaTgOKg7ChVXoIoji2ND4lEHt/vuXDoECtatCQGrpUUkKAkmcyLoGiGCUj5jeFAj0kuH9OZ3IjxkkOdrGycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=afZqlG7E; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741730027; x=1742334827; i=w_armin@gmx.de;
	bh=nWUREZG/uL3Q8iXD257aVJlTPH4Kp+WWUMzCY7ya+AU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=afZqlG7EYF2UOAer8QKxpX4XYORRhM9YjvE+d8ieEwQQYDukmIgKztll8nfQ9d2t
	 M6vgVDZIAankjFAbIy/NLeMg9nvI6M9LFL5S4yl/7RHo+x+H7WvR1XoKGh1L/Aqfr
	 861ViXVrX+mRVdIkjmw9tab6B/h7FSuTCZVlcjOJJaVwvLMHe0hObgb22uEG15yh6
	 jTVMZcjrSSkB6xCvC+aewA72s6ZXsanY1hulYSX6dNloOQljWvg7vxWOlkGMEFhP4
	 BeoULyipsxySTK2xGpseEKy49U5TBaVtcYzyQTTKRic9Lkc2TkmbWNwhr7zMQFcxo
	 YSnJIxbBfw5nnBPaGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1tPcLT3cXx-00imgH; Tue, 11
 Mar 2025 22:53:47 +0100
Message-ID: <eaeaef7a-570e-4738-a420-4d5f61adf0bf@gmx.de>
Date: Tue, 11 Mar 2025 22:53:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control
 support
To: Rayan Margham <rayanmargham4@gmail.com>
Cc: jlee@suse.com, basak.sb2006@gmail.com, kuurtb@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
 <637B90F3-58C6-43B6-9822-5314C62138C6@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <637B90F3-58C6-43B6-9822-5314C62138C6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BpoaWhM25TZXLWdOo3ZH3+Ng5tiC6+Fh/krIQmFSDspIrrVGMTZ
 +SkBpKT3Nt6ovOTGdof002huNyvyUyl1yokiEoyS1eC7vwJdBaW8TSzF/eLtd9Bs2oBXHBg
 AqypRQwMz45EseNcIzAr8fUwjEkBnWYAfNOoCFjv54Fxscip2cQF2amPWT151Y4hGG3fiti
 DzsOvtnnAYFgFq9h8NYkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:veyu5uVBUhc=;TduTV3tq0v9/5mWBTYbqkcHuqCz
 KQWjoqN4DUyq2+06Mdm5E2Ts0JaaPJ4P5WI/dViELCR6V4YWLDxEh+80ZO+HHU/4lbaWOuAsW
 nr4wlgynBCDfltbfh9j2cuksR3LFr74Co5InES87SHZnSb9G3ncudffqL3Qfpcq+8T8cXPALs
 os2kpEuTtcilpKd4kUj8sTZbmBIb+I1xtMg7onIY28nYgvnDyhPEfrG0jx21ZHizveRykpYRE
 WGjGJF4yF/uzzazYstfbcvmZ5rcliEZGL9YcAHcib04FKeinfLL/uXQN+4wN3fp4dBcvhmISg
 NXBX04b7ZLyDLv/KqRH4WNDviCqndVbLjLJ1ks8yiZQ0cqoYGHPqYs+o1+Myf/0NuO8eH05Mi
 92o35CPpdOJ3Kka71YSIlfj0senNa0DkxL2+akTkhh6A47A4dqYNJycvORScAFGW+kcI9wwkk
 faDn9RsgctsOph0oCOwOOtx7Ltpq2mdkHDrPcTeDr6P/a26JSJ4hW51evyP8sd1oGf9bEKfCt
 TH/zTZm9p7YS/8Zwi3R7NE4zMt4xdcSRdXVLUw/22kwAMiM/Szkp5VYfE02j3p2z6RkVYEo87
 JJ+0hsDeZS6CvXF2qXCBwHW6djOdQ6BmIpHXz5GFXqD959X4zmhrKcGFvs5i9jYX3+d2ZAjQY
 3OMDJy3jBsjII2DNApbc6cUE5TISW+xHr5OJH/+miIHFc9nD2nxlB4bXycRH7xsT1EGuuaowu
 ZYWUcx3DkvoexAEjpuEwXphx0pFhRvwUVB+nKao37TwNtNg0QVoOqQu0zEl7YRg4ckKtHGSxn
 isC1vS6MqhsKqrItwrd8RA77Wbn4PkpacjU1NKBaBPTWH5Wmw5NGvx2r5jCZUEKmJlJZNwcUS
 Djn/wHzm5KKhNYY2yPRTGjxQUlY8nTCIf6lCdBtWxYQH/cLLPNtJuhwmVF56TrNeLktru4wVV
 TRBpaJqIbTdBEUGjc1f3A9vBMXgEFT9zNH2+/IAK4+SBEa15rrjEBl3GykudiNP/G3HwEsTVd
 pLyX9czmJvF9emO3fQnZ+haFfBa7vjE2DA/3yJpg83zw6xYQRWYF/zZ99R4XBnKb+FugKcG/T
 +AZS+LPlvif67/7SJGdT9S8LSihivDQpdm2PXQMTtc54hqHmSTQ6zShvturnRuykE0Mvxi42Y
 2xZYWe5MrBk8maetRbLJAlQMKSWK1WiYiBz9k78zxzslgAFM5+ryDV0Netj+7t/2dWTcHU+cQ
 lhhjjCL/DMwBkkcX8c30/dNJLPICsTQbXb3TD1d0tOwXh+tr7Zurl4CQhv0LSkNLkPyZREcsp
 3qaiVJdAmDAmrU4P7VQ1bF7HpOFshyFjzHY6naZO6DaDA40Uu+z65n+7NMAFXYn1ZMWnyjYsL
 u3kmBr00GDqhaR6MoP4R46hKQ2DZRu8pZxGaoVzwAiWww0iy3YWsxNTGLv9p9QvjqoNxMDiKA
 wzMg2Vr+Yn9FiVsCPa5ZM0yQiIrc=

Am 09.03.25 um 13:51 schrieb Rayan Margham:

> I=E2=80=99m so sorry I=E2=80=99ve been in a mental health unit for the p=
ast month, are you still working on the driver I would love to test anythi=
ng you provide me now
>
> Bestest regards
> Rayan Margham

Oh my, i wish you all the best for recovery.

Can you compile the current -rc kernel with this patch series applied? If =
no then i can give you a .deb package containing the kernel and the
modified acer-wmi driver.

Thanks,
Armin Wolf

>> On 5 Mar 2025, at 00:24, Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> =EF=BB=BFAm 15.02.25 um 18:45 schrieb Armin Wolf:
>>
>>> This experimental patch series aims to add fan control support to the
>>> acer-wmi driver. The patches are compile-tested only and need to be
>>> tested on real hardware to verify that they actually work.
>>>
>>> I CCed two users who requested support for this feature. I would be
>>> very happy if both of you could test those patches and report back.
>>>
>>> I am ready to help you both with compiling a custom linux kernel for
>>> testing this series.
>> Any updates from the two people with Acer hardware?
>>
>> Thanks,
>> Armin Wolf
>>
>>> Changes since v2:
>>> - remove duplicate include and replace hwmon_pwm_mode with
>>>    hwmon_pwm_enable in second patch
>>>
>>> Armin Wolf (3):
>>>    platform/x86: acer-wmi: Fix setting of fan behavior
>>>    platform/x86: acer-wmi: Add fan control support
>>>    platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>>>
>>>   drivers/platform/x86/acer-wmi.c | 298 +++++++++++++++++++++++++++++-=
--
>>>   1 file changed, 273 insertions(+), 25 deletions(-)
>>>
>>> --
>>> 2.39.5
>>>
>>>

