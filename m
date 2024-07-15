Return-Path: <linux-kernel+bounces-252933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD4B931A06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94E82822A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE027172F;
	Mon, 15 Jul 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yn3ea2oq"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44EE6D1A8;
	Mon, 15 Jul 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067160; cv=none; b=AfP0nKttgEviKFFL1hsDnBbN2K9YxF8e2L+tt7GZzusafasq1OOkt1WCPGI/1T+T9f9SmMv1EpPIopVF9zBQXp7ODkObNF0fDNp5YEg+gyzQ8uPqf39WZ/SizxLS4Z3Mva79cPv5WOJLZq7a/n3JBbJUQk081HHQo3EGlnfe06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067160; c=relaxed/simple;
	bh=Yo7w8oXTIjmMoShqyIG1ILVWKcwhVfG1aLjWyEfKGaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApyMu9bPgP2SS7yE5gJq6fLKMYcJ7QGuRjIl0QEUNiRITMKxG0/OAbxMUQpkAxvonpGSEhhUSMZFrSSzcT/ACbVoaep3N1u/B2D6lHr4FrOgP6elrG3y9kXszt+rA+xd9tb6DxPyzxG33e9MXx5asMIL2JVrklvOLnT+AwiwtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yn3ea2oq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yVTBamQZ6bxGogmwiFCMjbqgu4rJ80p0T1Hs3Yq+QIM=; b=Yn3ea2oqbbpM1+eDyq2D+9Nm6v
	kpUM7RouAPIihF4RauOX1360j8o5L0QfsOhS9+rS0C5PjbF5MFw1iVB5R0m1N2DiUpbdGUd+tk2XW
	aYYcDu/vL9klXGDXv7L8gn02y2Rqy88oItZF76TmeywuycKpvd8rC2LBdhXo3AqBZA0U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sTQBc-002aX2-Ol; Mon, 15 Jul 2024 20:12:32 +0200
Date: Mon, 15 Jul 2024 20:12:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] arm: dts: marvell: armada-38x: add description
 for usb phys
Message-ID: <e35e0edf-f99e-4af7-8abc-c8f96b73ddd5@lunn.ch>
References: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
 <20240715-a38x-utmi-phy-v1-2-d57250f53cf2@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-a38x-utmi-phy-v1-2-d57250f53cf2@solid-run.com>

On Mon, Jul 15, 2024 at 07:47:30PM +0200, Josua Mayer wrote:
> Armada 38x has 3x USB-2.0 utmi phys. They are almost identical to the 2x
> utmi phys on armada 8k.
> 
> Add descriptions for all 3 phy ports.
> 
> Also add a syscon node covering just the usb configuration registers.
> Armada 8K have a syscon node covering configuration registers for
> various functions including pinmux, woith dirvers using syscon framework

woith -> with

> for register access.
> 
> Armada 388 has various drivers directly claiming some of those
> configuration registers. Hence a similar syscon node would compete for
> resources with these drivers.

Do these drivers make exclusive use of these registers? Or are
multiple drivers using the same registers and you need something to
mediate in order to have atomic access?

In the old days, a register space could be mapped into multiple
drivers, so long as all the drivers agreed to it. There are probably
orion5x, kirkwood era mvebu drivers doing this.
 
	Andrew

