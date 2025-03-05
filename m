Return-Path: <linux-kernel+bounces-547995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B9EA53EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E789E3A9453
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F068207A0A;
	Wed,  5 Mar 2025 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l44AdQvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBC2E3365;
	Wed,  5 Mar 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218443; cv=none; b=K8/eSTBVDHIdJXKK9AUrxbL0KVSJUBK9cGxnNBO2GrUlse8xo8eTJ420KbqUvxJXC4qNVz9nNHsrVVesxWJYwwA50o7snfC7WQZb4w8quAjPtyAV1KU7lmo7zmxP12lW2KSqSKicNfQRvtpa9NkEWA2y5TlqtsLjbA7hncsX48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218443; c=relaxed/simple;
	bh=yA+mUIWACYxP3Wr1A2JYKZlm4l4xjgxWXhCe3n4HpBw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=DWkNjWhfMaDFUjtkKJZTjuhuz2OP6B9hyisF+GhvGqFSfVFqiYFODodcLIG9nVvcXrlT0OakW2bfXPKVfFlppqQp9+Y4xd7L1vOUY6h03GNQMxZU4f146CA3bdKEiiQydYoGTLTJc/6XNwbcbX6MPN4hJkG6OlcmHuOlOCOCxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l44AdQvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28FCC4CED1;
	Wed,  5 Mar 2025 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741218442;
	bh=yA+mUIWACYxP3Wr1A2JYKZlm4l4xjgxWXhCe3n4HpBw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=l44AdQvFTlXE8ARf+BNvTDCRbaYon8o/M9LdZYejmCWWUovoprvtNhQqzc2mtMdqf
	 u3MrpKKSG1SplcM2kQASQXt2pQdGTQv0OnyK/ZlLSaynTp/cGd7pzsxm3zhqRdvlz9
	 iY0hMoysDkpLpa5ypgSn5c+1nmu/x6mBNtb7cMnizpkkhKJO+/XDl55ph335On0cch
	 bzaPCrv6k1sHMTnHhZKK+AC1g1ByoOfW9aNm3ypSDDSm/T60LaFgYl2q0akHmMkB4O
	 qKYxQRA/hvbDzKe9yImCbDGWYTlWBrHL8N6wT9IX+6X720wGg56rIxKMSYq+jFMZC7
	 N3zX6hQSEXOOg==
Message-ID: <de50dd55e1285726e8d5ebae73877486.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250303143629.400583-5-m.wilczynski@samsung.com>
References: <20250303143629.400583-1-m.wilczynski@samsung.com> <CGME20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0@eucas1p1.samsung.com> <20250303143629.400583-5-m.wilczynski@samsung.com>
Subject: Re: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with CLKGEN reset support
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal Wilczynski <m.wilczynski@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, alex@ghiti.fr, aou@eecs.berkeley.edu, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, jszhang@kernel.org, krzk+dt@kernel.org, m.szyprowski@samsung.com, mturquette@baylibre.com, p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, wefu@redhat.com
Date: Wed, 05 Mar 2025 15:47:20 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Michal Wilczynski (2025-03-03 06:36:29)
> The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
> clock gate is marked as "Reserved" in hardware, while core and cfg are
> configurable. In order for these clock gates to work properly, the
> CLKGEN reset must be managed in a specific sequence.
>=20
> Move the CLKGEN reset handling to the clock driver since it's
> fundamentally a clock-related workaround [1]. This ensures that clk_enabl=
ed
> GPU clocks stay physically enabled without external interference from
> the reset driver.  The reset is now deasserted only when both core and
> cfg clocks are enabled, and asserted when either of them is disabled.
>=20
> The mem clock is configured to use nop operations since it cannot be
> controlled.
>=20
> Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5=
c.camel@pengutronix.de [1]
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
[...]
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th=
1520-ap.c
> index ea96d007aecd..1dfcde867233 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_=
aclk_pd, 0x20c, BIT(3), 0);
[...]
> =20
>  static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
>                         video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
> +static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
> +                       video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gpu_op=
s);
> +static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
> +                       video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gpu_op=
s);
> +
> +static void ccu_gpu_clk_disable(struct clk_hw *hw)
> +{
> +       struct ccu_gate *cg =3D hw_to_ccu_gate(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&gpu_reset_lock, flags);
> +
> +       ccu_disable_helper(&cg->common, cg->enable);
> +
> +       if ((cg =3D=3D &gpu_core_clk &&
> +            !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
> +           (cg =3D=3D &gpu_cfg_aclk &&
> +            !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
> +               reset_control_assert(gpu_reset);

Why can't the clk consumer control the reset itself? Doing this here is
not ideal because we hold the clk lock when we try to grab the reset
lock. These are all spinlocks that should be small in lines of code
where the lock is held, but we're calling into an entire other framework
under a spinlock. If an (unrelated) reset driver tries to grab the clk
lock it will deadlock.

I see the commit text talks about this being a workaround. I'm not sure
what the workaround is though. I've seen designs where the reset doesn't
work unless the clk is enabled because the flops have to be clocking for
the reset to propagate a few cycles, or the clk has to be disabled so
that the reset controller can do the clocking, or vice versa for the clk
not working unless the reset is deasserted. Long story short, it's
different between SoCs.

Likely the reset and clk control should be coordinated in a PM domain
for the device so that when the device is active, the clks are enabled
and the reset is deasserted in the correct order for the SoC. Can you do
that?

> +
> +       spin_unlock_irqrestore(&gpu_reset_lock, flags);
> +}

