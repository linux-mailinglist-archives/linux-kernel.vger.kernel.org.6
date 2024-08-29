Return-Path: <linux-kernel+bounces-306834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB9E964453
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EB5281B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4F19645C;
	Thu, 29 Aug 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8eI8bTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADE19408D;
	Thu, 29 Aug 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934260; cv=none; b=ApUhBUZXPziC0suzAX1/4Gn0AIfvwOl7MBatHVAhDYKXfSSpFJ36UFU0Ynz+j/d60D4izfsC1urC3574i1K7P3q4VLlSrUMyybD6ndTrbXJMfBWH1wiK4V2I3g+LW2w5Snzi9DUriUi+YIidnUcu4dR226h/ojqOTVJdZ2sMJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934260; c=relaxed/simple;
	bh=gfo7M4rFSc2kDdyqbx9PNzApWPwrRZh0JwXsvvoWfJ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fmgp1LIPqmU7Ys8MotoUfag1WS0JwNm7ahLlDHW4geDLfuosqumEq2bwKagOvtKzyWHbMIZxilQKjqVq2Y5DA5UHJ+v53XlBQZFSrStSTC1upHqE40j9k+LfTY8m41ignFFxlM3c4cWDbKfI8xcL+jhYx2haPbUK8o5MI9fT48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8eI8bTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C53DC4CEC3;
	Thu, 29 Aug 2024 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724934260;
	bh=gfo7M4rFSc2kDdyqbx9PNzApWPwrRZh0JwXsvvoWfJ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p8eI8bTpKuCI1Jzqw6BI6SSbNmgJbM8t04QwzJT5u3OO6UAAVk8rm7Dc9XwiBZ3NE
	 GPG/WPjRrpEEUj1DvdwIKXBUjg1sdj3rgdyfloANEhhVpdNkh6hut5Op+rqvKNMD9N
	 O/3A/UGa9Gy6E1VFZh2qGKZJQXhMdESTkidPceX9Vr+/tX+EAeqs0ALbVmtDwCOQZX
	 sBEUYRPiCUsDXjCZtEKusv9C3Nyi+A2Yt+D/BZsHDh36ZiKOnlCiBA+k89w27+faOD
	 T+Rzsk4VALLC0rUobKIMehBpfJVUQ3ZgKCvu4c+LpCUtoLFwP2IyoLok/SO3I8hyQw
	 3wLZ8f4NI9hyQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240828092709.2626359-1-lukma@denx.de>
References: <20240828092709.2626359-1-lukma@denx.de>
Subject: Re: [PATCH v3] ASoC: dt-bindings: Convert mxs-saif.txt to
 fsl,saif.yaml (imx28 saif)
Message-Id: <172493425791.31048.9422317952364353644.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 13:24:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 28 Aug 2024 11:27:09 +0200, Lukasz Majewski wrote:
> The 'fsl,imx28-saif' compatible has already the mxs-saif.txt description.
> This patch converts (and removes it) this file to fsl,saif.yaml (to follow
> current fsl convention).
> 
> Changes for the mxs-saif.txt:
> - Adds 'clocks', '#clock-cells' and '#sound-dai-cells' properties
> - Provide device description
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Convert mxs-saif.txt to fsl,saif.yaml (imx28 saif)
      commit: 125b749221aa54db069a7805f08d99b55c74c88c

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


