Return-Path: <linux-kernel+bounces-563898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F80A64A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B1A16F1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D2238169;
	Mon, 17 Mar 2025 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl5wTHlu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547C238144;
	Mon, 17 Mar 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207657; cv=none; b=D6z92krPzFDVDcWfCUSdP5hHC3As4Kpa+iaC7ITXdcnTjmOOfIKxTo7ZuSiW13L3w+9kwR0PhqBfLNL+j21BQr4QHcGe3XgUQcxW/guzLAS7U5p+03KQ5VP9fnCgQllPsHmKG36vPGuFfizoim7PSGkGElL5gjEIcxc/Z9xTf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207657; c=relaxed/simple;
	bh=PKtSN/G3Q8z6f3hwaks/+EjBJFqkYSjfjT9iRRKWNWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uiGDHlPLYfVB7EpcZwPAtIaK1mY75jZV8V6RXjCUkmiqyiWktYnvw5JEBJm/nEKP9HHp/+91Sffg9x+IZY4QWOJO4y5yQxYxY/XpHGN9tErqp+vFri9txnIdQ76KH4dbfSPNyL2GY7HwWYWac8bhl7F7kinYGIPHwTnE4iVKbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl5wTHlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508EAC4AF0B;
	Mon, 17 Mar 2025 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207657;
	bh=PKtSN/G3Q8z6f3hwaks/+EjBJFqkYSjfjT9iRRKWNWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pl5wTHluGgMlvEewCTRIUrYO7JLcO2XAmeHxV1GvkEc4Hw3QxWiYTuWGh3mg17+o2
	 04uXEp0F3R/vhGZY9s2KV2E2zJykl2Wj0Rbbp5mP+3dNw5S2oXrKGA5T2QYXLCoddX
	 FNaO/+L1ylZanGRJ83O9yQZhwuVUdFGZZpzhH7eF1lMQvV2oWjqtnO5tsJNc3xPw0F
	 axDTblTOBmwlWtueHvFDEdPkiJFoVSSucqV2DFUeoLRl0LJ/lPBh4sysGJWBuod6hM
	 vX98P1/Nr1IMWieweLP64IMXwQ5rPiqQ6f0urwk4Y18s6t0W2jmMtAhFTv+NyaSPCW
	 U9qWkCkXFdcng==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
References: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
Subject: Re: [PATCH RESEND v4 0/2] regulator: add new PMIC PF9453 support
Message-Id: <174220765500.94847.12810276460362366874.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:34:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Feb 2025 12:38:38 -0500, Frank Li wrote:
> Add binding doc and driver.
> 
> DTS part wait for
> https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453 compatible string
      commit: 276c2fe14632a393c1b4d418e4fc2d9d656e1c30
[2/2] regulator: pf9453: add PMIC PF9453 support
      commit: 0959b6706325bf147f253841eea312e27a3bf013

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


