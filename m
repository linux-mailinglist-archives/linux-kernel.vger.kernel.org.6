Return-Path: <linux-kernel+bounces-401424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA9D9C1A4E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52871F22E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF51E1C3A;
	Fri,  8 Nov 2024 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrxD84i0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BE1BD9D8;
	Fri,  8 Nov 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061063; cv=none; b=RcgtVbMZ/D5blKAtC3EUFrAp+SuElB8VZhNHJhYWHMe5Jck8LLz+HWptY9CLA3aNu1rUkm0m/s6/L62pbOkD50XFr4pMtp3yjl2kjktzHcBAxaq5UuNxrep2/QaQ8W09irs2Sp3Yw4AeHdxvy9Qe+VJQa90+ArwDeaYjyiWTSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061063; c=relaxed/simple;
	bh=9qVAY2x9AAkKI0I1Jv5wu2JGzZKB5V6yLVc5Uzfc3Ow=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gD3giGvfdQfsknhlVQuuSSw7PmvXdQ6pTzKxJxgxFOqTAQZUOXsyYqPPB7XVE53wgWJpuh+YLto0hDE3+LpN99Tb3qPpfgbw1GoQNLm8kB6OkYwuQvcLGpbWbWNwj14cRa3Pd9PUToLq0kMTyQylyDuITBwmvk1caMD/pX5KHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrxD84i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0245BC4CECD;
	Fri,  8 Nov 2024 10:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731061063;
	bh=9qVAY2x9AAkKI0I1Jv5wu2JGzZKB5V6yLVc5Uzfc3Ow=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mrxD84i07x+hmoF11eyZM/gf0BtUtRDOTQ8wXs65pC6hGNRiJdOyZ2RiNsjwPLny0
	 4bwr5COuTz4anm/Ff9FnyWnK4Zp4n7HTqQMcKIQdGOitpfNNNYX/ssiuDV2rd1w6tK
	 ZFnOi3dSSIkJ6VIzePA017ORFNPGzcvf2agGU0j6Glq7rP1snqR79M1GHHXn0ong/e
	 B2lwH5qYjdMvcbK0qlVmVgH43IHPkJ2gdpLeTBoEo4llEUPQHN8xFAaXNMrO8jVnXx
	 MByqA7pZVW6dWTXkIlI5OequPGjnLulR9fP86swtbVLkkdpxRSluNUzJb6Qwlez0hv
	 xWDC9JVMEmiMw==
Date: Fri, 08 Nov 2024 04:17:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 devicetree@vger.kernel.org
In-Reply-To: <20241108093544.9492-3-ramoncristopher.calam@analog.com>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
 <20241108093544.9492-3-ramoncristopher.calam@analog.com>
Message-Id: <173106106125.1193852.5591566183422782580.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: regulator: Add
 adi,lt8722-regulator.yaml


On Fri, 08 Nov 2024 17:35:44 +0800, Ramon Cristopher M. Calam wrote:
> Add documentation for device tree bindings of LT8722.
> 
> Signed-off-by: Ramon Cristopher M. Calam <ramoncristopher.calam@analog.com>
> ---
>  .../regulator/adi,lt8722-regulator.yaml       | 178 ++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.example.dts:42.44-45 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241108093544.9492-3-ramoncristopher.calam@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


