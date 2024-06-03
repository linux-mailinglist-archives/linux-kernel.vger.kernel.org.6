Return-Path: <linux-kernel+bounces-199287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8108D84EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4821F21F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9601311A7;
	Mon,  3 Jun 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU8RFvtq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635A130A79
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424807; cv=none; b=bJgrEJiWXfAh1PzO92q+GH5Bn6+ZTZt7GGvu6xyb9VnoQmuUWD/fF9XS08zy5PuA42HmuVb9qrP1Kh9wEskPQiGSvd0G8Ct0EiwCDkpuw5s7B5A8CPMnppNTNcWJTPh17lYA9gRTLshLe+j8ySehrQybGx5BqyWEU/o1oVrKrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424807; c=relaxed/simple;
	bh=ro77ju63wQnu5SRrClZDNDdDunh4smtgqd5dihJwcTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lWcb3R2bqrJT/J0AVsc0o2tkSk0GUHx1uDDzLgDRD/VOL+AnIPwg7xwCTnNmfKaNpgS3nQcI+/k1WFumP2oPlU52qpOkpzHsJK7y3NtHmvEAZqUNZtVPtqBXvXrWy1pXZhtjP79Pf5eD9CEQSNeymxMoLjSYpjTelAZ9AMX09JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU8RFvtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC639C2BD10;
	Mon,  3 Jun 2024 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717424807;
	bh=ro77ju63wQnu5SRrClZDNDdDunh4smtgqd5dihJwcTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uU8RFvtqIrb4XuK/Z4mDEvv6qQlnBq0q6G3SxryRN9n2jMJuwXzDcAmcyN7OJ+SHD
	 Z/mR5uem+aTRYDnu8ecx4Mk7h7GfvkHUaPjHEWTTS4+xDpMP7VPXpBJBzeQeX/oQ0Z
	 z3GKNmdDjobQFqF1Drc9XFoFqxrmHGi66q9ttcPJBjsHd5ZpcNd//DC594rBx5OSHV
	 oeiakR0yFA93Sd7Ezz7PNrKD700YLuIMaDbsMfwZMCWjj8bSEhrFex8j4GAyb+D3e9
	 GmRtOsvMVfyXbwAINW3C7xETsgHNYXJ4kh7B+5gXSbpAqnJ1xs7JLHlTKkUiEjSDlJ
	 TMHmej29pff9g==
From: Vinod Koul <vkoul@kernel.org>
To: patrice.chotard@foss.st.com, linux@treblig.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240527205844.165279-1-linux@treblig.org>
References: <20240527205844.165279-1-linux@treblig.org>
Subject: Re: [PATCH] phy: miphy28lp: remove unused struct 'miphy_initval'
Message-Id: <171742480532.106728.7665267575086699177.b4-ty@kernel.org>
Date: Mon, 03 Jun 2024 19:56:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 27 May 2024 21:58:44 +0100, linux@treblig.org wrote:
> 'miphy_initval' is unused since the original
> commit 2c14e9be0c60 ("phy: miphy28lp: Provide support for the MiPHY28lp
> Generic PHY").
> 
> Remove it.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: miphy28lp: remove unused struct 'miphy_initval'
      commit: 3f8bb7a7b4e016df586f464279936a5767c2a36a

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


