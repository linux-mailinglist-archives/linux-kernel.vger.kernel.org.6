Return-Path: <linux-kernel+bounces-527671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E29A40E0D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8153AB41D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8D204C0E;
	Sun, 23 Feb 2025 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtyaSA7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8751FC3;
	Sun, 23 Feb 2025 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306432; cv=none; b=qyWt5jlXpNc2bQv7pRwFzoev5PArunp3hLKCAXACQw0CsjMQsZSZGcgVa9/T0U+fZm6qOEfibjNZulKBVMCyeSKh4Q84/IN3iZoyrzl94jG2sXtb5uQIA6k6aOBOsHvk53A86cHSQAZxKP+EDG1f/WSzSsP5o+8AjbwbboNG15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306432; c=relaxed/simple;
	bh=M/NiBlLZB/96+Sf8fu4U8io2VkaRX38UaB7BPciHyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0kDMN1Q31bR/Z4r1qJXC94tWiu4onsSWD8JT+jSWA7x1ay927ZANddN17BAgBiSCYgMh4jMF14jEUxTN7K+XNoJCEhfaJOagVbZ1uBXqcfwncCDyIPc7qv2HIVy6OgkY1ux3gBgiAHbypkaklFUquDy2GW905wYtxG+X8mToMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtyaSA7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8045C4CEDD;
	Sun, 23 Feb 2025 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740306431;
	bh=M/NiBlLZB/96+Sf8fu4U8io2VkaRX38UaB7BPciHyp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtyaSA7kyxslpOuXl8UvM2sb2GrvXcbFGIl9j9QxEoZ5Z5D7Ez41+9sDvPtkBfv3F
	 mxpoipHXNZ0b59zuGAWrB+hDRQoO8TCMiOFDJ0TsACaEr/sBZItLpxXSV9/DARCcfc
	 v/e13HWsXGYtGIXM4mEMnCW7k5Cp5Yjek0ibuQh/fLpXa9mticuYQR68l/xvbOqJoV
	 y6HfeeZTLidNA3OQ6v6gXvgBE+rJwXlL7jIC9HygPRCncKY+IsywLcwzkguhSXwoIb
	 /Mn0v2UpQ3ByfHl7WclQ4whC8lWw/j0Ne81LOnNg12cn3pEVw/HJHVGbFe6bL4ATSH
	 Z1KsoNKolO4DQ==
Date: Sun, 23 Feb 2025 11:27:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mm: Add pinctrl config definitions
Message-ID: <20250223-messy-silent-tuatara-68f2e7@krzk-bin>
References: <20250218-pinctrl_defines-v2-0-c554cad0e1d2@gocontroll.com>
 <20250218-pinctrl_defines-v2-1-c554cad0e1d2@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218-pinctrl_defines-v2-1-c554cad0e1d2@gocontroll.com>

On Tue, Feb 18, 2025 at 09:39:16AM +0100, Maud Spierings wrote:
> Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
> register is written in the dts, these values are not obvious. Add defines
> which describe the fields of this register which can be or-ed together to
> produce readable settings.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>

Why are you adding defines which have no users? This is just dead code.

Best regards,
Krzysztof


