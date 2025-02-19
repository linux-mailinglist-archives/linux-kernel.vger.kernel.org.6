Return-Path: <linux-kernel+bounces-522130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35582A3C660
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16CE179A00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F988214802;
	Wed, 19 Feb 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj3nFcO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6412144C2;
	Wed, 19 Feb 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986805; cv=none; b=WepExXVX2Lo4/BcZxw9yx4/IChvTYfirAJcI8D3j95IYSpGRmiYqAdXbZEb2q2GFiwDkNY01HwjwTWvcdrY6KMSflBdIdkIT14v5pRvp4jv3go6PxrQ3IKxWgpzFdL2ogsqeuoYLhBNCvgABIL5YXZ32MuX3VpbKkuMdEeTloUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986805; c=relaxed/simple;
	bh=tWVlyiku6DDOUnayBYaxpOjbrGAy4KLPY4ZzqIVbggQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABGbA3DlPkZs+3IVCO5SDCLTQNIVh3WQiS0OmxkyBuz/ewXFTXsp5uc/bzF13fh3YL0GJHpzoprXxIWe1rawTKjkVuO0TTBVYuXuf0Xpyaq67YB9Vi1DXlx8Dy2mkMLzstxhG8E3w5cg+E9gwL43xfEZgQ6f6pAPUxd7rO3+UGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj3nFcO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19829C4CEE7;
	Wed, 19 Feb 2025 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986804;
	bh=tWVlyiku6DDOUnayBYaxpOjbrGAy4KLPY4ZzqIVbggQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj3nFcO4p1Gtl81ozgFHEc2Qun4lIHnDhbOt8ODtD1oku4EgZlitKQv2hJvvuseYt
	 LIqXk2IOWeaMQFhtuXJ682LuFKxaySfGQyEDINInigwJKrI6Ns3sLQiKS3ElqtALas
	 n7us10yW7NRHAYck4H2kIOJOrFEPCk6fAl45wKIGiI6vRChBKD/8UTAZVV32pieZ8s
	 +XMp40eyMflX8ITGfXh4I4ig5yKjAfDvxcUimgo5k+7XaC1rOcdxxoK6jMi0U4nZYR
	 nPO6ikCpcVTM62YpZEUcKn5W4W6vkNQc99fWthEQXhhWlYpVkv3q/HOsmuvAhsuxbl
	 FziwD4+QwEwUQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	E Shattow <e@freeshell.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable USB3.0 for Pine64 Star64
Date: Wed, 19 Feb 2025 17:39:55 +0000
Message-ID: <20250219-cut-lankiness-0c5c0a561fc6@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250102183746.411526-1-e@freeshell.de>
References: <20250102183746.411526-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YZAIZV2rwVuZrYvda7DwESnPj1jkxo9S/jbsdffmwyU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOnbxHP6PI4F+M3813FYYrG/jcb5pdyF7I/iry9UUnH/W v9/FdPTjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk/n2G/9kVL19p32af9G7f 0mMOWzZNijkWkbHs4u2kPddmHBJ3O3iXkWF/wNeGB8FLdsf3Pv7V4Lx5m8M25cr3jtYKfSbVDH2 TdPgA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 02 Jan 2025 10:37:35 -0800, E Shattow wrote:
> Add PCIe configuration of USB3.0 registers for pciephy0 mode on all
> JH7110 targets:
> 
> VisionFive2 1.2a, not applicable (USB-C peripheral mode power input)
> VisionFive2 1.3b, not applicable (USB-C peripheral mode power input)
> Milk-V Mars, one USB-A port USB3.0 disable (USB2.0 + PCIe0 peripheral)
> Pine64 Star64, one USB-A port USB3.0 enable (USB3.0 + PCIe0 disable)
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive: jh7110: pciephy0 USB 3.0 configuration registers
      https://git.kernel.org/conor/c/65e8b9912670
[2/2] riscv: dts: starfive: jh7110-pine64-star64: enable USB 3.0 port
      https://git.kernel.org/conor/c/38818f7c9c17

Thanks,
Conor.

