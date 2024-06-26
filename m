Return-Path: <linux-kernel+bounces-230819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32D8918248
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDFB2825FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0799D181BB8;
	Wed, 26 Jun 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjcDgGmP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294217D34D;
	Wed, 26 Jun 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408312; cv=none; b=hZSD4aDuxBc7gj8dto6hhjU5MQHmB4jhYtEoNNcnipxAaabpbTTFMVK/dL9jZAnqap0IIaTdqFQBFZG+Xh55kgqY6Uz5NnlVQbTudJGSJrHIGH0svI5m2igVhsFpbGWSEROZuju7Ib/Ny5iMjCAIqRRG7EVlg3msxURNo6Hkqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408312; c=relaxed/simple;
	bh=Z37XRrmWvVILWMnkjGGDKcM3OK2JNge9DvmvgsYx/vs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WLKiU2W1Hxa9TQ8LHaKG53igk6D7mRyCsFNjgNcJFBQ7uWbXuBzxAChHuwo3tK7BSs837UTArfDJF4Og2xxptO5FnQpj2ULrTrCsWWKK3dMacAKK06jA/LeZAKgUyi9tFzH/BEtYJbghLw91OA1Gx0xUskpbO9NMOUTLLID7+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjcDgGmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D42C32789;
	Wed, 26 Jun 2024 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408311;
	bh=Z37XRrmWvVILWMnkjGGDKcM3OK2JNge9DvmvgsYx/vs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WjcDgGmPDPxeGeVOYqx3XflypyDVyUQ8wwWqn4i5CK2w6bQod3AHMFd6BRvJxJg4P
	 E2vdQuxkw9e7npfhsTClna0ER5pDDv7KGl/O6S0CexOQBEhwJFGdcDaXttsDmyJ+Sb
	 9bDK5Y0k3hi9tY/l6nlF4EmcAEUAGqFRlafKkVk+ksStQYleLe20M1V4LsGrishE1u
	 UvseVSo2ae9Zm5dsBI0hCJOVyIScEHwuKcAqBq4eU2doQSv/RRBUjH7f3k1gpeLqKH
	 ui21FEnDnQb/jteeNC/6sWcHYL47PGqyTsbQUaVD1B45Sw+pKdxafb0KqoKTc779uv
	 gzaTn5YdX3g2A==
Date: Wed, 26 Jun 2024 07:25:10 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: dsimic@manjaro.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, heiko@sntech.de, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240623083413.2051412-1-andyshrk@163.com>
References: <20240623083413.2051412-1-andyshrk@163.com>
Message-Id: <171940790600.2950728.17625531433842246632.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix the i2c address of es8316 on
 Cool Pi 4B


On Sun, 23 Jun 2024 16:34:13 +0800, Andy Yan wrote:
> According to the hardware design, the i2c address of audio codec es8316
> on Cool Pi 4B is 0x10.
> 
> This fix the read/write error like bellow:
> es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x0000000c] -6
> es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x00000003] -6
> es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
> es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
> 
> Fixes: 3f5d336d64d6 ("arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B")
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-coolpi-4b.dtb' for 20240623083413.2051412-1-andyshrk@163.com:

arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts:286.25-300.4: Warning (i2c_bus_reg): /i2c@fec90000/audio-codec@11: I2C bus unit address format error, expected "10"






