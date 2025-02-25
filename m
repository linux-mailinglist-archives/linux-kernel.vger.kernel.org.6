Return-Path: <linux-kernel+bounces-531702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53775A443CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA377AC5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DCB257AD7;
	Tue, 25 Feb 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="VAtgprLN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A221ABBA;
	Tue, 25 Feb 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495584; cv=pass; b=hDje0YXDqbyDDzFnY5oqrEBuOYgqKdlgAihTDe3BbKcCsTmJUZ1tpUXCJuyAstQ6X9CxF+6woeZC5FOaeg02I7CBXn/FF3e9TnpJ4RkPtuoURM6eMpuOI6PS5AOY8OBSi198N/ZdDXQAGpk0t6LTv6TmykMmWzM0hSY+INotlJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495584; c=relaxed/simple;
	bh=aZtAlWRb86fNzZyHG9U/Ch6tls1gOr4OGNqUXGklnQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJkWLmsy1YqYiqIPLkMlYB7EEkf5dilV6PJhJ7A45GZSm2zaJUjI4aYfjwLSIGN8moj864v7W2G7z6T1lRAsgnPTL5ujwp+hOL+HEOdlZeA7pqumlAyPXguk5A6LghMYd09O3KT2+Iw0CIc+dVhgBG5xGjHWxc16Ncwu1djphuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=VAtgprLN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740495509; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mQbs+nNywvchZFCL9JymH2C8Mfwg6UtxLkIBKFfXH+OgT3Er9z92reIXwwZDlCaXzBFGSqFUCB99RUbDPDI/jH3WgyxTy4695bkfa6stVdnU5tJI0DQqp40daOjUrBm7+EtUQ3nTgFTVt+I2k4fZ4NVcdvFExsYLShEv9OZYZV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740495509; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UPm7l3RiX1WuCB7tMXcd8twnqxK37m3RDu2nnogmkfY=; 
	b=Z1XR4CWew3aD4t4Sl2nhyLbmcHwGn6emwSBsGnQO4/8UYJ4FvFwU/i0mQtXSRjC2zqlZvgUcmqM6KxF++fN8GPX/3fB0QueOEHTN8xQy/KcMO9+qDfo/VPaTs6w43L6R8BNnjGZbfA8KpgHrTuH/6H4kZvUtNffCy0svlZDWdkY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740495509;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=UPm7l3RiX1WuCB7tMXcd8twnqxK37m3RDu2nnogmkfY=;
	b=VAtgprLNucRCs34k6jFRYcQYth7SSrgIubTX93w+NZ99KalCH1glGXW/gwR57Tvb
	0xUz4CDDIKPg8yiKI5lCp8PLmGSnz7UYqMxGjLOaAnvcLRKb6TWugknX5lkX+zvm6K8
	yMWQOyM3tOBj57i8GNs9LywGwbqDneKv9XS995cQ=
Received: by mx.zohomail.com with SMTPS id 1740495506960426.84058732469487;
	Tue, 25 Feb 2025 06:58:26 -0800 (PST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, linux-kernel@vger.kernel.org,
 Algea Cao <algea.cao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel@lists.freedesktop.org, Niklas Cassel <cassel@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, kernel@collabora.com,
 David Airlie <airlied@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Chen-Yu Tsai <wens@csie.org>, FUKAUMI Naoki <naoki@radxa.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v7 0/3] Add HDMI audio on the rk3588 SoC
Date: Tue, 25 Feb 2025 09:58:23 -0500
Message-ID: <3337030.aeNJFYEL58@trenzalore>
In-Reply-To: <8734g2sg4t.wl-kuninori.morimoto.gx@renesas.com>
References:
 <20250217215641.372723-1-detlev.casanova@collabora.com>
 <87frk2sumw.wl-kuninori.morimoto.gx@renesas.com>
 <8734g2sg4t.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Morimoto-san,

On Tuesday, 25 February 2025 01:16:50 EST Kuninori Morimoto wrote:
> Hi Detlev, again
> 
> > > Especially those commits:
> > >       ASoC: audio-graph-card2: use __free(device_node) for device node
> > >       ASoC: audio-graph-card: use __free(device_node) for device node
> > >       ASoC: simple-card: use __free(device_node) for device node
> > 
> > I got same report from our test team. I'm now tring to solve it.
> 
> Unfortunately, I can't reproduce the issue on my environment,
> but I guess I found the root cause. Does attached patch can solve
> your issue ?

From what I see, the error is not present anymore on linux 6.14-rc4. I tried 
reverting your patch "ASoC: simple-card-utils.c: add missing dlc->of_node" 
(dabbd325b25edb5cdd99c94391817202dd54b651) and the error reappears.

On 6.14-rc3, any of your patches (dabbd325b25e, or the one you attached here) 
will fix the issue and on 6.14-rc4, there is already a patch that fixes the 
issue.

Also, since dabbd325b25e, the node indeed should be kept while the driver is 
used. So even though the issue reported here is fixed by another patch, both 
are likely needed.

That being said, I'm not sure I completely understand why that extra line fixes 
the issue. Is the __free() attribute smart enough to know that the pointer has 
been copied and not free it at the end of scope ?

> I will officially post the patch to ML, but want to confirm it before it.
> 
> Thank you for your help !!

Thank you for looking into this too :)

Detlev.





