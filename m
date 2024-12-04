Return-Path: <linux-kernel+bounces-430934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7FD9E376B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F32AB2D9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756361AF0A7;
	Wed,  4 Dec 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ChbWaFvN"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFA1AB528;
	Wed,  4 Dec 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307704; cv=none; b=mKAskBSVd6Kr5kJh2GdmzMnO8G4lkdXgLEpCk0jRRkBeKqgirlPG5JQ/WxgloffbTwqzBrmdmeHtMcmsuxy/U2riMAjQyOobc2s7SHNxnSGwPBBkPGbTBM3DyESjjGAFCRgLolErwQ1/xWvbwONCrQ6tkqxbDiVG7JwLnaL8XAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307704; c=relaxed/simple;
	bh=oCF4F6g4HETPFEI1bzhzEo0O0nQ0nCkNsbcFVdrgYHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+fGheRqRISx9+plmcKCSAe/ydT7eR4R55v/VTFMa+0nwig5Wop81jwNaPbjfitaT6RKG7L+MTVe48FufSaoeHwRiJr6iMBtIxWc1cRvXlCQpRlIBw0woLwM1kf5onRyfxRm4koEbUgRgiHRRl5rnjAR8RLkwGSkSDscEi3xwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ChbWaFvN; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA09E6000B;
	Wed,  4 Dec 2024 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733307700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avT8sCPNh7sFRj+FBqxStI57oHP5ZUEtBKxa7gJHFZw=;
	b=ChbWaFvNQ1XrD7sl6Uf+fcuNS/6xV+IJMdTHXnbtTVh2nMUCA5yN9w5FZ5WbtI9WORhE3v
	/mFgbhFLH6z0A3woWTbnR2dt4eu1Uc9Q8MPZdDvn18vVBMf41vg+UR0BXOqQJdWgX7y4Y4
	rCzseGALJEIX2IrzGL04PnAxF9uY6JE1Wf2GMLrWPE08jjmecFZlqxHcHtZJf/XRd+9fI+
	GL8LW9sWmZqomuWVaQyzjMHB0ADihQrZMts4QiK3F8b0mJqFk+2KfAmz+JK8usMG5OyWxZ
	lvKmD1vt/3Z8HtHMPp3LpifIdvpxw/bfbqkNXvGCR1p3qGVzafD6G/UKeEYwyw==
Message-ID: <e405b65e-e9b7-451b-9b40-64d5d9cafa98@bootlin.com>
Date: Wed, 4 Dec 2024 11:21:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: use ti,j7200-padconf
 compatible
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-kumar1@ti.com, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com,
 richard.genoud@bootlin.com
References: <20241113-j784s4-s2r-pinctrl-v1-1-19aeb62739bc@bootlin.com>
 <20241119190106.GA70080@francesco-nb>
 <6e47e420-84c4-4539-ba54-5e1e939a37a5@bootlin.com>
 <Z1An9_auC3dRyPln@gaggiata.pivistrello.it>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <Z1An9_auC3dRyPln@gaggiata.pivistrello.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 12/4/24 10:59, Francesco Dolcini wrote:
> Hello Thomas,
> thanks for the update.
> 
> On Wed, Dec 04, 2024 at 10:08:43AM +0100, Thomas Richard wrote:
>> On 11/19/24 20:01, Francesco Dolcini wrote:
>>> Hello Thomas and TI folks,
>>>
>>> On Wed, Nov 13, 2024 at 11:43:05AM +0100, Thomas Richard wrote:
>>>> Like on j7200, pinctrl contexts shall be saved and restored during
>>>> suspend-to-ram.
>>>>
>>>> So use ti,j7200-padconf compatible.
>>>>
>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>> ---
>>>> Use ti,j7200-padconf compatible to save and restore pinctrl contexts during
>>>> suspend-to-ram.
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  6 +++---
>>>>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 12 ++++++------
>>>
>>> Do j784s4 supports any kind of low power mode and/or suspend to ram? My
>>> understanding was that this was not supported, but maybe there is some
>>> details that was lost when I was told this information.
>>
>> We are working on suspend-to-ram support for j7200 and j784s4.
>> During suspend-to-ram the SoC is fully powered-off (thanks to the PMIC
>> which powers off all the power rails except the DDR which is in
>> self-refresh), like on j7200.
>> Please let me know if you want more details.
> 
> ok, that's quite different from the common suspend-to-ram we use to have
> implemented on other SoC. You would have some boot firmware (likely U-Boot)
> code executing during resume, taking some different code path, in a similar way
> to what it is being done for the partial-io support on am62p. It's going to be
> more similar to hibernation from some point of view.

If you want more details you can have a look to this presentation [1]
(from my colleague Gregory CLEMENT).

[1] https://www.youtube.com/watch?v=sN4krurp8bM

> 
> Do you expect to have this feature nicely integrated within the standard
> suspend/resume "framework" in Linux?

Yes.

Regards,

Thomas

