Return-Path: <linux-kernel+bounces-511765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C3A32F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C797A152A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB2261396;
	Wed, 12 Feb 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="UrA4yfGq"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92D2505B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387672; cv=none; b=GIKm9N1jPg0+cnbgzMZvfpYjEWxcySvel4/F0ZupBp5u+oxMF/xmA9tWzWLWFs+/pjWDt8kNh0mApka4hRaW7gRaTSgw+enCQq7w9CJ+Y+PsRBkuY4y9NLwiQ3LZH3qnmt9DjILTl342bpqQG5tshFrmK8TC4F/gvIxlbMuZj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387672; c=relaxed/simple;
	bh=2KCLN0XM7+SRpPadIaOlbXnW53ZWQ5uXr50ipbP9xco=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IxUDVEr41DELtmFT8/G27UN0VNMX7K3l/gGFBuQwnNDdeLRhi7lix+60b8Z/cEtbbv/b6BZtV1fUzCPwqHVBI/dnHJmCqgxIkW24mqdIP900LxOGxvm0Sez10eTjhDBdkwmDtStkLgekO4BMaqcZhCbzAyg0a61v0yQ+u4fb/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=UrA4yfGq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739387662; x=1739992462; i=frank.scheiner@web.de;
	bh=2KCLN0XM7+SRpPadIaOlbXnW53ZWQ5uXr50ipbP9xco=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UrA4yfGqKGQXlVZZ9PVeHkpQAFZrmlRT2qdOJ/jrEoLvPUBngPAv47gy6GDKxb1I
	 xg+O3NmF//0guy27JNCYY9S9LsNZoZhSo+/9DecLWS64gDpjxIwfzuWqorlq7TKqX
	 1E2i77IS8HVQeLxCHOfd/ewpFKjjKtAxfOLBEkClXUv51YK/W++MjpzkSq3YsptLL
	 QNxDEnkT1tZygt0ePZCG5SHwbsGc3qIEYlP1CtPG56wA7uG3QuQZi6FAVxAcQp7Vt
	 GdITiqi5TRtD8XKBd8M0Z/rzq1qrdzMCWviHka3c0BBjBR5GOyDWRtSaMz6bJ4plq
	 KfPk4HCibqAX8drEGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([79.200.223.229]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZjb-1t5wd10aWz-00jYjR; Wed, 12
 Feb 2025 20:14:22 +0100
Message-ID: <cb6f4ece-6c89-4a11-9790-3e917f558e95@web.de>
Date: Wed, 12 Feb 2025 20:14:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?=
 <tglozar@gmail.com>
References: <CAHk-=wiGR6aB2oE7VsDkpnSbHaUnxVqtMvcEB0JzdvS-YmT_Lg@mail.gmail.com>
Subject: Re: Linux 6.14-rc2
Content-Language: en-US
From: Frank Scheiner <frank.scheiner@web.de>
In-Reply-To: <CAHk-=wiGR6aB2oE7VsDkpnSbHaUnxVqtMvcEB0JzdvS-YmT_Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S7iO/H7vJ3j9C8QXifoFMCYrH3xt4QLmyc/8eEP8KC7HMpWh/xT
 Ie7K5t1ovesAQJGEIwFVevqLcRtxRNsnQkE3OHAkXUC8PDrIMoXR13859vk0w7E6uU8+MWq
 Enst08YhbA7BMuDH2INM7crKiWUUL5/wuHaM1n8+J7Ma30Dy0tUN2nSUylQ8gzOU37hrc8s
 i/pinnf/0VTICLTlbON3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U323G6u7TQ0=;AmvKD2vmI6FamONi6t0kKpywHXA
 ok0C7Zqr4AICPuZAQB+HyX/RGYK1iBQXbnCabo9Ai1xNpXBl8FzeGe4ZfCtg9LcNOKLP0Tchy
 0o62JvE0WORHVKbSqc/TsDQw963xu5hJsNWLsRLMYWh0xBH0O1XUVUv1f7NSlrH+zlEDUVH7U
 Ebf6U9BL9V/SZibWQIchGDC4tgNu6h6QWhAlNBogMV0cNuqLtEL6jeapPW4DyRM7zuyyOLTuL
 5VFmU21uYT0ESWgfMeCnz3d6bGzx4U2luhpvzrRZiyvZscnWkERPN3aDGjNoGcso8gqilAwzL
 ss3NhvVRSQaPntX4MGX+vOGsxw8vFcD4MrNipp9PelcH7hb9+oUK9att6/UOqHpwIPWCXNVL8
 TYHhoUpcdM0BhudvGSG+PxgGJ4oIxo7z7XfOnCCvhf+dWI6Dpq/ZhwdiOUvivGLlQvszAsa/8
 HXAT/EhQRZDqbsvi1NVJX1Q5rk7DzBiEF311sB7QiSm4S6Om3R549WnTeav9WvWgVNTke224N
 +Pl8M5aqZpcCHQIrnYkNNZXy1yUbq/1Ue7/oQswT8+akeGbMxZ8rXaKLxEspwgHKm45lkTKKT
 /071rezGF84i5aPNVsbxrCwPW1Id9fyE3k/dZDsN56RPRwU2pvZ44gaciUVFiLNMBCcG4tGN5
 m/qDI+uY+8fraehx6yfQwfQyRlYiNZ71H1EkdWjcIz8j+HSheBLW1LrP2xcjmqoiRw4utIo6M
 X3J8uHh8dMiUgGrD0zfxKceV9ro5LqwuBd40EYXBGfo4BbPrXaNztUxHA5+Kk+m7c81Qk5HwW
 bP07F9Hc0lqA3iHrKEOsXA6uSRC6VHwGmdLJQy5kP5Wl6kZFZOQBWKHhVQeN1XOG57Z5Akito
 CstTfmx5+wPXXn8MTh0Yftclz6y5efsWE8zDOHjU3JwVfEDJYeH3Mo87ZwOrb4w+HJf5FaTBg
 vksAry7mCk30KEI4XVdHtXJ2V+c9mVdzjaB0mGI2k7F/vE0yYz1Dyd8M3arvbwPkZ9BczCKTS
 oaaMF5AViBamoQR/7gN1dYSvaj2h2g4rN/k49YFYZchyVk4eH8NGD7m0h36RSgfvjXcsqtjOg
 /99LMaqtzZvQ1XUJfpfRCeggJIvI/sIJepf/J28Q2+mIs4eh3vcp5mne25aU0a0WUGKMKz4/O
 PvRRwTc/AO7+P1rXpEPB5xnQXrZ8xWTHJGMRCyWY9y2kdyBoADMosKCI7nS1bZD6WgXeU1gEr
 FgjwDnQos4vQMjHbJ/CSAo0JT1YXTU732sYoydSKeZhQpynznzT6etxOXaxlVZYYpOVFUuK2c
 mfZXZhLEe/f9Bpi6nbSS6c0XkYp33VOLf8pxv93bhI2EgverF52SO+61TfgmWt2bkv7/vFLFM
 5j3JIUn0FpxQ55jPEFJ8BE4VCq92HeondETyXMQL8g7RcahOs20LjsCh4X

> Anyway, it all looks fine, please give it a try,

Works splendid on ia64. No regressions observed for:

* rx4640
* rx2620
* rx2660
* rx6600
* rx2800 i2
* Ski/hp-sim

...compared to 6.14-rc1 ([1]).

[1]: http://epic-linux.org/#!testing-effort/tested-kernels-table.md#v6.14-rc2

Cheers,
Frank

