Return-Path: <linux-kernel+bounces-382123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D111B9B09BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD5284A48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA771531C1;
	Fri, 25 Oct 2024 16:22:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299921A4CE;
	Fri, 25 Oct 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873329; cv=none; b=Dq9nSWQiZ3v4n2eC+IzXTznxFq62Xjnw2NH1K9OXS2rqKCi5rb7wRzzbIis9wn6cN/GbYOLdgZChHchGhoWHeL9rO4olqGXKQz7tICVAr27PcbIBy7x9NOyBw0JQzDd8G4q/WbLI8MLfyH3RPPS4m9g0vAmctaUvttBABpL/JEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873329; c=relaxed/simple;
	bh=Jykwqvg3kciOamwxLVUNRX81rmtLJn3mnysEzt1kRT0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CYHWlin6kwUZgAVZHI7PP4rpoEr6yjj+tkXmtJMS3J7N4+rjKWeh4+MuRz5BKNpMSbnHC3cnHRjhCF7ISguoAwM4uWdhqH+oocEI7j51SkKhoEDHcJL3jZxFvceskHj0smTI9gXhegt+DzFQvzHeA5FS9AjllUmzaAAt9ncjKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31323C4CEE3;
	Fri, 25 Oct 2024 16:22:09 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id D33D05FCB4;
	Sat, 26 Oct 2024 00:22:06 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, Maxime Ripard <mripard@kernel.org>, 
 Icenowy Zheng <uwu@icenowy.me>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240913104845.4112986-1-uwu@icenowy.me>
References: <20240913104845.4112986-1-uwu@icenowy.me>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: document RerVision
 A33-Vstar board
Message-Id: <172987332686.809046.13831869939181367498.b4-ty@csie.org>
Date: Sat, 26 Oct 2024 00:22:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 13 Sep 2024 18:48:44 +0800, Icenowy Zheng wrote:
> RerVision A33-Vstar is an evaluation board of their A33-Core1 SoM.
> 
> Add its compatible (with the SoM compatible) to the sunxi board DT
> binding file.
> 
> 

Applied to dt-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/2] dt-bindings: arm: sunxi: document RerVision A33-Vstar board
      commit: 654332bede7526cbe9e7ba4c1edbf86a1d0be76a
[2/2] ARM: dts: sunxi: add support for RerVision A33-Vstar board
      commit: 3888715c76956c6ea13577965586d5b891a1f3ff

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


