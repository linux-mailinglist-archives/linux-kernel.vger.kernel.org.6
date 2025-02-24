Return-Path: <linux-kernel+bounces-529703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71385A42A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC7417ACEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B6264FB0;
	Mon, 24 Feb 2025 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjV8/oTM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D61264FBB;
	Mon, 24 Feb 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418513; cv=none; b=NLJVcAQr/s8D6mKsWXME8PYueEz5Uep0DQ1Ccaxt6lmUHNC5SDSOwjiU99ZhtlCXJaoHri2W3JUa2MWoBFi2aidqXDUsus0+JS0ZKwzUNYF6aDUN0SpQGxdusOD9PBhrt+N9E1GmRaw4GFwjA5OcOVpeyGZXQgLxTbRWBeiGDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418513; c=relaxed/simple;
	bh=7BpnJlKXV4oOIFthAX5G/EP8mXIMBtpkyr/ME1iFYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP8S2qurkqAbvDCPM6nQYKwHpgpk73ss9+d2yq4JAJsxjncebvyk8g+axHDJr4B8If3Q8/F0Y3qs84b8ZUC5kcZoMpjVT9hLSFF4iApxvQXtrynkE52D0eZQSKbzEWBw2EG4Sr0FMmXGg2yHUNib5dBpcua6AuF9yrsn+QmlSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjV8/oTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CAFC4CED6;
	Mon, 24 Feb 2025 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740418512;
	bh=7BpnJlKXV4oOIFthAX5G/EP8mXIMBtpkyr/ME1iFYgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjV8/oTMaCzcrzFkD1o/RYCGAqz9fsdIfse+sngs8/DWwH4h3/fWkukPjBD7xgws2
	 41skETsxIOKiqpnZl210JKMqvEfMNkquLvD2QBTF4fwjX31mMP1WCDIH+ly14zlS62
	 vo24YZZCTCan8RJFokb4JS4nOsR9TXD/QCB+ib/kRVtXA3qGFBBfQ5dQsmrMhvKOMY
	 BjofZXZMYYZBGnVzqDsKPDyMaOxisxa5Zz/Gbiqnv2asvrEnIoYvMYWOobfYwfU5U6
	 TPTjVu3d4CldxmrDIH+68Jd+nBvjrk1km5NfZQ1Bcykp+zeDBv0ECKvLiZ/uk5gSjt
	 mBs57JSN1cSew==
Date: Mon, 24 Feb 2025 11:35:10 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: dsp: fsl,dsp: document
 'access-controllers' property
Message-ID: <174041850878.3566701.4991435952633058623.robh@kernel.org>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-3-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221191909.31874-3-laurentiumihalcea111@gmail.com>


On Fri, 21 Feb 2025 14:19:06 -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Some DSP instances may have their access to certain peripherals
> conditioned by a bus access controller such as the one from the
> AIPSTZ bridge.
> 
> Add the optional 'access-controllers' property, which may be used
> in such cases.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


