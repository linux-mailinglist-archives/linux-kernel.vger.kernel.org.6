Return-Path: <linux-kernel+bounces-379999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D89AE6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148C2284378
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58AA1E1C11;
	Thu, 24 Oct 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJZbzmra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B51E048D;
	Thu, 24 Oct 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777552; cv=none; b=VkTBqLRWfvNdE5+oTxw0KccLJMw68jQmbLAsBYv/Al1l92ngOV2CMhl4ID0EqTJkzVvIX5e1biHiqXnBYRb1+V5CtZbe85j7aeO2gdjmNfUkzG1cZXrRdekVYU5CUVnZHMOZ8+dn+3zFGkTwgaSr2e3hCXBB37tAzCtljRAn0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777552; c=relaxed/simple;
	bh=ysaebKzqz4XXZimRWbG9UPVLLN1JN2MVZiCwi9rRVUM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZnCtQC5lGHF6xuLGHopv7nroeX60svJRQK9T9xVxHFQMhPlvwlF4eIrC4LcfzPzpQlGobKld6+HilPeXxctj3Eo0oJcD6uRZvt48v1jYMtEsKDzsgXI9JW7Nd7MHMFTNknpsZx6wfQW+4WdJWGyX0SGxlX63BtZfAU80oP7ITs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJZbzmra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE3EC4CEE3;
	Thu, 24 Oct 2024 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729777551;
	bh=ysaebKzqz4XXZimRWbG9UPVLLN1JN2MVZiCwi9rRVUM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hJZbzmraRElTGj4KBom6GeCanhFOrtyiiz4Av4mm37YQgm08e7xJeXdowMAeUrKwN
	 OIr3+hJ/ughyyiPztWDSFEIus2G5qEpLvKQae7NId4tYMZgh9XbF9X6vN0q7QnDrFk
	 zrMtEwNLzdObM3qsTNT8ZNV2RCulL0/cZADvpKtbRZenAQD2bYRFPmne9tXKypxrbO
	 GxvsSJwreM0+TK5b9MG82mQaq0bp+jmUDDMCQHudtEMPrisod10+kLx0tK47MmJeS/
	 0h9sBep6NTNBshN34uWpdQlQ+7bRN9/PKUm7i7zjE/xPEFdqjHRMsQlclm3kwRmp+7
	 nSdabjxBxSC2w==
Date: Thu, 24 Oct 2024 08:45:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Karl.Li" <karl.li@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Chungying Lu <chungying.lu@mediatek.com>, Karl Li <Karl.Li@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20241024092608.431581-2-karl.li@mediatek.com>
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-2-karl.li@mediatek.com>
Message-Id: <172977754868.100447.11555196771647688261.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: mediatek: Add apu-mailbox
 document


On Thu, 24 Oct 2024 17:25:43 +0800, Karl.Li wrote:
> From: Karl Li <karl.li@mediatek.com>
> 
> Add apu-mailbox dt-binding document.
> 
> Signed-off-by: Karl Li <karl.li@mediatek.com>
> ---
>  .../mailbox/mediatek,apu-mailbox.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.example.dtb: mailbox@4c200000: reg: [[0, 1277165568], [0, 1048575]] is too long
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,apu-mailbox.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241024092608.431581-2-karl.li@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


