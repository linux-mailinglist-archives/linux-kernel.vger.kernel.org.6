Return-Path: <linux-kernel+bounces-448059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D679A9F3A87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A0188A082
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31DC1D1730;
	Mon, 16 Dec 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGAgjiE8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C991CF5EC;
	Mon, 16 Dec 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379977; cv=none; b=erkXZQ/xUaDT2EQ4oEk4e1QAMtDhin69aKPLc6R80YaYkGiAcdBw/ZUwdBKcxaX2nVX4zHkzUSkybZ/3fp8JDc57Xz3hrLXNZzlkF9iHbHeSykBTotyZyJuFQzAOkKrP4pxAeXyrj9Ix7rlwT+F4hbK1dsJQt76IqpYoWIzPZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379977; c=relaxed/simple;
	bh=0ZbyjzgC3dHjGKp8RZR5Ahq6W5KWOhfGSyCWXHNwsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+OqaC1AYcRsPv2Rn7y7ySYl0gH98jftogeN7WgP01wwif4ece6MJ5QFFjpYnXMlSgWx1MJ5VRoII8Z7LJZiUTqY/vcaQcbqPjbl7GsTnMS+JV/D8vEYrdEMcPCa9jFpKMkpXc9b/t+/sXGJJ6r7JzENV9ovtyDx7XsNb2lIgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGAgjiE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24015C4CED0;
	Mon, 16 Dec 2024 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379976;
	bh=0ZbyjzgC3dHjGKp8RZR5Ahq6W5KWOhfGSyCWXHNwsIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGAgjiE81L4S6Ic6+1dYnB4u9n6HR1VQXWRWcl5EevUBW4ad9rMlppiJJ69GkX7in
	 sluke/vuJtbMbNzNZj+7Ud/wS2MwETmdMhL29a4UAbVIsYAB3iRMSpdIFIWUv8dpAW
	 xS97vXz0GDgjVDnUICNdLgQ2kTSkvYcNlUXSE+frlocxRkMSL9fa4zQKZdZyx2ADPG
	 AHA9IAzbwu55kuUKjBW/F9VD6oiz78Ih+foOD7PHdhv1EppvzGcTRQ2RrgMPnv4drE
	 gPaLkP0pYSollYN1vD1SmY47YbIQuhQUlV9B7Y8n8NIwDjqGoFhDOBHIkvS+Lh2sBl
	 6DamSxCbzNR7g==
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	E Shattow <e@freeshell.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: Fix a typo in StarFive JH7110 pin function definitions
Date: Mon, 16 Dec 2024 20:12:45 +0000
Message-ID: <20241216-freemason-suitcase-b51553eb39d7@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210042002.165297-1-e@freeshell.de>
References: <20241210042002.165297-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=316; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=mpxJW/4UFb2dGz8JVlLmLF1WTAywGMOwpepePhdbuhw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkJnfsnt4gfPrL2eM4T14RGjgO1HIo6AmGPm5rq55k7B L+2a17SUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIl8mcLI0HIw8MrRyNnPTpp3 8t19Wd2yMV7sYM2Fn8FH5qm8uz7R3Jvhv9OVSqmrHwPtdBa1bfLLDb60JJN/nWIcQ8jcau3Xr4J 92QE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 09 Dec 2024 20:19:56 -0800, E Shattow wrote:
> Fix a typo in StarFive JH7110 pin function definitions for GPOUT_SYS_SDIO1_DATA4
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: Fix a typo in StarFive JH7110 pin function definitions
      (no commit info)

Thanks,
Conor.

