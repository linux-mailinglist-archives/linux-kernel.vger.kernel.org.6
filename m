Return-Path: <linux-kernel+bounces-168630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1068BBB08
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A57D1C20E92
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95420B34;
	Sat,  4 May 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="CCf9uezy"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BE1755C;
	Sat,  4 May 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824089; cv=none; b=dP9HEDp5+2ir2JjiNq/SefAuwfW31431By12EtYJdLfvgaZcMiYFQG6N9yTJKy33q4RzYJeCehqK13uEDp3bYBU4DDzko5q+QrANRB9ZaZbYic8dUuZ9fQOHmu+f9WfB+8VcAdNnYsJK2visJDrYvDdit/5GcUsO5kSmpYWCdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824089; c=relaxed/simple;
	bh=98J14FRWVrtau2eLWnGu0jUhYcj7HkEFqoCO9ClUc0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2T/a9qwREYHcF5LAeJuYLfEPPp6j3FVAw6/hs6pH/56LYd91d9vGreoQ6bnfFjk7jA7SwqOdQhCJ5vlE8oRfxeb9JKuyxLrlerufg6WTGEKfTxL5jVjp8BJRY66W+eJxOtl8N8x0kK0mMcRBhzshKAp+/V3HTeKiUTUc0S5gCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=CCf9uezy; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4F8AC1FC17;
	Sat,  4 May 2024 14:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1714824086;
	bh=RDCWpEhUSa7ErprbfVlOsGqwAI0proMiKIt11OMQwEc=; h=From:To:Subject;
	b=CCf9uezyQ3qNbeZ0A/pisU3qvhU6jq/0+m6iJeCPE3h03mjnnV2wopc8fcyFonEmM
	 m8LkRVk4pIAHtHLiNyZq4g4NoPx9TrNADd1aPKXJBauAulud5wDOhyRWtbC4Ztc2Og
	 Is2yC6+M5BDYPBXK4ADBcIJ0OcSTOk5oT82BnsnG1cYt/zXfF+sztLulafjY4Xx9+U
	 hrXKFz4mWyRM7enFzPv3gaBKI+MvQWJf//nDX70sizGKFyHYyd9uQZ7zCtLMe+QGss
	 gXDgZsV1tqErvOApABsA5eU6cYa2G9UGtJYnS/RoZQj8w/uV4mgGYPCN4+QUzeANJ1
	 gvz0sS62LiaiQ==
Date: Sat, 4 May 2024 14:01:24 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 10/18] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux
 for i.MX7D
Message-ID: <20240504120124.GC3666@francesco-nb>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
 <20240504-imx-clk-v1-10-f7915489d58d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504-imx-clk-v1-10-f7915489d58d@nxp.com>

Hello Peng,

On Sat, May 04, 2024 at 08:49:03AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> For i.MX7D DRAM related mux clock, the clock source change should ONLY
> be done done in low level asm code without accessing DRAM, and then
> calling clk API to sync the HW clock status with clk tree, it should never
> touch real clock source switch via clk API, so CLK_SET_PARENT_GATE flag
> should NOT be added, otherwise, DRAM's clock parent will be disabled when
> DRAM is active, and system will hang.

From the description this is solving a system hang, but no fixes tag nor
cc stable.

Francesco


