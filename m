Return-Path: <linux-kernel+bounces-400713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77749C114C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60038B20FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4C21893D;
	Thu,  7 Nov 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH2EdexX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8772170C2;
	Thu,  7 Nov 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016339; cv=none; b=kYHn1BcFurwATRcZPKHoV/gw7DXrFc9CFhIIBb0II+lLBw8SqkozqVahQREV70pxu3D9yvNxUY767mv0BIkiwfKERjiqfvEpLUO3P6abplLHsUPjVhbCjOt1+NhPrsQW7P49yPsONvK2K2hqzpC9qY5U/oFQmdtdvhT1UEnGzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016339; c=relaxed/simple;
	bh=wSfUGIR63ir+DpqRwf9z1fSRhrUzDgrtDr7l6TxiiTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TXFpEjLeacDcPH9V+u3W8IascMdnD47oKv+ZwHCwSb2p/4Uhp7WWfrPi7hHxAPqJqSD7zdBNZuQu+hjoqStg/UQTRS+JmFkCLGrBlVuB8n/nAhk6p3uLVfjF93RXF1EeflvnqFZ0UqOAVKr/rlQq/RuE5lnvcuH/rg5YFG4nJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH2EdexX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B546CC4CECC;
	Thu,  7 Nov 2024 21:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731016338;
	bh=wSfUGIR63ir+DpqRwf9z1fSRhrUzDgrtDr7l6TxiiTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YH2EdexX3KvdkaJuasETWrxZJrzJsauhEYBdAoaVi5Vm5WUBGV+efceHhgDHPaiAp
	 3UPHpiZqTJ9JRaaKqe/uINtvLoshWcCyKenJWuhtLk7qIx8pjM9sdnW0ZZisDqbciQ
	 Uan9oGdSiAAG7ukVbG3/7sMkNCjlg1Jof/9XE4RjYbPrvfggcmzg05zYuYlrjS/wiI
	 A7+TH7s7AlB43qVvKT6G7aTvnnUCcDfl2bnE2u0Kxd/tPt6ytmzv4fh4TiHo8ilciT
	 CM4KHTfMHE5B3LbMdR201Rn53XPMlsSL29jSS0YNm6IpphEEaLgDhXlsHg8qeoOXbe
	 TD+gLwCDcWnrw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Ki-Seok Jo <kiseok.jo@irondevice.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <SL2P216MB23377A60BEC4396ADFA78A6A8C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
References: <20241104-irondevice-sma1307-v3-0-4bbe79895f54@irondevice.com>
 <20241104-irondevice-sma1307-v3-1-4bbe79895f54@irondevice.com>
 <SL2P216MB23377A60BEC4396ADFA78A6A8C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT binding
Message-Id: <173101633645.271800.734453630790415201.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 21:52:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 04 Nov 2024 07:33:47 +0000, Ki-Seok Jo wrote:
> This adds the schema binding for the Iron Device SMA1307 Amp
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: irondevice,sma1307: Add initial DT binding
      (no commit info)
[2/2] ASoC: sma1307: Add driver for Iron Device SMA1307
      commit: 576c57e6b4c1d734bcb7cc33dde9a99a9383b520

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


