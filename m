Return-Path: <linux-kernel+bounces-522131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABDA3C662
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA6179A25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF22214233;
	Wed, 19 Feb 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdxvxqnW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04FD21481F;
	Wed, 19 Feb 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986807; cv=none; b=VvHeR2qWKixozP5cQPyLZdbJm3hMeK/A5QalCSbype4+KlXc8UWgaVZ5quFDltKgXpVl/vjbXoLPcc+dCP0I0AQWIAbkObDgOLDr4y24jTgVl5MLLU2hQYXqnll7Q98c/cOlzbhuToXaM1Yew9xp3wcAnou5O7Dds0UJnqXD1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986807; c=relaxed/simple;
	bh=7e64/5L6MTYJPbB9Fmi1eekyUsrDKLbg0aRRMYqYpc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULZDvVaXTx0bdG4nwo9iGK4sHNo9bz9kXX3fpgeMJTUkKr3AGDO00wrL+TprypE3wo3wHg7cV4+y6ZR+v144QvKZCFViArWHmsOrbklGXdleVLAVbqPTG+LMG2ZKISKwj3fBvdPhoSe/k56lPRbocJ6NMYq1o0MaW/LuvfO5Jiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdxvxqnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01BFC4CED1;
	Wed, 19 Feb 2025 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986807;
	bh=7e64/5L6MTYJPbB9Fmi1eekyUsrDKLbg0aRRMYqYpc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdxvxqnW1P/AncAt7m6XOxd8JCuA+52zJHPOSCtvwSZF8m58ZRnUQ/akVIb/gCjcQ
	 YLKc5g8sqOQATo5QJ96iLIC4otFSbzeliRutoVLPkATX1SR9m0BCpTO/FZfnG5gOEa
	 Rrc8MiJVWs4uolDRfFgs6D//mVricSqFGpUb21Y45ndiFimfqpsFZ3jj37036CEvsx
	 YHzcCO18oIn+8DIvwVJa+8yx6SASJeR3i/8DCaekujdsucqHwZYHO7fTyRRlqt2XFE
	 Rut6WyDcjHBrjEYa0uixeVBllxKbE6sB9hcolXOArgMocmoY6nwOgq+FUhKcatkA5m
	 mT6seqAYuuUhA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sandie Cao <sandie.cao@deepcomputing.io>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] riscv: dts: starfive: fml13v01: enable pcie1
Date: Wed, 19 Feb 2025 17:39:56 +0000
Message-ID: <20250219-sudoku-brewery-196094c5a506@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250207093618.126636-1-sandie.cao@deepcomputing.io>
References: <20250207093618.126636-1-sandie.cao@deepcomputing.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=446; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=vxuzSktMxnzfKt2p1RVJeC5rLdC7Hwpf1ExvcuVO114=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOnbxHNKhE9Lrt12bMGu8hzXQxN6r0iGrNPeEZfk/9aDS +6wY41cRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZis4mRodOHdbF3tvr8S5la fx7Ux3JfOXwn0eFvStjSIjkph1jfmwx/BVobGy0nMmSa2886fzby4/bcLw6cHmLejM9SG1axqpV xAAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 07 Feb 2025 17:36:18 +0800, Sandie Cao wrote:
> Starfive Soc common defines GPIO28 as pcie1 reset, GPIO21 as pcie1 wakeup;
> But the FML13V01 board uses GPIO21 as pcie1 reset, GPIO28 as pcie1 wakeup;
> redefine pcie1 gpio and enable pcie1 for pcie based Wi-Fi.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: fml13v01: enable pcie1
      https://git.kernel.org/conor/c/57b5369f3668

Thanks,
Conor.

