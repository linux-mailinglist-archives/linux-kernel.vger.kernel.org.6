Return-Path: <linux-kernel+bounces-191921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B038D1618
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321301F24D91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25513C80E;
	Tue, 28 May 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xi6QhMkz"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198E17E8F9;
	Tue, 28 May 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884277; cv=none; b=Imeojv1CDUHc/Tnow0FPjry2Iap2bEZouCDnBnBLaOOQeAtPPEhCKCGbIcAf66vRT2A+QxSqZYbBQhLDblPZaOmP7KR0V6ml/smfiCJztPRHqswP6WjRFpqKMTdD0f7p1dl1OKULO04zfU5ULP9u1y+hJ82TFnjFwHpqHNFXqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884277; c=relaxed/simple;
	bh=Zmj+JQNLsA96GI/qhGfukYbCSPLk5XeJ1/7kCCFGV4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2DBvsQut9FS+sz7fSl9bMbroYnCKouBNikgDmaG3+OEJh3feGwXBkN2bzcdijDc9Uhfy8tkeKE0Rr+9TNMlno7CtKpjYer7yQSJDMdrHeARFfFc95n1ZYRL+ghnNDVVaudFRbf+ImjbLbwUuAS7Vg2uVqQUf5MfC+rC59hSRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xi6QhMkz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ptdRbhjrU2YQFZDIdErCpj8jdFAb7IMVbRAa0hSntoU=; b=xi6QhMkzi8MZAlFsG0qMB6gZNm
	zcxFzAM2cfSsbE9P+TkNvq7CG2mdAEnO5Y/+m8EcvAzX7b+Rd0ziS5JekLB8WQhOMwUAqREQwX8Kp
	eUduX/VeNECDR1NerQqUpLmMGGm5WcxvomQxAjSAUZbCDYy9SKLHG5iicwp0gfnOhkjvv94TooJBM
	RFSlKSCszCHbn4/G6YYBq4rj4h/Uy+3bGS5aug9WGkKrkhc3RerMcKUWiPm2vGgejAC/7IYR9e4ti
	m7BCXBpfO1xpI/EMhx2OiKFaNY96Wr8UocUqju/zi4IIb2+ePyxzGdrK6cbVE5o5g5KNQ3zVZ3OdX
	42dJRckA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33574)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBs1e-0004Ri-3D;
	Tue, 28 May 2024 09:17:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBs1f-000375-47; Tue, 28 May 2024 09:17:43 +0100
Date: Tue, 28 May 2024 09:17:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>, Yang Li <yang.lee@linux.alibaba.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] clk: sifive: Do not register clkdevs for PRCI clocks
Message-ID: <ZlWTJvvTSm2hH2ls@shell.armlinux.org.uk>
References: <20240528001432.1200403-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528001432.1200403-1-samuel.holland@sifive.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 05:14:12PM -0700, Samuel Holland wrote:
> These clkdevs were unnecessary, because systems using this driver always
> look up clocks using the devicetree. And as Russell King points out[1],
> since the provided device name was truncated, lookups via clkdev would
> never match.
> 
> Recently, commit 8d532528ff6a ("clkdev: report over-sized strings when
> creating clkdev entries") caused clkdev registration to fail due to the
> truncation, and this now prevents the driver from probing. Fix the
> driver by removing the clkdev registration.
> 
> Link: https://lore.kernel.org/linux-clk/ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk/ [1]
> Fixes: 30b8e27e3b58 ("clk: sifive: add a driver for the SiFive FU540 PRCI IP block")
> Fixes: 8d532528ff6a ("clkdev: report over-sized strings when creating clkdev entries")

This doesn't really fix this commit, since if someone else is doing the
same thing, then they too may also fail to boot, so I'd suggest that
this Fixes tag is removed.

See https://lore.kernel.org/r/E1sBrzn-00E8GK-Ue@rmk-PC.armlinux.org.uk

for a fix that solves the issue introduced by that commit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

