Return-Path: <linux-kernel+bounces-232882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC891AF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BC11C21104
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCF19B3CF;
	Thu, 27 Jun 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cuMYuhMz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9743AA8;
	Thu, 27 Jun 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515220; cv=none; b=AOFusGldLX3Rp+hNGZeJk6UmyitVIibNjfkKUUjoHEMcM0E9gVVkoTONh8QRKEy9uhR6Kolgs1MBLkRApqRbWD6vZJPiEjpLhaZ60OczRi2WODHa4zNKigKiX9/5T/wbvm2xqc6VRwR0F8a9So0fjx2u8T2RdHwQDi90cdcLOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515220; c=relaxed/simple;
	bh=O3UAnwLqiXF1HevzG0iNPWunY1PZOIAzI9fMywd+2Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRZev/s9nR3ik9cd4sYQG2IwrF/C8BXpPxGQSDJmFao/eoPS6HCgxsj9wud+EKxa5TqLWxYhWHYIHOVh8FGiMK4ITEDJuzdtvHPiK6vjZtANsxOi4ghHJrMb/qj0Rut6ehVf7orNGmCNodlU0nLreiVmJVMSEtQNFMsTparTOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cuMYuhMz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lCV7ImW4mZ83RIzV4l9OBdCxKN+5Cb89l/YQC0k0wvs=; b=cuMYuhMz895WZVuxV6m14bQL4h
	ofp+tz9PeZjdqGyXaX5xOSm/oKCZ0o/Hlrmluz8/W7j1UTAm3Tvh4ST9PqRvXwM06URWj+4TVehbo
	fjQ1koT2BWpO5n4NGvd2a3ULgFdmGsWJrr5vIVKwJQLg/X4yQN39yAV08LAvKl+NpM2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMuSJ-001CZ3-9T; Thu, 27 Jun 2024 21:06:51 +0200
Date: Thu, 27 Jun 2024 21:06:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO
 addresses to match DH i.MX8MP DHCOM rev.200
Message-ID: <1ae34d3f-a44d-47ab-8bf1-d87366d24fc8@lunn.ch>
References: <20240627005913.326662-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627005913.326662-1-marex@denx.de>

On Thu, Jun 27, 2024 at 02:58:33AM +0200, Marek Vasut wrote:
> The production DH i.MX8MP DHCOM SoM rev.200 uses updated PHY MDIO addresses
> for the Fast ethernet PHYs. Update the base SoM DT to cater for this change.

Where did the original values come from? Did they never work? A
pre-production device? Do we need to be worried about regressions?

It would be good if the commit message explained why this is safe.

   Andrew

