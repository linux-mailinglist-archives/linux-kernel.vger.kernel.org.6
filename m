Return-Path: <linux-kernel+bounces-519710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB575A3A0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411B27A3036
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54FC26B94B;
	Tue, 18 Feb 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJhGCAuo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE526B2A2;
	Tue, 18 Feb 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891785; cv=none; b=iGPTKBgX5j1al6CslZqN8OWa+DuK1SWc8K18IdeDSCCrOzX0orsTiMv8DTsBIBgdKUWAnAkFqjN2OsUccyZPBMQz6PZongzVhyTq9IQE0ACoYCqpFouiAHjTuqrb7XzGhPb3SRwA1PXDYiMQnoe6neFa4qL359YtxN4CN66tKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891785; c=relaxed/simple;
	bh=AceSqE+dN1fqncQf3jSZVkxkI4JsO0+9I/Rm/ds/R/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyFm3HNYpHmzjOgoCoJr3EIze2Hq72Q6brC133Kx6mIfseu+OCMrufSB0sQh/m7C6ybeSrb7GypTwZBzJQDeNfPgti3GZP+hmdl8b3GT1hs8MsG5EyFx6XDaEpjMrIqufmFMLL1jTXB4Hap80pwyReTeaovhhVl0sj8q64l9XFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJhGCAuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0402DC4CEE2;
	Tue, 18 Feb 2025 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891784;
	bh=AceSqE+dN1fqncQf3jSZVkxkI4JsO0+9I/Rm/ds/R/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZJhGCAuoRW4LKYqn1tFbJZJ9GkQKkOn5zHhRmSA66HDExxvLHkOjU0LuQN3lOcj6Z
	 TQ3A4ylu2YsB2dUBDZvJaIVuvdm7o51sLerNLcXoouyDRIZecxq2BIXrVdshNi8DIh
	 gNqL/o/QWzrtMw2vSUWe0ivH3p1AD4MAH7h/BPdhYDKx4Bl/tvxSogkNGpl6jb+c+Z
	 8WdJ9KGKL++lx76jCRK92/EhQAmaXAEWZ+cHNdY1+Zu6H6NaKPGZo5dJ8UK8YfgLx7
	 G++xW2k+1gf5B9NONT5HK/3ILTmpSEqokLW44m3Vmwbjn+omuzGN0mB8Z7GQg0KRpT
	 GCu36+ESNBRBw==
Message-ID: <b2876489-7bd5-4c38-b1f8-2d2fcb5a9aba@kernel.org>
Date: Tue, 18 Feb 2025 09:16:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Adjust all AMD audio drivers to use AMD_NODE
To: Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "open list:AMD NODE DRIVER" <linux-kernel@vger.kernel.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>
References: <20250217231747.1656228-1-superm1@kernel.org>
 <Z7SjI-NIZbMEgz2y@finisterre.sirena.org.uk>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <Z7SjI-NIZbMEgz2y@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/2025 09:11, Mark Brown wrote:
> On Mon, Feb 17, 2025 at 05:17:40PM -0600, Mario Limonciello wrote:
> 
>> The various AMD audio drivers have self contained implementations
>> for SMN router communication that require hardcoding the bridge ID.
> 
>> These implementations also don't prevent race conditions with other
>> drivers performing SMN communication.
> 
>> A new centralized driver AMD_NODE is introduced and all drivers in
>> the kernel should use this instead. Adjust all AMD audio drivers to
>> use it.
>> Mario Limonciello (7):
>>    x86/amd_node: Add a helper for use with `read_poll_timeout`
> 
> What's the thinking for merging this - the SMN driver is in arch/x86 but
> the bulk of the changes are in ASoC?  My first thought is that it's
> mostly ASoC stuff, are the x86 people OK with me picking up the arch
> patch (I'd put it on a branch anyway so if needed we can do a merge
> later)?

Probably need Boris' perspective here.

There are some patches that just landed to tip/tip.git today which I 
believe the first patch needs to rebase on top of.

My thought is maybe:
1) We can get an immutable branch from tip/tip.git with the conflicting 
changes.

2) An Ack from x86 maintainers on the first patch.

3) ASoC merges immutable branch and takes the series through ASoC tree.

