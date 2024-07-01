Return-Path: <linux-kernel+bounces-236648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB4B91E559
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6321B27772
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5816D9D2;
	Mon,  1 Jul 2024 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu1DH73v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF216D9AC;
	Mon,  1 Jul 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851298; cv=none; b=txVbIIPUBni8g9MXWZ9FN9MXL0u8ZddSEBaLn7P0yvw8uG0FEFxkBO6KPE7TPelk8QgHUDaIC6VsFcnUXTP5lDdtZFcpB/O34ADIcaDPwLXgdfxXMiBnyrhgS4XSpBBkwMyzLwBJz6/bFBjdsS5KCDSS9bEmHp17JaPI4E2fWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851298; c=relaxed/simple;
	bh=Z3r7I8XIc/WKhoJcsclB+qIA380c6kLLjl+j+GKU1ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5xBLlJUDqS/YSutzDqQ1t/K+rc5KiYMal8vbq9ecgb++4e1L60XqLQK4D3i3OFxCJpIdSuF5Gl7Nb4fu+ZVpDK2QZH8R4cVdE8EKGmI99cT0T/lQLT2Lfeef0fUCXfVrxiFMiMZ3ICVExHQSES0+NifELkcam73ctOXqPM0+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu1DH73v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC531C116B1;
	Mon,  1 Jul 2024 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719851298;
	bh=Z3r7I8XIc/WKhoJcsclB+qIA380c6kLLjl+j+GKU1ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nu1DH73vMUZ2+OZTKSSW4hN6euISJ3zjKxbH0+nE8pvO1/dvMt/b25Kxc/TYPIk7x
	 d+HcgjPmeElZfthuLdm4aNcVHsRi7Fu4ebmzE9VjalygRlqz+8O9sr7a6+arns/bxp
	 gNIpyzSC0gFhTRw6BzbND+K+R3UTjPYwMgoAxm7+k4W4Bsy2GQZKGZaOZhigNnbYAs
	 /2bif9HuH9MqjEhLJSkn83Wq7Tll1gxlPEmmxlQxn3DOiMnMmKswQTz5dyQh+LEmOJ
	 LSdDVszSNNv45I70LmuG7BbLQwe0BsDGkwkybUuIwddBmt30YMwV6zGGKcI6qKIWQ+
	 Arhy+6mLvf7dQ==
Date: Mon, 1 Jul 2024 10:28:16 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: realtek,rt5677: Convert to dtschema
Message-ID: <171985129580.58603.3347485988484873333.robh@kernel.org>
References: <20240627105030.14360-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627105030.14360-1-animeshagarwal28@gmail.com>


On Thu, 27 Jun 2024 16:20:26 +0530, Animesh Agarwal wrote:
> Convert the RT5677 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> 
> ---
> Changes in v2:
>   - Used consistant quotes.
>   - Listed jack detect as properties instead of patternProperties.
> ---
>  .../bindings/sound/realtek,rt5677.yaml        | 135 ++++++++++++++++++
>  .../devicetree/bindings/sound/rt5677.txt      |  78 ----------
>  2 files changed, 135 insertions(+), 78 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt5677.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


