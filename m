Return-Path: <linux-kernel+bounces-393783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C969BA525
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9251C20DEA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7754F167296;
	Sun,  3 Nov 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+O3ivOW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE94430;
	Sun,  3 Nov 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629936; cv=none; b=Vf9OUreJ0lXi1Qixjge6D9VBluCUZHdQJG5af4pIFxifYMo/kFTTLprhBzVXOgPlMbkcDoJ7YBAyP1u2JSMwd3LYfRzvRI4NMGPX9nDHIytsZA18AIYr6J+sMAWFYS1nNywmWu5PUg2IfzCXYS3mk7Qy1AsxzuQeLWPcdUOk42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629936; c=relaxed/simple;
	bh=iHupWsxzFRgV+Th+tOJmSIrQJ3vqK571Fe0TvhNqbZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDzfIlJOJPBapxz4kKPlFeG4ctwyhVCCLqABlh2w1qrGMurLpUl7DTOXQwEFQCS924jR3J11fPKkDa0cdP0cac5CDKIF/6A+l3cBUWoiXMZ4rtReE+VG4b0PbDY2eXuhdG1g1dVR0ZpczaUH3vtX9J6EhhYYwzcrXa7Qi53R/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+O3ivOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACEDC4CECD;
	Sun,  3 Nov 2024 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730629936;
	bh=iHupWsxzFRgV+Th+tOJmSIrQJ3vqK571Fe0TvhNqbZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+O3ivOWVfNk+A3vC6vQchJ/dGA01SFbXB6Bc8QCF1wC3o8Bj1iiAW7QT3LBU4clS
	 mI6q5Dp98RjwYh8zeA+Mjo49qTH6oCMOfvl2bubdUo96ShgwSUxewtZl9vfH1eneyl
	 jPh4HdEYrqLs1FJ+PxvA5s0HuKUfjeWFH76SFfg6uZSf5kOojD99vRvnGplxVgzTP4
	 GtaVpbwNbjVxKd9oBOeQSkC+1reN4P3UAlft6H/nXXfH3G6f0jeROuzx8vlAz6z3Fn
	 cdrzUMR2mwNLoojuVgq+pIq/wDtLx9HjnABIi0XtCcJsnvkzJD1bz38+tHTo3wCCP8
	 rJ9Gcb8kUJRyw==
Date: Sun, 3 Nov 2024 11:32:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-actions@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: power: actions,owl-sps: convert to YAML
Message-ID: <4cmyml3ng22wcohule4a6qwl2qyyblkbjydn7ceuxm4xu3jewa@wyd2ugtyfjf4>
References: <20241102221707.2857342-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241102221707.2857342-1-ivo.ivanov.ivanov1@gmail.com>

On Sun, Nov 03, 2024 at 12:17:06AM +0200, Ivaylo Ivanov wrote:
> Convert the Actions Semi Owl Smart Power System (SPS) bindings to DT
> schema.
>=20
> Changes during conversion:
>  - Rename file to match compatible

Where?
Old file: actions,owl-sps
New file: actions,owl-sps


>  - Add a description
>=20
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  .../bindings/power/actions,owl-sps.txt        | 21 --------
>  .../bindings/power/actions,owl-sps.yaml       | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 51 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/actions,owl-s=
ps.txt
>  create mode 100644 Documentation/devicetree/bindings/power/actions,owl-s=
ps.yaml

=2E..

> +
> +maintainers:
> +  - Andreas F=C3=A4rber <afaerber@suse.de>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Actions Semi Owl SoCs feature a Smart Power System (SPS) that manages =
power
> +  domains to optimize power usage across various hardware blocks. Each p=
ower
> +  domain corresponds to a specific hardware block and is represented by =
a bit
> +  in the power control register and an acknowledgment bit, which is then
> +  translated into a corresponding voltage on a rail.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - actions,s500-sps
> +      - actions,s700-sps
> +      - actions,s900-sps
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +
> +additionalProperties: false

Blank line

With changes above:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


