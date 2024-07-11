Return-Path: <linux-kernel+bounces-249860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAD92F0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC63728407E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1312219F464;
	Thu, 11 Jul 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwaEH00l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9D51004;
	Thu, 11 Jul 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732474; cv=none; b=m1liY7xuY98dnmN1EnSsSAf9HQesv9ZJwTjVpO5Ak187GWnAgtHI6eISG8wETEuZHJESy1rTP9NtrFGLKlUvFPi1tljFpHN2gMaA1e37cn0JxlxN9i+KQ+uWICl6DhzYRikkIx9/ah5WHzYRhiO4olGwUx1eznpfp38ItgmUt8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732474; c=relaxed/simple;
	bh=PqmkKClzKA9/SBnHkaebvSMhSF4dVf6/yT6uauqZ1ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MllbonL/9cApT60aoVWQ34c6MurI2JW/GH1SOaD6OmYOCwoCO5yPBPyqYl9Bx7xMl21xW3SOboGzNKFFwUrUtwLeVflPpBBkrGm4oEwc62uNRRKuuzL3LyVRj5ZCKwlw7ugo93d4EobUkEjkEFCOs9Z8X35eWpcz9oJB4r0DBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwaEH00l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6926C116B1;
	Thu, 11 Jul 2024 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720732473;
	bh=PqmkKClzKA9/SBnHkaebvSMhSF4dVf6/yT6uauqZ1ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwaEH00lPYizGDKn3Lj426vXvs6iS3F3txCwEPg5beVfkBvD61hOq1JKCd1ngTNsN
	 XWu+VztjQPRqlkgQeFN1wOnBvlwvq6LNriLsQmFIBKKvTo9rc+SkAGBTl9ZXEFzKFG
	 7MXRi+f1EA1TxV67rs7xvM0CgJwVJD6lZO5rDvfd69tV8avxM05k+5n7ach+cUVUti
	 E6rVlxpW4vjtGQpmS0vgoBxdkDZ6zN+DcBHP2yR2+MiAeQkK5MxarHPOtl7UDG2cCy
	 W/Zht9tvzw6GoSsEmIBur7LTi0ZYritzCsDbO2Ps3nZYdp5YY3PfWZ+GbF9hOLM89F
	 U9q+Xi8IwMJdg==
Date: Thu, 11 Jul 2024 15:14:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	alsa-devel@alsa-project.org, David Rhodes <david.rhodes@cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs42xx8: Convert to dtschema
Message-ID: <172073247178.3021175.15222505507624018342.robh@kernel.org>
References: <20240710072756.99765-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710072756.99765-1-animeshagarwal28@gmail.com>


On Wed, 10 Jul 2024 12:57:52 +0530, Animesh Agarwal wrote:
> Convert the Cirrus Logic CS42448/CS42888 audio CODEC bindings to DT
> schema format. Set power supply properties to required only for CS42888.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../bindings/sound/cirrus,cs42xx8.yaml        | 81 +++++++++++++++++++
>  .../devicetree/bindings/sound/cs42xx8.txt     | 34 --------
>  2 files changed, 81 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42xx8.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/cs42xx8.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


