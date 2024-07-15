Return-Path: <linux-kernel+bounces-252438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A477F93130B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7AD284216
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225F1891A5;
	Mon, 15 Jul 2024 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJj0xdYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB0446DB;
	Mon, 15 Jul 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042770; cv=none; b=e8vpFCIvmOIhZ0c/Ue6o1DG/tNRp7Oq8L1YaNUOGfxvHK2Fs063+KdlKa4wy7kobBlrRhX/C0IKKQ0ILxZrn3RocqYmgDbo/ogFLh5hHijws5mu13K8DKQw1ENODeY2dQ2unzFxlUbONOqllRs9hn2ykXKv4pdUC1HW0pBnADGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042770; c=relaxed/simple;
	bh=QM1uBAPF2108gHk50qZVBd1zgDVHl1QsHEWx7znti1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn1S4eaH3h2ihaklq0eY0Udu7dfIEenTdUN/kotEbLdyeyS7Vel8hc3AxI0Wi1RqOSLy1WVbJICojTPoqSzMLaBcBk2w86vBhsXrarUnFbMFAhmrVvLERiD8bij1LuTM2qbJ4OnDEfXv2PIeNgEtYgwfn3C1pM5WB7rhV8BgjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJj0xdYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13038C32782;
	Mon, 15 Jul 2024 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042770;
	bh=QM1uBAPF2108gHk50qZVBd1zgDVHl1QsHEWx7znti1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJj0xdYxkgEIT5/4cc53FrhzNHUTX12qA9VdQtGzy3xByuaSz7VS4aEI3Xb7p19EE
	 tFY1r5EjQvwfkcuTdLFUrmcTFkkXTyCMgh/kJQ9/nbr5a9ICpEOnJloZS4zoaW8uj2
	 yRXZyJe+1vZJHDJchmKmnqBfZ2UamUGeDLb5rq94lTvSYzH4fv0JfrkU0Q5Co8rCcy
	 BC0pFfd2VbqW/wm5VWuy07oawklnAogC3n/qtYRCTIrs/Fx4qA9nllzQxvI94DC+5H
	 dOJDEZXJSEd+hTqDpUz0hIU5n0eAFTOSTZLEX9FIdVdTdpT8ZK+I5S4eTuej+NXQoH
	 /xQZzJns0fvBQ==
Date: Mon, 15 Jul 2024 05:26:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>, devicetree@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: sprd-timer: convert to YAML
Message-ID: <172104276748.3594257.7060683721858153378.robh@kernel.org>
References: <ZoU95lBgoyF/8Md3@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoU95lBgoyF/8Md3@standask-GA-A55M-S2HP>


On Wed, 03 Jul 2024 14:02:46 +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 timer bindings to DT schema.
> 
> Changes during conversion:
>   - rename file to match compatible
>   - add sprd,sc9860-suspend-timer which was previously undocumented
>   - minor grammar fix in description
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/timer/sprd,sc9860-timer.yaml     | 68 +++++++++++++++++++
>  .../bindings/timer/spreadtrum,sprd-timer.txt  | 20 ------
>  2 files changed, 68 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
>  delete mode 100644 Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt
> 

Applied, thanks!


