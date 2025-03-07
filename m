Return-Path: <linux-kernel+bounces-552016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A9A5740D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2703F171A15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEF620E026;
	Fri,  7 Mar 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDPfjuKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBF2080FD;
	Fri,  7 Mar 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384449; cv=none; b=thNOMFZ2VR7CvoIeyezClRE07LxvyQt9IqvsctuJ9y9a8kazk/Jlox/mNKyczSBkW+SUZtArEbv/4yM3r22j81ymbnDbimO7qoJMXQDI66Q7ejEs0a/sJlOh3k+OCjoFrq+4JfOnnKHZ5tM6v94Xlb3fOW21p8aCnGXq1Nor7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384449; c=relaxed/simple;
	bh=OYkDFDN++s9mXl2BERPZRbOwLjSw7X2E+xn2cE2k+sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAGLP1zUrBfktwo3NOpkusb2m776/pMSpKf7qEAP3sNu2DZF82L5PZNZZyfFMRdr/qS+yaPBHtqJmrZpQOgVmz32sZCqmLuhrL1PiqCLO2u53CM8snvg3ji2grE8POPOLp/ZGKizhaR2jGzoKm/n5yCY62eoboGc8VBsoULHoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDPfjuKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA9C4CED1;
	Fri,  7 Mar 2025 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741384448;
	bh=OYkDFDN++s9mXl2BERPZRbOwLjSw7X2E+xn2cE2k+sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDPfjuKCLPcmODM/mpQszeD+fH1oOnyE+g26bB9sJR0YeOSQeDEjG6lpru6IhjLyK
	 i7wOyboV+mZJ6mKrEsttT4VIXFqtH9b53QbpoCZyyePXy/EWODOadXYTJlkXCR5Sjn
	 avTHG6JN26FsgyJxWt3iars2OypKHXDeMA41F5nZsNuJ7i5G+rKde2w4gOxJJowlwZ
	 jXnwOo+PFwgIKaBSm1ePVwiVB8RGBANf7AZPvbVs+y5zTPUFLt17lFKkmzc/cOpO+T
	 w53K2Prh1qksQWbyF8Pd4UewYzyWQRheRLrPzrdUeX/SEgqoUMdQKcEzC40LhFQmi9
	 NVDB53G9rrqlg==
Date: Fri, 7 Mar 2025 15:54:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: add regulator support to dmic
 codec
Message-ID: <174138444621.670593.13171992364660148960.robh@kernel.org>
References: <20250306171840.593443-1-olivier.moysan@foss.st.com>
 <20250306171840.593443-2-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306171840.593443-2-olivier.moysan@foss.st.com>


On Thu, 06 Mar 2025 18:18:39 +0100, Olivier Moysan wrote:
> Add optional vref-supply property to describe the regulator supplying
> the digital microphones.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  Documentation/devicetree/bindings/sound/dmic-codec.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


