Return-Path: <linux-kernel+bounces-529993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F2A42D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4352189288F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7C23FC49;
	Mon, 24 Feb 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbzk8jyJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D332054E3;
	Mon, 24 Feb 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427811; cv=none; b=H7aDriO8tq6DJYnmOUN60+yiyZL0F1sDMSUSVoZRl3o9q/UCOqpG7jOebuaK7YS5V0AP28lgo6VGk2gd9m5cWs6wok3jLzOq2TfhkaWjfr5A67L2O7FyehmkqenLf+PXnnRCDyjLVreSRpDTPmSOz1xJ3BQDxwLw9mwOdk/2eQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427811; c=relaxed/simple;
	bh=oMyxUXCNCt5QbA9y/tZas4vEAJMKHD5JIO/9lW44SUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOzQfx8OOrj3IWgrXTNe+s43R8+s4i4S8ZS3mpMnMQWNfSS/7wA9QPD5EiPh/ng9tCaNMlqBRmYcvHMCUkldpxU7cfFz0/beaLASs4A6+SkNJYFgkyl8O/TlDVoWWSc5vejvgW/ThIspAdwDTQdCS+yH9EkAJsaZkak+GfgBqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbzk8jyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAFFC4CED6;
	Mon, 24 Feb 2025 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427810;
	bh=oMyxUXCNCt5QbA9y/tZas4vEAJMKHD5JIO/9lW44SUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sbzk8jyJ0X2AqiIspNONwXAgICaK46vYrAEvI8ULM4VFS5Jc3VelDL/Kxn7Sk+dkv
	 4NHwKBtu08YVyezofQpAQ2wirDnS+/llCLYOtML9P6iQ011S4YvfpEG27A9OK8zcGC
	 F/lStpEFZU6nv2ahrVqTrsL8bw8Wij0YPWkBDj+5CDginuNIdRNSJcPQWf7J5M+k3M
	 LJdznxaoray8yz2g/StcHrwsyJeUOCypO6FOR3F5EpBgcjGiCHcflPyTLDfBTrrHF2
	 8f/G5PHUgK5QG7nyQdUWTEl4AhSWJ3bAEtoVuER/w61oDDL41STFBHaACNg4ZTANHk
	 jtYZtlisSskbQ==
Date: Mon, 24 Feb 2025 14:10:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: festevam@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	lgirdwood@gmail.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
	broonie@kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl,easrc: Reference common DAI
 properties
Message-ID: <174042780757.4022495.9496011863536978047.robh@kernel.org>
References: <20250224090413.727911-1-shengjiu.wang@nxp.com>
 <20250224090413.727911-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224090413.727911-2-shengjiu.wang@nxp.com>


On Mon, 24 Feb 2025 17:04:12 +0800, Shengjiu Wang wrote:
> Reference the dai-common.yaml schema to allow '#sound-dai-cells' and
> "sound-name-prefix' to be used.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,easrc.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


