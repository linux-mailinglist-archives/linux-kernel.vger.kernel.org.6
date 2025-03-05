Return-Path: <linux-kernel+bounces-547375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8BA50660
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676367A6295
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E542E250C14;
	Wed,  5 Mar 2025 17:30:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3991151992;
	Wed,  5 Mar 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195801; cv=none; b=HVZtCNfplZjkpnuXyMDe3FioaVZxZSu/JcPnxxMN6GPhxbQu3hVZjS2SoCPOJuoWcbWebiDAKcEuzlFoyBs/eary3ulqDG4/6Y1jVrhepzDlQE1tMrfUh0o1rUfQIb9H5tzUlqj0sEMowehDyLGnxyLLdWu5o2yOtcd1Q3Ow1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195801; c=relaxed/simple;
	bh=QT1Q/bmG89S72y6eL6ERN7cq/WwbniJG65e3HFm1/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBXO6YEWzS/t/fO/2R88/GpllHBN0lKc0HovCDM0EgQlFSQNXKAReIJe5qAVl1KCtXSeKgbxRjyQXPihrcA9rzIvYfmcRisq9bXW3pw4VzbpR6VOd1/4weKwg7jivlqd1c2oa0R+ugEPWog/gZdEEvzdJghCZm4z74v4VXAalOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81087FEC;
	Wed,  5 Mar 2025 09:30:12 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0FF3F66E;
	Wed,  5 Mar 2025 09:29:56 -0800 (PST)
Date: Wed, 5 Mar 2025 17:29:54 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Abel Vesa <abelvesa@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH NOT APPLY v2 4/4] clk: scmi: Support spread spectrum
Message-ID: <Z8iKErarE0lHWxEy@pluto>
References: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com>
 <20250205-clk-ssc-v2-4-fa73083caa92@nxp.com>
 <Z6SqeNsAqbZM8nr1@pluto>
 <20250303041125.GC13236@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303041125.GC13236@nxa18884-linux>

On Mon, Mar 03, 2025 at 12:11:25PM +0800, Peng Fan wrote:
> Hi Cristian,
> 
> On Thu, Feb 06, 2025 at 12:26:32PM +0000, Cristian Marussi wrote:
> >On Wed, Feb 05, 2025 at 05:49:54PM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> Support Spread Spectrum with adding scmi_clk_set_spread_spectrum
> >> 
> >
> >Hi,
> >
> >I forwarded ATG with our latest exchange on the possibility of using a
> >standard OEM type instead of Vendor one if it is general enough....
> 
> Do you have any update?
> 

Yes I think you can go on with your original plan of using vendor OEM
types: as of now we are not gonna standardize a new commmon SCMI type
for Clock-SS, given there is really just one SCMI user of such clock
features...maybe in the future if more users shows up...

Thanks,
Cristian

