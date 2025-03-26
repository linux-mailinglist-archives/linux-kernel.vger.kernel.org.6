Return-Path: <linux-kernel+bounces-576650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BBA71273
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB443B3D50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773319DF4C;
	Wed, 26 Mar 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq901tP2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE171282EE;
	Wed, 26 Mar 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976987; cv=none; b=kASXtsmfHWYNiDxCzyeyrNk5F/wDHugvi6ft84/tUGTIF8VAj94fzMxruyVRxzt8V9VTSQfWscuAiS1DBqwc3bDboP/WrRj4uAxDlwJN0ZmwB6AFJFe2v2X9aYIrXcK9usu/4/PVRFMYi+OukusfXZ196OrBq66p6rvtstX4cTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976987; c=relaxed/simple;
	bh=T/xRUZGs7ItgYgVXiQ+hB5Q/0Hnxt8WtQdvXjVtJt70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udVr/zZrjd/Zux59fEOTtWqt9Z7VUcIw/I+z/yJzfXgdljV0/KeYsG5dPyXeLhZUkiZD0VC9K15AiBhR0b0Dbeoy3Ny2w9l5PFSokyHxHB55vZyVqdBIVtsx2+NRbC+s6ua1IvS0KpDiL+XQ70ZvpWSwypX8TlQrbw+ZE7+o81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq901tP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878F0C4CEE2;
	Wed, 26 Mar 2025 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976987;
	bh=T/xRUZGs7ItgYgVXiQ+hB5Q/0Hnxt8WtQdvXjVtJt70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qq901tP2RyP4BqnwzJQEbZEuuLP2h4kqqWQhL3YoxuvFuRFQozy/cNyBlrckHCjwQ
	 omqE6jk2NCeE67u/poGn5zZ69v69AiHgQ0TnYqjoq51QNjkNFMpTS+kineMnV+tDXS
	 pEhRrkGEiBRne6RS1Bw4y70rJaxUY4v+EUuJdsOoAm+NIyVjY+bFOWu2F4zVYn021M
	 GPgHPkm//kWoT2CIBpHpj9HSXw9N0PBKX2+5LR5FlfeU0Z/zv3WuP/juUxk/z0ryt9
	 tnVZo/bemgWPDIOiL4VaDT8NJt5w8xVBeAa3P5d+nABv+B31ugaFKll84KjxR63nhs
	 cyPsIRBgl9lPA==
Date: Wed, 26 Mar 2025 09:16:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,mqs: Reference common DAI
 properties
Message-ID: <20250326-aloof-famous-lizard-3ada69@krzk-bin>
References: <20250325062751.3296913-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325062751.3296913-1-shengjiu.wang@nxp.com>

On Tue, Mar 25, 2025 at 02:27:51PM +0800, Shengjiu Wang wrote:
> Reference the dai-common.yaml schema to allow '#sound-dai-cells' and
> "sound-name-prefix' to be used.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,mqs.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
> index 8c22e8348b14..99e7372abd0c 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
> @@ -55,6 +55,7 @@ required:
>    - clock-names
>  

You need to constrain dai-cells to 0 (const: 0).

Best regards,
Krzysztof


