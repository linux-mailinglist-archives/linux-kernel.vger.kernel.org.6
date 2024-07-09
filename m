Return-Path: <linux-kernel+bounces-246012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0617E92BCA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EB41F21F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B237F19CCEC;
	Tue,  9 Jul 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="h5sBXcK+"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B1158A37;
	Tue,  9 Jul 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534582; cv=none; b=PGfbpmd+wESoZLoDm5Gqm7SuFNUoK20a00jzmjgRRNzaQzmRaBFcNATSsOVGtKOd8KXfxufmSgPYRLWB2aP7/A5BY9Qnk0kFGrGNGuSvZjDaqScmFxIxIbbg+Hili61/XMbzFp8VcPx0GSU6MqI9V/fxpm/aVtyvKrC0jRtmjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534582; c=relaxed/simple;
	bh=ZhaY/4x3f4ruOAcY8iwU5SlZfxMqNd80J3CoK7mNwY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0U5A/Jkp3RdDmcdZbcbnemJE3vLuJ0G/Wyan1J8zdrQGhB9GKEZYFqrGxm+7jMnqXn/iM69dNBGuW3jQ+8ZAmGvYOHFA1EJM/8HIlPvu8S4julaasHskZ4ia77cM4sG5MTmm14P/8oMMydqJkRYY+WHkIBXpdSnVxSEgsx5k7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=h5sBXcK+; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CFBC3885CF;
	Tue,  9 Jul 2024 16:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720534578;
	bh=j8uH5LAqoGEHnE0i2h70/qLLtUa4idrvgO0Or56fKwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5sBXcK+Co55wCMMwagBGX7JKSszZM7MNPT8jFFyRWLz9842GsMso0IRTgUX+kwIw
	 2Kq/McQRYspT+6Z6QDz4qETUSI3W21jaPNmzSPcIkUTNcOL5Gd2996hid5tpgAsWbE
	 cXjiAmSR0dQqY1oyQgAUCGSR3Vwt6gvk1NUhZqUqWkUELk/C029+lzRf7siOVwIdey
	 QobNnpiRHgQEvwl9D9tUpYm7qcyKNCNlOpOP3LMEc19hcQht1Mq3jOYRjVFJtu1NvU
	 T32nfkhREUUScQepqN6eEgiQ+R6sLcrQaQ65sA72+O2wY8T4+MqrbcliFAkHRQUNDx
	 brugWrEj1LQVA==
Message-ID: <944ecc41-9ef7-4d9e-9d96-3c5c0cdb71b5@denx.de>
Date: Tue, 9 Jul 2024 15:24:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ti,sn65dsi83: add
 burst-mode-disabled
To: Stefano Radaelli <stefano.radaelli21@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 "Noah J . Rosa" <noahj.rosa@gmail.com>, linux-kernel@vger.kernel.org
References: <20240708151857.40538-1-stefano.radaelli21@gmail.com>
 <172045725750.3389992.15451403448241421795.robh@kernel.org>
 <CAK+owohBrewYFpDKjsE5iWC5OQ3p6S_9fwj7DWa1Ux2h8CXcAw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAK+owohBrewYFpDKjsE5iWC5OQ3p6S_9fwj7DWa1Ux2h8CXcAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/9/24 2:45 PM, Stefano Radaelli wrote:
> Hello everyone,

Hi,

> Thank you a lot for your prompt feedbacks.
> I'm really sorry for all the mistakes, it is the first time that I try to
> submit a patch and i thought I followed the guideline but clearly that was
> not the case.
> 
>   @Marek Vasut <marex@denx.de> About your question to why disabling
> burst-mode:
> - I agree with you that Burst Mode is the preferred way to send data. For
> that reason I created the new flag in a way that, if not used in dts, burst
> mode remains active by default.
>    However, I decide to introduced this property because I have noticed that
> some dual-channel panels work better in non-burst mode (even if less
> efficient), and since the sn65dsi84 datasheet allows this setting, I
> thought to give this opportunity to users.
>    What do you think about it?

Are there any further details, which panels behave this way ? Does your 
DSI host generate correct HS clock, ones which the DSI84 expects to 
receive on the DSI side ?

Such link mode properties would have to be generic properties placed in 
some dsi-client.yaml file in any case, such properties are not specific 
to this DSI8x bridge.

