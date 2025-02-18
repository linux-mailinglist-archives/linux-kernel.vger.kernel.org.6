Return-Path: <linux-kernel+bounces-519330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA314A39B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56EC18890B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5824113C;
	Tue, 18 Feb 2025 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0vIasmSy"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36E2417FA;
	Tue, 18 Feb 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880013; cv=none; b=e9Kv3t1IAjedkDFX5jNOw6s6BZ/DQvrn+ljXsla/1t+4QcuiaJOeAWFDRjRWbbdy+bLxIPw4JHfupkonqOxjq+uHwDyDKqGuw0cjriuSXxjI2Ic2iDNJGBwiNCPCRvC0aKMlaYQI3w6JtLl1G1Pnirz+oa1XGr/4ESrKqIULkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880013; c=relaxed/simple;
	bh=9lsqb3KzQdXtJP11Em4GvATQ9hJVRCwBkO2a5mLLxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwNeFVjC8FHXSUlDxQh/zvTHaZkRYMVaS8GraVR3CZx6+FjXMVF4nNVw8ZgAygPezPschvqp/cDwADha4KmrKmWifL4cfWBOCUSLa+m57JtO6inz0xbE1sExqcHPYf2qMTkKMS8GKlY/gofuLph4Np57NsjUkSkcLkBoAKIGOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0vIasmSy; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 611F11F8BD;
	Tue, 18 Feb 2025 13:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739880007;
	bh=Mj3PztAnvD9vDz6xP2L4dDXDamq37tJkkDcB9UoW23A=; h=From:To:Subject;
	b=0vIasmSyAYoHCecFVq8qfDEAKDf5y8zcgzKEgmSf4SnjZUhpdWkZy9p3GuieOjyRD
	 iDV89X9ERnCVMIZRnHABwQQOGCkPs8AG+tpupDCqLnV0qj+xsF9jwzTiZvWafig1SK
	 usqZmaBUTHQVPknMUVysdLDgSU/PylBZFlYh0GK92wWbJbM9M1qeny8DsiuRRjPtUC
	 e9+kCupqf02xuhszS1x6QARjQXfmlBwP49yQSoHj4FSJEAr5jXM9rPdu+U+gYbkvXR
	 oBT7KCh11h9tz2B4YIEmpkgxB0y5mTW6zaxFvbp1eEzJgeWx8NKh8cVVCBreoZ/lMX
	 Ztyk/MSWmcV2A==
Date: Tue, 18 Feb 2025 13:00:02 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: freescale: imx8mp-verdin-dahlia: add
 Microphone Jack to sound card
Message-ID: <20250218120002.GA15270@francesco-nb>
References: <20250217145744.179213-1-eichest@gmail.com>
 <20250217145744.179213-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217145744.179213-2-eichest@gmail.com>

On Mon, Feb 17, 2025 at 03:56:40PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The simple-audio-card's microphone widget currently connects to the
> headphone jack. Routing the microphone input to the microphone jack
> allows for independent operation of the microphone and headphones.
> 
> This resolves the following boot-time kernel log message, which
> indicated a conflict when the microphone and headphone functions were
> not separated:
>   debugfs: File 'Headphone Jack' in directory 'dapm' already present!
> 
> Fixes: 874958916844 ("arm64: dts: freescale: verdin-imx8mp: dahlia: add sound card")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Cc:stable@vger.kernel.org
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


