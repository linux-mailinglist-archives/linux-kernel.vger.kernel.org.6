Return-Path: <linux-kernel+bounces-373860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545159A5DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB03B22B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00AE1E1321;
	Mon, 21 Oct 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOnCoMlt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318A199933;
	Mon, 21 Oct 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497700; cv=none; b=FUwyKp6ZZwSVXq1XoCD/fj3wK63NHHJvA70IE96zmN0PCPilm37iJez0VKIL+cLEZftWKe6kUHie+F5p0tHnAFJsTbqaOtxyAqsVDUfUI9V8rYjM04Ljl33Pw9SjeF5y+8Fu7/P3XJ5wTLhD+U/dAhCkRK1vVJGc7jMc0QCFTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497700; c=relaxed/simple;
	bh=wS3x1bBk72iAzhy+QOSkGx+nvDN5sxeUmsyJDpqcBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtV2bp0ZoL8Ijcs/85LYXmSskNSSo2dpcrb+2HMdAA3qRAamH6k2zCcrzbkIsvz/Mxz/7Y1WkSxA4YyASoZ63ktw+E1QczPD8PKsgXO0EqB6WUGAZhDypNvS7EZhlO2oNUXAUOSfSVl13t2AIM4QwqO+b95mMvWwcevzkIu/e7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOnCoMlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F85FC4CEE6;
	Mon, 21 Oct 2024 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729497699;
	bh=wS3x1bBk72iAzhy+QOSkGx+nvDN5sxeUmsyJDpqcBms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOnCoMltOSX8XM4dM7hK3Fq7JsSBwU+YsKDhMN9WXl0EODsppr8yy2ICB7Jxf3A8h
	 sMA7MFbY2TlbgzwA3xcACFOVOIue+eUsazC2cnzvijH7DD48Lmfi+EVLvnBEuyGUG8
	 oYDWzBbCoBcA37tLxLvwYyhsdCfngiT60dp/Q6NEpvNG2CsM0T4x4q+M0TGr7Nrn0g
	 U+X5HZu4H6kmQweY+1rQcAgZNHFeW2PqIZaG52tqYPYWUK6xiYO8MiMbH4I8QW/9Qq
	 Wonr5Z5kwlg5lba68WWyVnwDJ9+j6JsmOsyvdpXcxOtJJ7T3BTW2TPBbxMdd+x4bi8
	 gjSf9Sgpwygzg==
Date: Mon, 21 Oct 2024 10:01:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add Gateworks GW82XX-2x dev
 kit
Message-ID: <m37tqalh4ek7ldwtdy5yy7j5wn4nmbr7lpkdxaswzlgc7sg6ns@5zu5pquyqmer>
References: <20241018182444.817848-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018182444.817848-1-tharvey@gateworks.com>

On Fri, Oct 18, 2024 at 11:24:45AM -0700, Tim Harvey wrote:
> Adds support for the Gateworks GW82XX-2X development kit
> based on a GW82XX baseboard and a GW702X System On Module.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


