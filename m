Return-Path: <linux-kernel+bounces-519743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF9A3A150
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CD43A8303
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630FE26BD8F;
	Tue, 18 Feb 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj8B1nl2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3E262811;
	Tue, 18 Feb 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892787; cv=none; b=krhDX+3Ltfvgzj/3wpaXxp6NpV8tgK4Y/aEfEpJ1y9NdX4K1VU76EFR6atjd6cU3u348AplQQjxVOQjlR2PB3gOBmeGJvfYoaUq3cTdlzhlDqHwlv4bWGdESUKYaTszaV4WMrF1uQO0zz7aoIBWvtFVh2nlCC0RxevpeWmdZ5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892787; c=relaxed/simple;
	bh=Ho8At3fudVw1RlzYmxhPINgwfvBXMwUMGOG24duS2eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG2Syq7qms1sq3px/iDpUKix8IjJys+GvAmJkh1DnQXr9tAuOqGNVsU2v6FCPgvBvYQIV3BW8rq3u+FMFAKankc+pt1BEt3yM7YI03MjvYVcr0v7X7tUKFhc7YO+lzr2DaIMkVbM65C9JwtAs5HFigtGRVIebsJlSYngtGQZfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj8B1nl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5549DC4CEE2;
	Tue, 18 Feb 2025 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892787;
	bh=Ho8At3fudVw1RlzYmxhPINgwfvBXMwUMGOG24duS2eQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cj8B1nl2ae5F6ixjV3Oqs+TXJwMdBZs/hHe+wyOszHTfHUeoMarNEssW/URxVFFe+
	 7aSGeJYpl3WZyOmDSpIdP3wgruofkb4uQrNw8e3/mX6fGW4bg7CqJO06tMCKKLI0y9
	 1h9fL7R+Gy8ztSBaxNKGJePFkhzDdxdbo2647FAaZVhfzM9jBGbHxF4IVU75JGUMzh
	 QPMhzDilws0WtHQBYYw9tOlflS5BmXqWjFHuCNEOT+HS7+9vWj529ZK42VUz3QBkNk
	 p0ju/W8L88FXcQWt5XErMNdCBFbT+2s0ceNQHyv19cKBZVk2EGPx5XXuqKFVE/BFfF
	 G4T9UfCGPtiIA==
Message-ID: <f037a5a9-7e5a-4582-9a35-90e8442c6ed6@kernel.org>
Date: Tue, 18 Feb 2025 09:33:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Adjust all AMD audio drivers to use AMD_NODE
To: Borislav Petkov <bp@alien8.de>
Cc: Mark Brown <broonie@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
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
 <b2876489-7bd5-4c38-b1f8-2d2fcb5a9aba@kernel.org>
 <20250218152649.GKZ7SmubM_YWhDqaPo@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250218152649.GKZ7SmubM_YWhDqaPo@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/2025 09:26, Borislav Petkov wrote:
> On Tue, Feb 18, 2025 at 09:16:20AM -0600, Mario Limonciello wrote:
>> My thought is maybe:
>> 1) We can get an immutable branch from tip/tip.git with the conflicting
>> changes.
> 
> I can very easisy do that. Just holler.
> 

Yeah; please get that ready and I'll rebase the series and send out a v2 
on that branch.


