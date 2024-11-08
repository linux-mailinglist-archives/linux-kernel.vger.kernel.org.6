Return-Path: <linux-kernel+bounces-401612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8109C1CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E311F23E42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08821E7C2E;
	Fri,  8 Nov 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJVlOg6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242291DED55;
	Fri,  8 Nov 2024 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068812; cv=none; b=BWmTRYP88wiGIz/Dc9Vv19jFREVv4DmjvEvPI+uxDpBNVRDYfKt0D5L7JH9shGIgHOTrSajav+oe2sz2F7MeIqEZkzMJh/U63ED1iNNIUYKmLFtYuITbvVI07QGWJmKxCnMYFmVD/6+ZJX8bbUSipws/FvVnTpPKEB9XaDahx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068812; c=relaxed/simple;
	bh=LE5ViNZC097yakLUhcdt/2Wuhu+SiSGw5zfIBA0XZD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do+cyn6EJ7dmItgDFISJZeTGEBrjZNENt2m8X9qnXtft2wk1YiuS3ztBGQ3OvlR9e3wVTQt8le5wCGpc7PEBIoi5jq3yQ5cnhONnlLtcVLi/yBEJdBdzVIxo6QShk+ol59MM1z2/RRNTOl3E0u6z9JbLX148qZjGc41bf5Ahr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJVlOg6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE97C4CECD;
	Fri,  8 Nov 2024 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731068811;
	bh=LE5ViNZC097yakLUhcdt/2Wuhu+SiSGw5zfIBA0XZD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJVlOg6CB9NqZpkXXZWGGcE3xtciRj+3e9/6HOJDc/uN+fGb14cuq6eovzph8pA/y
	 OkmjJNmdX3lQk56OKAeVIqGCp1iBiM95I3dV5p6DtCcH2bsB6Ll2o++rdMMvrZNo0o
	 FCdAD9FaqEJNDpXPW1NoCdTswVTUbOxO5vTzaqC6r6IfrSTvibhQt9tk8SeGc/MhCe
	 x+2RtXnmW0c47VR3F72rr+M6i+r58uhBu6OIc7SM24V9Z8SKmuoR7CcmeAcQ6blkX0
	 furKlzwOWdP417FrJgP5ZA3BE2zAudQw/ZGFdCXziNd342imkYHmt+faIv7IBRbjVl
	 FaPGOE2NK5vLA==
Date: Fri, 8 Nov 2024 13:26:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: add stm32mp25 support for i2s
Message-ID: <vbdhp4q6ymyf6skjqblb3f77l2x6po7djhlu5zmh75tbqigaqg@hjyhyzpfklsf>
References: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
 <20241107144712.1305638-2-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107144712.1305638-2-olivier.moysan@foss.st.com>

On Thu, Nov 07, 2024 at 03:47:11PM +0100, Olivier Moysan wrote:
> Add STM32MP25 support for STM32 I2S peripheral,
> through "st,stm32mp25-i2s" compatible.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/sound/st,stm32-i2s.yaml          | 36 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


