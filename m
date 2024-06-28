Return-Path: <linux-kernel+bounces-234502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503AF91C76E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25A6B2115F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA178C93;
	Fri, 28 Jun 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifPqJ+o+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837755C89;
	Fri, 28 Jun 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607062; cv=none; b=RysHJM7rMIaJ05HWIuJB1LisH5s8aHokYG1o+ccfNKzHaXGN4aG1vmDJQjmn8tV0IkD4cgEh69Q8FM6prw4pqlQ+hBxNi6Flf53muitS/SmeZVxa/52405C0VFpN+chfGhM3tzTnAeef1gHcSUr98GL6SBBTgUaVglufBrGwjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607062; c=relaxed/simple;
	bh=AX6LBzNoPmrO8nUiMc2oTDoNRrQ7+h+H6LTmhxs/l6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtFBJgA7z2ggQB8Jdxzat2FBcFCvbnttBQYa+4OaIg6NvwDCz6jeNy+P7MfNq2nCtZW4JNmRrKQx/M/Cb+IPn0OuI0dUVCuGIueOBfOwuCPAVO6I02kryo1tB/arQ1/Rs+FrXgHrWjS+dCgAm7JNrNdqOG7BpFZ/3EDEBNMl6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifPqJ+o+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC41CC116B1;
	Fri, 28 Jun 2024 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719607062;
	bh=AX6LBzNoPmrO8nUiMc2oTDoNRrQ7+h+H6LTmhxs/l6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifPqJ+o+XBvF5XVEWhcz66h08VaybrPd1aw9BL/iGvfGtYGToiTbeuXjHWHczzCEP
	 DL2bmS/M3TXONMLsDWC6i9kda18FCREQ2aCTWBf27F4upYSNv/dQjljtB/KVyFwXJ2
	 uSO99voSWREirrTAAgcUSaklGSiQY4JXkdpZT69gETn9Pla63VUfVEAhzrhvgfPKrw
	 nljz5GducGZjrxLiGEpWGJrTGQUuGZBGNlpiQVUl7npapoj/zwp8+YwSn4wsjdbFAv
	 t4t1HAtLZDXAkCqP7JFUVQr/VAuD3DT5GLjWDQcaZg2j7+hljixK3veEMAh8MWneBr
	 47eab6PPBBzMA==
Date: Fri, 28 Jun 2024 14:37:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: realtek,rt5659: Convert to dtschema
Message-ID: <171960702851.177689.11478031644579833106.robh@kernel.org>
References: <20240624132949.124228-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624132949.124228-1-animeshagarwal28@gmail.com>


On Mon, 24 Jun 2024 18:59:44 +0530, Animesh Agarwal wrote:
> Convert the RT5659/RT5658 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> 
> ---
> Changes in v2:
>   - Dropped redundant descriptions from reg, interrupts and clocks.
>   - Added default to gpio properties.
>   - Dropped sound-name-prefix: true
> ---
>  .../bindings/sound/realtek,rt5659.yaml        | 129 ++++++++++++++++++
>  .../devicetree/bindings/sound/rt5659.txt      |  89 ------------
>  2 files changed, 129 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


