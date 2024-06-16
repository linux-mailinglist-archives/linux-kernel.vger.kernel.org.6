Return-Path: <linux-kernel+bounces-216436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C0909F48
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129371F21CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32883FE4A;
	Sun, 16 Jun 2024 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfVi1Spq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C11CA85;
	Sun, 16 Jun 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563322; cv=none; b=d/XIvBSOKH9TJwu/W0QfU4JSS0GQ2b4pf9t4IqVdK4M2biTTS0Eo8e2cbV8H1d5uzThKvMKRXqZj8EIq94g4JtJq0V5pljd/bA3wUUDFXdyAMLUuPTkJE6SftyF4jqtOkg1i2Cu0rswl6ucKVfs6seTSsmb/8Vu2T+WdBqeVAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563322; c=relaxed/simple;
	bh=CsM4DGKZqITnSBvF9KRlVOZ+BrnA9Rcyy2NY/zVK/6g=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=REOZZso+jm6qYFDGKgMPmXAmYug0qP2T9Y39OqZYt8YAUKqYLRJgjuiIDa+HIpH1eUKxrFele6o6LmZOx9V3a3csrossD3LEzjn12cVbeQTWxGb4X+nvDbhI9L8TNhYBLqOskHNYWjpWb7cYvhC2EmaGsBwmBPkejleMaT1JlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfVi1Spq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A42C2BBFC;
	Sun, 16 Jun 2024 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718563321;
	bh=CsM4DGKZqITnSBvF9KRlVOZ+BrnA9Rcyy2NY/zVK/6g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nfVi1Spq3O8TwowZ+vuXDDMSYKmcpzSwehCL6EsX5rme/5Rs0qC/j207G32eUK6+I
	 Q5kPW2vCz4AbBp0dC1RE446//AmvLTnAKiw8UeFWUNR2lu/syMupXPeDQyXHztv9uO
	 lEv7XmArJhFOd9KER6aJ8eVuPJcPKLWE7YPTFTdfro5F+bFwr8dt9GvGyXAc2RLl3H
	 FYsx8nnS0mfExHNBr2V2uxZQ1ll7kwXBKyjfLku//pZXK7bBff7QR9n8G9k+/XGww6
	 guhtUxmsX066+TSLbNhm9UEQ3jP4GZAhQfL73bnKxwF0l/Z3/sVB993oZljwrF1sP0
	 p8EbJM/El1Y2g==
Date: Sun, 16 Jun 2024 12:42:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, 
 Anup Patel <anup.patel@wdc.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_D3577BC67116D732862BE4A7B187EF4ED005@qq.com>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_D3577BC67116D732862BE4A7B187EF4ED005@qq.com>
Message-Id: <171856332052.2487659.8752285245461346812.robh@kernel.org>
Subject: Re: [PATCH v1 3/9] dt-bindings: riscv: add SpacemiT K1 bindings


On Mon, 17 Jun 2024 01:20:48 +0800, Yangyu Chen wrote:
> Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
> Pi BPi-F3 board[2] which used it.
> 
> [1] https://www.spacemit.com/en/spacemit-key-stone-2/
> [2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  .../devicetree/bindings/riscv/spacemit.yaml   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/spacemit.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/spacemit.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/tencent_D3577BC67116D732862BE4A7B187EF4ED005@qq.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


