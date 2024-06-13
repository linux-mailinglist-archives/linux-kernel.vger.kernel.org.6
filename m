Return-Path: <linux-kernel+bounces-212917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255890682E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE3E1F23612
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1013E3F9;
	Thu, 13 Jun 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjrquMx2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E45477A;
	Thu, 13 Jun 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269827; cv=none; b=uwT+CJeFKsObwRrThdTHL8mlNTeltptWF72EqBnaalDzCVIptO6JTKs4XJrZniItKRimQDiex/ADt8VS4J453SctR7GLbAV7g+gPW6kTsFxW8/wczBuxRcj5rHUL29oiHrBzPhSHY8zAY7b8VTLfhFrWKXT55m92X7xWiRTa3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269827; c=relaxed/simple;
	bh=UK+zcEIHryurwkWJeX2LJatJ+UEVLlUY2B0YFlMx1SQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WOBDhleMANpiAdW+Hrlj0RRxtop7UelEuvyqXPdf7+ma4ER2/kD69Lq2tc94/JBf4+EzFw5v0n09QBF5OzSwKDxR/2kDgKvnHS9mWF7Vc563ae+0G2D1or0YvEk9lzhF/qOZPMMjONJnThRiP9d8VESwr7+UaocTp3qNxzNGZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjrquMx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8F2C4AF1C;
	Thu, 13 Jun 2024 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718269825;
	bh=UK+zcEIHryurwkWJeX2LJatJ+UEVLlUY2B0YFlMx1SQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KjrquMx2o3ugPiwV4D0S6VOvA9OwRP0F+5UYJcYmBLz80r7woSnhrcB3oNk0JEybY
	 rVBN4JWRtKpasyUXRA43c1oS6+iKSvCZrRo6/EeeEKVQi/2M9jf8td28fm6y9noFiL
	 thWz9oVDLK8L0FfC9b009HW5CGyP3LY5BIHCh7PpC6eSxhp73lo2fXLUJtP3cfxRFR
	 Bck7xA/TNGaFBRgjFjSUeumldODjiMwtkSmXt5LqPp0IJHov9QUcawOkWyS98k+p7w
	 26TS50YoENxvpIzAEDGAUeLJaO38ITJN7hVAsjlKV+5KmxKALG8QD4zhfymx/UYZ0x
	 NOtVBt4d3ZGSQ==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240611122258.47406-1-animeshagarwal28@gmail.com>
References: <20240611122258.47406-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8804: Convert to dtschema
Message-Id: <171826982446.253389.4335340259446732912.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 10:10:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Tue, 11 Jun 2024 17:52:51 +0530, Animesh Agarwal wrote:
> Convert the WM8804 audio codec bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wlf,wm8804: Convert to dtschema
      commit: e8ffc08366f9787a69ac4b4fb3bfa0f837cd846a

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


