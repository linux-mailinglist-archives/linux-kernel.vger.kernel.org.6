Return-Path: <linux-kernel+bounces-271248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A555944B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064D02842DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4B91A070E;
	Thu,  1 Aug 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXP1MsBB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE80198832;
	Thu,  1 Aug 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516235; cv=none; b=YnDvBVfUs6aFue9lMeHFGivGdVN7fS4EqI/JCx/tZ2C6Np3CYeRVvFS4QOoWXGlfWyw5ISbPfITDMAmMtkZLI8Q87qhiTJKrjH3x1V2hAtv5bQ6oPSq2PQoUV3AhH+G2OKOUXwb9QTg1q/PxRgdrE/Tw/1OEHpo+/IfmJEv0kfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516235; c=relaxed/simple;
	bh=6H1MVYMTvoQk5bNEBHe4eza6uBQw9ZId3AXRWvWqoZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLnVh/NltH6fZUzSB96xmoqzTE8AktZcRHuEWwvowjjAyn9q/sgP/219yt/e6TB3jqOBjBgO7CBx6JZ65nd5sH0muPoq6Afl4o+T+cvggzm39jxCxUtGb7apDAVcwmdoVzH8PB0yONf/GtEmlJCVaL2JHAMc3Rg98S9ImPyE4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXP1MsBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797D3C32786;
	Thu,  1 Aug 2024 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722516235;
	bh=6H1MVYMTvoQk5bNEBHe4eza6uBQw9ZId3AXRWvWqoZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXP1MsBBJdvJVIMG8T14ryJlUDWSxyE8pKT6bS4aWlhrJr8Ex74Ff5Nv6UoEA9ER0
	 v+L8Ul8gDdrolEOofEXmjK1A24qqtjLSSOTKQ6m10Tb1K8SvTdEDgolaiSwhjSPHYS
	 EL4FM0F88G6VIHA9KwBXHS5xX7WhmI4I8Dznn/vyHB8PL3RC+e8pQ4D+y61Y3vDDKx
	 d8dK6qX0WDhHjQ5CUv8UvId3ezMiRYmZi/laYpO8bSTHgiwFrt8cU8CimfDdezq2o2
	 hNRvFsv48plAKLgskTwYptqKTZ9cIg8uPM5FIeCV2KZ8/qKjqWSmp92qp6OZx884ZG
	 ag0t4l2SPUoZQ==
Date: Thu, 1 Aug 2024 13:43:50 +0100
From: Lee Jones <lee@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2] dt-bindings: mfd: syscon: Add
 ti,j784s4-acspcie-proxy-ctrl compatible
Message-ID: <20240801124350.GD6756@google.com>
References: <20240729064012.1915674-1-s-vadapalli@ti.com>
 <20240729160453.GA805559-robh@kernel.org>
 <a98b975d-ec8b-432b-9437-aef07240257b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a98b975d-ec8b-432b-9437-aef07240257b@ti.com>

On Mon, 29 Jul 2024, Siddharth Vadapalli wrote:

> On Mon, Jul 29, 2024 at 10:04:53AM -0600, Rob Herring wrote:
> > On Mon, Jul 29, 2024 at 12:10:12PM +0530, Siddharth Vadapalli wrote:
> > > The ACSPCIE_PROXY_CTRL registers within the CTRL_MMR space of TI's J784S4
> > > SoC are used to drive the reference clock to the PCIe Endpoint device via
> > > the PAD IO Buffers. Add the compatible for allowing the PCIe driver to
> > > obtain the regmap for the ACSPCIE_CTRL register within the System
> > > Controller device-tree node in order to enable the PAD IO Buffers.
> > > 
> > > The Technical Reference Manual for J784S4 SoC with details of the
> > > ASCPCIE_CTRL registers is available at:
> > > https://www.ti.com/lit/zip/spruj52
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > > 
> > > Hello,
> > > 
> > > This patch is based on linux-next tagged next-20240729.
> > > v1: https://lore.kernel.org/r/20240715120936.1150314-2-s-vadapalli@ti.com/
> > > Changes since v1:
> > > - Rebased patch on next-20240729.
> > > - Separated this patch from the series.
> > > - Collected Acked-by tag from:
> > >   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >   https://lore.kernel.org/r/04d94188-5e30-4cab-b534-e97c0b2a61f3@kernel.org/
> > > 
> > > NOTE: Though it was mentioned on 25th July 2024 that this patch was applied:
> > > https://lore.kernel.org/r/172190301400.925833.12525656543896105526.b4-ty@kernel.org/
> > > since I did not find the commit in the MFD tree and the Linux-Next tree,
> > > I am reposting this patch.
> > 
> > That's because it was in the middle of the merge window and only fixes 
> > get published during that time. That's now over, so it should get 
> > published soon. However, maintainers get busy on other work or take 
> > vacation, so it could be delayed.
> > 
> > Unless a maintainer updates their tree with other later patches and your 
> > patch is not there, no reason to worry and resend.

Thanks Rob.

> I was under the assumption that a commit ID is mentioned after the patch
> gets applied to the Maintainer's tree and is visible publicly. Thank you
> for clarifying the details regarding the process followed. I will make
> sure to wait long enough before resending any patches in the future.

Pushed now.

-- 
Lee Jones [李琼斯]

