Return-Path: <linux-kernel+bounces-541753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892ACA4C12C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34233188971D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDA1E521B;
	Mon,  3 Mar 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/sEm5fC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1221147C;
	Mon,  3 Mar 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006996; cv=none; b=K/QaASpNXOTWIRK6Ep+tpSbsuP41HivLzX7RhSTBKzFf8bRfFakDJSxsdMFUWDWPW3kobw4mib5Ifdx732ZgD60Pki892u4HgwL4NQEb277mVzTANF2PQRRnOiERhsfPlXIsH8H1LrjSAUvQhLYFIwcd8ZmmRgJ+belWIyZQ9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006996; c=relaxed/simple;
	bh=oSR/KHjI9MSt0N2w8+L2Fx68vorquw7bUIpd7Zjxu6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8G3B1a7YJS+hSvq9fYsYx4yVN4aIWPyVvekBBvlO9YSfR2nPQ62/dN8lWLI6Egod8v0fffryEIJTmrZQgIV1SjC+ixSS9DrCUEOv3gQYlYeMRDNLVa9AFnS3Og4BpAp9/xgxjXZjh63wSvpTz1QwUDLMugDcCk7DK7dqzPmlnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/sEm5fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B335BC4CED6;
	Mon,  3 Mar 2025 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006994;
	bh=oSR/KHjI9MSt0N2w8+L2Fx68vorquw7bUIpd7Zjxu6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/sEm5fCwsRHugQtLNJsfW5yPPUlDiCwJa4NkvnByLNoMfQhw0BvsRfgKtIHNQGHc
	 tSMD0zD8Tdo3b5qweXFYRAXreJXTW9+Bb1QDiAyJCI+MpFf5cJohYXBIG+SWY3GXTd
	 ENnE8u+b9iRvuUHp0A9+nivyYUvvsLZq5MEpfDBWPxJtn/UnUSW5ZPv/LLJ/Q/4L2f
	 QoTG+DCpcqSm1R4BGUCN+8sYyqIu/xTZPM5oMZrT63m1DylnVlsjxoPDDwVscE3Sff
	 q7Ouknnsio+E4OUH092C60Zd8t8cUPssNpCMvX3ZHMsEMj1ZBvQTgdd63IHRXM7e64
	 sLBUOcBgvb3iw==
Date: Mon, 3 Mar 2025 07:03:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, broonie@kernel.org,
	nicoleotsuka@gmail.com, krzk+dt@kernel.org, festevam@gmail.com,
	linux-sound@vger.kernel.org, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, perex@perex.cz, conor+dt@kernel.org,
	tiwai@suse.com
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: fsl,sai: Document audio graph port
Message-ID: <174100699235.1416596.7740734064527505113.robh@kernel.org>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
 <20250226100508.2352568-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226100508.2352568-2-shengjiu.wang@nxp.com>


On Wed, 26 Feb 2025 18:05:05 +0800, Shengjiu Wang wrote:
> This device can be used in conjunction with audio-graph-card to provide
> an endpoint for binding with the other side of the audio link.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,sai.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


