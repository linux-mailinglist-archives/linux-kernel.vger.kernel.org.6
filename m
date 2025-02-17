Return-Path: <linux-kernel+bounces-517356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EC2A37F93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89477A32AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CE81E;
	Mon, 17 Feb 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qCELh/cv"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16703215F75;
	Mon, 17 Feb 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787153; cv=none; b=Vt0NAjJTG1ETA8DD01cCQQufNVnGdTmG6I/+9qL9jrP2uZvf+k9iuhaalIUa7ZqcPXiJn7Bm/+AI2E8nXCVTVzNcoXgnpu+kplaKJ4vCHW+sNf28rG4ugQ1z2AiJrC6xumkLeSiC50fQI7OwzEyO8Ep1fbJyyVcbQzVlh1GYklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787153; c=relaxed/simple;
	bh=Dz/mc4M7A7lcIj44Btvtc/c5kfNMPa3gssZu8LopwoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwDxfZr+l7kmgqPToiBcynv74j4M1ZyAvT7YhPB3i7ihTKNSYmIALOYNCdrBlGNdqvmc27DfxgXU6pBFDSYbO1TW0iiWIPEX6kMnWn0L+fLfBObb8BpyGMzNJ/+W9bCz3DswX/aox7gMvQ3jK2lkAPFc5vk0pD/w5O/Vb/7dUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qCELh/cv; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=FKkPX8SSsZZubXRSv3O7mjjd5d5lK8W3Iit7i4K0x3U=;
	b=qCELh/cvx9nCT6quI4lzHZYumKBpmnKj2xFQCw9dSGHy9efbOzhPpiAbQHnUqx
	Xp1/oOA20xiMTDk6COOjQNUMgfDUx+54jnB7YCT4qZWi7VbVfvryrk4m1KOqhmHK
	1fvAzsweWtsOzRMKtaFZmUO4YUXy8qQWYrpUn1j47Z7lk=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCXW7BcC7NnpRIUCQ--.16375S3;
	Mon, 17 Feb 2025 18:11:42 +0800 (CST)
Date: Mon, 17 Feb 2025 18:11:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andrej Picej <andrej.picej@norik.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v2 13/15] arm64: dts: imx8mm-phycore-som: Add overlay for
 rproc
Message-ID: <Z7MLXJkmcTuq3ZHn@dragon>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
 <20241202072052.2195283-14-andrej.picej@norik.com>
 <Z3Ie8GO/GtoSkIr3@dragon>
 <221c8216-ce71-4ba2-9981-8612ff33ec2a@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221c8216-ce71-4ba2-9981-8612ff33ec2a@norik.com>
X-CM-TRANSID:M88vCgCXW7BcC7NnpRIUCQ--.16375S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryDKw4xZF43ZrWDZry5urg_yoW8uw48pr
	y7uayUKrs2gF4xCrZIqw4DWryqy3W3XF43u34DZr1vgr4avF9FyF409ryfuryjqF4kZw4F
	vF4fZFZF9wn8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFdgAUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwL2ZWey6E2ehQAAsx

On Tue, Dec 31, 2024 at 08:34:32AM +0100, Andrej Picej wrote:
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso
> > > new file mode 100644
> > > index 000000000000..0c61946f0cf8
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso
> > > @@ -0,0 +1,55 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
> > > + * Author: Dominik Haller <d.haller@phytec.de>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +/plugin/;
> > > +
> > > +#include <dt-bindings/clock/imx8mm-clock.h>
> > > +
> > > +&{/} {
> > > +	reserved-memory {
> > > +		#address-cells = <2>;
> > > +		#size-cells = <2>;
> > > +		ranges;
> > 
> > I'm getting this:
> > 
> > arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso:16.3-10: Warning (ranges_format): /fragment@0/__overlay__/reserved-memory:ranges: empty "ranges" property but its #size-cells (2) differs from /fragment@0/__overlay__ (1)
> > arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso:13.18-43.4: Warning (avoid_default_addr_size): /fragment@0/__overlay__/reserved-memory: Relying on default #address-cells value
> > arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso:13.18-43.4: Warning (avoid_default_addr_size): /fragment@0/__overlay__/reserved-memory: Relying on default #size-cells value
> > 
> 
> I see, missed this before, sorry. But I have some problems fixing it.
> I think the problem is that this is overlay, the same node put in the
> imx8mm-phycore-som.dtsi doesn't trigger a warning.
> The only solution that I found is that I specify the default address-cells
> and size-cells in root node:
> 
> 
> &{/} {
> 	#address-cells = <2>;
> 	#size-cells = <2>;
> 
> 	reserved-memory {
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 		ranges;
> 	...
> 	};
> };
> 
> The same values are used in imx8mm.dtsi, but the checker fails to find these
> default values.
> Not sure if this is the right solution, though. Your input would be helpful,
> thanks.

Unless DT folks have better suggestion, I'm fine with this.

Shawn


