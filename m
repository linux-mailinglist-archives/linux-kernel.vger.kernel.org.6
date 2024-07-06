Return-Path: <linux-kernel+bounces-243090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E53792917C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E7AB2212F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9B1CD00;
	Sat,  6 Jul 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NBzdTE48"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD631A29A;
	Sat,  6 Jul 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720250748; cv=none; b=a6RqSv3dVnwdixrmkAckA4MIL1CUxpcel8P9Tv1vYoBVV3+oe1IAzl7atoYpMxBgYdj3Pj7x36ghHgGc11l7dEDHw8zaZhY5LcVx3YmtDDyMR1bfHU3bbVppJgzRbSFry3/kuMDYbKFPy9K2i3fAMTewC4PODi1jBIxZVKgGzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720250748; c=relaxed/simple;
	bh=enV4Pmz9JYqoPxrbZ7WoUiNHOT9xZDkPD53ffPmZ6ec=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DcjEAkuCSeoCzvl2coSDw5Pa9jxF7xotvnBUZQ8HJtEh+yQlyhlgO2yNZr0tzfHJL3DNBuxeYngVeKLw2mzRfPR9zEOUQon1/b780yYlhMJIJG/QbMb6sHcQCTaFXXuKH5eZyw9YScZny5hkqt1aIK7833bepxBWdCSygstGGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NBzdTE48; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720250738; x=1720855538; i=markus.elfring@web.de;
	bh=IZviilEXqtAESXHA45V3MqR+qjy8V7xE6K2KvJiIJuU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NBzdTE48zB75GH1cIbjj8DhKztJazc02uYPVYk0aZnvCwXP3esDYJdtjl9d1vUJo
	 ht0QnqJ9lkMjiWUla+zQzpewKTo+CF0mTz54mjLSKLqZ6Ag7Jg385aD566MkpEkBe
	 2mGf6LrxBScpnukxZ6a7NwbSjC/8VpvGCeSIuLFKIChAqzjH4VeW9GfpMKMu5CnYE
	 JJc79/xIuov/UgYBAxEk2IS59XcbOcYU1w8UvsDO7D6SYQU0RSfzYhCexmqoe4l8c
	 JKd30OfoBiM99gfZgbj5ruh29PiiS+IHp6fEz+Y5PeTmOFvFdWSpNxu+xWmYpFmLi
	 ejSbYzMnrZ6zDLI1eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1sBD3f2JyN-0149MY; Sat, 06
 Jul 2024 09:20:04 +0200
Message-ID: <90779f58-9fe3-4d64-a449-f08f5eef7369@web.de>
Date: Sat, 6 Jul 2024 09:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick Terrell <terrelln@fb.com>
References: <20240706045641.631961-4-senozhatsky@chromium.org>
Subject: Re: [PATCH v5 03/23] lib: zstd: fix null-deref in
 ZSTD_createCDict_advanced2()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240706045641.631961-4-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Km/vDPiXp2BPvMcRE46bACQq+CFLlZKgrDCpRquZORNjwnw3hZM
 grTaNSXbwKURJzJL14MKYZWLRUKVaPLNV86E8bNMJ77ObiQpDuT8jUoJDdAFRLmgbQLIJVH
 bZ0ToYgXzBHPZW657yxkYj5B4TVlCdLf77EMg5/j3R85tpZaVgyP/n1wAjanBPapGIfNvDT
 7by/OuVlqbeEG+Z6Xk/fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UXwnxxGvBaA=;P1NogJ1YKVOgnzjl88/twQDNnL/
 +KxAV2UIWohZ9dWi2J2+peWpES4w+FatxhLgrtnB9vSbvjnj2UdAvY5oyEThbIut6AdirhP48
 3QEvtISsaCLloAm/m6Tk8KfLgUikuvIk3RofeC1gg5KSnZUfftJEL3eQ4outl8mxcdjdHKZ5L
 7IUsQYnVzMozvd8rswgWT0R12Pe0VVL1Wb+LWnom4Lmm+2NUN3hnCviYv0Q/hrp5LCgAHDOOE
 d4rjeoSNmGqCjUMx3Naq7dabdPg2Cog5f30ctfoVBFV4WqURVBEqMmZVR0ATygqjieM0CbcYD
 31kc/xriKTZ/ppfgcqECZfodkVxGmao3ZG6qh23CLtIDVEEBACcc3YSTQRA8jyjI37SCzuylp
 5io0fhZQoRarTW1byeeAp92Hmm4Uu751ffi5JxwN2A0R+QuYBkA+Kr+AD7U0PIsn5+HC/bBm4
 o1HAF5PKzaUTgUJrv9rDSxwonIfkYXqbaFHpnzTCB4VYM2zVJCLqQl1zmvvmj2z2pVsfDiATJ
 UQGNruVMjBBE+TbeYRQx5I3+Iv1NnBqi1J6BJzDDdIHqgmG7ltKxoJe0/7sTwhtUNgKzSTYm7
 yATlpuMvYujW0xBBjLzNrmlOkV0MSnb/zzsdXUDjMju6hTPCiZquESiX5g7mc8iIkyJCGlDKG
 eZYeqTriMSwJ2a2uqGn/h3XEHspqLFAVSevm0oiGEA3Y/GYz/JQJsGYOqMtPxwllWBxI5xNUl
 wtGEylw/rFAf4RGFnIXvot+FQz19y3SVas8S3LOINv44+e+du0criJCoupgm7mLUmnijHBz9P
 4scvCF4ikuks4g3ZP1b9QFLD4aflD+yxsXa2OKToQYfuM=

> ZSTD_createCDict_advanced2() must ensure that
> ZSTD_createCDict_advanced_internal() has successfully
> allocated cdict.  customMalloc() may be called under
> low memory condition and may be unable to allocate
> workspace for cdict.

* Please improve such a change description with imperative wordings.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94

* Would you like to use the term =E2=80=9Cnull pointer dereference=E2=80=
=9D (in the summary phrase)?


Regards,
Markus

