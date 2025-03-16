Return-Path: <linux-kernel+bounces-563130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D46A63750
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696C0188E101
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4623191499;
	Sun, 16 Mar 2025 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="YyoHq2+6"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B07485
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742155604; cv=none; b=FejNX7NRl17szva3Wj+VW370+qhDCHpxNiPxCcSZIX+pxRVsrwgZH7HCEfaSN78uOt2SS4lyPEyRPY3D35GhODWIetxtHtbRGmyxQpLfcdAello+unE2nMEWZ7q4tC3E/hVVJrNNXN9MC00Xc+gfvqgqysM0ksxQC9TDbWM0X7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742155604; c=relaxed/simple;
	bh=lp+qKfgxlgHOzgYTq5zbCh56NTXhIwqTfeZc6NclMD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXGve/MvGBqXgOHnCmrDzD6GxJkW6Hf5cY5DDHlLVhV6ULvqFK358BcWV8gn/Bn2uQfU9nv/7Lf6bvMs3+K10zmbyHjm55VEzVtpV//etNJsQVJ+JQfaWbwUb+hKo6/UWWOy/Y7ZDduh6s/8Oq0IhjAKsp+0rEOqWyGVYaXuLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=YyoHq2+6; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742155569; x=1742760369; i=spasswolf@web.de;
	bh=8/Kj3I2BsLN/9FJ15gJzCZJpW8LAFDEU+8nDaf03+30=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YyoHq2+6YhxGfNyiwZrf3vupDobiy1zBJEMoSctxEbdO2XWI+UJZk3qSf9idfw7e
	 WLwRTYOHwx6DWA7EOVRFda4Zhk8Pzd25fIcj+NaMF0RahMMG6NCFGHm2smjKOcZy1
	 +bstnaM5NAiTJSM1sEQPIg8w1P5CELvinf2BiaOqW8aQPQLe95y39v5BGa92P89Ih
	 EbYa71sCaBQl27mU8TdLKSxKvKOUtRA/4pQJimehSnPW0x/jvFDUjJU0IWyLA0wMm
	 maMhyi6mvcO+zxofuOVmGXfB1QAR0yCPAbcNEi/Is4hW69ImV3Toh3wfpBHrYdnMR
	 HsS2/M2I5MR09pAKNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2kU-1u0ToP2Ney-00FgaU; Sun, 16
 Mar 2025 21:06:09 +0100
Message-ID: <6b0c9a4d840757ee54b141ed26f4e81c3e4eaacf.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexdeucher@gmail.com>, Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Sun, 16 Mar 2025 21:06:08 +0100
In-Reply-To: <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
References: <20250310112206.4168-1-spasswolf@web.de>
					 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
					 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
					 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
					 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
					 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
					 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
					 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
					 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
					 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
					 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
					 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
					 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
					 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
					 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
					 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
					 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
					 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
					 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
					 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
	 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2WxrHgAC6bEVnLbwBH6tFrQmLNqoXQheJCWpa4ZuAV8+PHMjCek
 U5iuuKMB7muZ/40tSSLu4wT5kJrA1CJ6B8+bPXU44R3adxIzMDlj+CNNqGzFXN/gxuYyCai
 oHIzEHRhFYSD+wVghIdbkWxW+Aljua5M7AGHp/6pQGCyAg5JEB/izuuIjEWcOPA5333XyET
 cwDLYkks5VtXErG0jBFMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zdDeXVTiWOU=;eetKsx3aJp8UwKkepAWLWHL/jnk
 2iuJ4erMcPlAlVbWuW/tXdMVrkJDSgFUAKmO78CqWk3aBwm7TzWSu3+CDKY4STw1nydTroMYW
 3Zhwzx4jNl1+yAHQ/s7cFhIg+FGXcZCXcG2A0ysN9sbnQpRa7mlThNACJbcyp3WcqJqCsA8kH
 gPojBN0Tov/6Hw4LEFbqrAE7mWn1FkJkDlGjR30RYV1cFJRnic2OULYuixisF7i8wgUO4cSE+
 glCwDlSN7jcI6PeTntMcNl9ONJMiPvNqub4pu7GCCwxuF5xiIEhTC5yvg2NYCTkz+gHvlCZU7
 beSooicxTqhSAXSztQIPSBBLAfbm/Wv8tJWDx18xK+a44Yaa7wkFeYscVxYqLYi4DI4nzaS3E
 raF6ry+qoEiBXaanZJTVDL0MknHY5VwXLdUm5lEHawkHPsXK8A2gKH9G0Q8wBBZF1rpf90+ZG
 mIvb2YBfMG79v3sZl9f/6SjTDuYhNtR3fUaFCV7+LpaU7/GZiAIbLByMy1B7uyz9wl3v/Q7IQ
 +2bNnNlx7nstO7SFRnZQUC2gAegsI8cXJGP92bfcZ8AUe31+3Ziq0Rmo9gROBxjFrsIrCYtY6
 4MOWX6gzesicfNqjfygpdynQVDisBY1WzuIx4U0MqtTWVTnjYdkOD/EoEYubj1uqBzvVqARHi
 0ctVqu3XNdSbaA5vXKVGdVoipLSdraG1o4TBrl4bDQHmxgYHUc2vkogsg61HVybZFI6FbAV/s
 B9mwlAvUWwdbqGkzEYfZKARuhBadl9xkQB0Ydze1HlfRfMkL2+nVzjisoyfSUujV9Ar9YHQ83
 Ei15HSImlmOY2KW3zmu9j5KFV78ZTd/bnry5nJzrjqakkIjgKNRc386/Da34zafYNipsVEcxv
 PF6eMc6gND0Xnqj/JuRtP1SznXO8N6kUoy7e2tES2Y8/RHx9j0YwJSwZYQHehE2bkKgqdGSYg
 esbedYAfbg99NHG+jD7/IzBdDVau6E9vtdSI5/ifeBfHIMaYrUA6QnrssedO5BT4N6lbqjCAR
 wOc8jQIErcYwoJuu04q66qHxj8izplU01t4R9mLn4k+otVVKji+Rf+IT5sJS5NG1DdLHnTCtW
 7Cz7p53v8J1ShBSc57lPhh8r4InZDx5t0KvLWH5aIfvgfj05lZRpcBXFUNWHEDZHVzNrKQuqI
 qfXVutw8e1reoF0fG1DU0F9I7xcLrA9qH39gQdPVHpB2g2TYecHVrBnaF0M/FhsrynAsA4p9j
 Mim8CGsbpZ21y95Ac3vX9UuOpxSM2+qTYVhOD9NG8pXeTGETeHslNORxzpUCWm+YS/JMzffXR
 LWObb1h4I5guAQkXXWFf/+6OpH0LaXIgLfqbnD/ur3rV2ZFDV5dwonrJ+znO+3okX9BI5O4Fs
 FFwTtLbbzoxHuDg2aEa7SgOn6gnbR68D0+wdgre588NyWiVJOME7IHnXhaXJCDfyOZJaQiIfR
 KeH1O4Q==

Am Sonntag, dem 16.03.2025 um 14:09 +0100 schrieb Bert Karwatzki:
> This is related to the admgpu.gttsize. My laptop has the maximum amount=
=C2=A0
> of memory (64G) and usually gttsize is half of main memory size. I just=
=C2=A0
> tested with cmdline=3D"nokaslr amdgpi.gttsize=3D2048" and the problem do=
es=C2=A0
> not occur. So I did some more testing with varying gttsize and got this
> for the built-in GPU
>
> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI=
]
> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
>
> (nokaslr is always enabeld)
> gttssize   input behaviour
>  2048		GOOD
>  2064		GOOD
>  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
>  3072		BAD
>  4096		BAD
>  8192		BAD
> 16384		BAD
>
> As the build-in GPU has ~512 VRAM there seems to be problems when gttsiz=
e >
> 4*VRAM so I tested for the discrete GPU with 8G of VRAM
> gttsize   input behaviour
> 49152		GOOD
> 64000		GOOD
>
> So for the discrete GPU increasing gttsize does no reproduce the bug.
>
> Bert Karwatzki

So I was thinking the reason the bug does not show on the discrete GPU is =
that
it has too much VRAM so the GTT memory is not used in this case.
In order to test this I booted with amdgpu.vramlimit=3D512. Unfortunately
initialisation fails in this case:

[  T291] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init of IP bloc=
k
<gmc_v10_0> failed -22

But using the parameter amdgpu.vramlimit fixes the problem for the built-i=
n GPU,
even when the value is larger than the VRAM of the builtin-GPU (i.e. nokas=
lr
amdgpu.vramlimit=3D4096 does not give the buggy behaviour)

Bert Karwatzki



