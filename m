Return-Path: <linux-kernel+bounces-515023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE74A35EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528AA3A5858
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00607264A7A;
	Fri, 14 Feb 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm/IQjiv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950622D786;
	Fri, 14 Feb 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539069; cv=none; b=Lx3GyQ5Np6VS2FNLUHKUQNL5qfxUVce6HCt2VHQuGQbDtBOXR7dZcSlb/0uxjrVBhrYynKq1gD68CjrdjV928B2TjrcTMreNvpwuaXpxMWaB7zIgMYSVgXga1x3epwxF9c8IYIC0k8P16YE24JHoPOvbzfsmKOo6DbEmt6L/iYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539069; c=relaxed/simple;
	bh=Xrz6HHKDtLLsT/YWrF32+M81jYfehMVmbpteFdyfJ8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c8pLEFIFEOGTSkewMu5KWLHQqHrxDzEevlAf+h8RtaxmJX0m1DylzasIWMOZBfwQkA9RrVg4XNCQwToWTMH/DuRQEh5La7LSa1vwW7oo9FZ4MgxJDWxsUnP0hdHOTU+YQO649lGr+UkLC3awE8rENJHM6Zi1/JJjI4zoJ2ln9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm/IQjiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2E8C4CEDF;
	Fri, 14 Feb 2025 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739539068;
	bh=Xrz6HHKDtLLsT/YWrF32+M81jYfehMVmbpteFdyfJ8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gm/IQjivPxeNPqDWqWqHl7BcseR+N7jrGmv03SMZaRo2vFfKKyelU9h4EOaZrO+mo
	 MQquoIgk8MNOe83dXq2oFTe0dgWOfYuBdTzojC9ZBD5zi2lttgXb3re2GLPCKY7Y2z
	 3H1ZOljLALSwik58BweP2dLQL0v/WLUgN46Cy8PuGQfAERZMGaqoKgi9ZeQ4/Ty97l
	 KChht7op0RNm23GteFDp4brt1Jqba+Aa3zwgO2Qh5sBHi4B6wDQpymPvTqsWbXHtil
	 he3wPNt16g8VOkT8vRPTTcJ6zoC2cxgCJTLDkMO1XPVQt3rnPNHWZeYP1W/V0OdrNN
	 j3Xg2fcQ7CNbQ==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1737383314.git.geert+renesas@glider.be>
References: <cover.1737383314.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH v3 0/3] LAN966x PCIe endpoint cleanups
Message-Id: <173953906507.3648.11168442623966598761.b4-ty@kernel.org>
Date: Fri, 14 Feb 2025 18:47:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 20 Jan 2025 15:35:00 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains various cleanups related to the recent
> addition of LAN966x PCIe endpoint support.  They can be applied
> independently.
> 
> Changes compared to v2[1]:
>   - Add Acked-by,
>   - Fix references to bogus MFD_LAN966X_PCI symbol.
> 
> [...]

Applied, thanks!

[3/3] phy: PHY_LAN966X_SERDES should depend on SOC_LAN966 || MCHP_LAN966X_PCI
      commit: 7dff18535b93ea1ce6dbaf36b7ae670f04113d08

Best regards,
-- 
~Vinod



