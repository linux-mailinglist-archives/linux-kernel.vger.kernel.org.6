Return-Path: <linux-kernel+bounces-278376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98A294AF72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916161F22A98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316513F012;
	Wed,  7 Aug 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="ihtZZKD4"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56858558B6;
	Wed,  7 Aug 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054478; cv=none; b=UZ4GTb81G7W3lghoMU1swiIeuIcA0VPEvVaFLKdazCcYvNf7xgPoJP4PeBu6vYfKhSkFlFzWFv/6x+Duv22qvLyUWnjniVcR5rXr54gFmP3oNG68QmT2H3aUaFodpRiW5J4YuJ95Qle1j7bLx5KDdhUTuPUgkN9Mta/ugCTHrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054478; c=relaxed/simple;
	bh=xYd/yJ46aF0NP74DrO2K7LXccRJQjOKUym6o/ViLWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHYRWSuSjdGwr7tnehLc4wV5oQGSA5wC547WHrdWOGoM25MibFY2WHuZMbAF4gqVvvpyuy4IrdCQn+Zfu4jqvRbmzLLJFi7+FXSvLHn3Is0ecX1Ow6Rsk4pGt647oZFxeBl/zKqNEsx+OxYdCD4H/ZZEwSfcw4scxLaYO5Et+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=ihtZZKD4; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
Date: Wed, 7 Aug 2024 21:14:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1723054466; bh=xYd/yJ46aF0NP74DrO2K7LXccRJQjOKUym6o/ViLWJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ihtZZKD4Cuq6t9k8LK9hQLx5XJHBmIRsHUeOjrehazwZyjJ1MEiCC294wG9Gfaouy
	 2qJFXPAw5Ye3H39W9mf+87MmaQASbzTjci9EjxGzxhewP34/TVuwk8Dehr1x32846H
	 q10h4xM3Pq+PEaJzbUhI7N7qHQNfKFEVhacvDPgY=
From: Florian Klink <flokli@flokli.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Kever Yang <kever.yang@rock-chips.com>, Muhammed Efe Cetin <efectn@protonmail.com>, 
	FUKAUMI Naoki <naoki@radxa.com>, =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi
 on orangepi-5-plus
Message-ID: <krvprzy3iz5b7n37eo2mb6sol6pcjkxsjdbdi6sxeebwveqtnr@e52cvrlkdjsa>
References: <20240807162001.1737829-1-flokli@flokli.de>
 <20240807170030.1747381-1-flokli@flokli.de>
 <a10e70e2d67b9d63f2296b36b4cb3719@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a10e70e2d67b9d63f2296b36b4cb3719@manjaro.org>

On Wed, Aug 07, 2024 at 07:24:27PM GMT, Dragan Simic wrote:
>On 2024-08-07 19:00, Florian Klink wrote:
>>This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
>>rfkill node for M.2 Key E WiFi on rock-5b").
>>
>>On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
>>enable signal inside the M.2 Key E slot.
>>
>>The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
>>rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
>>node referencing RK_PC4 on &gpio0.
>>
>>Signed-off-by: Florian Klink <flokli@flokli.de>
>>Tested-by: Florian Klink <flokli@flokli.de>
>
>I forgot to mention that providing a Tested-by tag is redundant when
>there's already a Signed-off-by tag, because the latter already implies
>the former.

This came after I sent the v3. Generally I wish people would test things
- though too often it's not. I explicitly tested this to work (with a
wifi module added to that slot being unblock-able afterwards), and
wanted to point that out, thus adding the Tested-by.

DCO 1.1 doesn't say anything about Tested-by, it's mostly legalese about
being allowed to send out the patch, and understanding the consequences
regarding licensing. It doesn't require the person adding their
Signed-Off-By to have tested it.

Florian

