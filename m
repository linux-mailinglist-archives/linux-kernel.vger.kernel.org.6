Return-Path: <linux-kernel+bounces-331196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3720A97A986
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656C51C276C7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F4F9FE;
	Mon, 16 Sep 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Ah5+Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA414B95F;
	Mon, 16 Sep 2024 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529248; cv=none; b=SJKmoiO+Bchd9omwieMP/FT7h61ty7ipPYEtuZ5n5Tgmi+lrPuMwPHNeXht6QSDQJfVX8xglVlRLEZmwo46i8+Uj+2237W95QVpa6HLzoKLGYfLSvK/dcEZ390T+Z3tO4ArIZ8xgYAFZ7RsHxQvfBQ8pkoCyQE7uSKl8vWTqpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529248; c=relaxed/simple;
	bh=CCRO+wCGpM7n/fMSVYTlzzCNk4NwhSh8VfIQzH6croc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=k1CH0g0BjpEiDMwyLqrR5W1NjhGqPD7KKXVVDiv7+5HC95A2+qGeBtUwlTmSr1B6B7DxqZsCa4c2CSqjhWLjjDWu56tSiRGr9DX+c+MNy2iEOXXYw4gjza+ZPSzPDcdEfGMCMKeUs8ecpMkSRAtl5/sLv80hvD7zMP7jytVe7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Ah5+Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E95C4CEC4;
	Mon, 16 Sep 2024 23:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726529248;
	bh=CCRO+wCGpM7n/fMSVYTlzzCNk4NwhSh8VfIQzH6croc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Z6Ah5+DnVhdPgqnQb2f4eymVwzdCVNMxtZmN+EjfNEwrhcDkbkjQX0vA5WnfRjKCZ
	 chKTOymE81TDc5baty06rv2vSoGrbQaqvQ0l9HajLmxyHQ+Wp5wvzeTWeRmQavSwbw
	 2yNvBP1mzw7mj7d6AxbhDsiUPHOfURD+Kvi6rzFAqxd1DaS3fTcZcPglr9XC1GJbru
	 E3GVRaj8FVzbC210NDcQyEe3a5Z3BAJ2djq5J5l6HX3f6zl3zGXrCEtV/XcBVxWBKU
	 AB+6tqWd5Obg+oZyynFNgtqIiZlhYEaYVuxhJQgHLbGw6n7q3acS5aYN0OqJXmFeUN
	 lKgASO9+8ikMw==
Date: Mon, 16 Sep 2024 18:27:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: devicetree@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicornxdotw@foxmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>
In-Reply-To: 
 <SEYPR01MB42212A60B191731DF9759B7DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42212A60B191731DF9759B7DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Message-Id: <172652924608.1569418.9431223699256668863.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: spacemit: Add
 spacemit,k1-syscon


On Mon, 16 Sep 2024 22:23:08 +0000, Haylen Chu wrote:
> Add documentation to describe Spacemit K1 system controller registers.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  .../soc/spacemit/spacemit,k1-syscon.yaml      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.example.dtb: /example-0/system-controller@d4050000: failed to match any schema with compatible: ['spacemit,mpmu-syscon', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/SEYPR01MB42212A60B191731DF9759B7DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


