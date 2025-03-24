Return-Path: <linux-kernel+bounces-573819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CAA6DCD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00660188DDB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC8262810;
	Mon, 24 Mar 2025 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEp+e2S2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A07262805;
	Mon, 24 Mar 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826085; cv=none; b=PX92ZoHsp0U9l3pkLsofiIhqtJA7fg9QD6p4/btXLoppU4VAwjjITAhxglEIz+E4VNpoWpU5k9eQitiG7aT/eYW2yg1MzY27567XUH1jiJxxdU8LoNMnCmF6YnXNjHmHOdz188TvfEMlgAl1hjaJjKqzTcay2lpyWDsMyJia/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826085; c=relaxed/simple;
	bh=BUz8zYXf16hLfQPBxgTj8QMJv/VwcmDZZs0OAPRiMrc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VoDvHQj/9VkdaxGiwJ/rN0jy9iqA2Ty/yYfqSYn06pfTgdbwszWzBGnsEs0qVRsihA8yqhzPYIZvGkV3NDuq1K14nRgl8T7siG5sb19PM8wSWomgraxy1cnVJC3bTDtXQZvIDcc9ZKbiNxVQ6OdRdfS1ji7PJvjQ/1xSncaiK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEp+e2S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F4EC4CEDD;
	Mon, 24 Mar 2025 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826084;
	bh=BUz8zYXf16hLfQPBxgTj8QMJv/VwcmDZZs0OAPRiMrc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aEp+e2S2Mt5oiqdGcYgXj22r5GuOik2+/7oBiJTp3js7wmt6R/EPVP7RrmIsPjT/d
	 RtEXQPJXegXw9zanTSfpD1IMnJNDP3kDC2b31xYnNpLbUJRVYnFl8VedB9MH/HwsRK
	 ajc7p/shnr8u603dLAsvdrNl7lqm0CvOg4MxaY98Zu314I3cEgjQr1Jx/HSmoC7gsy
	 qIyKp4Efh70CMLHQ14x2hfmeYYspmORhbX7q3xFfINGgnM8xn/8r3OYIQXeY59qrlL
	 NAiYUH3UmsSKI7gGFfkNsUy75IMg7sEnvrrQE9VSP7f2IvC0CX/CdOFzzYpuP01R5C
	 GG7PkYK2LXqsg==
Date: Mon, 24 Mar 2025 09:21:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Fossati <thomas.fossati@linaro.org>, tglx@linutronix.de, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com
To: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250324100008.346009-1-daniel.lezcano@linaro.org>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
Message-Id: <174282608006.6289.10388719224772938093.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: NXP System Timer Module


On Mon, 24 Mar 2025 11:00:05 +0100, Daniel Lezcano wrote:
> Add the System Timer Module description found on the NXP s32 platform
> and the compatible for the s32g2 variant.
> 
> Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Thomas Fossati <thomas.fossati@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/timer/nxp,stm-timer.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,stm-timer.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/timer/nxp,stm-timer.example.dtb: stm@4011c000: compatible: ['nxp,s32g2-stm'] is valid under each of {'items': [{'const': 'nxp,s32g2-stm'}], 'type': 'array', 'minItems': 1, 'maxItems': 1}, {'items': [{'const': 'nxp,s32g2-stm'}], 'type': 'array', 'minItems': 1, 'maxItems': 1}
	from schema $id: http://devicetree.org/schemas/timer/nxp,stm-timer.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250324100008.346009-1-daniel.lezcano@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


