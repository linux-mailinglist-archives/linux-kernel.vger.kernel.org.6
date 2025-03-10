Return-Path: <linux-kernel+bounces-555015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45BA5A47F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D63B17215D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9FF1DE885;
	Mon, 10 Mar 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeO2rj8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE591DED5B;
	Mon, 10 Mar 2025 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637591; cv=none; b=UZFdE+AGALEONoVJZB3fuH5F18z9EI4a20M4D4vy1I0liDk2KyQ76FKLuogK6nGHSRr6UKTn5SGCtyZk2l2Vny09bRCOK0ByxjwpbBWrtTBXWl5f0DNz/3e98RTnY+ip3nTF+3z0L9nd2Btd3zE2hpYRIqTlqMT49mqv2jWDqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637591; c=relaxed/simple;
	bh=wrYhrgim9PhEQBxk0pDxMA3KCZn8MUdw+MmT1214ST4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TRJBtvloMO16muATxukGCRfFbPbXKtX53fdRoeWyeJsiU1e2d3DhG7wGDpsuxoPfBbURKTxkWc0qtQoxomdU+GzwBmYSs1hwexY1vdnduVNguo8KLTiS3WbA4e7CdVO5KRXdb7a5lbIHNoE0XmdfY79IxpRw6wMGogTrgr8nPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeO2rj8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2713C4CEE5;
	Mon, 10 Mar 2025 20:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637589;
	bh=wrYhrgim9PhEQBxk0pDxMA3KCZn8MUdw+MmT1214ST4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IeO2rj8fzNq7ozwjmPb7YfobvumLeNMdveveUzzMUtHZ2ASt3isz9TotqMuqJA/My
	 3YuHXWYlbuOgmvPRVzBZ5PdalX+ECc/11FhWEgEWpXk6gCd1d8CM0Vn05qB3KYlbfw
	 04tNSB+soXboMe/ergr/jNUTw/Qy9hhmc03zZVnCJ8AQuThKpyLFpbD6tdG58ViGrY
	 HYkFD5VvnSNeq+GsfWUPwqHhap/SxtBagYCiK5lz9KVzp6JsCQKmO8DP+27fJinGXe
	 8bHqrhHMgMoCeGJZfXRrZNx7edtu8pqSoDJ9S3flZ/zeKk3YQvWztlsokkYke+XPDl
	 H+JcZEViH8amw==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, corbet@lwn.net, linux@treblig.org
Cc: linux-phy@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306015408.277729-1-linux@treblig.org>
References: <20250306015408.277729-1-linux@treblig.org>
Subject: Re: [PATCH] phy: core: Remove unused phy_pm_runtime_(allow|forbid)
Message-Id: <174163758730.467704.13260521723607545351.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 01:43:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 06 Mar 2025 01:54:08 +0000, linux@treblig.org wrote:
> phy_pm_runtime_allow() and phy_pm_runtime_forbid() were added in 2013
> as part of
> commit ff764963479a ("drivers: phy: add generic PHY framework")
> but have remained unused.
> 
> Remove them.
> Fix up the (English) docs - I've left the Chinese translation.
> 
> [...]

Applied, thanks!

[1/1] phy: core: Remove unused phy_pm_runtime_(allow|forbid)
      commit: b02d41d884f64d22d5d5a2a4b35550f5e80bdb3d

Best regards,
-- 
~Vinod



