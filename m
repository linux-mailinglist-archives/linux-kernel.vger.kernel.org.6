Return-Path: <linux-kernel+bounces-444501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3FC9F07E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878EA16736E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535C1B21AE;
	Fri, 13 Dec 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myNtbP8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA12364D6;
	Fri, 13 Dec 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082228; cv=none; b=XhSebxaKfTYoipDxH0Ly+DFuKYbW4hmFStnm0syQedwWb0ZdeogO3b/Khx2K14xofFKgu8vfy/YBko36YL9Bmjqw7qBuEaewb85QRl9QV/SmupH2QuQbJgKdJziLdmP9Lkj14I81P5ksBS2SkvY1M/PkaVjGQKz4g2hihQ5nz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082228; c=relaxed/simple;
	bh=bRbDDk89fSWfSJCWbZmKGfqHdsGWHT5C127PpH93rSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKrQk3pI9lOJC0+K18qCSYX8JvD0myFmPbT7HK9BqBVp/fTVjci6trSKyU/L8SGtbDR7yXuHNBmLSH2hl3PxitjQW67fzYwIv6h7YYy7UZ+jGh0UqpDtoSGVJjc4k3S2RAecn0CldIinOmJoMShKXdxUMzliGyipMvCqfJiUwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myNtbP8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82388C4CED0;
	Fri, 13 Dec 2024 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734082226;
	bh=bRbDDk89fSWfSJCWbZmKGfqHdsGWHT5C127PpH93rSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myNtbP8WTKdgILbcr+mKbJty/Y7tbuUIzbmbYuCy/lHX3d5jp33hUnXqrquPapMab
	 Y2kFTSa/SC/HWLYfaN/H2iNmMoALXym0pcjfHJ2tNCBKko9MMSqEdxy5pE8lSiJhwu
	 P8W8FY+S/NqRJO9kLUv0ADeQZz8bJ5kr0cXPT4cQAZrr/NOyaga0uISoi/f3pyQG1U
	 LNH4QYBhmILydjJ25LKs+XoxHeFNrn3bk9AQ6XqD9YM2OsEu66lRvCK3gm7LlZbUT8
	 Rek0qkzDBJXkHR+xdqHOKyfcBZeY0uoAzqGDneOySuY0HeEnPDqp2VdpgM+cxY7JH+
	 6XVwdCEWB2qsg==
Date: Fri, 13 Dec 2024 10:30:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453
 compatible string
Message-ID: <lelajzxonciani7lqpssscnjh7y7wbooch47era54rd6ywjmyu@w6w7aa5u7hjg>
References: <20241212-pf9453-v2-0-f59d2c096356@nxp.com>
 <20241212-pf9453-v2-1-f59d2c096356@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-pf9453-v2-1-f59d2c096356@nxp.com>

On Thu, Dec 12, 2024 at 05:26:24PM -0500, Frank Li wrote:
> Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
> is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
> BUCK[1-4].
> 
> Restrict LDO and BUCK numbers for nxp,pf9453 and keep the same restriction
> for other compatible strings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/regulator/nxp,pca9450-regulator.yaml  | 24 +++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> index f8057bba747a5..3589817858c5a 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> @@ -17,6 +17,9 @@ description: |
>    Datasheet is available at
>    https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
>  
> +  Support PF9453, Datasheet is available at
> +  https://www.nxp.com/docs/en/data-sheet/PF9453_SDS.pdf
> +
>  # The valid names for PCA9450 regulator nodes are:
>  # BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
>  # LDO1, LDO2, LDO3, LDO4, LDO5
> @@ -29,6 +32,7 @@ properties:
>        - nxp,pca9450b
>        - nxp,pca9450c
>        - nxp,pca9451a
> +      - nxp,pf9453
>  
>    reg:
>      maxItems: 1
> @@ -42,7 +46,7 @@ properties:
>        list of regulators provided by this controller
>  
>      patternProperties:
> -      "^LDO[1-5]$":
> +      "^LDO([1-5]|_SNVS)$":

LDO-SNVS
Underscores are discouraged in node names,

Best regards,
Krzysztof


