Return-Path: <linux-kernel+bounces-556725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96274A5CDFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3623D3B3C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5E262D2F;
	Tue, 11 Mar 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lNtft3sY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7AC1DE3CE;
	Tue, 11 Mar 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718101; cv=none; b=T4dH9c70s7kJCXKPLXUYb457pBfPNTCDnJLfGNLIxdu8O1KONvortzOFJQ91OEEURLToRo9VZIAYeA10B30dlGgmXYJ9JYcnO9gYY48U6DBFZU6AHrRxCBQj+88BS5NWsjSmXLuD7bUzu6GSnh0jN3MmfEuIE8M2OQbNTwQOdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718101; c=relaxed/simple;
	bh=sVHNbdJnau3K6ieK5h764cFOUI/8Mm9xtddYsKbK+KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfGboSJLdaYs2Wc223s60N/N6iepRYKYqcdebDB9Q8+sAU3uPjjnaLvGLt5VOL8u5x0Tj7BdcTFz8g24/mhvFP2oGYtA7gCiMWKHIk/HrRvxsdFXxojoUTR+A6Zk1wv/QPzjOzMoTextf9fTiISFFSq3nQ75kk9fZjAFseadjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lNtft3sY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71747C4CEE9;
	Tue, 11 Mar 2025 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741718100;
	bh=sVHNbdJnau3K6ieK5h764cFOUI/8Mm9xtddYsKbK+KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNtft3sY19IiVuoDzWfgWESJrNn8CH/auzECap2rnCrOyzG33cEo99oc2alPIEy/f
	 cfy5T3Uj0QvfOnC9Z8Z7W61KLNXyeCfSdqIICG4pUe/lynRsu/ubZghRKuRRf2g/v5
	 VNPXnEL/LCImE+wpS4xk1EZps/FDDPFe2bezUc5M=
Date: Tue, 11 Mar 2025 14:34:56 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and
 Concerto board
Message-ID: <20250311-omniscient-fiery-bison-8e7feb@lemur>
References: <20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com>
 <20250310-varsom6ul-concerto-dts-v3-1-551e60713523@bootlin.com>
 <63f8aa7d-fcd4-450f-b3a1-44886a29fc7e@kernel.org>
 <cd2f3c97-53bb-42f5-a3cd-4385bfda5dc7@kernel.org>
 <D8CQAAKOZ1O5.8JVESQPJSSM8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D8CQAAKOZ1O5.8JVESQPJSSM8@bootlin.com>

On Mon, Mar 10, 2025 at 05:31:32PM +0100, Antonin Godard wrote:
> > And now I noticed you used b4, so I really do not get how the tags can
> > be missing here. :/
> 
> Sorry, that's totally my fault here, I forgot to run 'b4 trailers -u' before
> sending... :/ And I don't think it's part of the prep checks?

Mostly, because there's no clear picture of how this would work reliably. All
other checks are on a "ran since modifications to the series" basis, but this
one would have to be time-based.

Should it check if the trailer updates have been run in the past XX minutes
(and how long should that XX be?).


-K

