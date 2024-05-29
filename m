Return-Path: <linux-kernel+bounces-193332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8288C8D2A69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3723F1F27828
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5304A15D5AD;
	Wed, 29 May 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpSHzTgG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C015D5A0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948138; cv=none; b=BUwXnTipr3AYmgiHQPvRxSGyCW59RNw9tIQgA1aiOnjGJEhwbD0z/lQyMkg7v4Z4/jNWYi8J5PZWHI87HfrM1mBLrNmf1GrHNrQTne0JXrmx+3UpwxF0TBQJP1+DXDApfWAhrc8NnEPK5hGLvkMKvoDs0cq9kXDKeVQLzV5yhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948138; c=relaxed/simple;
	bh=8swLETxim8r2v0QSa7h6ND7QWhB9AeksE9x8hvsQ7Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPIJS/4oRrX6X+CoDlHTsDwDYKFuJ8WhKRNzs1BVhBMOx8242fFRekuaVJfv8aV+IF2VgSe78Ju8zOrX8/2PNuTb+DgnL/6LNyiHVEJRxNdOxV1Gwm+gcDzqSgUmm/IlVSqAZf7n/OG5D8nWVrl+G9iyQ686GEQpbPNmhn4Byyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpSHzTgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F50C4AF0B;
	Wed, 29 May 2024 02:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716948138;
	bh=8swLETxim8r2v0QSa7h6ND7QWhB9AeksE9x8hvsQ7Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpSHzTgG4h0JZ7fOnMpNDtGcBUQaraSwnwcuNVnJP3+EvSGtf/Z4x/y1JxvCTarWJ
	 /Lj2dJ3JkZ++cGijMqUTtH19lRtbsyKEEcnRBRY/0h/xO1vsHgv7ERLLKoF6ql3ELn
	 n+7csGpPHS8z1SjMcmX9UtGeAz7AxGqPalociJODi5oJyXkrK1kRBMWdwDsXiFVat4
	 V/ZB+7U+EaO2QZqYTckw9XnZXTMQ3k3biCtC45ShPTf2VnToifqoSDMD+p8BKfL3bT
	 tz2a4fiOd/m7pOGYEavPDQMQlhVRyY9pXPL3jKhMZpbmIpe08SaNkTYUxGK4Its4F2
	 B3QRLut+YygxQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com
Subject: Re: (subset) [PATCH v4 0/8] ipq9574: Enable PCI-Express support
Date: Tue, 28 May 2024 21:01:56 -0500
Message-ID: <171694812079.574781.12688876318785901212.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501040800.1542805-10-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com> <20240501040800.1542805-10-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Apr 2024 23:07:51 -0500, Alexandru Gagniuc wrote:
> There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
> addresses pcie2, which is a gen3x2 port. The board I have only uses
> pcie2, and that's the only one enabled in this series. pcie3 is added
> as a special request, but is untested.
> 
> I believe this makes sense as a monolithic series, as the individual
> pieces are not that useful by themselves.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
      commit: 475beea0b9f631656b5cc39429a39696876af613
[2/8] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
      commit: a8fe85d40ffe5ec0fd2f557932ffee902be35b38

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

