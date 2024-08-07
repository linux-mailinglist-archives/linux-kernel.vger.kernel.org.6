Return-Path: <linux-kernel+bounces-278334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C448494AEEB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FC0B2172A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70713CFA6;
	Wed,  7 Aug 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoIcQDvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860066BB4B;
	Wed,  7 Aug 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051608; cv=none; b=FXiFKvmKW+NDEPOvTPw6YV/vA1YhSmbtpxUSYwDUiTAjCriVqAgHRG1kt0l0jrUCtK3RYVW8/l5BP3gWaQEG1i2o/D44TNFM3ZKTBPi9DPwt1o+9jqyNd8ZjomnyqaGi1tyfE4xqsJIxeNeKG6uOuK0qE4laKKtXdC7krfS7AQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051608; c=relaxed/simple;
	bh=67G5aM7r5ENe4kk3e8NhN3hbML0eenyJjRuPNLwAPVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvpBl/REVfiZumLhmT9y4FTL17QYUW+h4bYp2uxiJY/1heTeEIiq1sG2EHJo/6a2bphB1d5i+d5mKumYSU3bAOYhD8ZXDCcSnlU2zHXOdSYJpxvHlWmVRAx785apk4iTb3VR6FtL65nb0SN0ZkjPd1La5aVR+4Kyxwm9jDXBH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoIcQDvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95145C32781;
	Wed,  7 Aug 2024 17:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723051608;
	bh=67G5aM7r5ENe4kk3e8NhN3hbML0eenyJjRuPNLwAPVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoIcQDvlcEHtdyWUFRo2Nc2cTlChZqrGRuVBJJ49mFUyxN9Rb+cmcH/wTNIwPYmED
	 Xl0rf+MdjjcamcIfknkCSXy6o1it5yrb6Y1KJK3MKbYB1pRpwUnQB6Q/zm83nHHvet
	 Mq/NAzPyrBhYXKxdgy7mv80caxRu5VIIsozJOE4AHHHe+f+4HpM4MAyyDVSmDhcScY
	 kexVIUod3Yj1KgQPYciEhZb01c4SZ3SGnihOJGlsBmJ+dVbMTJ501j2BXaORTWlbps
	 GI2AZ0Ks2kTy6W4wV8wKPBIwELps0WRVjI92+Ein0YIYxOOjvAgWBkeff8WeLhzlzs
	 pnYqR65woSN8w==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Cc: conor@kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: remove non-existant spi device from jh7110-common.dtsi
Date: Wed,  7 Aug 2024 18:26:40 +0100
Message-ID: <20240807-recital-elixir-f5951f6760d7@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716-majesty-antler-d9bedc7fd0af@wendy>
References: <20240716-majesty-antler-d9bedc7fd0af@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=706; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Z1y/ge0Wkp4E+XvuMKkTCYFUccqMsIcn9c8BhZA7u+U=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmb1wUmbufI2u319+7uw70S4rqMmzfv9nwbfr77saGkz /d1LkLCHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZgI7wxGhrPBjVn/5/369DxC 5+6KxOcGm3kvpP18KjLh6cf9H25/Zc9m+J9lx3ta6rdG5Lll1edmfQmx4PT3DlmilXLo9fcQ5W2 uzdwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 16 Jul 2024 11:54:00 +0100, Conor Dooley wrote:
> There is no rohm,dh2228fv on any of supported JH7110 boards - in fact
> the dh2228fv almost certainly does not exist as it is not a valid Rohm
> part number. Likely a typo by Maxime when adding the device originally,
> and should have been bh2228fv, but these boards do not have a bh2228fv
> either! Remove it from jh7110-common.dtsi - pretending to have a device
> so that the spidev driver will be bound by Linux is not acceptable.
> 
> [...]

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: starfive: remove non-existant spi device from jh7110-common.dtsi
      https://git.kernel.org/conor/c/db6efa5e81a5

Thanks,
Conor.

