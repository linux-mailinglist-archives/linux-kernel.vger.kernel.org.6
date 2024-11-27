Return-Path: <linux-kernel+bounces-423880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A369DADD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164CEB24B59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D11201277;
	Wed, 27 Nov 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5g2Al6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96D20125A;
	Wed, 27 Nov 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735710; cv=none; b=OiTd0nk19oMgjI7zk9VMMnbrQJ/FT1AzJSR9HFKeYNBUQYB4rx6oPPV780wsRMKdQ83yDVNT1sGXNmEEXg4xkbUwZUl5N6hxWBqG/AdObW7Z0mcTq4Ael304DrVVHCOPFgJcjXL4+2e9BJYFwIi5qPGb1pyrSsTJI2MyTUvjJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735710; c=relaxed/simple;
	bh=pn08VhPU0IzLO+EQ5107DJpr+bUyCyhgulrEENPm+BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+SnNxdzZrkjMOVQSrfe71dsLkor/8YmyMTZgnJTNV/Er0XmsUNEiFiZEF8q7Rs0bk312RupHb9mKDITRQWh/aHnSudE8vrNmvMABp3fg89ZcJtD2JrPWFCejSr87l01NHxHwQ1YuK67pnSna7WVGnZudmQmSgEcNUMhFyoX3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5g2Al6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D27DC4CECC;
	Wed, 27 Nov 2024 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732735709;
	bh=pn08VhPU0IzLO+EQ5107DJpr+bUyCyhgulrEENPm+BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5g2Al6nwZYQXC227GFiXL/B9FPuClhSMF7kBPvHmNNRvXX9uN+rZMY2mzHQWph0E
	 UDU8e6gqY27su5Qkka/Z3QgWkG3D6WuR34V/3wWHioskk951F+1Ax300Hj40lpTqPA
	 bZT8rRu56wJROxd8p5JuI2VR6BAmTw/BuKcqPQ/0S8GMLE8acjRVFpdAB5AxKVlbCj
	 3IdkDp6FqeDLwjV9kgMIDzSLW0FfRrBExIVnT0yikip4n5KAjvR4AQgJM3wFnOxW4J
	 wYZBlBZEuL6hZjw7JAVoAlFiVFg+sY3I+RS70a7XDZD7pCCwkjuAz1jXPLpRNr9TBg
	 pUS93Jlj66hxA==
Date: Wed, 27 Nov 2024 13:28:27 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] of: Add Google Juniper to excluded default cells list
Message-ID: <20241127192827.GA4086536-robh@kernel.org>
References: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org>
 <CAL_JsqL6e28pZ9G55Ab6SJO_xNK1R7D-xReC8girvP9VMUk=2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL6e28pZ9G55Ab6SJO_xNK1R7D-xReC8girvP9VMUk=2Q@mail.gmail.com>

On Mon, Nov 25, 2024 at 09:46:10AM -0600, Rob Herring wrote:
> On Mon, Nov 25, 2024 at 5:32 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > Google Juniper platforms have a very old bootloader which populates
> > /firmware node without proper address/size-cells leading to warnings:
> >
> >   Missing '#address-cells' in /firmware
> >   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0x90/0xf0
> >   Modules linked in:
> >   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
> >   Hardware name: Google juniper sku16 board (DT)
> >   ...
> >   Missing '#size-cells' in /firmware
> >   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:133 of_bus_n_size_cells+0x90/0xf0
> >   Modules linked in:
> >   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
> >   Tainted: [W]=WARN
> >   Hardware name: Google juniper sku16 board (DT)
> >
> > The platform won't receive updated bootloader/firmware so add it to
> > excluded platform list to silence the warning.
> 
> I'm interested to know what needs these in /firmware. /firmware is
> supposed to be for things without an MMIO interface. An alternative
> solution is to add the properties. That doesn't require
> CONFIG_OF_DYNAMIC and is often the approach powerpc uses.

Here's the fixup based approach I had in mind. The main possible issue I 
see is it doesn't run until of_core_init() which happens at driver core 
init. 

static void dup_parent_cells(struct device_node *np, const char *cellname)
{
	struct device_node __free(device_node) *parent = of_get_parent(np);
	struct property *prop;

	if (of_property_present(np, cellname))
		return;

	prop = of_find_property(parent, cellname, NULL);
	if (prop)
		prop = __of_prop_dup(prop, GFP_KERNEL);
	if (!prop)
		return;
	of_add_property(np, prop);
}

/*
 * Some Google Chromebooks have MMIO addresses in firmware nodes and fail to
 * populate /firmware node with #address-cells and #size-cells.
 */
static void fixup_firmware_cells(void)
{
	struct device_node __free(device_node) *np = of_find_node_by_path("/firmware");

	if (!np || !of_property_present(np, "ranges"))
		return;

	dup_parent_cells(np, "#size-cells");
	dup_parent_cells(np, "#address-cells");
}

void of_apply_fixups(void)
{
	fixup_firmware_cells();
}

