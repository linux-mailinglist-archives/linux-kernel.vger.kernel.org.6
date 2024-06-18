Return-Path: <linux-kernel+bounces-219914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758A90DA12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CBD1C21C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038314F13D;
	Tue, 18 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et6DxZZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081811494DA;
	Tue, 18 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729642; cv=none; b=WO4fv1eITEoF6q6jJpfQ07SmE4s8fVYfWFjshtN9lsHLXn5JLFM5OSufDMbd1a9p9YGrU2KnCo6CRC9fPzkE+2PkklMSloBhbJgcw5CHmOGE9eVFXKhnLvsSPNOH3XsORKuk4Rfueu9a+ic4JpocdMtO3ewkAOWzkOFo+SQR4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729642; c=relaxed/simple;
	bh=M3dXsTI8S1ItZw3XuJcDiIRq8FIhqSg2BtRyqdaJxVo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Lt3hrCTdrAo4nkpVnp4ttjPlzEa3SSBqiCK1eJc9p/y2QvJiloN/52e2OC9iLqgv7kfIY5Rs/MU4o4EYYIEWQ9/HxYgiSelA54liZNh8KUuBepwC/I+UjGaMclwzFP+1OOC5Yui5Lf2RgXVEWVWKwhjt6rSt6eSAC6FrULVyBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et6DxZZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EFBC4AF66;
	Tue, 18 Jun 2024 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718729641;
	bh=M3dXsTI8S1ItZw3XuJcDiIRq8FIhqSg2BtRyqdaJxVo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Et6DxZZltQp4/HaVCgZjMhEBk28Q79+FXmjjPL2hNSAHrM5jtLcG3O95YjBagmz9x
	 uYpc6hg8HqPrHQBfoa4QvwJe2FuuhSMRVTKoR8HUt+RuATBY08ytPuS156lRGgvrh7
	 hf0Wh/PjZOzNw7OIb9KRgLqDkHpalRWdjw2CTdnKzoARdkxCkc+pnf7G7MvVdjXPkS
	 DipApUS6tAwIX+V+IJqa7E5QtYI94nqxGU3QVdUKnEloTrAa743CstsR30tKG6Xm5d
	 o/SfpcjacozJAoroYyVzYyoRl3TCuIxSb2e2ixFrtNM4T9yLmAzC9vDaEQUuiqFF7P
	 CLuNR64Uwsm7Q==
Date: Tue, 18 Jun 2024 10:54:00 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yuntao Dai <d1581209858@live.com>
Cc: conor+dt@kernel.org, jassisinghbrar@gmail.com, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 inochiama@outlook.com, aou@eecs.berkeley.edu, palmer@dabbelt.com, 
 linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, 
 unicorn_wang@outlook.com, krzk+dt@kernel.org
In-Reply-To: 
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Message-Id: <171872963677.3062707.7560457462678270333.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs
 mailbox


On Tue, 18 Jun 2024 23:12:33 +0800, Yuntao Dai wrote:
> Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox
> 
> Signed-off-by: Yuntao Dai <d1581209858@live.com>
> ---
>  .../mailbox/sophgo,cv1800b-mailbox.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml: recvid: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml: sendto: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


