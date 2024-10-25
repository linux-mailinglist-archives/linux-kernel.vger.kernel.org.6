Return-Path: <linux-kernel+bounces-382122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68049B09BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BB61C233EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABB18870D;
	Fri, 25 Oct 2024 16:22:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FC18660B;
	Fri, 25 Oct 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873329; cv=none; b=dgcoNQEhaM28d+oSitcLmGFIckfiMb/vbOTKSFwJ6UTl4jJ+tTBazQ7DBj0VgJiuQqsWnvWCuj9ilyx5HWoKtt0uQS6u6zgBW+Kcj3jLd0+MV6mWh0IgcyWQOhQ9gSozyqXQLGoUZw15ud9nDPcR8/BiIlMGrDUoRGkXLeE6gaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873329; c=relaxed/simple;
	bh=FJPXzHtf+OYrg9rW3PpL8n8pW4gtLtTefds9D5VnEAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BpuB/uZISzEJRp/W+9GDG7H6XUx1bbgdoTNnS6/4ITHHqyWLbiXaH+MH5gdyHgd4agoUmmn2pZwdG2sqn8Ts2ETdK9+3nz6GuviH89Y/BFv2KWH1mBYiEiQigXuwYL/rZsYdqCeZq3rP4FtOceXbz+tsybHt7xj9k845OJWuwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DD2C4CEC3;
	Fri, 25 Oct 2024 16:22:09 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id C5E6A5FC74;
	Sat, 26 Oct 2024 00:22:06 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240919-b4-nanopineoplus2-fix-mmc0-wp-v2-1-c708a9abc9eb@gmail.com>
References: <20240919-b4-nanopineoplus2-fix-mmc0-wp-v2-1-c708a9abc9eb@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: Add disable-wp for boards
 with micro SD card
Message-Id: <172987332678.809046.10942756189276546172.b4-ty@csie.org>
Date: Sat, 26 Oct 2024 00:22:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Thu, 19 Sep 2024 20:35:39 +0200, Kryštof Černý wrote:
> Adding disable-wp property for micro SD nodes of Allwinner arm64 devices.
> Boards were verified from online pictures/tables
> that they have micro SD slots.
> 
> 

Applied to dt-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/1] arm64: dts: allwinner: Add disable-wp for boards with micro SD card
      commit: aee2eca83fb4725f3a81166ff21805d87504dac1

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


