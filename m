Return-Path: <linux-kernel+bounces-246111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7792BDF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F728B2D365
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352519DF61;
	Tue,  9 Jul 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AzZ4p/1U"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113319DF62;
	Tue,  9 Jul 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537260; cv=none; b=ewPBnwHIV73Czmp8KaJw4T+2B8UH/gselctcjBDy/2YOIFrLfjE+lQOo7WBiFzHSbOsAH9/sGj2GbmXfg44io5h9C5MPnB7Wy9gQ5glKxiK5/myX8nPB4ykjS+10lv0253M4Rr1hBfhPJTQHps2ofu097ZCBFE1MozFEJ9AVfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537260; c=relaxed/simple;
	bh=D/wJbIM+lRhAXcdp1BawofJZHyy7Gni6K6sYqGtwPnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7xZY7Nm7ViKgJIWkLRmIBS4/Wo3nJrbegtnwCdziyp/YFXelUAkkh1eQAaTzL3+cA4ZZ87jKTzreb+1j+otNHltnu32eYlo6UpIRJHKwGeMGQ+0A2W6yvNezhYjARUF1kEXEHUHgN4jP7D51y7Adj4Xd1s1T4HWZ0VLn4i39EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AzZ4p/1U; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C46D7885A5;
	Tue,  9 Jul 2024 17:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720537257;
	bh=drnLt1b1BmTFLCLihLElO36n1bFhH7KTbcwXYuUra4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AzZ4p/1UriwwwQz6i5ha/gIYsThJk8EAZl1hYrRahDLWWeMNwFom64hSOevZAa6w5
	 ylnMGCw6SX+/6Opd4jjtceI/HKg/ke05ahV23OylQDb8Ow04aYwiXCQeJeUOWHFHqI
	 20BtFFctc5S0OAUwo3maMdwItjhRFYQNyOC9pMgftNdii8Qy5f/g7QOrF1GiPCtM8U
	 /JrP+jdjNQadsuLGk9Nhpr1FJkjwBLehYZUJ2zmOSGTLOO6hLFR94MzKNISbPexyUd
	 Z95NedLf+n+KNrHargWVDdOZgHybQ8Sg+NfD2zFuziAtWsqj+VTTNtP+6QvI9U/CW0
	 thzM3Eq0uk4Kw==
Message-ID: <223b287f-4da6-4ec1-be7c-6135215c5551@denx.de>
Date: Tue, 9 Jul 2024 17:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ti,sn65dsi83: add
 burst-mode-disabled
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
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
 <944ecc41-9ef7-4d9e-9d96-3c5c0cdb71b5@denx.de>
 <CAK+owoiQY8OYiZofyq4jj2S3Mg6ub88DF5V52JcppxhWbUsWgg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAK+owoiQY8OYiZofyq4jj2S3Mg6ub88DF5V52JcppxhWbUsWgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/9/24 4:44 PM, Stefano Radaelli wrote:
> Hi Marek,

Hi,

> Actually this property is specific also to DSI8x bridge, as you can see
> from the screenshot below taken from official datasheet:
> 
> [image: image.png]
> 
> And it's the sn65dsi8x driver that tells MIPI driver which flags to use
> during attachment.

There are other bridges and panels which support both DSI burst and 
sync-pulse/sync-events modes, so a property which selects the mode is 
generic, not specific to this particular bridge . The bridge driver 
could parse such generic property, although it would be better if the 
core code parsed it instead.

> So, for example, this bridge can work also for MIPI interfaces which don't
> support burst-mode.
> Also, as a value-added benefit, I found non-burst mode better for some
> 1920x1200 LVDS panels I'm testing (Of course with more energy consumption).
> That's why I though it could be useful have this option, since SN65DSI8x
> supports both modes.

Can you share which panel model this is ?

