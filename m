Return-Path: <linux-kernel+bounces-370859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BF9A32F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2C51F221C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423C1537D7;
	Fri, 18 Oct 2024 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="FWLH4Go5"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F722CA5;
	Fri, 18 Oct 2024 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219418; cv=none; b=LkIz6HEBUyH5WoaYMFMv2mCr0oT0J2qbIj8hRNusYF/9zClP8xeoht4ynJDTAx4RvBreaTymFBdzAGN5Ws/ny1fEtV1xojAM6VrucQzRQTHECr436kMHf9dGTVyB3/HhQsxqung4IxAuX9SpmdRCtZ87x5hCBJjyzqKY4u0i1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219418; c=relaxed/simple;
	bh=gDpTerw8HpqCtWNZwAtMPRgxbLPsqXWZDuimu7QRBy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCOqN+bUDHHl3P87PKqjqoHDzElfX77C5sx/IThFjGEaL5wOu4evhB+sc/jQwoSSjAg5Tso1qs6+9UiW5vt+6CnVHF0a7sPItsYw4MTaDFa6JJcrTUicO6DkMrqZ04sKjGMHf2taKTmNT13rH+eMGbC7LCWwSqOvCM4E3vlK2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=FWLH4Go5; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=6FiyOV1NzqEGFBu6tBoFwS8FcBgdWmn5Api3fwFEEFE=;
	b=FWLH4Go5UMA/bMp7Q7vthQSSzqEdwVqAZNQAUUZNtGKewyEy1tbYmDsL/uWc6g
	gU1yuys3a0RPn1WpRnrl0dtqdo4nLlJD4XGLqDbE7IKUOCf3s9oP1ZBxu+Tq1paM
	V/5ad/lO61DmIjdOgkJH/4cspPD6z1U4cX/cRJAgnAsLU=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnD8IoyxFnCf8_AA--.1970S3;
	Fri, 18 Oct 2024 10:42:50 +0800 (CST)
Date: Fri, 18 Oct 2024 10:42:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] arm64: dts: imx8mp-phyboard-pollux-rdk: update
 gpio-line-names
Message-ID: <ZxHLKP+jXl/sbL16@dragon>
References: <20240927-wip-bhahn-update_gpio_lines-v1-1-49aca212e25a@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-wip-bhahn-update_gpio_lines-v1-1-49aca212e25a@phytec.de>
X-CM-TRANSID:Mc8vCgDnD8IoyxFnCf8_AA--.1970S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBZ8ZWcRVdzy9AAAsy

On Fri, Sep 27, 2024 at 01:34:16PM +0200, Benjamin Hahn wrote:
> Update gpio-line-names. Add missing and remove unused.
> 
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Applied, thanks!


