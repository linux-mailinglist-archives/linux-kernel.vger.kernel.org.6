Return-Path: <linux-kernel+bounces-242797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC41928D49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1614F1F26348
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196D16CD0B;
	Fri,  5 Jul 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip5XSHDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198A1F94C;
	Fri,  5 Jul 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202678; cv=none; b=NHwL/TDJivnAAgyHZd7pSbTExzV2mRIEFLg54oLV8VYNeyjkzcksb5Npx3ISonQHFJC2xnJ/qbgAtJEkFNy8CZJSF8/FMhXPCcIvDFn8hC+/fhUt1MWtYLUdn3Yk4TEZhlk+l+GehjmUrQASBYbhcxarGEr95x44u8ax8uOVrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202678; c=relaxed/simple;
	bh=JhcO/S986tnJdQ3SRzEjJmm8DfbFGwXOf9yb4qYwoe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WZYbPaRVR3nttcosUbJZPSw0NQcDmjcyGX3SVVYr5kR/JzMgB8N2wHUs5VA1XdMlRXeOeNlBUXQU+MrrumKlljUuY2dm21dm7w5iE0O81wLp8X4Nd3jwF0l7LVS422b57HrRiPVn3fONhG8HqEYqyR+Xq+RygSh6olOetqoRi1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip5XSHDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D57C116B1;
	Fri,  5 Jul 2024 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720202677;
	bh=JhcO/S986tnJdQ3SRzEjJmm8DfbFGwXOf9yb4qYwoe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ip5XSHDupl/D3tuEGkIZiJlUCMwnjkRigsPAJcMnSFCwOCyxtvHZNshmyqmzfcP9v
	 ldHM2/JKIk5WB4jXuGtW/l6ga5156auzj+von3J4vOINJjfi0QWCAJ2YZl8da6mZKw
	 3Un7IlOoGd61ge3fNzP+PvBFQwcrY46OfetlS6dQKgqYVxu1txD6Eyj88yH8JTUUh4
	 z/nTBB2/qCZK508E6eApKuoglF829knbJViDTKKUlwEdfdAaFHWY5biH9lhATq9DJH
	 maiuaVVrwqsN80QkdPAuuupzvo/356RWGNsswfexSdv12BH/HUe+huXe5Kf1XU2wp2
	 JtAK8NmMNQOlg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <ZobxoobZvA8k3pyi@standask-GA-A55M-S2HP>
References: <ZobxoobZvA8k3pyi@standask-GA-A55M-S2HP>
Subject: Re: [PATCH] dt-bindings: regulator: sprd,sc2731-regulator: convert
 to YAML
Message-Id: <172020267547.58822.12771637622982215899.b4-ty@kernel.org>
Date: Fri, 05 Jul 2024 19:04:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 04 Jul 2024 21:01:54 +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC2731 regulator bindings to DT schema.
> 
> Change during conversion:
>   - switch compatible from sprd,sc27xx-regulator to sprd,sc2731-regulator,
>     same as the only in-tree user has done back in 2019 [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/sprd/sc2731.dtsi?h=v6.9&id=0419a75b1808dda225b17ba1509f195f23c0db88
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: sprd,sc2731-regulator: convert to YAML
      commit: 6070471088b9db1f7e2aee4b648ce53fdbb3e5aa

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


