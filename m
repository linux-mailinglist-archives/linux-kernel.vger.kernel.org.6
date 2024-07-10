Return-Path: <linux-kernel+bounces-248395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D792DC9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA54284040
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A18A153835;
	Wed, 10 Jul 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuruZDGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A31527A7;
	Wed, 10 Jul 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653971; cv=none; b=ZLCnDze7WLq7Yt3J6b4a40rNBixHpj6sXx4flMlkubGTL2JRaijaM67YRZ3SLajdbRNlcUaachJv4YkGk2ETsfHBZN7bm5WX8YQblZn3ukDL3U0ljN/XojkgrYVK3eLFLgO3cZzMyw3sDYhobhhrMJeNLp0kHT1+EvgNX3ICF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653971; c=relaxed/simple;
	bh=4j7HhjyR3P0XTsOa2hJfJvKNhltv5iQXTeJBSXBmgDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FgTNcvRTgSniz8muL5io4z/7qJRUiXRih50LqbAn4jXEVBCTNcPGpLfP1oNiiqjT9J1KOZiiakYS7Goum7549UAZMhqD41eLHE3lgFRAS3Atv73oxBQAqbzITNddE89PSXSgjYhhEmcKpRtDDODPMpif/JLDSgyiYKy/6MJJnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuruZDGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84466C32781;
	Wed, 10 Jul 2024 23:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720653971;
	bh=4j7HhjyR3P0XTsOa2hJfJvKNhltv5iQXTeJBSXBmgDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KuruZDGU1G9jIshYs8VLqAtfT4LDSGyTiG3NMoJm4+yhB4U++ekx+EtxHSpUo9cD6
	 6m2pVVNOcvWU8KFzFsoPyqttrDJVxzW2+hwK8E8cpyHvACGi4OGzCrKyHjzxFhiYfI
	 x5en6NxFiJCLl/OSjS7xD459Oo49zmKpo9Aj7bRFclnALDYUV7H5sSP2kbholTWkRz
	 pvKX2MOJeuZ6L21eB+TxWTaPV3jhv+vEcKa09o8KsUaRQY1L6CrOT7IWmcxxYRgdC/
	 qt3kewJN0ylFfma5mUF11JYIemKsHBomT/5zchH9KgbjWRm9c3XAHuJ0zlPM3yMfaD
	 sX8gm/0aL/Edg==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240709184231.125207-1-animeshagarwal28@gmail.com>
References: <20240709184231.125207-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: cirrus,cs4270: Convert to
 dtschema
Message-Id: <172065396818.391308.16919623245935152451.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 00:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45

On Wed, 10 Jul 2024 00:12:25 +0530, Animesh Agarwal wrote:
> Convert the Cirrus Logic CS4270 audio CODEC bindings to DT schema. Add
> missing va-supply, vd-supply and vlc-supply properties, because they
> are already being used in the DTS and the driver for this device.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema
      commit: e021e0eecba99d7ec68f6e7972a72175f54ff6e3

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


