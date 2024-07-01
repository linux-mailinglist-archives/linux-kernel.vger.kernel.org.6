Return-Path: <linux-kernel+bounces-236549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1892591E3DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C718E288915
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201B16CD3A;
	Mon,  1 Jul 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNotNBLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8916C871;
	Mon,  1 Jul 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846884; cv=none; b=MQfTn8jcOx9ETH1iqWmpVcVp8gR1U8bdsNaJzL86GyxHci/3s0hOr6XVsPedZ2eQeY5qGrolHwZvw7XDw3ec0eR7UT0kvr00hxH9z2rYNRMSMmuRnCnMND9eKghVdnARxGT5T3h8yhPo3Gi7TN3uqYL8cJeh6cBIFq4vBfb/3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846884; c=relaxed/simple;
	bh=KMbxszmTtAQTfUvimgTMN3qjOR1aGHntUXhKwepkAIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cZijPU8h9wlWpCRP5FwhKnNciaqnzh4xAghs2xQcSvwmSCuDPZY5iKXqOTmZzBghZtHeDZaIAWbFdzoFlnsLTb6/i/kB7FgEwX4HDX8m95/9dww/tiSdGz4y0HeJGPLYP512sthha+yZsntkSf8kedOIhJ5ySWZeDLoXUDRYFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNotNBLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D48C116B1;
	Mon,  1 Jul 2024 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846884;
	bh=KMbxszmTtAQTfUvimgTMN3qjOR1aGHntUXhKwepkAIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oNotNBLZbd0V2yBBPXQwrYgkWvWFMJ6AJwVBnrQtlsu6lALgjoRwrSenk8Rxzwetr
	 BFqjywbrnJ3xfb9fJ+XJelHtELhj3mPPU9JdvUNc1SWkO65AfX1Nepn2gI4e+GvKMQ
	 16Xv/vkB1kYfIK7quarIF0SCv570SnqbXohP0bQ0tRVgUa/GvdZTKnDDKRC6maenmq
	 eRy2lqfCXzWiL8sFC22udw1erFVxu6x83i1bvgNp63K0gYwD1xPQIFO2/itFg6BFMG
	 ZJxpOI/I6/Vtbq6nZ07nS7I1mz5A2kDsb3PJ/0QOMrJBNr1aOT0jwg7V3fAZo5ZujM
	 450rA/YFbe+ww==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240624132949.124228-1-animeshagarwal28@gmail.com>
References: <20240624132949.124228-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: realtek,rt5659: Convert to
 dtschema
Message-Id: <171984688206.72817.9141540174439714171.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 16:14:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 24 Jun 2024 18:59:44 +0530, Animesh Agarwal wrote:
> Convert the RT5659/RT5658 audio CODEC bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: realtek,rt5659: Convert to dtschema
      commit: 878f4c36f9235e8a15fe0c2ecde066d92c50c8ff

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


