Return-Path: <linux-kernel+bounces-312409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18096963C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D02B2671C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A1200108;
	Tue,  3 Sep 2024 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="rCJwgCab"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBF1DAC78;
	Tue,  3 Sep 2024 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350094; cv=none; b=BooiYdSxnWWKlWFlndkUiR6L8tNBzStLORBpAIYcommSLe+grF/q5OXxC5jDqUOPh3St415ONU/2C0dlN1Wy4QJgpYo7nynGT0nhwkjQmjPbCWAza0yW3nohd2Tsd6qXs2hs1C0joV5jOHFnGDDjHE+M4F2XOrWGx5Jr+uhSRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350094; c=relaxed/simple;
	bh=EditlmvornbgN+97SGAdjsvPMU/7bouDFdN0SEiY454=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td7ifN5cWlAkzv72F6iVzo8EBzdZr9JPGecvVsSZojcjRC4xGDJen+DjVlj78C7zkiq8ouDb6eJkKnbZMzz8KrPgqsLKvI4WK9fXlH+8ntMw4deOdBMK9gJwKQo+2PBUvDZA5ObuF3xz9+nq5FJ41lGRWPjIj9W9ozZKWkQ46Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=rCJwgCab; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725350061; x=1725954861; i=deller@gmx.de;
	bh=aroSbJ5KDqvjcnsxq9cYy5gL1qdHDU69nrXcL1/sQzE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rCJwgCabqnqfERKu569mPwkTMIlsCCI3ujHYLoAqTV96ZuckmEf70ThbNWfzXSXB
	 qQrZxJQohRor4HZ4l3IeD/grvAaBqB3dN0kk8itYWvHjLnGlnEBG64w8HUCDkl/JX
	 D1GioB586j+s+aFpcOb6wN6gVUScLiltX5pAaUuFecl0uAEDeqEOpRBFzrPMNVk7/
	 KQr4EKSzMjnDAWUZLxnD8mR9OlhEABkmogG90uPSpVS9hWDJJcvoMjD2nbRBHABng
	 gPfFNgVLcBq9CrGBZs97DR12UUWBas+s7uPmjvfbsFWBvhn+tNz/1iB8IJv3eV3Zl
	 OL1JPX4uOp9LGFE/Jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1sVf422SWh-00LJDO; Tue, 03
 Sep 2024 09:54:21 +0200
Message-ID: <250f3ae6-3a81-40c7-a747-4713e8888510@gmx.de>
Date: Tue, 3 Sep 2024 09:54:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx>
 <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx>
 <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9yru+gKebg2BfZyEcOKFBiNgpwlqfWt8pXUHrfwCUaNgroTHMWf
 F/vVSrM+/dqINS4nHQPv16j+cifnt+0GD+NXO6jwtxVxIrg9Aw+KmHQ6l4CmhC8ASgOP7Q9
 olhx51oRYwK5NYRIBxNzyKo1BLc1sd/KI4t7GCbPCujYc6vf59440SkhYAob5LaaPL/Hvsu
 KYqi9ThiMpDN3k4FHd7XA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5tS+uVVUKOk=;M30VvBEdBiEUi7Szajf9qEmyrGN
 Sxqvh1RAbmlhcU7NydQ73IUBZ8HWTCw369rFbBUdWz/dAAs3sIR7xdsOjKZp+oTNwnUWLWORc
 xV2PKnda+vis9n5VSPB29qyzCvLnusT2E7TdvrAYn3fIhJHhsUqTSC6VB8lOfn8oqUgN1IOna
 jB/TQoUkXoNU+z22z0jVdyccEcOjGT6KTYIISWEKvcWvR5z+IFLZqFpaDWuBppOmi/Sq7Zzp2
 DOgDh2GWyR91nFsnOFTzlewM+EWKje121jd0sdeihBl3HffMZLIYnWud/0S04V5Qk1VRjDiXd
 8rLhBevkX4I30lhe3cVyjbtHI8OwI4D2jwc6CSUqzd4n3vt/qX+ylxnEIOqt/lgyZnUTfb/Xz
 SQTMWvX0hy2+0XJ/+G3zl+rlYjMma0bA4SSroLQp8OfrlzeIxhF+7P01XngXQk4D38K3zcNyD
 boh4U1y214QilL1ECnleN3FXSpwBDfmO+cjCos/MaI6vxo1vOPUjXUe3jDoymkZg1sg/topsI
 ZIuAR1kpImjSkiDadeLXTrGrJbI5zgy34ygrVNux4VSawHP8L/2MUNee3n8x4YJfApXNrKX8t
 zPaWisOxcf8VOto3xscAGeS7YMkGTwFsInJ/Yt+hWV73lJ0aMu8Fi2eFdxoW3mwBo55Ha9YzF
 RMt2/VHBEBa60PlcDEpJ72gu4iPH8EeAx2KtBD48H7eQL90diexNr5tSt+v//s4ZBgT+DXdTm
 XT9aGZ8X+KWU4Ka2pYc2pheyM/sOjvAS6i4FQK0rSvCn6xFvow9I5aNu7tsD6B7Emzb+jsQUK
 B/9jJRNWy5j4qh+lvTq+iqlQ==

On 8/8/24 20:19, Linus Torvalds wrote:
> On Thu, 8 Aug 2024 at 10:48, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Here is the disassembly from my latest crashing debug kernel which
>> shifts it up a couple of pages. Add 0x10 or sub 0x20 to make it work.
>
> Looks like I was off by an instruction, it's the 28th divide-step (not
> 29) that does the page crosser:
>
>>      4121dffc:   0b 21 04 41     ds r1,r25,r1
>>      4121e000:   0b bd 07 1d     add,c ret1,ret1,ret1
>
> but my parisc knowledge is not good enough to even guess at what could g=
o wrong.
>
> And I have no actual reason to believe this has *anything* to do with
> an itlb miss, except for that whole "exact placement seems to matter,
> and it crosses a page boundary" detail.

Well, you were on the right track :-)

Guenters kernel from
http://server.roeck-us.net/qemu/parisc64-6.10.3/
boots nicely on my physical C3700 machine, but crashes with Qemu.

So, it's not some bug in the kernel ITLB miss handler or other
Linux kernel code.

Instead it's a Qemu bug, which gets triggered by the page
boundary crossing of:
    41218ffc:   0b 21 04 41     ds r1,r25,r1
    41219000:   0b bd 07 1d     add,c ret1,ret1,ret1

During the ITLB miss, the carry bits and the PSW-V-bit
(from the divide step) are saved in the IPSW register and restored
upon irq return.

During packaging the bits there is a qemu coding bug, where we missed
to handle the PSW-V-bit as 32-bit value even on a 64-bit CPU.
The (copy&pasted) patch below fixes the crash for me.

Helge

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index b79ddd8184..d4b1a3cd5a 100644
=2D-- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -53,7 +53,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
      }

      psw |=3D env->psw_n * PSW_N;
-    psw |=3D (env->psw_v < 0) * PSW_V;
+    psw |=3D ((env->psw_v >> 31) & 1) * PSW_V;
      psw |=3D env->psw | env->psw_xb;

      return psw;


