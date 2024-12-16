Return-Path: <linux-kernel+bounces-447795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313619F370E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F2C18852CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532F2063D6;
	Mon, 16 Dec 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD+qOXsh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77681C54A6;
	Mon, 16 Dec 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369029; cv=none; b=Bosj8tEa6r8f1OmnePrMJnd3Z3EMLRN5iq+0tr70sa8J+6LzzYlVx0yK4d0G9zh2TiaxsqWfyz4UdkV13Mj0u5c5wGSnYHQ0bPXhwJjdydzoRtYtAZfdxQkgTpEldO5O9d8/BAfkVSsmyMs1EuARs8D7Wi7sz3QtkbnALmblAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369029; c=relaxed/simple;
	bh=hk/orhlZtPRCVTAY/48OB6VRHvzYZsvOKapCSPu1XBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yf1QC5agi6UdFozb9X4TfzVGDCX2LNjoRJ0J+J4eyeSJEMstRhwUkzOO75PqlRlup7V6tJSIswzIsEgcUUQSOUoONUjpU4nQWeuV4A2Vqa9lZx2i5UeHFKc2MTBARn4N8MqeL7cueL3JbRUnNktb4+vAj2bRwXvXQS/dFHAS4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD+qOXsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61051C4CED0;
	Mon, 16 Dec 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369029;
	bh=hk/orhlZtPRCVTAY/48OB6VRHvzYZsvOKapCSPu1XBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pD+qOXshhom9N5KPqwWseuhwVJJRBEeqDucT81yLYjinPiby6+TbL9sPC0RjEvXrG
	 aUO2Cy1PN0vvt4mjftd59SwHz/BYgwSn22eQ9B+gmvwbzKjrGtoo4o3GO3a2vX2C1u
	 QMF9jYCcApBJ1220Zo0jM9OxauBj3jFyR9NwUlSubLfPTF5Ai0u1Bp+KVRcQMyMAAZ
	 3/6s+s+Dkh6hHtq64TCxZvw01RM5vFWbnT7TsGj6qBlsPFefcLjbJB32KGRzLPRjwl
	 jfzxOWZtG4hatBsbxGYYFwWZLPV2FwjuH8PUBLfiR3hllmdVpFD0OItM5p5zD5yAkv
	 eTTHbqZIl21kw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Animesh Agarwal <animeshagarwal28@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20241211035403.4157760-1-wenst@chromium.org>
References: <20241211035403.4157760-1-wenst@chromium.org>
Subject: Re: [PATCH] ASoC: dt-bindings: realtek,rt5645: Fix CPVDD voltage
 comment
Message-Id: <173436902708.158279.3911359979093567109.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 17:10:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 11 Dec 2024 11:54:02 +0800, Chen-Yu Tsai wrote:
> Both the ALC5645 and ALC5650 datasheets specify a recommended voltage of
> 1.8V for CPVDD, not 3.5V.
> 
> Fix the comment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: realtek,rt5645: Fix CPVDD voltage comment
      commit: 6f4a0fd03ce856c6d9811429b9969b4f27e2eaee

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


