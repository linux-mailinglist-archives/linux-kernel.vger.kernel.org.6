Return-Path: <linux-kernel+bounces-367618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412049A0483
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E121F2205B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969E1FCC78;
	Wed, 16 Oct 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HEENpf4S"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9861D1E75;
	Wed, 16 Oct 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068203; cv=none; b=Xc1e8hOB+rrdf4medzlp/4G+7U9U7u/rsRhh2zhJy9j0BVkVSxot2sgJHvwQ0J8YqlSi7VskOnvj8liFyjOfCzdPLFWkFVxRg05H2VX9jXEDxW3NGyi2My9CJ4zGj9+ERw8LG8LzLyV+jEWiicptmM4LAS5Z7Q4agqxempEe6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068203; c=relaxed/simple;
	bh=jzDEQX0G4aFdYBgBD8Q9TVHHCXcVx8mUrzPKx46F6UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQJh3X409kw3Niac1HAEn9NP5WO1RQ5r9UnhtZj4c9zDQajU+IutzhPj6ro6snSwf/Fc5M7uKhlWC68EBZTvMGEf6WtWtR9qcPgdjF/S0Zfa3Nvqjx1ZIvwaxqEsEORsdyyPKOtnddCm1RFMDiWMB11SHWpGk1Y5x+0JU1iSeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HEENpf4S; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8cxRSQIWKMfv15uvq9UbQkjHI3xRuImVJscKgphQC98=;
	b=HEENpf4SpRrJHEpj+Zhrj5da5JQGEtelKCSUETcT4e+UMtQHKtjxglAJR5KAtE
	Pe21yv2hrClsDEA0YxjmNWki3ftRr7btgi6oQfSqXH/NEjfxzd7IwULySUsI73E/
	SIZfv7lzF3MTh0I8Umvm8/TH0HPZ4D5zgZ+uTYa8bdZxw=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCXH7OBfA9n8OQZAA--.452S3;
	Wed, 16 Oct 2024 16:42:43 +0800 (CST)
Date: Wed, 16 Oct 2024 16:42:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, aisheng.dong@nxp.com, Frank.Li@nxp.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8: Fix lvds0 device tree
Message-ID: <Zw98gEMgXbx8lIjr@dragon>
References: <20240917065801.2579750-1-diogompaissilva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917065801.2579750-1-diogompaissilva@gmail.com>
X-CM-TRANSID:M88vCgCXH7OBfA9n8OQZAA--.452S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsPfHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxB6ZWcPLTjrhwAAsV

On Tue, Sep 17, 2024 at 08:58:01AM +0200, Diogo Silva wrote:
> Some clock output names on lvds0 device tree were duplicated from mipi1,
> which caused an -EEXIST when registering these clocks during probe.
> 
> Fixes: 0fba24b3b956 ("arm64: dts: imx8: add basic lvds0 and lvds1 subsystem")
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

Applied, thanks!


