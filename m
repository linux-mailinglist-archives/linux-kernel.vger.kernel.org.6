Return-Path: <linux-kernel+bounces-526791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341AA40358
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D5016878D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566E205E31;
	Fri, 21 Feb 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ8ErIQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5031F9F70;
	Fri, 21 Feb 2025 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179578; cv=none; b=MGDHl0o3Wd5LnSuv11oqVAJ6WCSImJO0pVwFvfflz5Y60MK0qoNfXbGwO4cj+iV98RPs7ElsL8Ku1oOKPiDlGLgH9+phcLUoS1njAN0N1dU47x3QSUOvfXoQ3R5mYUDmFo+3Uv/mvJxUBfmVkzIPl5d3K+TTW4O0Cidm7VxUUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179578; c=relaxed/simple;
	bh=7KJL9KWszpg5g4w4ho8u8E3fRUo7FQHkyyEsqmU1Ph8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drJdSmYd8rVD2SW+P/Mdop8vPkqz7oj2PaVh3sZGby5LZA15e4ufXJaRuK/FukUsHiJTon7Oe5KpayCA+Fmw7eIA2HSnW4rFuO+pKktXY+iLuwQTRtJzHtGSlT2pJL8a43nuJjdGi6gjk2AiqtXvU/vaLDESPWKYzwNOhkipsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ8ErIQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C860C4CED6;
	Fri, 21 Feb 2025 23:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179577;
	bh=7KJL9KWszpg5g4w4ho8u8E3fRUo7FQHkyyEsqmU1Ph8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZ8ErIQMkY1DYx+3T5fdybrL60kZuLkRB0Gi/W1iAfwcnxyULLWUT9znUVBToVcev
	 zevPS24LokeENNnnLVSY90FDTyJXpRlvyBxSWmAx3+TFtez02Pxei0rH3td1CuUeU6
	 dxxbM/Zhkd51bbLBO7Qb+9KYkRUmCVf/MQm2Od7ZQkpIckW5hh0Wd2wnar2Im1W2Qe
	 6qxbqh3BO4A3ggulxSYLelPxgHZCruwpJD+k5YkTmmbcPVPMa5WEzOL7jz4XPwcQZE
	 utAtZ8RjSIyjUuVLeiYNFfBOxetvb4GGmAF392PggQvRpKVstslLAxaq+4OOh19JzK
	 zG1QDl0HlmFew==
Date: Fri, 21 Feb 2025 17:12:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Frank Li <Frank.Li@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v3] dt-bindings: crypto: Convert fsl,sec-2.0 to YAML
Message-ID: <174017957412.293199.15568009985621401095.robh@kernel.org>
References: <20250220-ppcyaml-crypto-v3-1-99eedece4821@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220-ppcyaml-crypto-v3-1-99eedece4821@posteo.net>


On Thu, 20 Feb 2025 12:57:35 +0100, J. Neusch�fer wrote:
> Convert the Freescale security engine (crypto accelerator) binding from
> text form to YAML. The list of compatible strings reflects what was
> previously described in prose; not all combinations occur in existing
> devicetrees.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: J. Neusch�fer <j.ne@posteo.net>
> ---
> V3:
> - split out as a single patch
> - Add Frank Li's R-b tag
> - fix typo in email address syntax
> - normalize spelling of "descriptor type", and reformat the description
>   of fsl,descriptor-types-mask for readability
> - add missing end-of-document marker (...)
> 
> V2:
> - part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
>   Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-3-8137b0c42526@posteo.net/
> - several improvements suggested by Rob Herring:
>   - remove unnecessary multiline markers
>   - constrain fsl,num-channels to enum: [1,4]
>   - constrain fsl,channel-fifo-len to plausible limits
>   - constrain fsl,exec-units-mask to maximum=0xfff
> - trim subject line (remove "binding")
> ---
>  .../devicetree/bindings/crypto/fsl,sec2.0.yaml     | 144 +++++++++++++++++++++
>  .../devicetree/bindings/crypto/fsl-sec2.txt        |  65 ----------
>  2 files changed, 144 insertions(+), 65 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


