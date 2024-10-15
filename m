Return-Path: <linux-kernel+bounces-365462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5299E2B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F25283396
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65B1DACBF;
	Tue, 15 Oct 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/S1t6+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315441BE854;
	Tue, 15 Oct 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984174; cv=none; b=OspEIQycrF8Rzui3FQnzer6uu7xzrgtOPoya40Ko8aUrDWSnPyk3KhUN5kiQLBPGmRTa9GrMRHfc5ZCR8sdXsYCxkuPzVQ5Y3KmTeViavAtA3+vyHx/5Z3C/Y71hwVLp3XqVFd6TeXczxA5U85t4HScFGUFwAuzLEhRIJR6izlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984174; c=relaxed/simple;
	bh=r04DrGUblCxTqcvpoGYuNbCdz9Gp8tFVnjTZHiP25To=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Zit6HXXzHX4SCWKSgcwaFNNu2q6iCyhfaow2wBb4gYXZWLIDznz9DibO5maWXzQZhkUCS07/4v9mDk3gGlcKuD9rnYGqhQcxdCytm3MQfnTAbJxJlbls0gYdMnZbV2xeeOu95xq+zoP9ZD8DH8T8NPVopeZwRj8zQA66M9pLgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/S1t6+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E78C4CEC6;
	Tue, 15 Oct 2024 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728984173;
	bh=r04DrGUblCxTqcvpoGYuNbCdz9Gp8tFVnjTZHiP25To=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=p/S1t6+c6YqwwV1HdnIvFwqHOZaxBk9zRc9c4GQw8aWo+mFTYIrQduwp8/PNugdOo
	 6GG8vnQD1DpgUc4DF9UZsPLxtSi8NaQcSo9oKpypOD4d8WKAZyNLKdshdhuSsXWy5I
	 9M5cQ9HJEkxlb5nyoc1Ljzrs9v22x87UQNx/MrOtx42M8UBNQrQhDf2APVnSZpW9n7
	 5Byo9892kuD5OI4QHiwUwtgMMqt29bkH7+ko/T26e/eRAul0rBf+ncCAG2ATJ/DS/u
	 LWXQj4jWpEp5H1PHq2jtPbswIK1Rn4gvhXw7fY+gQxBULGgbOX6WU1oZGVkTky01x2
	 0rZ1Hy2MQIfJA==
Date: Tue, 15 Oct 2024 04:22:51 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Troy Mitchell <troymitchell988@gmail.com>
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
 andi.shyti@kernel.org, conor+dt@kernel.org
In-Reply-To: <20241015075134.1449458-2-TroyMitchell988@gmail.com>
References: <20241015075134.1449458-1-TroyMitchell988@gmail.com>
 <20241015075134.1449458-2-TroyMitchell988@gmail.com>
Message-Id: <172898417189.3869826.12293740881092237390.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: spacemit: add support for K1
 SoC


On Tue, 15 Oct 2024 15:51:33 +0800, Troy Mitchell wrote:
> The i2c of K1 supports fast-speed-mode and high-speed-mode,
> and supports FIFO transmission.
> 
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> ---
>  .../bindings/i2c/spacemit,k1-i2c.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.example.dtb: i2c@d4010800: reg: [[0, 3556837376], [0, 56]] is too long
	from schema $id: http://devicetree.org/schemas/i2c/spacemit,k1-i2c.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.example.dtb: i2c@d4010800: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/spacemit,k1-i2c.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241015075134.1449458-2-TroyMitchell988@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


