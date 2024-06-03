Return-Path: <linux-kernel+bounces-198514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C848D797E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDABDB211B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E791C2D;
	Mon,  3 Jun 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VVyJN1sg"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B810FA;
	Mon,  3 Jun 2024 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717376895; cv=none; b=ZM0HFxsxmGYRVM6LGsaiVNNKAmCYLRpp73kdAoH3vwyDQ5euQ8sME9ywEM9iQ+jn1+Y5qvz4FnfECRMBLiVLlptNEHbGfsTW5k6hPz6KVUV6YP8X/O4qyS1ttFKa7/vMBctZD/DJUX3q+xIW0qKDa0Xppod3TJH5W/M38P0rems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717376895; c=relaxed/simple;
	bh=AJxGqelg0blaxEfUwaK4bxSO4X7eGYRg9Lopc0VXZiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxd7NmK6hcJfAPaKeu/s10mLeZo9fG8pXZI8/VtdWPkhvZJ+R29YpL8ZkUfTrj4a6vEPyVO1MDzQ7WkWADeXc4eJiHME7LDiOjm6l7yK4MJB4O2rnhqCGH2IJbpHtBpNexMpekeYnoABb0JdJEPA40YWypja8GZB2et+CyqMs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VVyJN1sg; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8k4gT2nqBFGqyZpCaHqPeKXyYM2eTwYAEViYCARACp4=;
	b=VVyJN1sgTyinA5KMAya98HGWpnxuyr3WS284tcF7qj+DWguzyIUYmUGlQj7EuD
	lT/li4MsfaK8GfxkLwiUy5Dh9XQXWvn7iTi1CpVVvLBDLBFMEIWECJN7+OCB+0Jn
	1VHf/9HZc5z4dABzLZ4dV6+knvVq/DrH/tyn94az9O+ss=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrACHT+JiF11mjQ7sBw--.2328S3;
	Mon, 03 Jun 2024 09:07:47 +0800 (CST)
Date: Mon, 3 Jun 2024 09:07:46 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: mba93xxla: Add USB support
Message-ID: <Zl0XYo+Ls25xM/SP@dragon>
References: <20240423093341.1927592-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423093341.1927592-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:C1UQrACHT+JiF11mjQ7sBw--.2328S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIxpnUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQPyZVszXjYKlAAAsH

On Tue, Apr 23, 2024 at 11:33:40AM +0200, Alexander Stein wrote:
> This adds support for both USB host and USB Type-C ports. This includes
> the on-board USB hub.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied both, thanks!


