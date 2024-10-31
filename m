Return-Path: <linux-kernel+bounces-390439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5439B79E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ABC1C20BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED219B595;
	Thu, 31 Oct 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M93cdLz9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9319AD73;
	Thu, 31 Oct 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374999; cv=none; b=UeXoV45gcFOwXe2QP6XrKntVuWaWHk/a8LTdJhQOhxlIpeFPB92/aA9QrlcLNJQQi5eez2pRnAw2gxMEE6Ngp5tvrjK6Z44sxPW0oe1X/eclAbalLZXuCKnYXACp6oI9KaIWIMIFvxbszTUXG4gqm5E+Z5TqBwwzQG2RrpINGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374999; c=relaxed/simple;
	bh=RMovIEGpTKgmSrH7hPWEOJRKPhKfHSl2HvWl/56Ae0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxnWJfjRUfd6w9D1G2MAuN7uGtoe5oj6ONKsPtkGdutbnKPLBaUUZSPLjEwNgcf089+d9mBXc+/b0OsA12yDAGTtW2rsRLF9OT+4SBJU3+9qrbWyEznrmfCPrhRS9SgvD2aaSt/OrlACTpB9dRRJ8qQgE9B1/WsE0cPJNw5Rpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M93cdLz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC339C4CED0;
	Thu, 31 Oct 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730374998;
	bh=RMovIEGpTKgmSrH7hPWEOJRKPhKfHSl2HvWl/56Ae0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M93cdLz9+3NrhL8an7HQzBtA/qjMAzQQL1afNnMbp5qfNcNSVUoXORGdc+pBn4xUB
	 oZHm+NL3IxgpKoIAArQuuwJ3TnolMQT+qmn+RRMnaGHxwyC+UH4QBolVXFn3uqWG64
	 lGnt3TM5I+LKYubbu1cZgGv1/ensI+bERysq7BPDXk61ZOApR3x6eEehOTec+KlU+u
	 Fg18mhY6MbgoBdLspraoW9aP6usXWQpK4rV80rFeCTTJ2nhZ527it1uHiiT24B+JB7
	 C/a+rCMxyXZkRXsZfCiw5ofuHtykRICzgVpPM5NKpopFDk1PniRqinJ/w0hLU98YbB
	 Ix7QvJ1NTYuFQ==
Date: Thu, 31 Oct 2024 12:43:13 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Troy Mitchell <troymitchell988@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/2] riscv: spacemit: add i2c support to K1 SoC
Message-ID: <stpzkggfwseaqy6kbppiog4xfbpq4r2jwix2nvredbmmjqzbsi@wkllt4jlingv>
References: <20241028053220.346283-1-TroyMitchell988@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028053220.346283-1-TroyMitchell988@gmail.com>

Hi Tony,

On Mon, Oct 28, 2024 at 01:32:18PM +0800, Troy Mitchell wrote:
> Hi all,
> 
> This patch implements I2C driver for the SpacemiT K1 SoC,
> providing basic support for I2C read/write communication which
> compatible with standard I2C bus specifications.
> 
> In this version, the driver defaults to use fast-speed-mode and
> interrupts for transmission, and does not support DMA, high-speed mode, or FIFO.
> 
> The docs of I2C can be found here, in chapter 16.1 I2C [1]
> 
> Link: https://developer.spacemit.com/documentation?token=Rn9Kw3iFHirAMgkIpTAcV2Arnkf#part5 [1]
> 
> Troy Mitchell (2):
>   dt-bindings: i2c: spacemit: add support for K1 SoC
>   i2c: spacemit: add support for SpacemiT K1 SoC

As Krzysztof has asked, please do provide the changelog, it's
important to track the progress of your series.

Thanks,
Andi

>  .../bindings/i2c/spacemit,k1-i2c.yaml         |  51 ++
>  drivers/i2c/busses/Kconfig                    |  18 +
>  drivers/i2c/busses/Makefile                   |   1 +
>  drivers/i2c/busses/i2c-k1.c                   | 658 ++++++++++++++++++
>  4 files changed, 728 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
>  create mode 100644 drivers/i2c/busses/i2c-k1.c
> 
> -- 
> 2.34.1
> 

