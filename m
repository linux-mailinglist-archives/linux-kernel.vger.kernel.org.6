Return-Path: <linux-kernel+bounces-444509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE49F0804
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA9C168AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8471B3932;
	Fri, 13 Dec 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGyYqb3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53F1B3724;
	Fri, 13 Dec 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082637; cv=none; b=aC6ARbYUrS7GgkD6rr2xJ3Qzy+BqJwmUxDMQpcD0e0FUbtH0ywbKzWvwwzfbLbMGMbLkRnUPpQ+ewIYqeaWEei9KQGV2+UE5slFg94VaXF9orWvsWGPJ+fkEAxgkilPaH8r1jHQe5a6btMFfQxXE25OU6qxUd7k6GvLL+73YWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082637; c=relaxed/simple;
	bh=Ot+Keot2DSbDeQxxNeM9NIquE52Bf3AknFppl0pabGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D40Hp1vokdgqZWCD9Y6bdAz92N4MK89m2rBrE2hjnhQwGXw9P2Cgfp6ydmz2cP6kUdAORtGvOatgulRZoIq5FG+bZqE5WrrVmkBG3XPPd+Ok9uiiKjbpejf92c/VsozSmxBgCn6fggPaYhX3iyc1fsZk3cxJTnyxPD/QhSKwI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGyYqb3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F4FC4CED0;
	Fri, 13 Dec 2024 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734082636;
	bh=Ot+Keot2DSbDeQxxNeM9NIquE52Bf3AknFppl0pabGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGyYqb3ysRMoR7UkMA1HPxEr/qT4ULL2oXJQ75QOUBd81afntfB+G4PHdVLh14Kdl
	 Uk194Gtiu8YgHfgLtUIkACzCApDCqhH6z/CAVswPAm/glOdGkeMIYRQ0L1zg/avv0w
	 yUPbMMATbj9yIfdhYR7DQmVsw15QzdPIsegvRHxPxs2tXN+SQMiGSs5FArgxZwPqEN
	 noFRwU6AljgYbP6mhZbDN13t9QoVt5oNaslnK0tIsvmItB6pgOHYmw59L4xbvP7Qq4
	 tumNVQRdzjaSsizGZi0e7mJp7/55Jq/9z65Zt4HzACzBAuK7oMiqJrwX9j7TX02FCz
	 ZPRblFu7tQ1xg==
Date: Fri, 13 Dec 2024 10:37:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Hal Feng <hal.feng@starfivetech.com>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: Fix a typo in StarFive JH7110 pin
 function definitions
Message-ID: <oacmcw5yvdlsmvqbt4dbdmsx6rvd6x43qv2ejmypw57jgraqu7@txhhsxdg2agq>
References: <20241210042002.165297-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210042002.165297-1-e@freeshell.de>

On Mon, Dec 09, 2024 at 08:19:56PM -0800, E Shattow wrote:
> Fix a typo in StarFive JH7110 pin function definitions for GPOUT_SYS_SDIO1_DATA4
> 
> Fixes: e22f09e598d12 ("riscv: dts: starfive: Add StarFive JH7110 pin function definitions")
> Signed-off-by: E Shattow <e@freeshell.de>
> Acked-by: Hal Feng <hal.feng@starfivetech.com>
> ---

Why are you sending the same multiple times? Where is the changelog and
proper patch versioning?

Best regards,
Krzysztof


