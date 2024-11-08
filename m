Return-Path: <linux-kernel+bounces-401567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333489C1C58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E493E286274
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D31E47C1;
	Fri,  8 Nov 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwPKEtgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2401E411C;
	Fri,  8 Nov 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066195; cv=none; b=jOCky1eBOq4ZI5rYq6EJL+vcmovIwqzEzi6kSGhbJNn+NoNTpCEht0NRo7XVBcvCugeDeeA3/v7DNAEoz8bEezpZMi6aXKbll8ZWM4zzCgezZMO4/0+pF2/2E2Di9Z5ZomeQQGWXhIoNOzkNpY2aF0TCVbcUaq9LQhZVfBbDFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066195; c=relaxed/simple;
	bh=8zaJ33eL6o1+wVR92icQ0rxE6wt94nUld/Us/a4aZpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfj37eN0wEZolo/No70PjN6jewwAutdzdIgNAEYt8+w/2BTRduiDUnqEsjoEHvEx+PmaoBekcNI4MRgMSNJklVT6jLeTeNx3xK9dLsVQEgjHK6iQX7m+ZpbbJFBAnVZZeTf7r2sflCgmKTD6oYMMh4rFU6o+FSrqmYBPFuQKszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwPKEtgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE7C4CECD;
	Fri,  8 Nov 2024 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731066194;
	bh=8zaJ33eL6o1+wVR92icQ0rxE6wt94nUld/Us/a4aZpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwPKEtgKFJpBmRRPq/RyEhl4//oELyueeAhtNFqoFEFYMNvlSRSnGA38v1ey6qvC+
	 skgKwROXWdzgElvH26Ahn0X6XoB4dmoSj62IsTsu2eMyXe2TLruFY4aPgUF0xukJM2
	 1WMyKCqlgTbtxpgDRSnQWPHp+AZKOve1j5f83gDGAybpuSJh1KcE7p2yimsHcmLkOm
	 HiyDXxlKQg3en33EXlzhzWRDfwmqt4OBGGTYnhNQogU3etOZlWK01tHcFdPQXYMGl/
	 XidtFG1QdryARAk+YOW+05RP1ATpswcivG8eoaO6MaulWZtcPSW8iaqf3YWzBp0z2K
	 c+iwcWAdxZgcQ==
Date: Fri, 8 Nov 2024 12:43:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: regulator: Add adi,lt8722-regulator.yaml
Message-ID: <qr72zky2xfy4uzcm7vqnipgx3nkic4hp377jbtha46cktnxncy@52ms2zg3sf7w>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
 <20241108093544.9492-3-ramoncristopher.calam@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108093544.9492-3-ramoncristopher.calam@analog.com>

On Fri, Nov 08, 2024 at 05:35:44PM +0800, Ramon Cristopher M. Calam wrote:
> Add documentation for device tree bindings of LT8722.
> 
> Signed-off-by: Ramon Cristopher M. Calam <ramoncristopher.calam@analog.com>
> ---
>  .../regulator/adi,lt8722-regulator.yaml       | 178 ++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
> 

This wasn't tested, so limited review follows.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> diff --git a/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
> new file mode 100644
> index 000000000000..3fbf788d4154
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) 2023 Analog Devices, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/adi,lt8722-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LT8722 Ultracompact Full Bridge Driver

Driver like motor driver or regulator? Or Linux driver? If the latter
then, drop. Describe the hardware please.


> +
> +maintainers:
> +  - Ramon Cristopher Calam <ramoncristopher.calam@analog.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

That's all folks! More review when this is tested, please.

Best regards,
Krzysztof


