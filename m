Return-Path: <linux-kernel+bounces-574349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34BA6E447
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1F3ABD61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824071C84AF;
	Mon, 24 Mar 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpS0uqO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DC19E99A;
	Mon, 24 Mar 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847846; cv=none; b=oIPAdFOe3qw1eJ6s81AoqbevUj/57ccbdBrt8BdYW20YvJFc+F63JNeogcAMblcznLeqAhNGbVRF1nzrLwR+muErvgMY6fF3iBT4liS+MAoG33iefil4mNFisNb/T+lR2Yi8NxRZ1H7NH7MZ+PS6Of2I6T9F1cSEkiogOHx4hYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847846; c=relaxed/simple;
	bh=Y8JdXz4w7Rb3q/NzS3QDuCo0lwePkl8nwoggfeIM59I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU1yA5v6X34bpl5jlNM/2q87nZO044nyAbq10qdeo9Gqx9YUzWt9XwTYso/aGrApezIR9Da6BPmtaKOUvuIyPvxktkcyQdedrGKEE0Ci4qvFdHhG1/7hhrZF0CVhF/sUu5M6tkiWAF22b7P1fYBzBlzHNN9eY37ldL0GM1t+YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpS0uqO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22244C4CEDD;
	Mon, 24 Mar 2025 20:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742847846;
	bh=Y8JdXz4w7Rb3q/NzS3QDuCo0lwePkl8nwoggfeIM59I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpS0uqO+GV78U+HhCW2Pa57Hp/F5lfUJ1TPrMxX9tm+Km4QEag0laYNWoLmJgmb0k
	 zqWDfjUKKludodl+A9N5q2QDF5NSUuzG11SLqNeXdlUd3ac/AwnZIW6OAIW6De2STL
	 mRdz2R22XloNfkaRETG6kAKRU8QZDJigmeAsmZ3In7+fjAx7tkwSewXO586gtQSV9+
	 Q4ohWhfKrMgUQ5OGuApJitcmW0DUGYYnmEpM2fFCUe7XAuPgDTgziFh0MIWmDY64GR
	 2KEOezRSks1Iz9iAGfweHqJUeNBhE+3AjtQEDzZs6pq7DnLQSu6IDlIahLOT4sSEwH
	 oytTG/oMBeKyQ==
Date: Mon, 24 Mar 2025 15:24:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: nvmem: Correct indentation and style in DTS
 example
Message-ID: <174284784448.810985.2720262744540534185.robh@kernel.org>
References: <20250324125214.82028-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125214.82028-1-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:52:14 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.  While re-indenting, drop
> unused labels.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/nvmem/nvmem.yaml      | 60 +++++++++----------
>  .../devicetree/bindings/nvmem/rmem.yaml       | 20 +++----
>  .../bindings/nvmem/rockchip-efuse.yaml        | 20 +++----
>  3 files changed, 50 insertions(+), 50 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


