Return-Path: <linux-kernel+bounces-560021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61084A5FCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5D0188FA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984A02690ED;
	Thu, 13 Mar 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukcXNXJL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5C7FBAC;
	Thu, 13 Mar 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884978; cv=none; b=ZCT5iIvmDgF8z73cg1oVBPgP6CYwp0zgTr2dn1Wp/1K1terThqIZ5uyO0Di+h26FENiYnaEYKsUN4z6h3TkO0dQyMmbLNMM8QSGaov11Z/Ubm58Q9pHEvFefpKAv9LLtIqyY/OyYiC1LHAPLf0kVIl9N1b2ov+I9MCyxE5VithQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884978; c=relaxed/simple;
	bh=AOqMFoSF7wMysKxflwNKrdVJb6TkuN/Bi0bZXKPBIh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CVkXRtPOuKd+5BFKnQ7rjU6UMhskikMSSuMg9LO7o2onSi6+mGNXKYp1f77+BDtmXYq3chi4Mf7MQy66k6Xp0Fyc8FzEWNE7yYXXS7DY8+QePIK/+jJTia6Rsq6eDdWBh4faRw/J0TThulb12LLN6R3pfMJEpjkDgnPXhv7/Pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukcXNXJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2B1C4CEDD;
	Thu, 13 Mar 2025 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741884977;
	bh=AOqMFoSF7wMysKxflwNKrdVJb6TkuN/Bi0bZXKPBIh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ukcXNXJLHYRqcpTN+7GEvlB0tlcsMOtTkmRUmB1pLqLoD8psS4WALY6g24l08QA+R
	 jn0qfvPXOnMOVAP0B4h0iuk8doOWpACR61KEJx0ek1FUIhMxYijGqq5JN4Gdy1JPCC
	 /VBJCOoEttl1XOaQLfuKvVzwdDwqh9ptGxHvg5CFyECteetU3TI92+ZbgPJR7uGP2/
	 DlXyPAgnDcM8/YbkUUxp3WlNCyid6t29oLLRvlXT7dX5deilt0FWxmHvNkhlXgVLWo
	 EA8zUDgg/apH6bCsV7nMEOs/esKmfX7Py1b7ws1yY1k1cnTmDCu80wyRv1Y3Yl6/rU
	 c/H61qRSciuyA==
From: Lee Jones <lee@kernel.org>
To: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20250306123809.273655-2-amadeus@jmu.edu.cn>
References: <20250306123809.273655-1-amadeus@jmu.edu.cn>
 <20250306123809.273655-2-amadeus@jmu.edu.cn>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: mfd: syscon: Add rk3528
 QoS register compatible
Message-Id: <174188497549.3792331.5613971273362591228.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 16:56:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Thu, 06 Mar 2025 20:38:08 +0800, Chukun Pan wrote:
> Document rk3528 compatible for QoS registers.
> 
> 

Applied, thanks!

[1/2] dt-bindings: mfd: syscon: Add rk3528 QoS register compatible
      commit: 1c313607416052414ce94bc9bb27b688741cb30d

--
Lee Jones [李琼斯]


