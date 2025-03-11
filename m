Return-Path: <linux-kernel+bounces-555408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A232A5B701
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B2D7A4F49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E61E8336;
	Tue, 11 Mar 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bZN/HkxA"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9E01DF25C;
	Tue, 11 Mar 2025 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661854; cv=none; b=TDM3wPcJb0R+oErwGftwGlc2ICQ912O7tiGvXORacpxktbDvO2RX5Ok7yAwCSogetj0NUZluVI3n9a4X7REgfqPg8RFxK6cX25LV0tK2sQDlbzE0XH9ytLZ0TD7baBjFb+2fd6rh8SxQcx5wFI/ln41qQ0x4dzajvPAYY90p+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661854; c=relaxed/simple;
	bh=rwQqyDcDc+bMra20ugcrb8veDxxTFzOfBpewMmM2OsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g49JeEytmYZRR/zMjXPDiFPf2g1dPzXzhFlOHkHxVAa0Kgs55bMMz3gXXMRWfZZxxcne3AqdSxcLT9aPl4KjT+W2VMk4v41AhMvLNWBblrn/DpoqlkIfwOXe85/mZvJ25pzcxS5SHKfGa24JvgKlpjmn0yfwUGhoE8SVCiOjQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bZN/HkxA; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2UT5JWESlIqMK88Qm0fZJYn8VJFoNxpbvjgrdMRXN5E=;
	b=bZN/HkxAw8pLxgZlkQiT5Uevk+4WAvRTFDqPITaWXNqhsjzQM27BtnVpAqTS+O
	tUKdb3R6e3galk+evy/LBZmavjIEHvB6B55Z2DriV8CjulaoOsj2Hy3xklw0zMQJ
	liWMaEFT+JF4XsDbDQ5vF/y3RqtwkOsdXEdJBeTRBDhX4=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCXbUZxps9nP+awAA--.43587S3;
	Tue, 11 Mar 2025 10:56:51 +0800 (CST)
Date: Tue, 11 Mar 2025 10:56:49 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend v3 1/1] arm64: dts: imx93: add ddr edac support
Message-ID: <Z8+mcZw9yjOr3m/y@dragon>
References: <20250225192159.2907320-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225192159.2907320-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgCXbUZxps9nP+awAA--.43587S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVvedUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNROT+GfPpnP3ogAA3l

On Tue, Feb 25, 2025 at 02:21:58PM -0500, Frank Li wrote:
> Add ddr edac support for imx93.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


