Return-Path: <linux-kernel+bounces-428239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC4B9E0D62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA2BB2D5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C361DE3BC;
	Mon,  2 Dec 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjBZb05Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5776C61;
	Mon,  2 Dec 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166573; cv=none; b=BTkD++t0ZcGsQMenrg55kXfpo1gmskGfzWHtnTntoJaqVWpjGqjckQExUxVc5y9os6qcclh8ov6JfumIOvAx+i01XW8/mKPh5eFCvrxKJRvbDclwlC+G44vjneiujsytBTR5LSpBrUMAZ9bfcm+L1loBABpttLR2mgc96jPwFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166573; c=relaxed/simple;
	bh=umy77aQd2gb3zfX2M3K2vwZXQQnnIJU+TbwFDWYEObs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOOkSfFDh9LMgSfo0zaFCUH56PxumnlC5tNyzDZROPMXKTsqAvIF5frcAS9H7/0UzfiO5FLm/fWQwn1AuHN8anuwH+Da0fVPTLyDpTicfMWa42LH/BSMQUFpWS6+4dbq19GD6uKh3r9OxAJG01qCbwgWkhjjbaojwWBKOcjRZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjBZb05Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF390C4CED1;
	Mon,  2 Dec 2024 19:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166573;
	bh=umy77aQd2gb3zfX2M3K2vwZXQQnnIJU+TbwFDWYEObs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjBZb05Y7vmgX/nXYA4hvHtbMBfgSdNP4Ojbam74gn8fSMv5BXKRONsu1XDyPOZHG
	 RCq15boRuTECFD4/Z/3I50rFpdjNrvxo6a5J1nQJrgYlcFuNRTkAz1XuIXEQZ+1yRs
	 w/Xnt4pyf1y/2UB2GEFaPQ2sf+IKfLngISGtJWmWj7syJH2PVM0fV3VbgFohvU6sQM
	 lImNoudzacbzX5sNS0TqJGYnr8wQuODttyFX9Y+UuMsXUH84pkrdWmFi/egam7pj57
	 bklQ6FLl17VD36oZa9HWsxTIcwMV7sJt/GHudMGcQqs3TlXP0QdGW5+Qi3c6ZwgZmV
	 TbMjB2+XJBNww==
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Henry Bell <dmoo_dv@protonmail.com>,
	E Shattow <e@freeshell.de>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
Date: Mon,  2 Dec 2024 19:09:25 +0000
Message-ID: <20241202-gimmick-fading-87a41318bb4e@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127151843.70341-1-e@freeshell.de>
References: <20241127151843.70341-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=597; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=xeDHdB8e4cS0BxMn6/ptFXFTuJZ7eEI88nwD+dI+sCo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl+rM+2/n0izeQ3ddG73dnZgY1fTnOGZuvmX08qEWwpa FRpnsPXUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIko1DIyTLZbXTnBnVVDr+bb PX0vvaBKkfAD76N/d3W0ljXH24UcZfhnd9Royoebv77k712QYF41KehA4vn0DJcym7wVlglJm+f wAAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 27 Nov 2024 07:15:04 -0800, E Shattow wrote:
> Enable host mode JH7110 on-chip USB for Pine64 Star64 by setting host mode
> and connect vbus pinctrl.
> 
> This functionality depends on setting the USB over-current register to
> disable at bootloader phase, for example U-Boot:
> https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
      https://git.kernel.org/conor/c/03bd268ae048

Thanks,
Conor.

