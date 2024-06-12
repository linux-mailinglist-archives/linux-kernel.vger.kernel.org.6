Return-Path: <linux-kernel+bounces-212312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0567905E57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C578B24318
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912F1272A3;
	Wed, 12 Jun 2024 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcgjuefB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CD1DFF0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230659; cv=none; b=BmLTYwXRknhsLvfwS1KfmYFWnSkUrfgoJrH82D4KCsBU+PVIQuR2h4q57uIUCGt/O2V0WQioGXcILQ2KX7VfWacwZYAVBuP1mUsreTd7nWm228R/6eOVLB5NwMFA9koOXeM+9eToqxNC2ewxkSzCMSIReWKdPJoCsxVDZjf7KOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230659; c=relaxed/simple;
	bh=ab9gxDF+pv9y5GqIwIDOyA5hgnkyctwuFMMl8d05w5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMjiN3yC62eZu4UZSWxi9gWuO/q12g9BBpSv9CVyUwgFV9RummQ9zz4eT6s5xy08jRZ5stSoMo9Iqqw1Gik8IjzLNswq6INlq93b0oV7bM7TWRLLLedniF9iImBc1xqYfUbusmyLt8ukNihTrxGu0i14w1ixmX9GyqUEaBp1hNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcgjuefB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B88C116B1;
	Wed, 12 Jun 2024 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718230658;
	bh=ab9gxDF+pv9y5GqIwIDOyA5hgnkyctwuFMMl8d05w5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcgjuefBzLb++dSDcsDU9ub+6kukg5XLcDffztcSjpoHnCT41FxoDk0tMt2cteF+/
	 Nn5WWB87kF27fnqelYyzuccl9UvqQjmF5z5pf0ox6LAPlOF0lrkrdCpDK+ikBFNnmk
	 YvdkUqQK7l6nFkyHvVw7QNPdQBrLp5z5YNxzpTvFjnl1WnrriVUQpxMgKsoPwrwOmI
	 7uJCeHu0FRpSs2AlJgaTy2EXjFGbaEC58vN45EBzTLP837WesHhGVxmw24l+kkod+U
	 BD0rkJkYrGs3L99xzsZ1ycHclZFnvCrDbZnUG/6/33l3kks3ehNqHCeKN9awRnxXRT
	 p6rcAYI5Q95oA==
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: defconfig: Enable StarFive JH7110 drivers
Date: Wed, 12 Jun 2024 23:17:30 +0100
Message-ID: <20240612-starving-oak-e5c1139c95d6@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605071701.13737-1-hal.feng@starfivetech.com>
References: <20240605071701.13737-1-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=562; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=kwvEV7h9fafWAM0Xgw52j8nyzhHS8hng0oyJZ2yOCpk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlZcpWqfi8fVskFiuWU7O0QmGT/ZtZrpSNapetjPtY3H 5Hmrd/bUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgImUVzAy/PpeoFt9UdRoSvZ0 o/Db5tpK1Ufnn55j61H7MFuiIrDYm5Hhc1T4/Odupp72zzb9nHNUcJbjfYUbzSI9X4WsdR5cubG FBwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 05 Jun 2024 15:17:01 +0800, Hal Feng wrote:
> Add support for StarFive JH7110 SoC and VisionFive 2 board.
> - Cache
> - Temperature sensor
> - PMIC (AXP15060)
> - Ethernet PHY (YT8531)
> - Restart GPIO
> - RNG
> - I2C
> - SPI
> - Quad SPI
> - PCIe
> - USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
> - Audio (I2S / TDM / PWM-DAC)
> - MIPI-CSI2 RX & D-PHY RX
> 
> [...]

Applied to riscv-config-for-next, thanks!

[1/1] riscv: defconfig: Enable StarFive JH7110 drivers
      https://git.kernel.org/conor/c/d8a7d89abb09

Thanks,
Conor.

