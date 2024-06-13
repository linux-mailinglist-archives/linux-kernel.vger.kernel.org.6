Return-Path: <linux-kernel+bounces-213714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349C190796F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9CDB23376
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791C6149DF4;
	Thu, 13 Jun 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4aRR+8C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287B4C6B;
	Thu, 13 Jun 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298546; cv=none; b=sRzd90ngoOzzOnelT1t0nGhS6soqFdWLQXJNW00LE8HjBrOW9/OaW0YPxgt1I2A7vDu65pBJp5Raon82WqGLvZ59rw5HGhvW4oiRAs+aiRJNmXoIikJuYxFUPr5XnVU0KFH9Tf5/+z+oaCm3EkA0eadz56AvE/iodibzMiWP3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298546; c=relaxed/simple;
	bh=UAJ19gWZVSp+Jfa+EQGjgkEQW4jwlnjcz9cwwfpkYBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRKyTbQNa+QYQKpnELJiJJKPoIjuo6rJ2Dc+tKbMOcMSWIkkkiuBecBfE7UzweJUThgZCkAyJ3pJla6Mg0JKwOvef/M6dObbgYQNSKHfWlGBXVVo4DzBopUbn2oLw4pq9Bpu0Opg+G3skZONMKmpNRcRcBHnMX96kF4ZKmghdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4aRR+8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BE5C2BBFC;
	Thu, 13 Jun 2024 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718298546;
	bh=UAJ19gWZVSp+Jfa+EQGjgkEQW4jwlnjcz9cwwfpkYBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4aRR+8C7Sh/cf4SwvVdfW1kr/CvzeO3ulH7fo0LOrrW/qZMGnREd0rE+0IIz+Qq3
	 sWE6vaNvFwZlFXH8pOIz/9T1Xe4jT8MgLw6qlSdI532huOcvDwSWNis20xNneqKCmo
	 AEPYgWDo7d8LmPgMdWwkycjZSD7LX+P/RgdzB1+f0H4AHFWtKreAI1McevlOxJ6LAg
	 ImTJgUVYm9LJEWGNI2AJcZb07J8Bnj6UKr9A9UHb/nlQOw1CPUBoNuFXa7eE2dUxp9
	 yQ3pr+rtFWA2zTolW+rUSfPxnjTbSPnpKlNt6ZfOtJ0K5mEAYem6gM2XdctdTq4Cp8
	 Do3jbrI48JUlg==
Date: Thu, 13 Jun 2024 11:09:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: convert tas571x.txt to dt-schema
Message-ID: <171829854359.2035979.9792456388087813565.robh@kernel.org>
References: <20240611-topic-amlogic-upstream-bindings-convert-tas57xx-v2-1-38269edc1d95@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-topic-amlogic-upstream-bindings-convert-tas57xx-v2-1-38269edc1d95@linaro.org>


On Tue, 11 Jun 2024 09:30:04 +0200, Neil Armstrong wrote:
> Convert the text bindings for the Texas Instruments
> TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers to
> dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Add missing port
> - Remove label, include and add blank line
> - Link to v1: https://lore.kernel.org/r/20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org
> ---
>  .../devicetree/bindings/sound/tas571x.txt          |  49 --------
>  .../devicetree/bindings/sound/ti,tas57xx.yaml      | 133 +++++++++++++++++++++
>  2 files changed, 133 insertions(+), 49 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


