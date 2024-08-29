Return-Path: <linux-kernel+bounces-307541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30C964EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AEA281A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673701B8E8A;
	Thu, 29 Aug 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7Dlz9TB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A63AC28;
	Thu, 29 Aug 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959468; cv=none; b=StK3oa2PoGNGiKS153R54dRoFUINnCxftj3caynicK9dOua92ZDZMCc1jWWssW/Z0TIPvXbF/gHlia/jewzMGpH9tgN/rYWecOAZKjjRtmIbzbcWeiPxXYXjSgHLbrK9QClEBfsyjz1FgnsZv+cN7P1juJ3wyt5nsNq5ce+lfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959468; c=relaxed/simple;
	bh=uTglyPOiv1StxvS2A3Sp8Hit9OuSpBd4jENxkIcloxE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XHn5m7Gxbjlj1pFyPu5Pg/kVd70GmIidRi0i+fZIsfH+LjnwTQrstUuFasDyn2NjP345+zfFIVGOUKf+weA7+ElocFv9jX7k9x5DhAhtqeqU8xyjXyRy5vYeuQA/ZNjSnGNJfkRMnPA1N4o5PpjKGOmQkw9D2etwhTJsF83VBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7Dlz9TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E57C4CEC1;
	Thu, 29 Aug 2024 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959468;
	bh=uTglyPOiv1StxvS2A3Sp8Hit9OuSpBd4jENxkIcloxE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=G7Dlz9TB8nEzWinXJWcSgeTS87cAEgVVA9VJSWyfWJqSXfGGRGzcPb5Y0dST73ScL
	 q0thvY1iM9n+z9w7WsZo0rQ/akN5SAJkaUSArWvpopb5ADG0abzaB3wjZ2AZB6pKQH
	 R7AKK5r9CXuokOgotN7DfWX/0RQizI4znTa0AGhTxZaa/ULRdPG7pzbsD+tKizpZmJ
	 5eG7P3zs/8lQHobaCwPxRyfwidrvnq3jKdJb2X3mjSiVoTsJDABu7GQM0C67uyXZwY
	 k8cgzvJyLrg7NdrnOPHbNHI0P7CpA6wrtaXzfjS73+3MiQHBMP/UcQSPRyYlWUDFXI
	 6nNe2GVKlCfqQ==
Message-ID: <78b5aa6efc5b3ca4151f503367a9bd3a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <NTZPR01MB0956E46297168E8E21D6F17F9F962@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com> <20240826080430.179788-2-xingyu.wu@starfivetech.com> <ba3077ef4b155649812fd8be75f131e7.sboyd@kernel.org> <NTZPR01MB0956E46297168E8E21D6F17F9F962@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Subject: RE: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0 clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>
To: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Michael Turquette <mturquette@baylibre.com>, Xingyu Wu <xingyu.wu@starfivetech.com>
Date: Thu, 29 Aug 2024 12:24:25 -0700
User-Agent: alot/0.10

Quoting Xingyu Wu (2024-08-28 22:42:43)
> On 29/08/2024 04:19, Stephen Boyd wrote:
> >=20
> > Quoting Xingyu Wu (2024-08-26 01:04:29)
> > > Add notifier function for PLL0 clock. In the function, the cpu_root
> > > clock should be operated by saving its current parent and setting a
> > > new safe parent (osc clock) before setting the PLL0 clock rate. After
> > > setting PLL0 rate, it should be switched back to the original parent =
clock.
> > >
> > > Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110
> > > SoC")
> > > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > ---
> >=20
> > What is the urgency of this patch? I can't tell from the commit text, s=
o I'm
> > assuming it can bake in clk-next for a few weeks.
>=20
> Hi Stephen,
>=20
> This is urgent. Without this patch, Cpufreq does not work and the CPU can=
't work in the best frequency of 1.5GHz. This patch can improve the perform=
ance of the visionfive-2 board.
>=20

Ok. I'll apply it to clk-fixes then.

